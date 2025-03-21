import 'package:doi_mobile/core/utils/colors.dart';
import 'package:doi_mobile/core/utils/enums.dart';
import 'package:doi_mobile/gen/assets.gen.dart';
import 'package:doi_mobile/presentation/features/dashboard/home/presentation/notifiers/game_notifier.dart';
import 'package:doi_mobile/presentation/features/dashboard/home/presentation/pages/widgets/game_keyboard.dart';
import 'package:doi_mobile/presentation/features/dashboard/home/presentation/pages/widgets/game_status_bar.dart';
import 'package:doi_mobile/presentation/features/dashboard/home/presentation/pages/widgets/guess_display.dart';
import 'package:doi_mobile/presentation/general_widgets/doi_svg_widget.dart';
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
  bool showKeyboard = true;
  @override
  Widget build(BuildContext context) {
    final gameState = ref.watch(gameNotifierProvider);
    final gameStatus = ref.watch(gameStatusProvider);

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
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
                30.verticalSpace,
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
                if (showKeyboard == true)
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        showKeyboard = !showKeyboard;
                      });
                    },
                    child: RotatedBox(
                      quarterTurns: 3,
                      child: AppSvgIcon(
                        path: Assets.svgs.left,
                        color: AppColors.dropColor,
                      ),
                    ),
                  ),
                20.verticalSpace,
                if (showKeyboard && !gameState.isGameOver)
                  GameKeyboard(
                    onNumberPressed: _onNumberPressed,
                    onDeletePressed: _onDeletePressed,
                    onSubmitPressed: _onSubmitPressed,
                    canSubmit: currentInput.length == 4,
                  ),
                if (showKeyboard == false)
                  AppSvgIcon(
                    path: Assets.svgs.keyboard,
                    color: AppColors.dropColor,
                    onTap: () {
                      setState(() {
                        showKeyboard = !showKeyboard;
                      });
                    },
                  )
              ],
            ),
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
