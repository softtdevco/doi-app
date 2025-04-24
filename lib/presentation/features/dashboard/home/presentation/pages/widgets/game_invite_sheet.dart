import 'package:doi_mobile/core/extensions/navigation_extensions.dart';
import 'package:doi_mobile/core/extensions/texttheme_extensions.dart';
import 'package:doi_mobile/core/extensions/widget_extensions.dart';
import 'package:doi_mobile/core/router/router.dart';
import 'package:doi_mobile/core/utils/colors.dart';
import 'package:doi_mobile/gen/assets.gen.dart';
import 'package:doi_mobile/gen/fonts.gen.dart';
import 'package:doi_mobile/presentation/general_widgets/doi_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GameInviteSheet extends ConsumerStatefulWidget {
  const GameInviteSheet({
    Key? key,
    required this.inviteCode,
    required this.invitee,
  }) : super(
          key: key,
        );
  final String inviteCode;
  final String invitee;
  @override
  ConsumerState<GameInviteSheet> createState() => _GameInviteSheetState();
}

class _GameInviteSheetState extends ConsumerState<GameInviteSheet> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(32, 16, 32, 36),
      child: SingleChildScrollView(
        child: Column(
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
              'Game Invite',
              style: context.textTheme.bodySmall?.copyWith(
                fontSize: 16.sp,
                color: AppColors.secondaryColor,
              ),
            ),
            26.verticalSpace,
            SizedBox(
              height: 50.h,
              width: 50.w,
              child: Assets.images.avatar2.image(),
            ),
            8.verticalSpace,
            Text(
              widget.invitee.toUpperCase(),
              style: context.textTheme.bodyMedium?.copyWith(
                color: AppColors.secondaryColor,
                fontSize: 20.sp,
              ),
            ),
            Text(
              'Is inviting you to join a private game',
              style: context.textTheme.bodySmall?.copyWith(
                fontSize: 14.sp,
                color: AppColors.primaryColor,
              ),
            ),
            61.verticalSpace,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 22.w),
              child: DoiButton(
                  text: 'Accept & Join',
                  onPressed: () {
                    context.popAndPushNamed(AppRouter.waitingScreen);
                  }),
            ),
            16.verticalSpace,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 22.w),
              child: GestureDetector(
                onTap: () => context.pop(),
                child: Text(
                  'Reject invite',
                  style: context.textTheme.bodyMedium?.copyWith(
                    fontFamily: FontFamily.jungleAdventurer,
                    fontWeight: FontWeight.w400,
                    color: AppColors.secondaryColor,
                  ),
                ).withContainer(
                    alignment: Alignment.center,
                    width: double.infinity,
                    borderRadius: BorderRadius.circular(12.r),
                    padding: EdgeInsets.symmetric(
                      vertical: 12.h,
                      horizontal: 10.w,
                    ),
                    border: Border.all(
                      color: AppColors.primaryColor,
                      width: 2,
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
