import 'package:doi_mobile/core/utils/colors.dart';
import 'package:doi_mobile/core/utils/enums.dart';
import 'package:doi_mobile/presentation/features/dashboard/home/presentation/notifiers/game_notifier.dart';
import 'package:doi_mobile/presentation/features/dashboard/home/presentation/pages/widgets/game_keyboard.dart';
import 'package:doi_mobile/presentation/features/dashboard/home/presentation/pages/widgets/game_status_bar.dart';
import 'package:doi_mobile/presentation/features/dashboard/home/presentation/pages/widgets/guess_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PlayGame extends ConsumerStatefulWidget {
  const PlayGame({super.key});

  @override
  ConsumerState<PlayGame> createState() => _PlayGameState();
}

class _PlayGameState extends ConsumerState<PlayGame> {
  final List<String> currentInput = [];

  @override
  Widget build(BuildContext context) {
    final gameState = ref.watch(gameNotifierProvider);
    final gameStatus = ref.watch(gameStatusProvider);

    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              GameStatusBar(
                aiGuesses: gameState.aiGuesses,
                aiPlaybackEnabled: gameState.aiPlaybackEnabled,
                timerActive: gameState.timerActive,
                timeRemaining: gameState.timeRemaining,
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 12.h),
                color: AppColors.green,
                child: Text(
                  gameStatus == GameStatus.playerTurn
                      ? 'your turn'.toUpperCase()
                      : 'ai turn'.toUpperCase(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.sp,
                  ),
                ),
              ),
              Expanded(
                child: GuessDisplay(
                  currentInput: currentInput,
                  playerGuesses: gameState.playerGuesses,
                  gameMode: gameState.gameMode,
                  aiSecretCode: gameState.aiSecretCode,
                  isGameOver: gameState.isGameOver,
                  winner: gameState.winner,
                ),
              ),
              if (gameStatus == GameStatus.playerTurn && !gameState.isGameOver)
                GameKeyboard(
                  onNumberPressed: _onNumberPressed,
                  onDeletePressed: _onDeletePressed,
                  onSubmitPressed: _onSubmitPressed,
                  canSubmit: currentInput.length == 4,
                ),
            ],
          ),
        ),
      ),
    );
  }

  void _onNumberPressed(String digit) {
    if (currentInput.length < 4 && !currentInput.contains(digit)) {
      setState(() {
        currentInput.add(digit);
      });
    }
  }

  void _onDeletePressed() {
    if (currentInput.isNotEmpty) {
      setState(() {
        currentInput.removeLast();
      });
    }
  }

  void _onSubmitPressed() {
    if (currentInput.length == 4) {
      final guess = currentInput.join();
      ref.read(gameNotifierProvider.notifier).makePlayerGuess(guess);
      setState(() {
        currentInput.clear();
      });
    }
  }
}
