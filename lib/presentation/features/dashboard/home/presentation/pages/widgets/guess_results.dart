import 'package:doi_mobile/core/extensions/texttheme_extensions.dart';
import 'package:doi_mobile/core/utils/colors.dart';
import 'package:doi_mobile/gen/assets.gen.dart';
import 'package:doi_mobile/presentation/general_widgets/doi_svg_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GuessResult extends StatelessWidget {
  final int deadCount;
  final int injuredCount;

  const GuessResult({
    Key? key,
    required this.deadCount,
    required this.injuredCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Row(
          children: [
            Text(
              '$deadCount',
              style: context.textTheme.bodyMedium?.copyWith(
                color: AppColors.greenText,
                fontSize: 14.sp,
              ),
            ),
            4.horizontalSpace,
            AppSvgIcon(
              path: Assets.svgs.skull,
              height: 14.h,
              fit: BoxFit.scaleDown,
            ),
          ],
        ),
        10.horizontalSpace,
        Row(
          children: [
            Text(
              '$injuredCount',
              style: context.textTheme.bodyMedium?.copyWith(
                color: AppColors.greenText,
                fontSize: 14.sp,
              ),
            ),
            4.horizontalSpace,
            AppSvgIcon(
              path: Assets.svgs.warning,
              height: 14.h,
              fit: BoxFit.scaleDown,
            ),
          ],
        ),
      ],
    );
  }
}
