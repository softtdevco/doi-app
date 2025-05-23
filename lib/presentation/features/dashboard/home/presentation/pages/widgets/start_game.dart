import 'package:doi_mobile/core/extensions/context_extensions.dart';
import 'package:doi_mobile/core/extensions/navigation_extensions.dart';
import 'package:doi_mobile/core/extensions/texttheme_extensions.dart';
import 'package:doi_mobile/core/router/router.dart';
import 'package:doi_mobile/core/utils/colors.dart';
import 'package:doi_mobile/core/utils/styles.dart';
import 'package:doi_mobile/gen/assets.gen.dart';
import 'package:doi_mobile/l10n/l10n.dart';
import 'package:doi_mobile/presentation/features/dashboard/home/presentation/notifiers/game_notifier.dart';
import 'package:doi_mobile/presentation/features/dashboard/home/presentation/notifiers/home_notifier.dart';
import 'package:doi_mobile/presentation/features/dashboard/home/presentation/pages/widgets/bar.dart';
import 'package:doi_mobile/presentation/features/dashboard/home/presentation/pages/widgets/new_game_ai.dart';
import 'package:doi_mobile/presentation/features/dashboard/home/presentation/pages/widgets/timer_counter.dart';
import 'package:doi_mobile/presentation/features/dashboard/home/presentation/pages/widgets/timer_widget.dart';
import 'package:doi_mobile/presentation/general_widgets/doi_button.dart';
import 'package:doi_mobile/presentation/general_widgets/doi_checkbox.dart';
import 'package:doi_mobile/presentation/general_widgets/doi_svg_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StartGame extends ConsumerStatefulWidget {
  const StartGame({super.key});

  @override
  ConsumerState<StartGame> createState() => _StartGameState();
}

