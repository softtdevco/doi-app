import 'package:doi_mobile/core/extensions/texttheme_extensions.dart';
import 'package:doi_mobile/core/utils/colors.dart';
import 'package:doi_mobile/gen/assets.gen.dart';
import 'package:doi_mobile/presentation/general_widgets/doi_svg_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DayProgressTile extends StatelessWidget {
  final int day;
  final bool isCompleted;
  final bool isCurrentDay;

  const DayProgressTile({
    Key? key,
    required this.day,
    required this.isCompleted,
    required this.isCurrentDay,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: 54.h,
            minWidth: 46.w,
          ),
          child: Container(
            padding: EdgeInsets.symmetric(
              vertical: 10.h,
              horizontal: 10.w,
            ),
            decoration: BoxDecoration(
              color: const Color(0xFFFCE5D1),
              borderRadius: BorderRadius.circular(8),
              border: isCurrentDay
                  ? Border.all(
                      color: AppColors.secondaryColor,
                      width: 1.83,
                    )
                  : null,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '50 DOI',
                  style:
                      context.textTheme.bodySmall?.copyWith(fontSize: 8.03.sp),
                ),
                8.verticalSpace,
                AppSvgIcon(
                  path:
                      isCompleted ? Assets.svgs.coinChecked : Assets.svgs.coin,
                  fit: BoxFit.scaleDown,
                  height: 12.79.h,
                ),
              ],
            ),
          ),
        ),
        6.4.verticalSpace,
        Text(
          'Day $day',
          style: context.textTheme.bodySmall?.copyWith(fontSize: 8.03.sp),
        ),
      ],
    );
  }
}
