import 'package:doi_mobile/core/extensions/context_extensions.dart';
import 'package:doi_mobile/core/extensions/navigation_extensions.dart';
import 'package:doi_mobile/core/extensions/texttheme_extensions.dart';
import 'package:doi_mobile/core/extensions/widget_extensions.dart';
import 'package:doi_mobile/core/utils/colors.dart';
import 'package:doi_mobile/gen/assets.gen.dart';
import 'package:doi_mobile/gen/fonts.gen.dart';
import 'package:doi_mobile/presentation/general_widgets/doi_button.dart';
import 'package:doi_mobile/presentation/general_widgets/doi_svg_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HowToPlayPop extends ConsumerStatefulWidget {
  const HowToPlayPop({super.key});

  @override
  ConsumerState<HowToPlayPop> createState() => _HowToPlayPopState();
}

class _HowToPlayPopState extends ConsumerState<HowToPlayPop> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                  child: Center(
                      child: Text(
                'How to play',
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
          ).withContainer(alignment: Alignment.centerRight),
          29.verticalSpace,
          Column(
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppSvgIcon(
                    path: Assets.svgs.target,
                    color: AppColors.secondaryColor,
                  ),
                  6.horizontalSpace,
                  Text(
                    'Objective',
                    style: context.textTheme.bodySmall
                        ?.copyWith(color: AppColors.orange0A),
                  )
                ],
              ).withContainer(
                color: AppColors.indicator,
                borderRadius: BorderRadius.circular(24.r),
                padding: EdgeInsets.only(
                  top: 8,
                  left: 10,
                  right: 10,
                  bottom: 8,
                ),
              ),
              9.verticalSpace,
              Text(
                'Crack your opponent’s secret code before they crack yours!',
                style: context.textTheme.bodySmall?.copyWith(
                  fontSize: 16.sp,
                  fontFamily: FontFamily.rimouski,
                  color: AppColors.secondaryColor,
                ),
                textAlign: TextAlign.center,
              ),
              35.verticalSpace,
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppSvgIcon(path: Assets.svgs.gameboy),
                  6.horizontalSpace,
                  Text(
                    'Gameplay',
                    style: context.textTheme.bodySmall
                        ?.copyWith(color: AppColors.orange0A),
                  )
                ],
              ).withContainer(
                color: AppColors.indicator,
                borderRadius: BorderRadius.circular(24.r),
                padding: EdgeInsets.only(
                  top: 8,
                  left: 10,
                  right: 10,
                  bottom: 8,
                ),
              ),
              9.verticalSpace,
              Text(
                'What the results mean',
                style: context.textTheme.bodySmall?.copyWith(
                  fontSize: 16.sp,
                  fontFamily: FontFamily.rimouski,
                  color: AppColors.secondaryColor,
                ),
                textAlign: TextAlign.center,
              ),
              16.verticalSpace,
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '1',
                        style: context.textTheme.bodyMedium?.copyWith(
                          fontFamily: FontFamily.jungleAdventurer,
                          fontSize: 10.4.sp,
                          color: AppColors.outsideGreen,
                        ),
                      ).withContainer(
                        alignment: Alignment.center,
                        color: AppColors.outsideBack,
                        height: 24.h,
                        width: 24.w,
                        borderRadius: BorderRadius.circular(1.6.r),
                      ),
                      8.horizontalSpace,
                      AppSvgIcon(
                        path: Assets.svgs.skull,
                        height: 24.h,
                        width: 24.w,
                      )
                    ],
                  ),
                  8.verticalSpace,
                  Text(
                    'Dead \n(Right Number & Position)',
                    style: context.textTheme.bodySmall?.copyWith(
                      fontSize: 12.sp,
                      color: AppColors.deadPosition,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  25.verticalSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '2',
                        style: context.textTheme.bodyMedium?.copyWith(
                          fontFamily: FontFamily.jungleAdventurer,
                          fontSize: 10.4.sp,
                          color: AppColors.injured,
                        ),
                      ).withContainer(
                        alignment: Alignment.center,
                        color: AppColors.injuredLight,
                        height: 24.h,
                        width: 24.w,
                        borderRadius: BorderRadius.circular(1.6.r),
                      ),
                      8.horizontalSpace,
                      AppSvgIcon(
                        path: Assets.svgs.warning,
                        height: 24.h,
                        width: 24.w,
                      )
                    ],
                  ),
                  8.verticalSpace,
                  Text(
                    'Injured \n(right number, wrong position)',
                    style: context.textTheme.bodySmall?.copyWith(
                      fontSize: 12.sp,
                      color: AppColors.injured,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ).withContainer(
                border: Border.all(
                  color: AppColors.iconBorder,
                ),
                borderRadius: BorderRadius.circular(12.r),
                padding: EdgeInsets.symmetric(
                  vertical: 24,
                  horizontal: 10,
                ),
              ),
              63.verticalSpace,
              DoiButton(
                width: context.width,
                text: 'Continue playing',
                onPressed: () {
                  context.pop();
                },
              ),
            ],
          )
        ],
      ).withContainer(padding: EdgeInsets.all(20)),
    );
  }
}
