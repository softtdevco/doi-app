import 'package:doi_mobile/core/extensions/navigation_extensions.dart';
import 'package:doi_mobile/core/extensions/overlay_extensions.dart';
import 'package:doi_mobile/core/router/router.dart';
import 'package:doi_mobile/core/utils/colors.dart';
import 'package:doi_mobile/core/utils/enums.dart';
import 'package:doi_mobile/gen/assets.gen.dart';
import 'package:doi_mobile/presentation/features/dashboard/home/presentation/notifiers/game_notifier.dart';
import 'package:doi_mobile/presentation/features/dashboard/home/presentation/notifiers/game_state.dart';
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
  bool _hasNavigatedAfterWin = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.listenManual<GameState>(gameNotifierProvider, (previous, current) {
        if (!_hasNavigatedAfterWin &&
            current.isGameOver &&
            previous?.isGameOver != true) {
          _hasNavigatedAfterWin = true;

          Future.delayed(Duration(seconds: 3), () {
            context.replaceNamed(AppRouter.result,
                arguments: switch (current.winner) {
                  'player' => true,
                  _ => false,
                });
          });
        }
      });

      ref.listenManual<GameStatus>(gameStatusProvider, (previous, current) {
        if (previous != current) {
          _handleStatusChange(current);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final gameState = ref.watch(gameNotifierProvider);

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
                60.verticalSpace,
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

  void _handleStatusChange(GameStatus status) {
    switch (status) {
      case GameStatus.playerTurn:
        context.showSuccess(message: 'YOUR TURN!');
        break;
      case GameStatus.aiTurn:
        break;
      case GameStatus.playerWon:
        context.showSuccess(message: 'YOU WIN!');
        break;
      case GameStatus.aiWon:
        context.showError(message: 'YOU LOST');
        break;
      case GameStatus.draw:
        context.showError(message: 'YOU LOST');
        break;
      case GameStatus.timeUp:
        context.showError(message: 'YOU LOST');
        break;
    }
  }
}
