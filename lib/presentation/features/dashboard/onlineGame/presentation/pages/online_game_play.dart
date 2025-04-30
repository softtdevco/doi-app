import 'package:doi_mobile/core/extensions/overlay_extensions.dart';
import 'package:doi_mobile/core/utils/colors.dart';
import 'package:doi_mobile/gen/assets.gen.dart';
import 'package:doi_mobile/presentation/features/dashboard/home/presentation/notifiers/game_notifier.dart';
import 'package:doi_mobile/presentation/features/dashboard/home/presentation/pages/widgets/game_keyboard.dart';
import 'package:doi_mobile/presentation/features/dashboard/onlineGame/presentation/notifiers/onine_game_state.dart';
import 'package:doi_mobile/presentation/features/dashboard/onlineGame/presentation/notifiers/online_game_notifier.dart';
import 'package:doi_mobile/presentation/features/dashboard/onlineGame/presentation/pages/widgets/online_game_status_bar.dart';
import 'package:doi_mobile/presentation/features/dashboard/onlineGame/presentation/pages/widgets/online_guess_display.dart';
import 'package:doi_mobile/presentation/general_widgets/doi_svg_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class OnlineGamePlay extends ConsumerStatefulWidget {
  const OnlineGamePlay({super.key});

  @override
  ConsumerState<OnlineGamePlay> createState() => _OnlineGamePlayState();
}

class _OnlineGamePlayState extends ConsumerState<OnlineGamePlay>
    with SingleTickerProviderStateMixin {
  final List<String> currentInput = [];
  bool showKeyboard = true;
  // bool _hasNavigatedAfterWin = false;
  late AnimationController _confettiController;
  bool _showConfetti = false;

  @override
  void initState() {
    super.initState();

    _confettiController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.listenManual<OnlineGameState>(onlineGameNotifierProvider,
          (previous, current) {
        if (current.yourTurn == true) {
          context.showSuccess(message: 'YOUR TURN!');
          setState(() {
            showKeyboard = true;
          });
        } else {
          setState(() {
            showKeyboard = false;
          });
        }
      });
    });
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final gameState = ref.watch(gameNotifierProvider);
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Container(
                color: AppColors.background,
                child: Column(
                  children: [
                    OnlineGameStatusBar(
                      friendGuesses: [],
                      timerActive: gameState.timerActive,
                      timeRemaining: gameState.timeRemaining,
                    ),
                    60.verticalSpace,
                    Expanded(
                      child: OnlineGuessDisplay(
                        currentInput: currentInput,
                        playerGuesses: gameState.playerGuesses,
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
                            color: AppColors.disableLock,
                          ),
                        ),
                      ),
                    20.verticalSpace,
                    if (showKeyboard &&
                        !gameState.isGameOver &&
                        gameState.isPlayerTurn)
                      GameKeyboard(
                        onNumberPressed: _onNumberPressed,
                        onDeletePressed: _onDeletePressed,
                        onSubmitPressed: _onSubmitPressed,
                        canSubmit: currentInput.length == 4,
                        aiPlaybackEnabled: true,
                        isOnline: true,
                      ),
                    if (showKeyboard == false)
                      AppSvgIcon(
                        path: Assets.svgs.keyboard,
                        color: AppColors.disableLock,
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
            if (_showConfetti)
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                height: 339.h,
                child: IgnorePointer(
                  child: Lottie.asset(
                    Assets.jsons.success,
                    controller: _confettiController,
                    fit: BoxFit.cover,
                    onLoaded: (composition) {
                      _confettiController.duration = composition.duration;
                    },
                  ),
                ),
              ),
          ],
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
      ref.read(onlineGameNotifierProvider.notifier).makeGuess(guess);
      setState(() {
        currentInput.clear();
      });
    }
  }
}
