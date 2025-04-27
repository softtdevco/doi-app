import 'package:doi_mobile/core/extensions/context_extensions.dart';
import 'package:doi_mobile/core/extensions/navigation_extensions.dart';
import 'package:doi_mobile/core/extensions/texttheme_extensions.dart';
import 'package:doi_mobile/core/extensions/widget_extensions.dart';
import 'package:doi_mobile/core/utils/colors.dart';
import 'package:doi_mobile/core/utils/styles.dart';
import 'package:doi_mobile/gen/assets.gen.dart';
import 'package:doi_mobile/gen/fonts.gen.dart';
import 'package:doi_mobile/presentation/features/dashboard/home/presentation/pages/widgets/bar.dart';
import 'package:doi_mobile/presentation/general_widgets/doi_button.dart';
import 'package:doi_mobile/presentation/general_widgets/doi_svg_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChallengePop extends StatefulWidget {
  const ChallengePop({super.key});

  @override
  State<ChallengePop> createState() => _ChallengePopState();
}

class _ChallengePopState extends State<ChallengePop> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 22.w),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    child: Center(
                        child: Text(
                  'Challenges',
                  style: context.textTheme.bodyMedium!.copyWith(
                    fontFamily: FontFamily.jungleAdventurer,
                    fontSize: 24.sp,
                    color: AppColors.darkShadeOrange,
                    fontWeight: FontWeight.w400,
                  ),
                ))),
                AppSvgIcon(
                  path: Assets.svgs.close,
                  onTap: () {
                    context.pop();
                  },
                  fit: BoxFit.scaleDown,
                ),
              ],
            ).withContainer(
              alignment: Alignment.centerRight,
            ),
            16.verticalSpace,
            GameBarType(
              textColor: AppColors.secondaryColor,
              cardColor: AppColors.indicator,
              label1: 'Daily',
              label2: 'Weekly',
              index: index,
              onChanged: (p0) {
                setState(() {
                  index = p0;
                });
              },
            ),
            24.verticalSpace,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Win 3 Games',
                  style: context.textTheme.bodySmall?.copyWith(
                    fontFamily: FontFamily.rimouski,
                    fontSize: 16.sp,
                    color: AppColors.secondaryColor,
                  ),
                ),
                16.verticalSpace,
                Container(
                  width: double.infinity,
                  height: 13.h,
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                )
                    .withContainer(
                      color: AppColors.glassfill,
                      padding: EdgeInsets.all(1),
                      borderRadius: BorderRadius.circular(16.r),
                    )
                    .withContainer(
                        color: AppColors.white,
                        padding: EdgeInsets.all(2),
                        borderRadius: BorderRadius.circular(9.r),
                        border: Border.all(
                          color: AppColors.primaryColor,
                        )),
                6.verticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Reward:',
                          style: context.textTheme.bodySmall?.copyWith(
                            fontFamily: FontFamily.rimouski,
                            fontSize: 12.sp,
                            color: AppColors.primaryColor,
                          ),
                        ),
                        Row(
                          children: [
                            AppSvgIcon(path: Assets.svgs.coin),
                            Text(
                              '200',
                              style: context.textTheme.bodySmall?.copyWith(
                                fontFamily: FontFamily.rimouski,
                                fontSize: 12.sp,
                                color: AppColors.secondaryColor,
                              ),
                            ),
                          ],
                        )
                      ],
                    ).withContainer(
                      padding: EdgeInsets.all(8),
                      color: AppColors.indicator,
                      borderRadius: BorderRadius.circular(42.r),
                    ),
                    Text(
                      '3/3',
                      style: context.textTheme.bodySmall?.copyWith(
                        fontFamily: FontFamily.rimouski,
                        fontSize: 12.sp,
                        color: AppColors.secondaryColor,
                      ),
                    )
                  ],
                ),
                16.verticalSpace,
                DoiButton(
                  height: 34.h,
                  width: context.width,
                  buttonStyle: DoiButtonStyle(
                    background: AppColors.claimColor,
                    borderColor: AppColors.secondaryColor,
                  ),
                  text: 'Claim reward',
                  onPressed: () {},
                ),
              ],
            ).withContainer(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(16.r),
              padding: EdgeInsets.symmetric(
                vertical: 12.h,
                horizontal: 16.w,
              ),
            ),
            16.verticalSpace,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Play 5 Quick Pairings',
                  style: context.textTheme.bodySmall?.copyWith(
                    fontFamily: FontFamily.rimouski,
                    fontSize: 16.sp,
                    color: AppColors.secondaryColor,
                  ),
                ),
                16.verticalSpace,
                Container(
                  width: context.width * 0.2,
                  height: 13.h,
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ).withContainer(
                  width: context.width,
                  alignment: Alignment.centerLeft,
                  color: AppColors.glassfill,
                  padding: EdgeInsets.all(1),
                  borderRadius: BorderRadius.circular(16.r),
                ),
                6.verticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Reward:',
                          style: context.textTheme.bodySmall?.copyWith(
                            fontFamily: FontFamily.rimouski,
                            fontSize: 12.sp,
                            color: AppColors.primaryColor,
                          ),
                        ),
                        Row(
                          children: [
                            AppSvgIcon(path: Assets.svgs.coin),
                            Text(
                              '200',
                              style: context.textTheme.bodySmall?.copyWith(
                                fontFamily: FontFamily.rimouski,
                                fontSize: 12.sp,
                                color: AppColors.secondaryColor,
                              ),
                            ),
                          ],
                        )
                      ],
                    ).withContainer(
                      padding: EdgeInsets.all(8),
                      color: AppColors.indicator,
                      borderRadius: BorderRadius.circular(42.r),
                    ),
                    Text(
                      '2/5',
                      style: context.textTheme.bodySmall?.copyWith(
                        fontFamily: FontFamily.rimouski,
                        fontSize: 12.sp,
                        color: AppColors.secondaryColor,
                      ),
                    )
                  ],
                ),
                16.verticalSpace,
                Opacity(
                  opacity: 0.5,
                  child: DoiButton(
                    height: 34.h,
                    width: context.width,
                    text: 'Claim reward',
                    buttonStyle: DoiButtonStyle(
                      background: AppColors.claimColor,
                      borderColor: AppColors.secondaryColor,
                    ),
                    onPressed: () {},
                  ),
                ),
              ],
            ).withContainer(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(16.r),
              padding: EdgeInsets.symmetric(
                vertical: 12.h,
                horizontal: 16.w,
              ),
            ),
            16.verticalSpace,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Use 2 Power-ups',
                  style: context.textTheme.bodySmall?.copyWith(
                    fontFamily: FontFamily.rimouski,
                    fontSize: 16.sp,
                    color: AppColors.secondaryColor,
                  ),
                ),
                16.verticalSpace,
                Container(
                  width: context.width * 0.05,
                  height: 13.h,
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ).withContainer(
                  width: context.width,
                  alignment: Alignment.centerLeft,
                  color: AppColors.glassfill,
                  padding: EdgeInsets.all(1),
                  borderRadius: BorderRadius.circular(16.r),
                ),
                6.verticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Reward:',
                          style: context.textTheme.bodySmall?.copyWith(
                            fontFamily: FontFamily.rimouski,
                            fontSize: 12.sp,
                            color: AppColors.primaryColor,
                          ),
                        ),
                        Row(
                          children: [
                            AppSvgIcon(path: Assets.svgs.coin),
                            Text(
                              '200',
                              style: context.textTheme.bodySmall?.copyWith(
                                fontFamily: FontFamily.rimouski,
                                fontSize: 12.sp,
                                color: AppColors.secondaryColor,
                              ),
                            ),
                          ],
                        )
                      ],
                    ).withContainer(
                      padding: EdgeInsets.all(8),
                      color: AppColors.indicator,
                      borderRadius: BorderRadius.circular(42.r),
                    ),
                    Text(
                      '0/2',
                      style: context.textTheme.bodySmall?.copyWith(
                        fontFamily: FontFamily.rimouski,
                        fontSize: 12.sp,
                        color: AppColors.secondaryColor,
                      ),
                    )
                  ],
                ),
                16.verticalSpace,
                Opacity(
                  opacity: 0.5,
                  child: DoiButton(
                    height: 34.h,
                    width: context.width,
                    text: 'Claim reward',
                    buttonStyle: DoiButtonStyle(
                      background: AppColors.claimColor,
                      borderColor: AppColors.secondaryColor,
                    ),
                    onPressed: () {},
                  ),
                ),
              ],
            ).withContainer(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(16.r),
              padding: EdgeInsets.symmetric(
                vertical: 12.h,
                horizontal: 16.w,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
