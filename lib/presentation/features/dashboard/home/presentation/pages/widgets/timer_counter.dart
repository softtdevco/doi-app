import 'package:doi_mobile/core/extensions/texttheme_extensions.dart';
import 'package:doi_mobile/core/extensions/widget_extensions.dart';
import 'package:doi_mobile/core/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TimerCounter extends StatelessWidget {
  const TimerCounter({
    super.key,
    required this.quantity,
    required this.minus,
    required this.add,
    this.size = 16,
    this.background = AppColors.lightGreen,
    this.textColor = AppColors.greenText,
    this.color = AppColors.countGreen,
  });
  final int quantity;
  final Function()? minus, add;
  final double size;
  final Color background;
  final Color textColor;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: minus,
          child: Icon(
            Icons.remove,
            size: size,
            color: textColor.withValues(alpha: 0.5),
          ).withContainer(
            color: color,
            borderRadius: BorderRadius.circular(10),
            padding: EdgeInsets.symmetric(
              horizontal: 7.5,
              vertical: 8,
            ),
          ),
        ),
        2.horizontalSpace,
        Text(
          '$quantity',
          style: context.textTheme.bodySmall?.copyWith(
            fontSize: 14.sp,
            color: textColor,
          ),
        ),
        2.horizontalSpace,
        GestureDetector(
          onTap: add,
          child: Icon(
            Icons.add,
            size: size,
            color: textColor,
          ).withContainer(
              color: color,
              borderRadius: BorderRadius.circular(10),
              padding: EdgeInsets.symmetric(
                horizontal: 7.5,
                vertical: 8,
              )),
        )
      ],
    ).withContainer(
      color: background,
      padding: EdgeInsets.all(5),
      borderRadius: BorderRadius.circular(10.r),
    );
  }
}

class EvenCounter extends StatelessWidget {
  const EvenCounter({
    super.key,
    required this.quantity,
    required this.minus,
    required this.add,
    this.size = 16,
    this.background = AppColors.indicator,
    this.textColor = AppColors.secondaryColor,
    this.color = const Color(0xFFFFDBC4),
  });
  final int quantity;
  final Function()? minus, add;
  final double size;
  final Color background;
  final Color textColor;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '$quantity',
          style: context.textTheme.bodySmall?.copyWith(
            fontSize: 14.sp,
            color: textColor,
          ),
        ),
        Row(
          children: [
            GestureDetector(
              onTap: minus,
              child: Icon(
                Icons.remove,
                size: size,
                color: textColor.withValues(alpha: 0.5),
              ).withContainer(
                color: color,
                borderRadius: BorderRadius.circular(10),
                padding: EdgeInsets.symmetric(
                  horizontal: 17,
                  vertical: 14,
                ),
              ),
            ),
            16.horizontalSpace,
            GestureDetector(
              onTap: add,
              child: Icon(
                Icons.add,
                size: size,
                color: textColor,
              ).withContainer(
                  color: color,
                  borderRadius: BorderRadius.circular(10),
                  padding: EdgeInsets.symmetric(
                    horizontal: 17,
                    vertical: 14,
                  )),
            )
          ],
        )
      ],
    ).withContainer(
      color: background,
      padding: EdgeInsets.only(
        left: 20,
        right: 5,
        top: 5,
        bottom: 5,
      ),
      borderRadius: BorderRadius.circular(10.r),
    );
  }
}
