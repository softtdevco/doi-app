import 'package:doi_mobile/core/extensions/context_extensions.dart';
import 'package:doi_mobile/core/extensions/texttheme_extensions.dart';
import 'package:doi_mobile/core/utils/colors.dart';
import 'package:doi_mobile/gen/assets.gen.dart';
import 'package:doi_mobile/presentation/features/dashboard/home/data/model/guess_model.dart';
import 'package:doi_mobile/presentation/features/dashboard/home/presentation/notifiers/game_notifier.dart';
import 'package:doi_mobile/presentation/features/dashboard/onlineGame/presentation/notifiers/online_game_notifier.dart';
import 'package:doi_mobile/presentation/general_widgets/doi_svg_widget.dart';
import 'package:doi_mobile/presentation/general_widgets/game_paused.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnlineGameStatusBar extends ConsumerWidget {
  final bool timerActive;
  final int timeRemaining;
  final List<Guess> friendGuesses;

  const OnlineGameStatusBar({
    Key? key,
    required this.timerActive,
    required this.timeRemaining,
    required this.friendGuesses,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final latestGuess = friendGuesses.isNotEmpty ? friendGuesses.last : null;

    final bestDeadCount = friendGuesses.isEmpty
        ? 0
        : friendGuesses.map((g) => g.deadCount).reduce((a, b) => a > b ? a : b);

    final friendProgress = bestDeadCount / 4;
    final state = ref.watch(gameNotifierProvider);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.only(
                left: 4.5.w,
                right: 18.w,
                top: 4.5.h,
                bottom: 4.5.h,
              ),
              decoration: BoxDecoration(
                color: AppColors.indicator,
                borderRadius: BorderRadius.circular(34.r),
              ),
              child: Row(
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.circular(82.6.r),
                      child: Assets.images.opponet.image(
                        fit: BoxFit.cover,
                        height: 46.h,
                        width: 45.w,
                      )),
                  8.horizontalSpace,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Friend’s progress',
                          style: context.textTheme.bodySmall?.copyWith(
                            fontSize: 16.sp,
                            color: AppColors.secondaryColor,
                          ),
                        ),
                        Row(
                          children: [
                            Flexible(
                              child: Row(
                                children: [
                                  if ((latestGuess?.code ?? '').isNotEmpty) ...[
                                    Text(
                                      latestGuess?.code ?? '',
                                      style:
                                          context.textTheme.bodySmall?.copyWith(
                                        fontSize: 12.6.sp,
                                        color: AppColors.primaryColor,
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
                                            style: context.textTheme.bodySmall
                                                ?.copyWith(
                                              color: AppColors.secondaryColor,
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
                                            style: context.textTheme.bodySmall
                                                ?.copyWith(
                                              color: AppColors.secondaryColor,
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
                                value: friendProgress,
                                backgroundColor: Colors.white,
                                valueColor: AlwaysStoppedAnimation(
                                    AppColors.primaryColor),
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
              horizontal: timeRemaining > 0 ? 20.w : 25.w,
              vertical: timeRemaining > 0 ? 7.h : 15.h,
            ),
            decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.circular(36.r),
                border: Border.all(
                  color: AppColors.secondaryColor,
                  width: 2,
                )),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: state.timeRemaining > 0 && !state.isGameOver
                      ? () {
                          ref
                              .read(onlineGameNotifierProvider.notifier)
                              .toggleTimer();
                          context.showPopUp(GamePaused(
                            isOnline: true,
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
