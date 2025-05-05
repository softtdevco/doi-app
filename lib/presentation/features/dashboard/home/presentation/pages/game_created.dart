import 'package:doi_mobile/core/extensions/context_extensions.dart';
import 'package:doi_mobile/core/extensions/navigation_extensions.dart';
import 'package:doi_mobile/core/extensions/overlay_extensions.dart';
import 'package:doi_mobile/core/extensions/texttheme_extensions.dart';
import 'package:doi_mobile/core/extensions/widget_extensions.dart';
import 'package:doi_mobile/core/router/router.dart';
import 'package:doi_mobile/core/utils/colors.dart';
import 'package:doi_mobile/gen/assets.gen.dart';
import 'package:doi_mobile/gen/fonts.gen.dart';
import 'package:doi_mobile/presentation/features/dashboard/home/presentation/pages/widgets/coin_count.dart';
import 'package:doi_mobile/presentation/features/dashboard/home/presentation/pages/widgets/invite_friend_tile.dart';
import 'package:doi_mobile/presentation/features/dashboard/home/presentation/pages/widgets/min_textfield.dart';
import 'package:doi_mobile/presentation/features/dashboard/home/presentation/pages/widgets/scan_to_join.dart';
import 'package:doi_mobile/presentation/general_widgets/doi_appbar.dart';
import 'package:doi_mobile/presentation/general_widgets/doi_button.dart';
import 'package:doi_mobile/presentation/general_widgets/doi_scaffold.dart';
import 'package:doi_mobile/presentation/general_widgets/doi_svg_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:share_plus/share_plus.dart';

class GameCreated extends ConsumerStatefulWidget {
  const GameCreated({
    super.key,
    required this.arg,
  });
  final (String, int, String) arg;
  @override
  ConsumerState<GameCreated> createState() => _GameCreatedState();
}

class _GameCreatedState extends ConsumerState<GameCreated> {
  void sharePost() {
    SharePlus.instance.share(
      ShareParams(text: widget.arg.$1),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DoiScaffold(
      showBackImage: false,
      bodyPadding: EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 24,
      ),
      backgroundColor: AppColors.background,
      appbar: DoiAppbar(
        title: CoinCount(),
        trailing: AppSvgIcon(path: Assets.svgs.help),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              'Game created!',
              style: context.textTheme.bodySmall?.copyWith(
                color: Color(0xFFD7A07D),
                fontSize: 14.sp,
              ),
            ),
            12.verticalSpace,
            Column(
              children: [
                AppSvgIcon(
                  path: Assets.svgs.link,
                ),
                4.verticalSpace,
                Text(
                  'Game Invite Link',
                  style: context.textTheme.bodySmall?.copyWith(
                    color: AppColors.black,
                    fontSize: 16.sp,
                  ),
                ),
                Text(
                  'Share, Copy or Scan QR',
                  style: context.textTheme.bodySmall?.copyWith(
                    fontSize: 12.sp,
                  ),
                ),
                16.verticalSpace,
                Row(
                  spacing: 8.w,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      onTap: sharePost,
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 15),
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
                          'Share',
                          style: context.textTheme.bodyMedium?.copyWith(
                            fontFamily: FontFamily.jungleAdventurer,
                            fontSize: 16.sp,
                            color: AppColors.white,
                          ),
                          textScaler: const TextScaler.linear(0.8),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () async =>
                          Clipboard.setData(ClipboardData(text: widget.arg.$1))
                              .then((value) => context.showSuccess(
                                  message: 'Copied to clipboard	')),
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 15),
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
                        child: AppSvgIcon(
                          path: Assets.svgs.copy,
                          fit: BoxFit.scaleDown,
                          height: 16.h,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => context.showPopUp(
                        color: Color(0xFFFFF5EF),
                        isDismissable: true,
                        ScanToJoin(inviteLink: widget.arg.$1),
                      ),
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 15),
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
                        child: AppSvgIcon(
                          path: Assets.svgs.qrCode,
                          fit: BoxFit.scaleDown,
                          height: 16.h,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ).withContainer(
              padding: EdgeInsets.all(16),
              width: double.infinity,
              color: AppColors.indicator,
              borderRadius: BorderRadius.circular(12.r),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 13.0, vertical: 16),
              child: Assets.images.mobileLeaderboard.image(),
            ),
            Text(
              'Or search friends to add',
              style: context.textTheme.bodySmall?.copyWith(
                color: Color(0xFFD7A07D),
                fontSize: 14.sp,
              ),
            ),
            12.verticalSpace,
            MinFormField(
              width: double.infinity,
              textAlign: TextAlign.left,
              cursorColor: AppColors.primaryColor,
              decoration: InputDecoration(
                prefixIcon: AppSvgIcon(
                  path: Assets.svgs.search,
                  fit: BoxFit.scaleDown,
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 16),
                fillColor: AppColors.indicator,
                filled: true,
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                hintText: 'Search friends',
                hintStyle: context.textTheme.bodySmall?.copyWith(
                  fontSize: 14.sp,
                  color: Color(0xFFD7A07D),
                ),
              ),
            ),
            32.verticalSpace,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Invited Friends',
                  style: context.textTheme.bodySmall?.copyWith(
                    color: Color(0xFFD7A07D),
                    fontSize: 14.sp,
                  ),
                ),
                12.verticalSpace,
                Column(
                  spacing: 16,
                  children: List.generate(
                    4,
                    (i) => InviteFriendTile(
                      index: i + 1,
                      onTap: () {
                        if (i == 0) {
                          context.pushNamed(AppRouter.addingFriend);
                        }
                      },
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
      footerButton: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: DoiButton(
          text: 'Start game',
          onPressed: () {
            context.popAndPushNamed(
              AppRouter.waitingScreen,
              arguments: (
                widget.arg.$2,
                widget.arg.$3,
                false,
              ),
            );
          },
        ),
      ),
    );
  }
}
