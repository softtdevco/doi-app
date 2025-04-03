import 'package:doi_mobile/core/extensions/context_extensions.dart';
import 'package:doi_mobile/core/extensions/texttheme_extensions.dart';
import 'package:doi_mobile/core/extensions/widget_extensions.dart';
import 'package:doi_mobile/core/utils/colors.dart';
import 'package:doi_mobile/gen/assets.gen.dart';
import 'package:doi_mobile/gen/fonts.gen.dart';
import 'package:doi_mobile/presentation/features/dashboard/home/presentation/pages/widgets/coin_count.dart';
import 'package:doi_mobile/presentation/features/dashboard/home/presentation/pages/widgets/start_match.dart';
import 'package:doi_mobile/presentation/general_widgets/doi_appbar.dart';
import 'package:doi_mobile/presentation/general_widgets/doi_button.dart';
import 'package:doi_mobile/presentation/general_widgets/doi_scaffold.dart';
import 'package:doi_mobile/presentation/general_widgets/doi_svg_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PlayOnline extends StatelessWidget {
  const PlayOnline({super.key});

  @override
  Widget build(BuildContext context) {
    return DoiScaffold(
      showBackImage: false,
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DoiAppbar(
              title: CoinCount(),
              trailing: AppSvgIcon(path: Assets.svgs.help),
            ),
            26.verticalSpace,
            Padding(
              padding: EdgeInsets.all(24),
              child: Column(
                children: [
                  Stack(
                    children: [
                      DoiButton(
                        text: 'New Match',
                        onPressed: () => context.showBottomSheet(
                          isDismissible: true,
                          color: AppColors.background,
                          child: StartMatch(),
                        ),
                        trailing: Assets.svgs.add,
                      ),
                      Positioned(
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(15.r),
                              child: Assets.images.a1.image())),
                      Positioned(child: Assets.images.a2.image()),
                      Positioned(right: 0, child: Assets.images.a3.image()),
                    ],
                  ),
                  50.verticalSpace,
                  Text(
                    'Your Turn',
                    style: context.textTheme.bodySmall?.copyWith(
                      fontSize: 14.sp,
                      color: Color(0XFFD7A07D),
                    ),
                  ),
                  17.verticalSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Assets.images.brazil.image(
                            height: 45.h,
                            width: 45.w,
                            fit: BoxFit.cover,
                          ),
                          14.horizontalSpace,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Claudia',
                                style: context.textTheme.bodySmall?.copyWith(
                                  color: AppColors.black,
                                  fontSize: 14.sp,
                                ),
                              ),
                              Text(
                                'Guessed 3460 ',
                                style: context.textTheme.bodySmall?.copyWith(
                                    fontSize: 10.sp,
                                    color: AppColors.secondaryColor
                                        .withValues(alpha: 0.7)),
                              ),
                              Row(
                                children: [
                                  Text(
                                    '3',
                                    style:
                                        context.textTheme.bodyMedium?.copyWith(
                                      fontFamily: FontFamily.jungleAdventurer,
                                      fontSize: 12.sp,
                                      color: AppColors.secondaryColor,
                                    ),
                                  ),
                                  0.7.horizontalSpace,
                                  AppSvgIcon(
                                    path: Assets.svgs.skull,
                                    fit: BoxFit.scaleDown,
                                    height: 8.4,
                                  ),
                                  2.horizontalSpace,
                                  Text(
                                    '0',
                                    style:
                                        context.textTheme.bodyMedium?.copyWith(
                                      fontFamily: FontFamily.jungleAdventurer,
                                      fontSize: 12.sp,
                                      color: AppColors.secondaryColor,
                                    ),
                                  ),
                                  0.7.horizontalSpace,
                                  AppSvgIcon(
                                    path: Assets.svgs.warning,
                                    fit: BoxFit.scaleDown,
                                    height: 8.4,
                                  ),
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Column(
                            children: [
                              Text(
                                'Is guessing',
                                style: context.textTheme.bodySmall?.copyWith(
                                    fontSize: 10.sp,
                                    color: AppColors.secondaryColor
                                        .withValues(alpha: 0.7)),
                              ),
                              3.verticalSpace,
                              IntrinsicWidth(
                                child: Container(
                                  constraints: BoxConstraints(
                                    minWidth: 58.w,
                                  ),
                                  padding: EdgeInsets.symmetric(
                                    vertical: 4,
                                    horizontal: 5,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColors.iconBorder,
                                    borderRadius: BorderRadius.circular(6.r),
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    '3469',
                                    style:
                                        context.textTheme.bodySmall?.copyWith(
                                      color: AppColors.secondaryColor,
                                      fontSize: 14.sp,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          24.horizontalSpace,
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 15),
                              decoration: BoxDecoration(
                                color: AppColors.primaryColor,
                                borderRadius: BorderRadius.circular(12.r),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.secondaryColor,
                                    offset: const Offset(0, 5),
                                    blurRadius: 0,
                                    spreadRadius: 0,
                                  ),
                                ],
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                'Play',
                                style: context.textTheme.bodyMedium?.copyWith(
                                  fontFamily: FontFamily.jungleAdventurer,
                                  fontSize: 16.sp,
                                  color: AppColors.white,
                                ),
                                textScaler: const TextScaler.linear(0.8),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ).withContainer(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(27.r),
                    padding: EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 12,
                    ),
                  ),
                  16.verticalSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Assets.images.brazil.image(
                            height: 45.h,
                            width: 45.w,
                            fit: BoxFit.cover,
                          ),
                          14.horizontalSpace,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Finneas',
                                style: context.textTheme.bodySmall?.copyWith(
                                  color: AppColors.black,
                                  fontSize: 14.sp,
                                ),
                              ),
                              Text(
                                'Guessed 3469',
                                style: context.textTheme.bodySmall?.copyWith(
                                    fontSize: 10.sp,
                                    color: AppColors.secondaryColor
                                        .withValues(alpha: 0.7)),
                              ),
                              Row(
                                children: [
                                  Text(
                                    '4',
                                    style:
                                        context.textTheme.bodyMedium?.copyWith(
                                      fontFamily: FontFamily.jungleAdventurer,
                                      fontSize: 12.sp,
                                      color: AppColors.secondaryColor,
                                    ),
                                  ),
                                  0.7.horizontalSpace,
                                  AppSvgIcon(
                                    path: Assets.svgs.skull,
                                    fit: BoxFit.scaleDown,
                                    height: 8.4,
                                  ),
                                  2.horizontalSpace,
                                  Text(
                                    '0',
                                    style:
                                        context.textTheme.bodyMedium?.copyWith(
                                      fontFamily: FontFamily.jungleAdventurer,
                                      fontSize: 12.sp,
                                      color: AppColors.secondaryColor,
                                    ),
                                  ),
                                  0.7.horizontalSpace,
                                  AppSvgIcon(
                                    path: Assets.svgs.warning,
                                    fit: BoxFit.scaleDown,
                                    height: 8.4,
                                  ),
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Column(
                            children: [
                              Text(
                                'Is guessing',
                                style: context.textTheme.bodySmall?.copyWith(
                                    fontSize: 10.sp,
                                    color: AppColors.secondaryColor
                                        .withValues(alpha: 0.7)),
                              ),
                              3.verticalSpace,
                              IntrinsicWidth(
                                child: Container(
                                  constraints: BoxConstraints(
                                    minWidth: 58.w,
                                  ),
                                  padding: EdgeInsets.symmetric(
                                    vertical: 4,
                                    horizontal: 5,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColors.iconBorder,
                                    borderRadius: BorderRadius.circular(6.r),
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    '342069',
                                    style:
                                        context.textTheme.bodySmall?.copyWith(
                                      color: AppColors.secondaryColor,
                                      fontSize: 14.sp,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          24.horizontalSpace,
                          Text(
                            'You Lost!',
                            style: context.textTheme.bodySmall?.copyWith(
                              color: AppColors.secondaryColor,
                              fontSize: 14.sp,
                            ),
                          )
                        ],
                      )
                    ],
                  ).withContainer(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(27.r),
                    padding: EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 12,
                    ),
                  ),
                  43.verticalSpace,
                  Text(
                    'Their Turn',
                    style: context.textTheme.bodySmall?.copyWith(
                      fontSize: 14.sp,
                      color: Color(0XFFD7A07D),
                    ),
                  ),
                  17.verticalSpace,
                  Column(
                      spacing: 16,
                      children: List.generate(
                        2,
                        (i) => Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Assets.images.brazil.image(
                                  height: 45.h,
                                  width: 45.w,
                                  fit: BoxFit.cover,
                                ),
                                14.horizontalSpace,
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Earl',
                                      style:
                                          context.textTheme.bodySmall?.copyWith(
                                        color: AppColors.black,
                                        fontSize: 14.sp,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        AppSvgIcon(
                                          path: Assets.svgs.sendEmail,
                                          fit: BoxFit.scaleDown,
                                        ),
                                        2.horizontalSpace,
                                        Text(
                                          '20Mins ago',
                                          style: context.textTheme.bodySmall
                                              ?.copyWith(
                                                  fontSize: 10.sp,
                                                  color: AppColors
                                                      .secondaryColor
                                                      .withValues(alpha: 0.7)),
                                        ),
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      'Your last guess',
                                      style: context.textTheme.bodySmall
                                          ?.copyWith(
                                              fontSize: 10.sp,
                                              color: AppColors.secondaryColor
                                                  .withValues(alpha: 0.7)),
                                    ),
                                    3.verticalSpace,
                                    IntrinsicWidth(
                                      child: Container(
                                        constraints: BoxConstraints(
                                          minWidth: 58.w,
                                        ),
                                        padding: EdgeInsets.symmetric(
                                          vertical: 4,
                                          horizontal: 5,
                                        ),
                                        decoration: BoxDecoration(
                                          color: AppColors.iconBorder,
                                          borderRadius:
                                              BorderRadius.circular(6.r),
                                        ),
                                        alignment: Alignment.center,
                                        child: Text(
                                          '3469',
                                          style: context.textTheme.bodySmall
                                              ?.copyWith(
                                            color: AppColors.secondaryColor,
                                            fontSize: 14.sp,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                24.horizontalSpace,
                                Column(
                                  children: [
                                    Text(
                                      'Results',
                                      style: context.textTheme.bodySmall
                                          ?.copyWith(
                                              fontSize: 10.sp,
                                              color: AppColors.secondaryColor
                                                  .withValues(alpha: 0.7)),
                                    ),
                                    10.verticalSpace,
                                    Row(
                                      children: [
                                        Text(
                                          '3',
                                          style: context.textTheme.bodyMedium
                                              ?.copyWith(
                                            fontFamily:
                                                FontFamily.jungleAdventurer,
                                            fontSize: 14.sp,
                                            color: AppColors.secondaryColor,
                                          ),
                                        ),
                                        0.7.horizontalSpace,
                                        AppSvgIcon(
                                          path: Assets.svgs.skull,
                                          fit: BoxFit.scaleDown,
                                          height: 10.h,
                                        ),
                                        2.horizontalSpace,
                                        Text(
                                          '0',
                                          style: context.textTheme.bodyMedium
                                              ?.copyWith(
                                            fontFamily:
                                                FontFamily.jungleAdventurer,
                                            fontSize: 14.sp,
                                            color: AppColors.secondaryColor,
                                          ),
                                        ),
                                        0.7.horizontalSpace,
                                        AppSvgIcon(
                                          path: Assets.svgs.warning,
                                          fit: BoxFit.scaleDown,
                                          height: 10.h,
                                        ),
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            )
                          ],
                        ).withContainer(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(27.r),
                          padding: EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 12,
                          ),
                        ),
                      ))
                ],
              ),
            ),
          ],
        ),
      ),
      footerButton: Assets.images.mobileLeaderboard.image(),
    );
  }
}
