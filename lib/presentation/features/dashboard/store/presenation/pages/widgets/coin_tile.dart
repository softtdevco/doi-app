import 'package:doi_mobile/core/extensions/texttheme_extensions.dart';
import 'package:doi_mobile/core/extensions/widget_extensions.dart';
import 'package:doi_mobile/core/utils/colors.dart';
import 'package:doi_mobile/gen/fonts.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CoinTile extends StatelessWidget {
  const CoinTile({
    super.key,
    required this.path,
    required this.value,
    this.price,
    this.onBuy,
    this.isFree = false,
  });
  final String path;
  final String value;

  final (String, double)? price;
  final void Function()? onBuy;
  final bool isFree;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          path,
          fit: BoxFit.cover,
          height: 53.h,
          width: 94.w,
        ),
        8.verticalSpace,
        RichText(
          text: TextSpan(
            text: '${value} ',
            style: context.textTheme.bodySmall?.copyWith(
              fontSize: 12.sp,
            ),
            children: [
              TextSpan(
                text: ' Coins',
                style: context.textTheme.bodySmall?.copyWith(
                  fontSize: 10.sp,
                  color: AppColors.secondaryColor.withValues(alpha: 0.7),
                ),
              ),
            ],
          ),
        ),
        14.verticalSpace,
        GestureDetector(
          onTap: onBuy,
          child: Container(
            constraints: BoxConstraints(minWidth: 92.w),
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
            child: isFree
                ? Text(
                    'Watch Ad',
                    style: context.textTheme.bodyMedium?.copyWith(
                      fontFamily: FontFamily.jungleAdventurer,
                      fontSize: 16.sp,
                      color: AppColors.white,
                    ),
                    textScaler: const TextScaler.linear(1.0),
                  )
                : Text.rich(
                    textScaler: const TextScaler.linear(1.0),
                    TextSpan(
                      text: price?.$1 ?? '',
                      style: context.textTheme.bodyMedium?.copyWith(
                        fontFamily: '',
                        fontSize: 16.sp,
                        color: AppColors.white,
                      ),
                      children: [
                        TextSpan(
                          text: '${price?.$2 ?? 0.0}',
                          style: context.textTheme.bodyMedium?.copyWith(
                            fontFamily: FontFamily.jungleAdventurer,
                            fontSize: 16.sp,
                            color: AppColors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
          ),
        ),
      ],
    ).withContainer(
      color: AppColors.indicator,
      padding: EdgeInsets.all(9),
      borderRadius: BorderRadius.circular(
        12.r,
      ),
    );
  }
}
