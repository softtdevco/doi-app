import 'dart:async';

import 'package:doi_mobile/core/utils/enums.dart';
import 'package:doi_mobile/core/utils/logger.dart';
import 'package:doi_mobile/data/third_party_services/socket_service.dart';
import 'package:doi_mobile/presentation/features/dashboard/home/data/model/create_game_request.dart';
import 'package:doi_mobile/presentation/features/dashboard/home/data/model/guess_model.dart';
import 'package:doi_mobile/presentation/features/dashboard/home/data/repository/game_repository.dart';
import 'package:doi_mobile/presentation/features/dashboard/home/data/repository/game_repository_impl.dart';
import 'package:doi_mobile/presentation/features/dashboard/onlineGame/data/repository/online_game_repository.dart';
import 'package:doi_mobile/presentation/features/dashboard/onlineGame/presentation/notifiers/onine_game_state.dart';
import 'package:doi_mobile/presentation/features/profile/data/repository/user_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OnlineGameNotifier extends Notifier<OnlineGameState> {
  OnlineGameNotifier();
  late OnlineGameRepository _onlineGameRepository;
  late GameRepository _gameRepository;
  late SocketClient _gamePlaySocketManager;
  late StreamSubscription _yourTurnSubscription;
  late StreamSubscription _winnerSubscription;
  late StreamSubscription _winnerEarningSubscription;
  late StreamSubscription _mobileEmitSubscription;
  Timer? _timer;

  @override
  build() {
    _gameRepository = ref.read(gameRepositoryProvider);
    _onlineGameRepository = ref.read(onlineGameRepositoryProvider);
    _gamePlaySocketManager = ref.read(socketclient);

    final eventStreamer = ref.read(socketEventsProvider);
    _yourTurnSubscription = eventStreamer.yourTurn.listen(handleYourTurn);
    _winnerSubscription = eventStreamer.gameEnded.listen(handleWinner);
    _winnerEarningSubscription =
        eventStreamer.matchupComplete.listen(handleWinnerEarnings);
    _mobileEmitSubscription =
        eventStreamer.mobileEmit.listen(handleGameControl);

    ref.onDispose(() {
      stopPolling();
      _yourTurnSubscription.cancel();
      _winnerSubscription.cancel();
      _winnerEarningSubscription.cancel();
      _mobileEmitSubscription.cancel();
      _timer?.cancel();
    });

    return OnlineGameState.initial();
  }

  Timer? _pollingTimer;

  void startPolling({
    required String joinCode,
    required int expectedPlayerCount,
    Function()? onAllPlayersJoined,
    Function()? onOpJoined,
    required bool isOpponent,
  }) {
    state = state.copyWith(
      expectedPlayerCount: expectedPlayerCount,
      joinCode: joinCode,
    );

    getGameSession(
      joinCode: joinCode,
      onAllPlayersJoined: onAllPlayersJoined,
      isOpponent: isOpponent,
      onOpJoined: onOpJoined,
    );

    _pollingTimer = Timer.periodic(Duration(seconds: 3), (_) {
      getGameSession(
        joinCode: joinCode,
        onAllPlayersJoined: onAllPlayersJoined,
        isOpponent: isOpponent,
        onOpJoined: onOpJoined,
      );
    });
  }

  void stopPolling() {
    _pollingTimer?.cancel();
    _pollingTimer = null;
  }

  void updateType(String type) {
    state = state.copyWith(type: type);
  }

  void updatePairing(String pairing) {
    state = state.copyWith(pairing: pairing);
  }

  Future<void> createGame({
    required CreateGameRequest data,
    required void Function(String) onError,
    required void Function(String) onCompleted,
  }) async {
    state = state.copyWith(createGameLoadState: LoadState.loading);
    try {
      final response = await _onlineGameRepository.createGame(data);
      if (!response.status) throw response.message;
      state = state.copyWith(
        createGameLoadState: LoadState.success,
        joinGameData: response.data?.data?.data?.msg,
      );
      onCompleted(response.data?.data?.data?.msg?.code ?? '');
    } catch (e) {
      state = state.copyWith(createGameLoadState: LoadState.error);
      onError(e.toString());
    }
  }

  Future<void> joinGame({
    required String secretCode,
    required String joinCode,
    required void Function(String) onError,
    required void Function() onCompleted,
  }) async {
    state = state.copyWith(joinGameLoadState: LoadState.loading);
    try {
      final response = await _onlineGameRepository.joinGame(
        joinCode: joinCode,
        secretCode: secretCode,
      );
      if (!response.status) throw response.message;
      state = state.copyWith(
        joinGameLoadState: LoadState.success,
        gameSessionData: response.data?.data,
        timeRemaining: response.data?.data?.timelimit ?? 0,
      );
      onCompleted();
    } catch (e) {
      state = state.copyWith(joinGameLoadState: LoadState.error);
      onError(e.toString());
    }
  }

  Future<void> getGameSession({
    required String joinCode,
    final Function()? onAllPlayersJoined,
    final Function()? onOpJoined,
    required bool isOpponent,
  }) async {
    state = state.copyWith(gameSessionLoadState: LoadState.loading);
    try {
      final response = await _onlineGameRepository.getGameSession(
        joinCode: joinCode,
      );
      if (!response.status) throw response.message;
      state = state.copyWith(
        gameSessionLoadState: LoadState.success,
        gameSessionData: response.data?.data,
        timeRemaining: response.data?.data?.timelimit ?? 0,
      );
      if (isOpponent) {
        if (response.data?.data?.players != null &&
            response.data!.data!.players!.length >= state.expectedPlayerCount &&
            (response.data?.data?.hasStart ?? false) == true) {
          stopPolling();
          if (onOpJoined != null) {
            onOpJoined();
          }
        }
      } else {
        if (response.data?.data?.players != null &&
            response.data!.data!.players!.length >= state.expectedPlayerCount) {
          stopPolling();
          if (onAllPlayersJoined != null) {
            onAllPlayersJoined();
          }
        }
      }
    } catch (e) {
      state = state.copyWith(gameSessionLoadState: LoadState.error);
      debugLog(e.toString());
    }
  }

  void handleYourTurn(dynamic data) {
    debugLog("Your turn handler called with data: $data");

    final turnEventId = DateTime.now().millisecondsSinceEpoch.toString();

    if (data['guess'] != null) {
      final newGuess = Guess(
        code: data['guess'] ?? '',
        deadCount: data['result']['dead'] ?? 0,
        injuredCount: data['result']['injured'] ?? 0,
      );

      state = state.copyWith(
        friendGuesses: [...state.friendGuesses, newGuess],
        yourTurn: true,
        lastTurnEventId: turnEventId,
      );
    } else {
      state = state.copyWith(
        yourTurn: true,
        lastTurnEventId: turnEventId,
      );
    }
  }

  void handleWinner(dynamic data) {
    debugLog("Your winner: $data");
    if (data != null && data['winnerId'] != null) {
      final winnerId = data['winnerId'];
      final winnerName = data['winnerUsername'] ?? '';
      final points = data['totalScore'] ?? 0;
      final coins = data['totalCoins'] ?? 0;

      _timer?.cancel();

      state = state.copyWith(
        isGameOver: true,
        timerActive: false,
        winnerId: winnerId,
        winnerName: winnerName,
        pointsEarned: points,
        coinsEarned: coins,
      );
    }
  }

  void handleWinnerEarnings(dynamic data) {
    debugLog("Your score: $data");
    if (data != null && data['score'] != null) {
      final points = data['score']['totalPoints'] ?? 0;
      final coins = data['score']['coinEarned'] ?? 0;
      final winnerId = data['score']['userId'];

      final currentUserId = ref.read(currentUserProvider);
      final bool isCurrentUserWinner = winnerId == currentUserId.id;
      state = state.copyWith(
        isGameOver: true,
        timerActive: false,
        winnerId: winnerId,
        pointsEarned: points,
        coinsEarned: coins,
      );
      if (isCurrentUserWinner) {
        _gameRepository.updatePoints(points);
        _gameRepository.updateCoins(coins);
      }
    }
  }

  void handleGameControl(dynamic data) {
    debugLog("Game control event: $data");
    if (data['message'] == 'pause') {
      pauseTimer();
    } else if (data['message'] == 'resume') {
      resumeTimer();
    }
  }

  void _handleTimerExpired() {
    // _timer?.cancel();
    state = state.copyWith(
      timerActive: false,
      isGameOver: true,
      isTimeExpired: true,
    );
  }

  void startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (state.timeRemaining <= 0) {
        timer.cancel();
        _handleTimerExpired();
        return;
      }

      state = state.copyWith(
        timeRemaining: state.timeRemaining - 1,
        timerActive: true,
      );
    });
  }

  void pauseTimer() {
    _timer?.cancel();
    state = state.copyWith(timerActive: false);
  }

  void resumeTimer() {
    if (state.timeRemaining > 0) {
      startTimer();
    }
  }

  void startGame({required String gameCode, void Function()? onGameStart}) {
    _gamePlaySocketManager.startGamePlay(
      gameCode: gameCode,
      onResponse: (response) {
        debugLog("Start game response: $response");
        if (response['ok'] == true) {
          if (onGameStart != null) onGameStart();
          debugLog("Game started successfully");
        }
      },
    );
  }

  void timeTick({
    required String gameId,
    required String message,
  }) {
    _gamePlaySocketManager.mobileEmit(
      gameId: gameId,
      message: message,
      onResponse: (response) {
        debugLog("mobile emit response: $response");
        handleGameControl(response);
      },
    );
  }

  toggleTimerwhileTurn(bool val) {
    if (state.timeRemaining > 0 && !state.isGameOver) {
      if (val) {
        resumeTimer();
      } else {
        pauseTimer();
      }
    }
  }

  void toggleTimer() {
    if (state.timeRemaining > 0 && !state.isGameOver) {
      if (state.timerActive) {
        timeTick(
          gameId: state.gameSessionData?.gameId ?? '',
          message: 'pause',
        );
      } else {
        timeTick(
          gameId: state.gameSessionData?.gameId ?? '',
          message: 'resume',
        );
      }
    }
  }

  void makeGuess(String guess,
      {Function(String)? onError, Function()? onSuccess}) {
    if (state.gameSessionData?.gameId == null ||
        state.gameSessionData?.gameId == '') {
      debugLog("Cannot make guess: Game ID is null");
      return;
    }

    _gamePlaySocketManager.guessNumber(
      gameId: state.gameSessionData?.gameId ?? '',
      guess: guess,
      onResponse: (response) {
        if (response['ok'] == true) {
          final newGuess = Guess(
            code: guess,
            deadCount: response['result']['dead'],
            injuredCount: response['result']['injured'],
          );

          debugLog("Guess response: $response");
          debugLog(state.gameSessionData?.gameId ?? '');
          state = state.copyWith(
            playerGuesses: [...state.playerGuesses, newGuess],
          );
          if (onSuccess != null) onSuccess();
        } else {
          if (onError != null) onError(response['error']);
        }
      },
    );
  }

  void resetState() {
    state = OnlineGameState(
      loadState: state.loadState,
      playerGuesses: [],
      friendGuesses: [],
      type: state.type,
      pairing: state.type,
      joinGameData: state.joinGameData,
      createGameLoadState: state.createGameLoadState,
      gameSessionData: null,
      joinGameLoadState: LoadState.idle,
      gameSessionLoadState: LoadState.idle,
      expectedPlayerCount: 0,
      joinCode: null,
      yourTurn: false,
      timeRemaining: state.timeRemaining,
      timerActive: false,
      isGameOver: false,
      winnerId: null,
      winnerName: null,
      coinsEarned: state.coinsEarned,
      pointsEarned: state.pointsEarned,
      isTimeExpired: false,
      lastTurnEventId: null,
      leaderLoadState: state.leaderLoadState,
      globalLeaderboard: state.globalLeaderboard,
      streakLoadState: state.streakLoadState,
    );
    debugLog('<====State reset====>');
  }

  void buyPowerUps({
    required int coinCost,
    required Function() onSuccess,
    required Function() onInsufficientFunds,
  }) async {
    int totalCoins = await _gameRepository.getTotalCoins();
    if (totalCoins >= coinCost) {
      _gameRepository.updateCoins(-coinCost);
      onSuccess();
    } else {
      onInsufficientFunds();
    }
  }

  Future<void> getLeaderboard() async {
    try {
      final response = await _onlineGameRepository.getLeaderBoard();
      if (!response.status) throw response.message;
      state = state.copyWith(
        leaderLoadSate: LoadState.success,
        globalLeaderboard: response.data?.data?.globalLeaderboard ?? [],
      );
    } catch (e) {
      state = state.copyWith(leaderLoadSate: LoadState.error);
      debugLog(e.toString());
    }
  }

  Future<void> handleDailyStreakCheck({
    Function(String)? onError,
    Function()? onSuccess,
  }) async {
    state = state.copyWith(streakLoadState: LoadState.loading);

    try {
      final shouldRecordStreak = await _gameRepository.checkDailyStreak();

      if (shouldRecordStreak) {
        final success = await _gameRepository.recordDailyStreak();

        if (success) {
          state = state.copyWith(streakLoadState: LoadState.success);
          if (onSuccess != null) onSuccess();
        } else {
          state = state.copyWith(streakLoadState: LoadState.error);
          if (onError != null)
            onError("Couldn't update your streak. Try again later!");
          debugLog("Couldn't update your streak. Try again later!");
        }
      }
    } catch (e) {
      state = state.copyWith(streakLoadState: LoadState.error);
      debugLog(e.toString());
    }
  }
}

final onlineGameNotifierProvider =
    NotifierProvider<OnlineGameNotifier, OnlineGameState>(
        OnlineGameNotifier.new);
