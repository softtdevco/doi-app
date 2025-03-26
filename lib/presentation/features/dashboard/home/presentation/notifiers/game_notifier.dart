import 'dart:async';
import 'dart:math';

import 'package:doi_mobile/core/utils/enums.dart';
import 'package:doi_mobile/core/utils/logger.dart';
import 'package:doi_mobile/domain/usecases/ai_strategy.dart';
import 'package:doi_mobile/presentation/features/dashboard/home/data/model/guess_model.dart';
import 'package:doi_mobile/presentation/features/dashboard/home/data/repository/game_repository.dart';
import 'package:doi_mobile/presentation/features/dashboard/home/data/repository/game_repository_impl.dart';
import 'package:doi_mobile/presentation/features/dashboard/home/presentation/notifiers/game_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GameNotifier extends Notifier<GameState> {
  GameNotifier();
  late GameRepository _gameRepository;
  @override
  GameState build() {
    _gameRepository = ref.read(gameRepositoryProvider);
    _loadSavedGame();

    ref.onDispose(() {
      _timer?.cancel();
    });
    return GameState.initial();
  }

  Timer? _timer;

  Future<void> _loadSavedGame() async {
    final savedGame = _gameRepository.getCurrentGame();
    if (savedGame != null) {
      state = GameState.fromJson(savedGame);
      if (!state.isGameOver &&
          state.timeRemaining > 0 &&
          int.parse(state.timerValue) > 0) {
        resumeTimer();
      }
    }
  }

  void startNewGame({
    required String playerCode,
    required bool aiPlayback,
    required String gameMode,
    required String timerValue,
    required int aiDifficulty,
  }) async {
    final aiCode = _generateSecretCode();
    debugLog('==== GAME STARTED ====');
    debugLog('AI secret code (for player to guess): $aiCode');
    debugLog('Game mode: $gameMode');
    debugLog('AI playback enabled: $aiPlayback');
    if (aiPlayback) {
      debugLog('Player secret code (for AI to guess): $playerCode');
    }

    int timerSeconds = 0;
    if (timerValue != '0') {
      timerSeconds = int.parse(timerValue) * 60;
    }
    state = GameState(
      playerSecretCode: playerCode,
      aiSecretCode: aiCode,
      playerGuesses: [],
      aiGuesses: [],
      isPlayerTurn: true,
      timerActive: timerSeconds > 0,
      aiPlaybackEnabled: aiPlayback,
      timerValue: timerValue,
      timeRemaining: timerSeconds,
      isGameOver: false,
      winner: null,
      gameMode: gameMode,
      aiDifficulty: aiDifficulty,
      gameCoins: 0,
      gamePoints: 0,
      codeSwapsRemaining: 1,
      maxCodeSwaps: 1,
    );

    _saveGameState();

    if (timerSeconds > 0) {
      startTimer();
    }
  }

  void swapPlayerCode({required void Function() onCodeChange}) {
    if (!state.aiPlaybackEnabled ||
        state.codeSwapsRemaining <= 0 ||
        state.isGameOver) {
      return;
    }

    String newCode;
    do {
      newCode = _generateSecretCode();
    } while (newCode == state.playerSecretCode);
    debugLog('New Player secret code (for AI to guess): $newCode');
    onCodeChange();
    state = state.copyWith(
      playerSecretCode: newCode,
      codeSwapsRemaining: 0,
    );

    _saveGameState();
  }

  void makePlayerGuess(String guessCode) {
    if (state.isGameOver || !state.isPlayerTurn) return;

    final feedback = _calculateFeedback(guessCode, state.aiSecretCode);

    final newGuess = Guess(
      code: guessCode,
      deadCount: feedback.deadCount,
      injuredCount: feedback.injuredCount,
    );

    state = state.copyWith(
      playerGuesses: [...state.playerGuesses, newGuess],
      isPlayerTurn: !state.aiPlaybackEnabled,
    );

    if (feedback.deadCount == 4) {
      if (state.aiPlaybackEnabled) {
        final lastAiGuess =
            state.aiGuesses.isNotEmpty ? state.aiGuesses.last : null;
        if (lastAiGuess != null && lastAiGuess.deadCount == 4) {
          _endGame(winner: 'draw');
        } else {
          _endGame(winner: 'player');
        }
      } else {
        _endGame(winner: 'player');
      }
      return;
    }

    if (state.aiPlaybackEnabled) {
      pauseTimer();
      Future.delayed(Duration(seconds: 1), () {
        makeAiGuess();
      });
    }

    _saveGameState();
  }

  void makeAiGuess() {
    if (state.isGameOver || state.isPlayerTurn) return;

    final aiGuess = AiStrategy.generateAiGuess(
      previousGuesses: state.aiGuesses,
      difficulty: state.aiDifficulty,
      secretCode: state.playerSecretCode,
    );
    debugLog('<=== Ai guess ${aiGuess} ==>');

    final feedback = _calculateFeedback(aiGuess, state.playerSecretCode);

    final newGuess = Guess(
      code: aiGuess,
      deadCount: feedback.deadCount,
      injuredCount: feedback.injuredCount,
    );

    state = state.copyWith(
      aiGuesses: [...state.aiGuesses, newGuess],
      isPlayerTurn: true,
    );

    resumeTimer();

    if (feedback.deadCount == 4) {
      final lastPlayerGuess =
          state.playerGuesses.isNotEmpty ? state.playerGuesses.last : null;
      if (lastPlayerGuess != null && lastPlayerGuess.deadCount == 4) {
        _endGame(winner: 'draw');
      } else {
        _endGame(winner: 'ai');
      }
      return;
    }

    _saveGameState();
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

      if (state.timeRemaining % 15 == 0) {
        _saveGameState();
      }
    });
  }

  void pauseTimer() {
    _timer?.cancel();
    state = state.copyWith(timerActive: false);
    _saveGameState();
  }

  void resumeTimer() {
    if (state.timeRemaining > 0 && !state.isGameOver) {
      startTimer();
    }
  }

  void _handleTimerExpired() {
    if (state.aiPlaybackEnabled) {
      final bestPlayerGuess = state.playerGuesses.isEmpty
          ? null
          : state.playerGuesses
              .reduce((a, b) => a.deadCount > b.deadCount ? a : b);

      final bestAiGuess = state.aiGuesses.isEmpty
          ? null
          : state.aiGuesses.reduce((a, b) => a.deadCount > b.deadCount ? a : b);

      if (bestPlayerGuess == null && bestAiGuess == null) {
        _endGame(winner: 'draw');
      } else if (bestPlayerGuess == null) {
        _endGame(winner: 'ai');
      } else if (bestAiGuess == null) {
        _endGame(winner: 'player');
      } else {
        if (bestPlayerGuess.deadCount > bestAiGuess.deadCount) {
          _endGame(winner: 'player');
        } else if (bestAiGuess.deadCount > bestPlayerGuess.deadCount) {
          _endGame(winner: 'ai');
        } else {
          _endGame(winner: 'draw');
        }
      }
    } else {
      _endGame(winner: 'timeout');
    }
  }

  void _endGame({String? winner}) {
    _timer?.cancel();
    if (winner == 'player') {
      final earnedPoints = calculatePoints(state);
      final earnedCoins = calculateCoins(earnedPoints);
      _gameRepository.updatePoints(earnedPoints);
      _gameRepository.updateCoins(earnedCoins);
      _gameRepository.addToLeaderboard(earnedPoints);
      state = state.copyWith(
        isGameOver: true,
        winner: winner,
        timerActive: false,
        gameCoins: earnedCoins,
        gamePoints: earnedPoints,
      );
    } else {
      state = state.copyWith(
        isGameOver: true,
        winner: winner,
        timerActive: false,
      );
    }

    _saveGameState();
  }

  void _saveGameState() {
    final gameState = state.toJson();
    _gameRepository.saveGame(gameState);
  }

  void toggleTimer() {
    if (state.timeRemaining > 0 && !state.isGameOver) {
      if (state.timerActive) {
        pauseTimer();
      } else {
        resumeTimer();
      }
    }
  }

  _FeedbackResult _calculateFeedback(String guess, String secretCode) {
    int dead = 0;
    int injured = 0;

    var guessDigits = guess.split('');
    var secretDigits = secretCode.split('');

    for (int i = 0; i < 4; i++) {
      if (i < guessDigits.length &&
          i < secretDigits.length &&
          guessDigits[i] == secretDigits[i]) {
        dead++;

        guessDigits[i] = 'X';
        secretDigits[i] = 'Y';
      }
    }

    for (int i = 0; i < 4; i++) {
      if (i < guessDigits.length && guessDigits[i] != 'X') {
        int indexInSecret = secretDigits.indexOf(guessDigits[i]);
        if (indexInSecret != -1 && secretDigits[indexInSecret] != 'Y') {
          injured++;
          secretDigits[indexInSecret] = 'Y';
        }
      }
    }

    return _FeedbackResult(deadCount: dead, injuredCount: injured);
  }

  String _generateSecretCode() {
    return AiStrategy.generateSecretCode();
  }

  int calculatePoints(GameState gameState) {
    int basePoints;
    double timeMultiplier = 1.0;
    double difficultyMultiplier = 1.0;

    if (gameState.timerValue != '0') {
      basePoints = 1000;

      int totalTime = int.parse(gameState.timerValue) * 60;
      int remainingTime = gameState.timeRemaining;
      timeMultiplier = remainingTime / totalTime;
    } else {
      basePoints = 500;

      int numberOfGuesses = gameState.playerGuesses.length;

      timeMultiplier = min(10 / numberOfGuesses, 2.0);
    }

    if (gameState.gameMode == 'mystery') {
      difficultyMultiplier *= 1.5;
    }

    if (gameState.aiDifficulty == 1) {
      difficultyMultiplier *= 1.2;
    }

    int finalPoints =
        (basePoints * timeMultiplier * difficultyMultiplier).round();

    if (gameState.winner == 'player' && finalPoints < 100) {
      finalPoints = 100;
    }

    return finalPoints;
  }

  int calculateCoins(int points) {
    return (points / 100).floor();
  }
}

class _FeedbackResult {
  final int deadCount;
  final int injuredCount;

  _FeedbackResult({required this.deadCount, required this.injuredCount});
}

final gameNotifierProvider =
    NotifierProvider<GameNotifier, GameState>(GameNotifier.new);

final gameStatusProvider = Provider<GameStatus>((ref) {
  final gameState = ref.watch(gameNotifierProvider);

  if (gameState.isGameOver) {
    if (gameState.winner == 'player') {
      return GameStatus.playerWon;
    } else if (gameState.winner == 'ai') {
      return GameStatus.aiWon;
    } else if (gameState.winner == 'draw') {
      return GameStatus.draw;
    } else {
      return GameStatus.timeUp;
    }
  } else if (!gameState.isPlayerTurn) {
    return GameStatus.aiTurn;
  } else {
    return GameStatus.playerTurn;
  }
});
