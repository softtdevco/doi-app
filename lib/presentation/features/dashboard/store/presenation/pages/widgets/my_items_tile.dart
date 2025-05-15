import 'package:doi_mobile/core/extensions/texttheme_extensions.dart';
import 'package:doi_mobile/core/extensions/widget_extensions.dart';
import 'package:doi_mobile/core/utils/colors.dart';
import 'package:doi_mobile/presentation/general_widgets/doi_svg_widget.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyItemTile extends StatelessWidget {
  const MyItemTile({
    super.key,
    required this.path,
    required this.name,
    required this.value,
  });
  final String path;
  final String name;
  final String value;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppSvgIcon(
          path: path,
        ),
        8.verticalSpace,
        Text(
          name,
          style: context.textTheme.bodySmall?.copyWith(
            color: AppColors.black,
            fontSize: 13.sp,
          ),
        ),
        8.verticalSpace,
        Text(
          'x${value}',
          style: context.textTheme.bodySmall?.copyWith(
            color: int.parse(value) > 0
                ? AppColors.greenBorder
                : AppColors.secondaryColor,
            fontSize: 13.sp,
          ),
        )
      ],
    ).withContainer(
      color: AppColors.indicator,
      borderRadius: BorderRadius.circular(
        12.r,
      ),
      padding: EdgeInsets.fromLTRB(16, 12, 33, 12),
    );
  }
}
