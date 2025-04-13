import 'package:doi_mobile/core/extensions/texttheme_extensions.dart';
import 'package:doi_mobile/core/utils/colors.dart';
import 'package:doi_mobile/gen/assets.gen.dart';
import 'package:doi_mobile/gen/fonts.gen.dart';
import 'package:doi_mobile/presentation/general_widgets/doi_svg_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InviteFriendSheet extends StatelessWidget {
  const InviteFriendSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 28.w,
          height: 3.h,
          decoration: BoxDecoration(
              color: Color(0xFFD7A07D),
              borderRadius: BorderRadius.circular(8.r)),
        ),
        24.verticalSpace,
        Text(
          'Invite friends',
          style: context.textTheme.bodySmall?.copyWith(
            fontSize: 16.sp,
            color: AppColors.secondaryColor,
          ),
        ),
        24.verticalSpace,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                AppSvgIcon(path: Assets.svgs.link),
                Column(
                  children: [Text('data'), Text('data')],
                )
              ],
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
                  'Copy',
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
        )
      ],
    );
  }
}
