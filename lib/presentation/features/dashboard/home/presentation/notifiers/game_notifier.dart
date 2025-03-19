import 'dart:async';

import 'package:doi_mobile/core/utils/logger.dart';
import 'package:doi_mobile/domain/usecases/ai_strategy.dart';
import 'package:doi_mobile/presentation/features/dashboard/home/data/model/guess_model.dart';
import 'package:doi_mobile/presentation/features/dashboard/home/data/repository/game_repository.dart';
import 'package:doi_mobile/presentation/features/dashboard/home/data/repository/game_repository_impl.dart';
import 'package:doi_mobile/presentation/features/dashboard/home/presentation/notifiers/game_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GameNotifier extends StateNotifier<GameState> {
  GameNotifier(this._gameRepository) : super(GameState.initial()) {
    _loadSavedGame();
  }

  final GameRepository _gameRepository;
  Timer? _timer;

  // Load saved game if exists
  Future<void> _loadSavedGame() async {
    final savedGame = _gameRepository.getCurrentGame();
    if (savedGame != null) {
      state = GameState.fromJson(savedGame);

      // Resume timer if game is in progress
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
  }) {
    final aiCode = _generateSecretCode();

    // Log the AI's secret code that the player needs to guess
    debugLog('==== GAME STARTED ====');
    debugLog('AI secret code (for player to guess): $aiCode');
    debugLog('Game mode: $gameMode');
    debugLog('AI playback enabled: $aiPlayback');
    if (aiPlayback) {
      debugLog('Player secret code (for AI to guess): $playerCode');
    }

    // Convert timer string to seconds
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
    );

    // Save to storage
    _saveGameState();

    // Start timer if enabled
    if (timerSeconds > 0) {
      startTimer();
    }
  }

  // Player makes a guess
  void makePlayerGuess(String guessCode) {
    if (state.isGameOver || !state.isPlayerTurn) return;

    // Calculate feedback
    final feedback = _calculateFeedback(guessCode, state.aiSecretCode);

    // Create new guess
    final newGuess = Guess(
      code: guessCode,
      deadCount: feedback.deadCount,
      injuredCount: feedback.injuredCount,
    );

    // Add the new guess to player's guesses
    state = state.copyWith(
      playerGuesses: [...state.playerGuesses, newGuess],
      isPlayerTurn:
          !state.aiPlaybackEnabled, // Change turn only if AI is active
    );

    // Check for win condition
    if (feedback.deadCount == 4) {
      // Player has guessed the code correctly
      if (state.aiPlaybackEnabled) {
        // Check if AI also won in previous turn
        final lastAiGuess =
            state.aiGuesses.isNotEmpty ? state.aiGuesses.last : null;
        if (lastAiGuess != null && lastAiGuess.deadCount == 4) {
          // Both player and AI guessed correctly - it's a draw
          _endGame(winner: 'draw');
        } else {
          // Only player guessed correctly
          _endGame(winner: 'player');
        }
      } else {
        // In single-player mode, player always wins if they guess correctly
        _endGame(winner: 'player');
      }
      return;
    }

    // Only trigger AI turn if AI playback is enabled
    if (state.aiPlaybackEnabled) {
      pauseTimer();
      Future.delayed(Duration(seconds: 1), () {
        makeAiGuess();
      });
    }

    _saveGameState();
  }

  // AI makes a guess
  void makeAiGuess() {
    if (state.isGameOver || state.isPlayerTurn) return;

    // Generate AI's guess based on previous feedback and difficulty level
    final aiGuess = AiStrategy.generateAiGuess(
      previousGuesses: state.aiGuesses,
      difficulty: state.aiDifficulty,
      secretCode: state.playerSecretCode,
    );
    debugLog('<=== Ai guess ${aiGuess} ==>');
    // Calculate feedback for AI's guess
    final feedback = _calculateFeedback(aiGuess, state.playerSecretCode);

    // Create new guess with feedback
    final newGuess = Guess(
      code: aiGuess,
      deadCount: feedback.deadCount,
      injuredCount: feedback.injuredCount,
    );

    // Update state with AI's guess
    state = state.copyWith(
      aiGuesses: [...state.aiGuesses, newGuess],
      isPlayerTurn: true,
    );

    // Resume timer for player's turn
    resumeTimer();

    // Check if AI won
    if (feedback.deadCount == 4) {
      // AI has guessed correctly
      // Check if player also guessed correctly in their last turn
      final lastPlayerGuess =
          state.playerGuesses.isNotEmpty ? state.playerGuesses.last : null;
      if (lastPlayerGuess != null && lastPlayerGuess.deadCount == 4) {
        // Both AI and player guessed correctly - it's a draw
        _endGame(winner: 'draw');
      } else {
        // Only AI guessed correctly
        _endGame(winner: 'ai');
      }
      return;
    }

    _saveGameState();
  }

  // Timer management
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

      // Save timer state periodically (every 15 seconds)
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

  // Handle timer expiry
  void _handleTimerExpired() {
    if (state.aiPlaybackEnabled) {
      // In competitive mode, compare progress
      final bestPlayerGuess = state.playerGuesses.isEmpty
          ? null
          : state.playerGuesses
              .reduce((a, b) => a.deadCount > b.deadCount ? a : b);

      final bestAiGuess = state.aiGuesses.isEmpty
          ? null
          : state.aiGuesses.reduce((a, b) => a.deadCount > b.deadCount ? a : b);

      // Compare best guesses
      if (bestPlayerGuess == null && bestAiGuess == null) {
        // No guesses were made - it's a draw
        _endGame(winner: 'draw');
      } else if (bestPlayerGuess == null) {
        // Only AI made guesses
        _endGame(winner: 'ai');
      } else if (bestAiGuess == null) {
        // Only player made guesses
        _endGame(winner: 'player');
      } else {
        // Both made guesses - compare best results
        if (bestPlayerGuess.deadCount > bestAiGuess.deadCount) {
          _endGame(winner: 'player');
        } else if (bestAiGuess.deadCount > bestPlayerGuess.deadCount) {
          _endGame(winner: 'ai');
        } else {
          // Equal best guesses - it's a draw
          _endGame(winner: 'draw');
        }
      }
    } else {
      // In single-player mode, timer expiry means player loses
      _endGame(winner: 'timeout');
    }
  }

  // End game
  void _endGame({String? winner}) {
    _timer?.cancel();
    state = state.copyWith(
      isGameOver: true,
      winner: winner,
      timerActive: false,
    );
    _saveGameState();
  }

  // Save game state to storage
  void _saveGameState() {
    final gameState = state.toJson();
    _gameRepository.saveGame(gameState);
  }

  // Calculate feedback for a guess
  _FeedbackResult _calculateFeedback(String guess, String secretCode) {
    int dead = 0;
    int injured = 0;

    // Create copies to mark used digits
    var guessDigits = guess.split('');
    var secretDigits = secretCode.split('');

    // First count dead (correct position)
    for (int i = 0; i < 4; i++) {
      if (i < guessDigits.length &&
          i < secretDigits.length &&
          guessDigits[i] == secretDigits[i]) {
        dead++;
        // Mark as used
        guessDigits[i] = 'X';
        secretDigits[i] = 'Y';
      }
    }

    // Then count injured (wrong position)
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

  // Generate a random 4-digit code with no repeating digits
  String _generateSecretCode() {
    return AiStrategy.generateSecretCode();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}

// Helper class for feedback results
class _FeedbackResult {
  final int deadCount;
  final int injuredCount;

  _FeedbackResult({required this.deadCount, required this.injuredCount});
}

enum GameStatus {
  playerTurn,
  aiTurn,
  playerWon,
  aiWon,
  draw,
  timeUp,
}

// Game state provider
final gameNotifierProvider = StateNotifierProvider<GameNotifier, GameState>(
  (ref) => GameNotifier(ref.read(gameRepositoryProvider)),
);

// Helper provider for current game status
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
