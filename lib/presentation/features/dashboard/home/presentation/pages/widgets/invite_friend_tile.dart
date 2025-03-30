import 'package:doi_mobile/core/extensions/texttheme_extensions.dart';
import 'package:doi_mobile/core/extensions/widget_extensions.dart';
import 'package:doi_mobile/core/utils/colors.dart';
import 'package:doi_mobile/gen/assets.gen.dart';
import 'package:doi_mobile/gen/fonts.gen.dart';
import 'package:doi_mobile/presentation/general_widgets/doi_svg_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InviteFriendTile extends StatelessWidget {
  const InviteFriendTile({super.key, required this.index});
  final int index;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Assets.images.avatar2.image(
          fit: BoxFit.cover,
          height: 45.h,
          width: 45.w,
        ),
        14.horizontalSpace,
        Flexible(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Claudia $index',
                      style: context.textTheme.bodySmall?.copyWith(
                        color: AppColors.black,
                        fontSize: 16.sp,
                      ),
                    ),
                    2.verticalSpace,
                    Row(
                      children: [
                        Text(
                          'Online',
                          style: context.textTheme.bodySmall?.copyWith(
                            fontSize: 12.sp,
                            color:
                                AppColors.secondaryColor.withValues(alpha: 0.7),
                          ),
                        ),
                        4.horizontalSpace,
                        AppSvgIcon(
                          path: Assets.svgs.streak,
                          fit: BoxFit.scaleDown,
                          color: Color(0xFFFF8C00),
                          height: 9.h,
                        ),
                        1.5.horizontalSpace,
                        Text(
                          '${2 + index}',
                          style: context.textTheme.bodyMedium?.copyWith(
                            color: AppColors.black,
                            fontSize: 10.sp,
                            fontFamily: FontFamily.jungleAdventurer,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
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
                    'Remove',
                    style: context.textTheme.bodyMedium?.copyWith(
                      fontFamily: FontFamily.jungleAdventurer,
                      fontSize: 16.sp,
                      color: AppColors.white,
                    ),
                    textScaler: const TextScaler.linear(0.8),
                  ),
                ),
              ),
            ],
          ).withContainer(
            border: Border(
              bottom: BorderSide(
                color: Color(0xFFFFECDF),
              ),
            ),
            padding: EdgeInsets.only(
              bottom: 16.h,
            ),
          ),
        ),
      ],
    );
  }
}
