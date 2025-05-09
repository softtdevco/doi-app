import 'package:doi_mobile/core/extensions/navigation_extensions.dart';
import 'package:doi_mobile/core/extensions/texttheme_extensions.dart';
import 'package:doi_mobile/core/extensions/widget_extensions.dart';
import 'package:doi_mobile/core/router/router.dart';
import 'package:doi_mobile/core/utils/colors.dart';
import 'package:doi_mobile/gen/assets.gen.dart';
import 'package:doi_mobile/l10n/l10n.dart';
import 'package:doi_mobile/presentation/features/dashboard/home/presentation/notifiers/home_notifier.dart';
import 'package:doi_mobile/presentation/features/dashboard/home/presentation/pages/widgets/timer_counter.dart';
import 'package:doi_mobile/presentation/features/dashboard/home/presentation/pages/widgets/timer_widget.dart';
import 'package:doi_mobile/presentation/features/dashboard/onlineGame/presentation/notifiers/online_game_notifier.dart';
import 'package:doi_mobile/presentation/general_widgets/doi_button.dart';
import 'package:doi_mobile/presentation/general_widgets/doi_checkbox.dart';
import 'package:doi_mobile/presentation/general_widgets/doi_svg_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StartMatch extends ConsumerStatefulWidget {
  const StartMatch({super.key});

  @override
  ConsumerState<StartMatch> createState() => _StartMatchState();
}

class _StartMatchState extends ConsumerState<StartMatch> {
  bool customChecked = false;
  bool realTime = false;
  bool setTimer = false;
  final List<String> mins = ['3', '5', '10'];
  int timerCount = 0;
  int guessCount = 0;

  @override
  Widget build(BuildContext context) {
    final notifier = ref.read(homeNotifierProvider.notifier);

    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 36),
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
                    color: Color(0xFFD7A07D),
                    borderRadius: BorderRadius.circular(8.r)),
              ),
            ),
            24.verticalSpace,
            Row(
              children: [
                Text(
                  'Quick pairing',
                  style: context.textTheme.bodySmall?.copyWith(
                    fontSize: 16.sp,
                  ),
                ),
                8.horizontalSpace,
                AppSvgIcon(
                  path: Assets.svgs.help,
                  fit: BoxFit.scaleDown,
                  height: 16,
                )
              ],
            ),
            8.verticalSpace,
            Row(
              children: [
                Flexible(
                  child: PairingTile(
                    title: 'Rapid',
                    path: Assets.svgs.speed,
                    subtitle: '20 seconds per turn',
                    time: '5 minutes total',
                  ),
                ),
                10.horizontalSpace,
                Flexible(
                  child: PairingTile(
                    title: 'Classic Duel',
                    path: Assets.svgs.target,
                    subtitle: '60 seconds per turn',
                    time: 'No time limit',
                  ),
                )
              ],
            ),
            12.verticalSpace,
            Row(
              children: [
                Flexible(
                  child: PairingTile(
                    title: 'Blitz Mode',
                    path: Assets.svgs.rocket,
                    subtitle: 'One random power-up auto-applied',
                    time: '3 minutes total',
                  ),
                ),
                10.horizontalSpace,
                Flexible(
                  child: PairingTile(
                    title: 'Mind Bender',
                    path: Assets.svgs.mindBender,
                    subtitle: 'Code length is 5 digits instead of 4',
                    time: '7 minutes total',
                  ),
                )
              ],
            ),
            24.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Custom',
                  style: context.textTheme.bodySmall?.copyWith(
                    fontSize: 16.sp,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      customChecked = !customChecked;
                    });
                  },
                  child: RotatedBox(
                    quarterTurns: customChecked ? 3 : 1,
                    child: AppSvgIcon(
                      path: Assets.svgs.arrowForwardIos,
                      color: AppColors.secondaryColor,
                    ),
                  ),
                )
              ],
            ),
            if (customChecked) ...[
              27.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Realtime',
                    style: context.textTheme.bodySmall?.copyWith(
                      fontSize: 16.sp,
                    ),
                  ),
                  CupertinoSwitch(
                    value: realTime,
                    onChanged: (p0) {
                      setState(() {
                        realTime = p0;
                      });
                    },
                    activeTrackColor: AppColors.primaryColor,
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
                    ),
                  ),
                  8.horizontalSpace,
                  DoiCheckbox(
                    isGreenCheck: true,
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
                            textColor: AppColors.secondaryColor,
                            color: AppColors.indicator,
                            onTap: () => notifier.updateTimer(mins[i]),
                            min: mins[i],
                          ),
                        ),
                      ),
                      10.horizontalSpace,
                      TimerCounter(
                          textColor: AppColors.secondaryColor,
                          color: Color(0xFFFFCCAB),
                          background: AppColors.indicator,
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
                            color: AppColors.primaryColor,
                          ),
                          4.horizontalSpace,
                          Text(
                            context.l10n.mins,
                            style: context.textTheme.bodySmall?.copyWith(
                              fontSize: 14.sp,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
              24.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Guess digits',
                    style: context.textTheme.bodySmall?.copyWith(
                      fontSize: 16.sp,
                    ),
                  ),
                  TimerCounter(
                      textColor: AppColors.secondaryColor,
                      color: Color(0xFFFFCCAB),
                      background: AppColors.indicator,
                      quantity: guessCount,
                      minus: () {
                        if (guessCount > 1) {
                          setState(() {
                            guessCount--;
                          });
                        }
                      },
                      add: () {
                        if (guessCount < 90) {
                          setState(() {
                            guessCount++;
                          });
                        }
                      }),
                ],
              ),
            ],
            53.verticalSpace,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 22.w),
              child: Consumer(builder: (context, r, c) {
                return DoiButton(
                  text: 'Start match',
                  onPressed: () {
                    context.popAndPushNamed(AppRouter.findingOpponents);
                  },
                );
              }),
            )
          ],
        ),
      ),
    );
  }
}

class PairingTile extends ConsumerWidget {
  const PairingTile({
    super.key,
    required this.path,
    required this.title,
    required this.subtitle,
    required this.time,
  });
  final String path, title, subtitle, time;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedType =
        ref.watch(onlineGameNotifierProvider.select((v) => v.pairing));
    return GestureDetector(
      onTap: () =>
          ref.read(onlineGameNotifierProvider.notifier).updatePairing(title),
      child: Column(
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                children: [
                  AppSvgIcon(path: path),
                  4.horizontalSpace,
                  Text(
                    title,
                    style: context.textTheme.bodySmall?.copyWith(
                      fontSize: 14.sp,
                      color: AppColors.secondaryColor,
                    ),
                  ),
                ],
              ),
              if (selectedType == title) ...[
                20.horizontalSpace,
                AppSvgIcon(path: Assets.svgs.checkSquare)
              ]
            ],
          ),
          10.verticalSpace,
          Text(
            time,
            style: context.textTheme.bodySmall?.copyWith(
              fontSize: 10.sp,
              color: AppColors.secondaryColor.withValues(alpha: 0.7),
            ),
            textAlign: TextAlign.center,
          ),
          4.verticalSpace,
          Text(
            subtitle,
            style: context.textTheme.bodySmall?.copyWith(
              fontSize: 10.sp,
              color: AppColors.secondaryColor.withValues(alpha: 0.7),
            ),
            textAlign: TextAlign.center,
          )
        ],
      ).withContainer(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 8,
          ),
          borderRadius: BorderRadius.circular(10),
          color: AppColors.indicator,
          border: switch (selectedType == title) {
            true => Border.all(
                color: AppColors.secondaryColor,
                width: 2,
              ),
            _ => null
          }),
    );
  }
}
