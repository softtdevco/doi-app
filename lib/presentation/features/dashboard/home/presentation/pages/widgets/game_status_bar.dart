import 'package:doi_mobile/core/extensions/texttheme_extensions.dart';
import 'package:doi_mobile/core/extensions/widget_extensions.dart';
import 'package:doi_mobile/core/utils/colors.dart';
import 'package:doi_mobile/gen/assets.gen.dart';
import 'package:doi_mobile/presentation/features/dashboard/home/data/model/guess_model.dart';
import 'package:doi_mobile/presentation/general_widgets/doi_svg_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GameStatusBar extends StatelessWidget {
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
  Widget build(BuildContext context) {
    final latestGuess = aiGuesses.isNotEmpty ? aiGuesses.last : null;

    final bestDeadCount = aiGuesses.isEmpty
        ? 0
        : aiGuesses.map((g) => g.deadCount).reduce((a, b) => a > b ? a : b);

    final aiProgress = bestDeadCount / 4;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Row(
        children: [
          if (aiPlaybackEnabled)
            Expanded(
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
                                    Text(
                                      latestGuess?.code ?? '',
                                      style:
                                          context.textTheme.bodySmall?.copyWith(
                                        fontSize: 12.6.sp,
                                        color: AppColors.greenBorder,
                                      ),
                                    ),
                                    8.horizontalSpace,
                                    Row(
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              '${latestGuess?.deadCount ?? 0}',
                                              style: context
                                                  .textTheme.bodyMedium
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
                                                  .textTheme.bodyMedium
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
                                  valueColor:
                                      AlwaysStoppedAnimation(AppColors.green),
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
            ),
          10.horizontalSpace,
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: timeRemaining > 0 ? 20.w : 32.w,
              vertical: timeRemaining > 0 ? 7.h : 20.h,
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
                Icon(
                  timerActive ? Icons.pause : Icons.play_arrow,
                  color: Colors.white,
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