class _StartGameState extends ConsumerState<StartGame> {
  bool playChecked = false;
  bool setTimer = false;
  final List<String> mins = ['3', '5', '10'];
  int timerCount = 0;
  @override
  Widget build(BuildContext context) {
    final notifier = ref.read(homeNotifierProvider.notifier);
    final selectedMode =
        ref.watch(homeNotifierProvider.select((v) => v.gameModeIndex));
    final selectedPlay =
        ref.watch(homeNotifierProvider.select((v) => v.playBackIndex));
    return Padding(
      padding: const EdgeInsets.fromLTRB(32, 16, 32, 36),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 28.w,
                height: 3.h,
                decoration: BoxDecoration(
                    color: AppColors.greenText,
                    borderRadius: BorderRadius.circular(8.r)),
              ),
            ),
            24.verticalSpace,
            Row(
              children: [
                Text(
                  context.l10n.aiPlay,
                  style: context.textTheme.bodySmall?.copyWith(
                    fontSize: 16.sp,
                    color: AppColors.greenText,
                  ),
                ),
                8.horizontalSpace,
                DoiCheckbox(
                  isChecked: playChecked,
                  onChecked: (p0) {
                    setState(() {
                      playChecked = !p0;
                    });
                  },
                ),
              ],
            ),
            if (playChecked) ...[
              8.verticalSpace,
              GameBarType(
                label1: context.l10n.easy,
                label2: context.l10n.hard,
                index: selectedPlay,
                onChanged: (p0) {
                  notifier.selectPlayBacksIndex(p0);
                },
              ),
              8.verticalSpace,
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppSvgIcon(path: Assets.svgs.info),
                  8.horizontalSpace,
                  Flexible(
                    child: Text(
                      context.l10n.whenDifficulty,
                      style: context.textTheme.bodySmall?.copyWith(
                        fontSize: 11.sp,
                        color: AppColors.tealGreen,
                      ),
                    ),
                  )
                ],
              ),
            ],
            24.verticalSpace,
            Text(
              context.l10n.gameMode,
              style: context.textTheme.bodySmall?.copyWith(
                fontSize: 16.sp,
                color: AppColors.greenText,
              ),
            ),
            8.verticalSpace,
            GameBarType(
              label1: context.l10n.hint,
              label2: context.l10n.mystery,
              index: selectedMode,
              onChanged: (p0) {
                notifier.selectGameModeIndex(p0);
              },
            ),
            8.verticalSpace,
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppSvgIcon(path: Assets.svgs.info),
                8.horizontalSpace,
                Flexible(
                  child: Text(
                    context.l10n.whenGameMode,
                    style: context.textTheme.bodySmall?.copyWith(
                      fontSize: 11.sp,
                      color: AppColors.tealGreen,
                    ),
                  ),
                )
              ],
            ),
            24.verticalSpace,
            Row(
              children: [
                Text(
                  context.l10n.setTimer,
                  style: context.textTheme.bodySmall?.copyWith(
                    fontSize: 16.sp,
                    color: AppColors.greenText,
                  ),
                ),
                8.horizontalSpace,
                DoiCheckbox(
                  isChecked: setTimer,
                  onChecked: (p0) {
                    setState(() {
                      setTimer = !p0;
                    });
                  },
                ),
              ],
            ),
            if (setTimer) ...[
              8.verticalSpace,
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Row(
                      spacing: 8.w,
                      children: List.generate(
                        mins.length,
                        (i) => TimerTile(
                          onTap: () => notifier.updateTimer(mins[i]),
                          min: mins[i],
                        ),
                      ),
                    ),
                    10.horizontalSpace,
                    TimerCounter(
                        quantity: timerCount,
                        minus: () {
                          if (timerCount > 1) {
                            setState(() {
                              timerCount--;
                            });
                            notifier.updateTimer(timerCount.toString());
                          }
                        },
                        add: () {
                          if (timerCount < 90) {
                            setState(() {
                              timerCount++;
                            });
                            notifier.updateTimer(timerCount.toString());
                          }
                        }),
                    12.horizontalSpace,
                    Row(
                      children: [
                        AppSvgIcon(
                          path: Assets.svgs.circleClock,
                        ),
                        4.horizontalSpace,
                        Text(
                          context.l10n.mins,
                          style: context.textTheme.bodySmall?.copyWith(
                            fontSize: 14.sp,
                            color: AppColors.greenText,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
            53.verticalSpace,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 22.w),
              child: Consumer(builder: (context, r, c) {
                final bool aiPlaybackEnabled = playChecked;
                final String gameMode = selectedMode == 0 ? 'hint' : 'mystery';
                final String timerValue = setTimer
                    ? r.watch(homeNotifierProvider.select((v) => v.timer))
                    : '0';
                final int aiDifficulty = selectedPlay;
                return DoiButton(
                  buttonStyle: DoiButtonStyle(
                    background: AppColors.green,
                    borderColor: AppColors.greenBorder,
                  ),
                  text: context.l10n.startGame,
                  onPressed: () {
                    aiPlaybackEnabled
                        ? _enterSecretCode(
                            aiPlayback: aiPlaybackEnabled,
                            gameMode: gameMode,
                            timerValue: timerValue,
                            aiDifficulty: aiDifficulty,
                          )
                        : _startNewGame(
                            aiPlayback: aiPlaybackEnabled,
                            gameMode: gameMode,
                            timerValue: timerValue,
                            aiDifficulty: aiDifficulty,
                            playerCode: '',
                          );
                  },
                );
              }),
            )
          ],
        ),
      ),
    );
  }

  void _enterSecretCode({
    required bool aiPlayback,
    required String gameMode,
    required String timerValue,
    required int aiDifficulty,
  }) {
    context.pop();
    context.showBottomSheet(
      color: AppColors.white,
      child: NewGameAi(
        aiPlayback: aiPlayback,
        gameMode: gameMode,
        timerValue: timerValue,
        aiDifficulty: aiDifficulty,
      ),
    );
  }

  void _startNewGame({
    required bool aiPlayback,
    required String gameMode,
    required String timerValue,
    required int aiDifficulty,
    required String playerCode,
  }) {
    ref.read(gameNotifierProvider.notifier).startNewGame(
          playerCode: playerCode,
          aiPlayback: aiPlayback,
          gameMode: gameMode,
          timerValue: timerValue,
          aiDifficulty: aiDifficulty,
        );
    context.popAndPushNamed(AppRouter.playGame);
  }
}
