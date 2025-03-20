import 'package:doi_mobile/core/extensions/texttheme_extensions.dart';
import 'package:doi_mobile/core/extensions/widget_extensions.dart';
import 'package:doi_mobile/core/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class QuantityCounter extends StatelessWidget {
  const QuantityCounter({
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
          ),
        ),
        20.horizontalSpace,
        Text(
          '$quantity',
          style: context.textTheme.bodySmall?.copyWith(
            fontSize: 14.sp,
            color: AppColors.greenText,
          ),
        ),
        20.horizontalSpace,
        GestureDetector(
          onTap: add,
          child: Icon(
            Icons.add,
            size: size,
            color: AppColors.black,
          ),
        )
      ],
    ).withContainer(
      border: Border.all(
        color: AppColors.lightGreen,
      ),
      padding: EdgeInsets.symmetric(
        vertical: 10.h,
        horizontal: 17.w,
      ),
      borderRadius: BorderRadius.circular(5.r),
    );
  }
}
