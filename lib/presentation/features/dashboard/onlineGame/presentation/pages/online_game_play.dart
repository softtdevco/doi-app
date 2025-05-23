import 'package:doi_mobile/core/extensions/context_extensions.dart';
import 'package:doi_mobile/core/extensions/navigation_extensions.dart';
import 'package:doi_mobile/core/extensions/overlay_extensions.dart';
import 'package:doi_mobile/core/router/router.dart';
import 'package:doi_mobile/core/utils/colors.dart';
import 'package:doi_mobile/core/utils/logger.dart';
import 'package:doi_mobile/gen/assets.gen.dart';
import 'package:doi_mobile/presentation/features/dashboard/home/presentation/pages/widgets/game_keyboard.dart';
import 'package:doi_mobile/presentation/features/dashboard/onlineGame/presentation/notifiers/onine_game_state.dart';
import 'package:doi_mobile/presentation/features/dashboard/onlineGame/presentation/notifiers/online_game_notifier.dart';
import 'package:doi_mobile/presentation/features/dashboard/onlineGame/presentation/pages/widgets/online_game_status_bar.dart';
import 'package:doi_mobile/presentation/features/dashboard/onlineGame/presentation/pages/widgets/online_guess_display.dart';
import 'package:doi_mobile/presentation/features/profile/data/repository/user_repository_impl.dart';
import 'package:doi_mobile/presentation/features/profile/presentation/widgets/forfiet_pop.dart';
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
  bool disableButton = true;
  bool _hasNavigatedAfterWin = false;
  late AnimationController _confettiController;
  bool _showConfetti = false;
  String? _lastProcessedTurnEventId;
  @override
  void initState() {
    super.initState();

    _confettiController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final currentUser = ref.watch(currentUserProvider);
      ref.listenManual<OnlineGameState>(onlineGameNotifierProvider,
          (previous, current) {
        // Turn handling logic (unchanged)
        if (current.yourTurn &&
            current.lastTurnEventId != null &&
            current.lastTurnEventId != _lastProcessedTurnEventId) {
          debugLog("New turn event detected - showing banner and keyboard");

          _lastProcessedTurnEventId = current.lastTurnEventId;

          if (mounted) {
            Future.microtask(() {
              if (mounted) {
                context.showSuccess(message: 'YOUR TURN!');
                setState(() {
                  disableButton = false;
                });
                ref
                    .read(onlineGameNotifierProvider.notifier)
                    .toggleTimerwhileTurn(true);
              }
            });
          }
        } else if (current.yourTurn == false &&
            (previous == null || previous.yourTurn == true)) {
          debugLog("NOT your turn detected - hiding keyboard");
          setState(() {
            disableButton = true;
          });
          ref
              .read(onlineGameNotifierProvider.notifier)
              .toggleTimerwhileTurn(false);
        }

        if (current.isGameOver && (previous == null || !previous.isGameOver)) {
          debugLog("Game over detected, winnerId: ${current.winnerId}");

          if (current.winnerId != null) {
            if (current.winnerId == currentUser.id) {
              context.showSuccess(message: 'YOU WIN!');
              setState(() {
                _showConfetti = true;
              });
              _confettiController.forward();
            } else {
              context.showError(message: 'YOU LOST');
            }

            if (!_hasNavigatedAfterWin) {
              _hasNavigatedAfterWin = true;
              Future.delayed(Duration(seconds: 3), () {
                bool isWinner = current.winnerId == currentUser.id;
                context.replaceNamed(
                  AppRouter.result,
                  arguments: isWinner,
                );
              });
            }
          } else if (current.isTimeExpired) {
            context.showError(message: 'TIME EXPIRED - YOU LOST');

            if (!_hasNavigatedAfterWin) {
              _hasNavigatedAfterWin = true;
              Future.delayed(Duration(seconds: 3), () {
                context.replaceNamed(
                  AppRouter.result,
                  arguments: false,
                );
              });
            }
          } else {
            debugLog("Game over but winner not yet determined");
          }
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
    final state = ref.watch(onlineGameNotifierProvider);
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, dynamic result) {
        if (!didPop) {
          context.showPopUp(ForfietPop(
            isOnline: true,
            fromIsPaused: false,
          ));
        }
      },
      child: Scaffold(
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
                        friendGuesses: state.friendGuesses,
                        timerActive: state.timerActive,
                        timeRemaining: state.timeRemaining,
                      ),
                      60.verticalSpace,
                      Expanded(
                        child: OnlineGuessDisplay(
                          currentInput: currentInput,
                          playerGuesses: state.playerGuesses,
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
                      if (showKeyboard)
                        GameKeyboard(
                          onNumberPressed: _onNumberPressed,
                          onDeletePressed: _onDeletePressed,
                          onSubmitPressed: _onSubmitPressed,
                          canSubmit: currentInput.length == 4,
                          aiPlaybackEnabled: true,
                          isOnline: true,
                          disableKeyboard: disableButton,
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
      ref.read(onlineGameNotifierProvider.notifier).makeGuess(guess,
          onSuccess: () {
        setState(() {
          disableButton = true;
        });
        ref
            .read(onlineGameNotifierProvider.notifier)
            .toggleTimerwhileTurn(false);
      }, onError: (p0) {
        context.showError(message: p0);
      });
      setState(() {
        currentInput.clear();
      });
    }
  }
}
