import 'package:doi_mobile/core/extensions/context_extensions.dart';
import 'package:doi_mobile/core/extensions/texttheme_extensions.dart';
import 'package:doi_mobile/core/extensions/widget_extensions.dart';
import 'package:doi_mobile/core/utils/colors.dart';
import 'package:doi_mobile/gen/assets.gen.dart';
import 'package:doi_mobile/presentation/features/dashboard/home/data/model/guess_model.dart';
import 'package:doi_mobile/presentation/features/dashboard/home/presentation/notifiers/game_notifier.dart';
import 'package:doi_mobile/presentation/general_widgets/doi_svg_widget.dart';
import 'package:doi_mobile/presentation/general_widgets/game_paused.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GameStatusBar extends ConsumerWidget {
  final bool aiPlaybackEnabled;
  final bool timerActive;
  final int timeRemaining;
  final List<Guess> aiGuesses;

  const GameStatusBar({
    Key? key,
    required this.aiPlaybackEnabled,
    required this.timerActive,
    required this.timeRemaining,
    required this.aiGuesses,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final latestGuess = aiGuesses.isNotEmpty ? aiGuesses.last : null;

    final bestDeadCount = aiGuesses.isEmpty
        ? 0
        : aiGuesses.map((g) => g.deadCount).reduce((a, b) => a > b ? a : b);

    final aiProgress = bestDeadCount / 4;
    final state = ref.watch(gameNotifierProvider);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Row(
        children: [
          aiPlaybackEnabled
              ? Expanded(
                  child: Container(
                    padding: EdgeInsets.only(
                      left: 4.5.w,
                      right: 18.w,
                      top: 4.5.h,
                      bottom: 4.5.h,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.lightGreen,
                      borderRadius: BorderRadius.circular(34.r),
                    ),
                    child: Row(
                      children: [
                        AppSvgIcon(
                          path: Assets.svgs.ai,
                          fit: BoxFit.scaleDown,
                        ).withContainer(
                          color: AppColors.white,
                          shape: BoxShape.circle,
                          height: 50.h,
                          width: 50.w,
                        ),
                        8.horizontalSpace,
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'AI progress',
                                style: context.textTheme.bodySmall?.copyWith(
                                  fontSize: 16.sp,
                                  color: AppColors.greenText,
                                ),
                              ),
                              Row(
                                children: [
                                  Flexible(
                                    child: Row(
                                      children: [
                                        if ((latestGuess?.code ?? '')
                                            .isNotEmpty) ...[
                                          Text(
                                            latestGuess?.code ?? '',
                                            style: context.textTheme.bodySmall
                                                ?.copyWith(
                                              fontSize: 12.6.sp,
                                              color: AppColors.greenBorder,
                                            ),
                                          ),
                                          8.horizontalSpace,
                                        ],
                                        Row(
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  '${latestGuess?.deadCount ?? 0}',
                                                  style: context
                                                      .textTheme.bodySmall
                                                      ?.copyWith(
                                                    color: AppColors.greenText,
                                                    fontSize: 12.sp,
                                                  ),
                                                ),
                                                2.horizontalSpace,
                                                AppSvgIcon(
                                                  path: Assets.svgs.skull,
                                                  height: 8.4.h,
                                                  fit: BoxFit.scaleDown,
                                                ),
                                              ],
                                            ),
                                            2.horizontalSpace,
                                            Row(
                                              children: [
                                                Text(
                                                  '${latestGuess?.injuredCount ?? 0}',
                                                  style: context
                                                      .textTheme.bodySmall
                                                      ?.copyWith(
                                                    color: AppColors.greenText,
                                                    fontSize: 12.sp,
                                                  ),
                                                ),
                                                2.horizontalSpace,
                                                AppSvgIcon(
                                                  path: Assets.svgs.warning,
                                                  height: 8.4.h,
                                                  fit: BoxFit.scaleDown,
                                                ),
                                              ],
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  10.horizontalSpace,
                                  Flexible(
                                    child: LinearProgressIndicator(
                                      value: aiProgress,
                                      backgroundColor: Colors.white,
                                      valueColor: AlwaysStoppedAnimation(
                                          AppColors.green),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : Expanded(
                  child: Container(
                    padding: EdgeInsets.only(
                      left: 4.5.w,
                      right: 18.w,
                      top: 4.5.h,
                      bottom: 4.5.h,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.lightGreen,
                      borderRadius: BorderRadius.circular(34.r),
                    ),
                    child: Row(
                      children: [
                        AppSvgIcon(
                          path: Assets.svgs.singlePlayer,
                          fit: BoxFit.scaleDown,
                        ).withContainer(
                          color: AppColors.white,
                          shape: BoxShape.circle,
                          height: 50.h,
                          width: 50.w,
                        ),
                        8.horizontalSpace,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Single Player',
                              style: context.textTheme.bodySmall?.copyWith(
                                fontSize: 16.sp,
                                color: AppColors.greenText,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
          10.horizontalSpace,
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: timeRemaining > 0 ? 20.w : 25.w,
              vertical: timeRemaining > 0 ? 7.h : 15.h,
            ),
            decoration: BoxDecoration(
                color: AppColors.greenBorder,
                borderRadius: BorderRadius.circular(36.r),
                border: Border.all(
                  color: AppColors.greenText,
                  width: 2,
                )),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: state.timeRemaining > 0 && !state.isGameOver
                      ? () {
                          ref.read(gameNotifierProvider.notifier).toggleTimer();
                          context.showPopUp(GamePaused(
                            isOnline: false,
                          ));
                        }
                      : null,
                  child: Icon(
                    timerActive ? Icons.pause : Icons.play_arrow,
                    color: Colors.white,
                  ),
                ),
                if (timeRemaining > 0) ...[
                  Text(
                    _formatTime(timeRemaining),
                    style: context.textTheme.bodySmall?.copyWith(
                      fontSize: 14.sp,
                      color: AppColors.white,
                    ),
                  ),
                ]
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatTime(int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }
}
