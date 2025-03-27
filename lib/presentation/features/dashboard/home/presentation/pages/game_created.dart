import 'package:doi_mobile/core/extensions/texttheme_extensions.dart';
import 'package:doi_mobile/core/extensions/widget_extensions.dart';
import 'package:doi_mobile/core/utils/colors.dart';
import 'package:doi_mobile/gen/assets.gen.dart';
import 'package:doi_mobile/gen/fonts.gen.dart';
import 'package:doi_mobile/presentation/features/dashboard/home/presentation/pages/widgets/coin_count.dart';
import 'package:doi_mobile/presentation/general_widgets/doi_appbar.dart';
import 'package:doi_mobile/presentation/general_widgets/doi_scaffold.dart';
import 'package:doi_mobile/presentation/general_widgets/doi_svg_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GameCreated extends StatelessWidget {
  const GameCreated({super.key});

  @override
  Widget build(BuildContext context) {
    return DoiScaffold(
      bodyPadding: EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 24,
      ),
      appbar: DoiAppbar(
        title: CoinCount(),
        trailing: AppSvgIcon(path: Assets.svgs.help),
      ),
      body: Column(
        children: [
          Text(
            'Game created!',
            style: context.textTheme.bodySmall?.copyWith(
              color: Color(0xFFD7A07D),
              fontSize: 14.sp,
            ),
          ),
          12.verticalSpace,
          Column(
            children: [
              AppSvgIcon(
                path: Assets.svgs.link,
              ),
              4.verticalSpace,
              Text(
                'Game Invite Link',
                style: context.textTheme.bodySmall?.copyWith(
                  color: AppColors.black,
                  fontSize: 16.sp,
                ),
              ),
              Text(
                'Share, Copy or Scan QR',
                style: context.textTheme.bodySmall?.copyWith(
                  fontSize: 12.sp,
                ),
              ),
              16.verticalSpace,
              Row(
                spacing: 8.w,
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 8, horizontal: 15),
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
                        'Share',
                        style: context.textTheme.bodyMedium?.copyWith(
                          fontFamily: FontFamily.jungleAdventurer,
                          fontSize: 16.sp,
                          color: AppColors.white,
                        ),
                        textScaler: const TextScaler.linear(1.0),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 8, horizontal: 15),
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
                      child: AppSvgIcon(path: Assets.svgs.copy),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 8, horizontal: 15),
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
                        'Share',
                        style: context.textTheme.bodyMedium?.copyWith(
                          fontFamily: FontFamily.jungleAdventurer,
                          fontSize: 16.sp,
                          color: AppColors.white,
                        ),
                        textScaler: const TextScaler.linear(1.0),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ).withContainer()
        ],
      ),
    );
  }
}
