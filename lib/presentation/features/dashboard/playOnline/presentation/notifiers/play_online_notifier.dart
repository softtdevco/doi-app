import 'dart:async';

import 'package:doi_mobile/core/utils/enums.dart';
import 'package:doi_mobile/core/utils/logger.dart';
import 'package:doi_mobile/data/third_party_services/socket_service.dart';
import 'package:doi_mobile/presentation/features/dashboard/home/data/model/create_game_request.dart';
import 'package:doi_mobile/presentation/features/dashboard/home/data/model/guess_model.dart';
import 'package:doi_mobile/presentation/features/dashboard/home/data/repository/game_repository.dart';
import 'package:doi_mobile/presentation/features/dashboard/home/data/repository/game_repository_impl.dart';
import 'package:doi_mobile/presentation/features/dashboard/onlineGame/data/repository/online_game_repository.dart';
import 'package:doi_mobile/presentation/features/dashboard/playOnline/presentation/notifiers/play_online_state.dart';
import 'package:doi_mobile/presentation/features/onboarding/data/repository/onboarding_repository.dart';
import 'package:doi_mobile/presentation/features/profile/data/repository/user_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlayOnlineNotifier extends Notifier<PlayOnlineState> {
  PlayOnlineNotifier();
  late OnlineGameRepository _onlineGameRepository;
  late GameRepository _gameRepository;
  late OnboardingRepository _onboardingRepository;
  late SocketClient _gamePlaySocketManager;
  late StreamSubscription _yourTurnSubscription;
  late StreamSubscription _winnerSubscription;
  late StreamSubscription _winnerEarningSubscription;
  late StreamSubscription _mobileEmitSubscription;
  late StreamSubscription _gameCreatedAndStartedSubscription;
  Timer? _timer;

  @override
  build() {
    _gameRepository = ref.read(gameRepositoryProvider);
    _onlineGameRepository = ref.read(onlineGameRepositoryProvider);
    _gamePlaySocketManager = ref.read(socketclient);
    _onboardingRepository = ref.read(onboardingRepositoryProvider);
    final eventStreamer = ref.read(socketEventsProvider);
    _yourTurnSubscription = eventStreamer.yourTurn.listen(handleYourTurn);
    _winnerSubscription = eventStreamer.gameEnded.listen(handleGameEnded);
    _winnerEarningSubscription =
        eventStreamer.matchupComplete.listen(handleWinnerEarnings);
    _mobileEmitSubscription =
        eventStreamer.mobileEmit.listen(handleGameControl);
    _gameCreatedAndStartedSubscription =
        eventStreamer.gameCreatedAndStarted.listen(handleGameCreatedAndStarted);

    ref.onDispose(() {
      stopPolling();
      _yourTurnSubscription.cancel();
      _winnerSubscription.cancel();
      _winnerEarningSubscription.cancel();
      _mobileEmitSubscription.cancel();
      _gameCreatedAndStartedSubscription.cancel();
      _timer?.cancel();
      _pollingTimer?.cancel();
    });

    return PlayOnlineState.initial();
  }

  bool _shouldPoll = false;
  Timer? _pollingTimer;

  void startPolling({
    required String joinCode,
    required int expectedPlayerCount,
  }) {
    _shouldPoll = true;
    state = state.copyWith(
      expectedPlayerCount: expectedPlayerCount,
      joinCode: joinCode,
    );

    getGameSession(
      joinCode: joinCode,
    );

    _pollingTimer = Timer.periodic(Duration(seconds: 3), (_) {
      if (_shouldPoll) {
        getGameSession(
          joinCode: joinCode,
        );
      }
    });
  }

  void stopPolling() {
    _shouldPoll = false;
    _pollingTimer?.cancel();
    _pollingTimer = null;
  }

  Future<void> getGameSession({
    required String joinCode,
  }) async {
    state = state.copyWith(gameSessionLoadState: LoadState.loading);
    try {
      final response = await _onlineGameRepository.getGameSession(
        joinCode: joinCode,
      );
      if (!response.status) throw response.message;

      String? secondPlayerId;
      final currentUser = ref.read(currentUserProvider);

      state = state.copyWith(
        gameSessionLoadState: LoadState.success,
        gameSessionData: response.data?.data,
      );

      if (response.data?.data?.players != null &&
          response.data!.data!.players!.length >= state.expectedPlayerCount) {
        debugLog(
            "Players found: ${response.data!.data!.players!.length}, Expected: ${state.expectedPlayerCount}");

        final otherPlayers = response.data!.data!.players!
            .where((player) => player.playerId != currentUser.id)
            .toList();

        if (otherPlayers.isNotEmpty) {
          secondPlayerId = otherPlayers.first.playerId;
          debugLog("Second player ID: $secondPlayerId");
          getUserById(userId: secondPlayerId ?? '');
        }

        debugLog("Stopping polling - all players joined");
        stopPolling();
      } else {
        debugLog(
            "Not enough players yet. Current: ${response.data?.data?.players?.length ?? 0}, Expected: ${state.expectedPlayerCount}");
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

  void handleGameEnded(dynamic data) {
    debugLog("Your winner: $data");
    if (data == null) return;
    _handleTimerExpired();
  }

  void updatePairing(String pairing) {
    state = state.copyWith(pairing: pairing);
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
    if (data == null) return;
    debugLog("Game control event: $data");
    if (data['message'] == 'pause') {
      pauseTimer();
    } else if (data['message'] == 'resume') {
      resumeTimer();
    }
  }

  void _handleTimerExpired() {
    _timer?.cancel();
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
        endGame();
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

  void joinOnlineGameRoom({
    required GameDuration time,
    required String secretCode,
    required Function(String) onError,
    required Function() onSuccess,
    required int timerValue,
  }) {
    state = state.copyWith(createGameLoadState: LoadState.loading);

    _gamePlaySocketManager.joinPlayOnlineRoom(
      time: time,
      secretCode: secretCode,
      onResponse: (response) {
        debugLog("Join Online response: $response");
        if (response['success'] == true) {
          onSuccess();
          state = state.copyWith(
            createGameLoadState: LoadState.success,
            timeRemaining: timerValue,
          );
        } else {
          state = state.copyWith(createGameLoadState: LoadState.error);
          onError(response['error']);
        }
      },
    );
  }

  void handleGameCreatedAndStarted(dynamic response) {
    debugLog("game created and started: $response");
    if (response["ok"] == true) {
      startPolling(
        joinCode: response['data']['msg']['code'],
        expectedPlayerCount: 2,
      );
    }
  }

  void endGame() {
    if (state.gameSessionData?.gameId == null ||
        state.gameSessionData?.gameId == '') {
      debugLog("Cannot make guess: Game ID is null");
      return;
    }

    _gamePlaySocketManager.endGame(
      gameId: state.gameSessionData?.gameId ?? '',
      onResponse: (response) {
        debugLog("End game response: $response");
        _handleTimerExpired();
      },
    );
  }

  Future<void> getUserById({
    void Function(String)? onError,
    void Function()? onCompleted,
    required String userId,
  }) async {
    state = state.copyWith(userLoadState: LoadState.loading);

    try {
      final response = await _onboardingRepository.getUserById(userId);
      if (!response.status) throw response.message;
      state = state.copyWith(
        userLoadState: LoadState.success,
        otherUser: response.data?.data,
        allPlayersJoined: true,
      );

      if (onCompleted != null) onCompleted();
    } catch (e) {
      state = state.copyWith(userLoadState: LoadState.error);
      if (onError != null) onError(e.toString());
    }
  }

  void resetState() {
    state = PlayOnlineState(
      loadState: state.loadState,
      pairing: state.pairing,
      playerGuesses: [],
      friendGuesses: [],
      joinGameData: state.joinGameData,
      createGameLoadState: state.createGameLoadState,
      gameSessionData: null,
      joinGameLoadState: LoadState.idle,
      gameSessionLoadState: LoadState.idle,
      expectedPlayerCount: 0,
      joinCode: null,
      yourTurn: false,
      timeRemaining: 0,
      timerActive: false,
      isGameOver: false,
      winnerId: null,
      winnerName: null,
      coinsEarned: null,
      pointsEarned: null,
      isTimeExpired: false,
      lastTurnEventId: null,
      allPlayersJoined: false,
      userLoadState: LoadState.idle,
      otherUser: null,
    );
    debugLog('<====State reset====>');
  }
}

final playOnlineNotifierProvider =
    NotifierProvider<PlayOnlineNotifier, PlayOnlineState>(
        PlayOnlineNotifier.new);
