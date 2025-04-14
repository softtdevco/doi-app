import 'package:doi_mobile/core/extensions/texttheme_extensions.dart';
import 'package:doi_mobile/core/extensions/widget_extensions.dart';
import 'package:doi_mobile/core/utils/colors.dart';
import 'package:doi_mobile/presentation/general_widgets/doi_svg_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserStatTile extends StatelessWidget {
  const UserStatTile(
      {super.key,
      required this.title,
      required this.value,
      required this.path});
  final String title, value, path;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AppSvgIcon(
          path: path,
          fit: BoxFit.scaleDown,
        ),
        10.horizontalSpace,
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: context.textTheme.bodySmall?.copyWith(
                  color: AppColors.black,
                  fontSize: 16.sp,
                ),
              ),
              Text(
                title,
                style: context.textTheme.bodySmall?.copyWith(
                  fontSize: 11.sp,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              )
            ],
          ),
        )
      ],
    ).withContainer(
      borderRadius: BorderRadius.circular(12.r),
      color: AppColors.indicator,
      padding: EdgeInsets.symmetric(
        vertical: 12,
        horizontal: 16,
      ),
    );
  }
}
