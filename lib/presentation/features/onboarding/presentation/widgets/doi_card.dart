import 'package:doi_mobile/core/extensions/texttheme_extensions.dart';
import 'package:doi_mobile/core/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DoiCard extends StatelessWidget {
  const DoiCard({
    super.key,
    required this.color,
    required this.letter,
  });
  final Color color;
  final String letter;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48.w,
      height: 48.h,
      decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withValues(alpha: 0.15),
              spreadRadius: 1,
              blurRadius: 3,
              offset: const Offset(0, 2),
            ),
          ],
          border: Border.all(
            color: AppColors.white,
            width: 2,
          )),
      child: Center(
        child: Text(
          letter,
          style: context.textTheme.bodyLarge,
        ),
      ),
    );
  }
}
