import 'package:doi_mobile/core/extensions/texttheme_extensions.dart';
import 'package:doi_mobile/core/extensions/widget_extensions.dart';
import 'package:doi_mobile/core/utils/colors.dart';
import 'package:doi_mobile/gen/assets.gen.dart';
import 'package:doi_mobile/gen/fonts.gen.dart';
import 'package:doi_mobile/presentation/features/dashboard/home/data/model/friend_model.dart';
import 'package:doi_mobile/presentation/general_widgets/doi_svg_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WaitingFriendTile extends StatelessWidget {
  const WaitingFriendTile({super.key, required this.friend});
  final Friend friend;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        switch (friend.url == null) {
          true => AppSvgIcon(
              path: Assets.svgs.question,
              fit: BoxFit.scaleDown,
            ).withContainer(
              color: AppColors.iconBorder,
              shape: BoxShape.circle,
              height: 50.h,
              width: 50.w,
            ),
          _ => Assets.images.avatar2.image(
              fit: BoxFit.cover,
              height: 45.h,
              width: 45.w,
            ),
        },
        14.horizontalSpace,
        Flexible(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    (friend.name ?? '...').toUpperCase(),
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: AppColors.secondaryColor,
                      fontSize: 17.28.sp,
                      fontFamily: FontFamily.jungleAdventurer,
                    ),
                  ),
                  4.verticalSpace,
                  Text(
                    friend.status,
                    style: context.textTheme.bodySmall?.copyWith(
                      fontSize: 12.sp,
                      color: AppColors.secondaryColor.withValues(alpha: 0.7),
                    ),
                  )
                ],
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {},
                child: Row(
                  children: [
                    AppSvgIcon(
                      path: Assets.svgs.bin,
                      fit: BoxFit.scaleDown,
                    ),
                    4.horizontalSpace,
                    Text(
                      'Remove',
                      style: context.textTheme.bodySmall?.copyWith(
                        fontSize: 11.85.sp,
                      ),
                    ),
                  ],
                ).withContainer(
                  color: AppColors.indicator,
                  borderRadius: BorderRadius.circular(41.r),
                  padding: EdgeInsets.symmetric(
                    horizontal: 8.w,
                    vertical: 9.h,
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
