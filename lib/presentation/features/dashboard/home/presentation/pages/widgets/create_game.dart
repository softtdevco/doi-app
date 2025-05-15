import 'package:doi_mobile/core/extensions/context_extensions.dart';
import 'package:doi_mobile/core/extensions/navigation_extensions.dart';
import 'package:doi_mobile/core/extensions/texttheme_extensions.dart';
import 'package:doi_mobile/core/utils/colors.dart';
import 'package:doi_mobile/gen/assets.gen.dart';
import 'package:doi_mobile/l10n/l10n.dart';
import 'package:doi_mobile/presentation/features/dashboard/home/presentation/notifiers/home_notifier.dart';
import 'package:doi_mobile/presentation/features/dashboard/home/presentation/pages/widgets/new_game_with.dart';
import 'package:doi_mobile/presentation/features/dashboard/home/presentation/pages/widgets/timer_counter.dart';
import 'package:doi_mobile/presentation/features/dashboard/home/presentation/pages/widgets/timer_widget.dart';
import 'package:doi_mobile/presentation/features/dashboard/home/presentation/pages/widgets/type_tile.dart';
import 'package:doi_mobile/presentation/features/dashboard/onlineGame/presentation/notifiers/online_game_notifier.dart';
import 'package:doi_mobile/presentation/general_widgets/doi_button.dart';
import 'package:doi_mobile/presentation/general_widgets/doi_checkbox.dart';
import 'package:doi_mobile/presentation/general_widgets/doi_svg_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CreateGame extends ConsumerStatefulWidget {
  const CreateGame({super.key});

  @override
  ConsumerState<CreateGame> createState() => _CreateGameState();
}

class _CreateGameState extends ConsumerState<CreateGame> {
  bool moreThan2Checked = false;
  bool setTimer = false;

  final List<String> mins = ['3', '5', '10'];
  int timerCount = 0;
  int guessCount = 4;
  int playersCount = 2;

  @override
  void initState() {
    super.initState();
  }

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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      'More than 2 players?',
                      style: context.textTheme.bodySmall?.copyWith(
                        fontSize: 14.sp,
                      ),
                    ),
                    8.horizontalSpace,
                    DoiCheckbox(
                      isGreenCheck: true,
                      isChecked: moreThan2Checked,
                      onChecked: (p0) {
                        setState(() {
                          moreThan2Checked = !p0;
                        });
                      },
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      '(Even Number)',
                      style: context.textTheme.bodySmall?.copyWith(
                        fontSize: 14.sp,
                      ),
                    ),
                    8.horizontalSpace,
                    AppSvgIcon(
                      path: Assets.svgs.help,
                      fit: BoxFit.scaleDown,
                      height: 16,
                    )
                  ],
                )
              ],
            ),
            if (moreThan2Checked) ...[
              8.verticalSpace,
              EvenCounter(
                  quantity: playersCount,
                  minus: () {
                    if (playersCount > 2) {
                      setState(() {
                        playersCount = playersCount - 2;
                      });
                    }
                  },
                  add: () {
                    setState(() {
                      playersCount = playersCount + 2;
                    });
                  }),
            ],
            24.verticalSpace,
            Row(
              children: [
                Text(
                  'Type',
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
                  child: TypeTile(text: 'Ranked'),
                ),
                12.horizontalSpace,
                Flexible(child: TypeTile(text: 'Casual'))
              ],
            ),
            8.verticalSpace,
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
                      if (guessCount > 3) {
                        setState(() {
                          guessCount--;
                        });
                      }
                    },
                    add: () {
                      if (guessCount < 4) {
                        setState(() {
                          guessCount++;
                        });
                      }
                    }),
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
            53.verticalSpace,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 22.w),
              child: Consumer(builder: (context, r, c) {
                final timerValue =
                    r.watch(homeNotifierProvider.select((v) => v.timer));
                return DoiButton(
                  text: 'Create game',
                  onPressed: () {
                    ref.read(onlineGameNotifierProvider.notifier).resetState();
                    context.pop();
                    context.showBottomSheet(
                      color: AppColors.white,
                      child: NewGameWith(
                        timerValue: timerValue,
                        isGroup: playersCount > 2,
                        playerCount: playersCount,
                        guessDigits: guessCount,
                      ),
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
}
