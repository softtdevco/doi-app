import 'package:doi_mobile/core/extensions/texttheme_extensions.dart';
import 'package:doi_mobile/core/extensions/widget_extensions.dart';
import 'package:doi_mobile/core/utils/colors.dart';
import 'package:doi_mobile/gen/assets.gen.dart';
import 'package:doi_mobile/gen/fonts.gen.dart';
import 'package:doi_mobile/presentation/general_widgets/doi_svg_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PowerUpTile extends StatelessWidget {
  const PowerUpTile({
    super.key,
    required this.label,
    required this.iconPath,
    required this.onBuy,
  });
  final String label;
  final String iconPath;
  final void Function()? onBuy;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              AppSvgIcon(
                path: iconPath,
              ),
              14.horizontalSpace,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: context.textTheme.bodySmall?.copyWith(
                      color: AppColors.black,
                      fontSize: 16.sp,
                    ),
                  ),
                  Row(
                    children: [
                      AppSvgIcon(
                        path: Assets.svgs.coin,
                        fit: BoxFit.scaleDown,
                        height: 14,
                      ),
                      Text(
                        '200',
                        style: context.textTheme.bodySmall?.copyWith(
                          fontSize: 12.sp,
                        ),
                      )
                    ],
                  )
                ],
              )
            ],
          ),
          GestureDetector(
            onTap: onBuy,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 4, horizontal: 20),
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
                'Buy',
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
      ).withContainer(
        color: AppColors.indicator,
        borderRadius: BorderRadius.circular(12.r),
        padding: EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 16,
        ),
      ),
    );
  }
}
