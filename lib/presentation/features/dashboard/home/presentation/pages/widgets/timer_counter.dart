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
  });
  final int quantity;
  final Function()? minus, add;
  final double size;

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
            color: AppColors.green,
          ).withContainer(
            color: AppColors.countGreen,
            borderRadius: BorderRadius.circular(10),
            padding: EdgeInsets.symmetric(
              horizontal: 7.5,
              vertical: 8,
            ),
          ),
        ),
        Text(
          'quantity',
          style: context.textTheme.bodySmall?.copyWith(
            fontSize: 14.sp,
            color: AppColors.greenText,
          ),
        ),
        GestureDetector(
          onTap: add,
          child: Icon(
            Icons.add,
            size: size,
            color: AppColors.greenText,
          ).withContainer(
              color: AppColors.countGreen,
              borderRadius: BorderRadius.circular(10),
              padding: EdgeInsets.symmetric(
                horizontal: 7.5,
                vertical: 8,
              )),
        )
      ],
    ).withContainer(
      color: AppColors.lightGreen,
      padding: EdgeInsets.all(5),
      borderRadius: BorderRadius.circular(10.r),
    );
  }
}
