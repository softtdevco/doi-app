import 'package:doi_mobile/core/extensions/context_extensions.dart';
import 'package:doi_mobile/core/extensions/navigation_extensions.dart';
import 'package:doi_mobile/core/extensions/overlay_extensions.dart';
import 'package:doi_mobile/core/extensions/string_extensions.dart';
import 'package:doi_mobile/core/extensions/texttheme_extensions.dart';
import 'package:doi_mobile/core/extensions/widget_extensions.dart';
import 'package:doi_mobile/core/router/router.dart';
import 'package:doi_mobile/core/utils/colors.dart';
import 'package:doi_mobile/core/utils/enums.dart';
import 'package:doi_mobile/gen/assets.gen.dart';
import 'package:doi_mobile/gen/fonts.gen.dart';
import 'package:doi_mobile/presentation/features/dashboard/friends/presentation/pages/widgets/user_stat_tile.dart';
import 'package:doi_mobile/presentation/features/dashboard/widgets/nav_bar.dart';
import 'package:doi_mobile/presentation/features/onboarding/presentation/notifier/onboarding.notifier.dart';
import 'package:doi_mobile/presentation/features/profile/data/repository/user_repository_impl.dart';
import 'package:doi_mobile/presentation/features/profile/presentation/widgets/delete_pop.dart';
import 'package:doi_mobile/presentation/general_widgets/doi_appbar.dart';
import 'package:doi_mobile/presentation/general_widgets/doi_scaffold.dart';
import 'package:doi_mobile/presentation/general_widgets/doi_svg_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Profile extends ConsumerStatefulWidget {
  const Profile({super.key});

  @override
  ConsumerState<Profile> createState() => _ProfileState();
}

class _ProfileState extends ConsumerState<Profile> {
  void _deactivate() {
    context.showLoading();
    try {
      ref.read(onboardingNotifierProvider.notifier).deleteAccount(
          onError: (p0) {
        context
          ..hideOverLay()
          ..showError(
            message: p0,
          );
      }, onCompleted: () {
        ref.read(currentIndexProvider.notifier).state = 0;
        ref
            .read(userRepositoryProvider)
            .saveCurrentState(CurrentState.onboarded);
        ref.read(userRepositoryProvider).deleteUser();
        context
          ..hideOverLay()
          ..showSuccess(
            message: 'User account deleted successfully',
          )
          ..replaceAll(AppRouter.welcome);
      });
    } catch (e) {
      context.showError(
        title: 'Failed',
        message: e.toString(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(currentUserProvider);
    return DoiScaffold(
      bodyPadding: EdgeInsets.all(24),
      showBackImage: false,
      appbar: DoiAppbar(
        title: Text(
          'my profile'.toUpperCase(),
          style: context.textTheme.bodyMedium?.copyWith(
            fontSize: 20.sp,
            fontFamily: FontFamily.jungleAdventurer,
            color: AppColors.secondaryColor,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(182.r),
              child: Image.asset(
                'assets/images/${(user.avatar ?? 'userPic4.png').toLowerCase()}',
                fit: BoxFit.cover,
                height: 106.h,
                width: 106.w,
                errorBuilder: (context, error, stackTrace) => ClipRRect(
                  borderRadius: BorderRadius.circular(182.r),
                  child: Image.asset(
                    Assets.images.userpic3.path,
                    fit: BoxFit.cover,
                    height: 106.h,
                    width: 106.w,
                  ),
                ),
              ),
            ),
            11.verticalSpace,
            Text(
              '${user.username?.capitalizeFirst}',
              style: context.textTheme.bodySmall?.copyWith(
                fontSize: 16.sp,
              ),
            ),
            // 4.verticalSpace,
            // Text(
            //   '33,590 XP',
            //   style: context.textTheme.bodySmall?.copyWith(
            //     fontSize: 14.sp,
            //     color: AppColors.orange0A,
            //   ),
            // ),
            // 16.verticalSpace,
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     Text(
            //       '32 Friends',
            //       style: context.textTheme.bodySmall?.copyWith(
            //         fontSize: 14.sp,
            //         color: AppColors.orange0A,
            //       ),
            //     ),
            //     8.horizontalSpace,
            //     Container(
            //       height: 5.h,
            //       width: 5.w,
            //       decoration: BoxDecoration(
            //         shape: BoxShape.circle,
            //         color: Color(0xFFD7A07D),
            //       ),
            //     ),
            //     8.horizontalSpace,
            //     Text(
            //       'Joined 2 years ago',
            //       style: context.textTheme.bodySmall?.copyWith(
            //         fontSize: 12.sp,
            //       ),
            //     )
            //   ],
            // ),
            // 14.verticalSpace,
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 50),
            //   child: GestureDetector(
            //     onTap: () => context.pushNamed(AppRouter.myFriends),
            //     child: Container(
            //       padding: EdgeInsets.symmetric(vertical: 8, horizontal: 17),
            //       decoration: BoxDecoration(
            //         color: AppColors.primaryColor,
            //         borderRadius: BorderRadius.circular(12.r),
            //         boxShadow: [
            //           BoxShadow(
            //             color: AppColors.secondaryColor,
            //             offset: const Offset(0, 5),
            //             blurRadius: 0,
            //             spreadRadius: 0,
            //           ),
            //         ],
            //       ),
            //       alignment: Alignment.center,
            //       child: Text(
            //         'View friends list',
            //         style: context.textTheme.bodyMedium?.copyWith(
            //           fontFamily: FontFamily.jungleAdventurer,
            //           fontSize: 16.sp,
            //           color: AppColors.white,
            //         ),
            //         textScaler: const TextScaler.linear(0.8),
            //       ),
            //     ),
            //   ),
            // ),
            // 50.verticalSpace,
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     Text(
            //       'Profile visibility',
            //       style: context.textTheme.bodySmall?.copyWith(
            //         fontSize: 18.sp,
            //       ),
            //     ),
            //     CupertinoSwitch(
            //       value: true,
            //       onChanged: (p0) {},
            //       activeTrackColor: AppColors.primaryColor,
            //     )
            //   ],
            // ),
            // 24.verticalSpace,
            60.verticalSpace,
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'User stats',
                  style: context.textTheme.bodySmall?.copyWith(
                    fontSize: 16.sp,
                  ),
                ),
                14.verticalSpace,
                Row(
                  children: [
                    Flexible(
                        child: UserStatTile(
                      title: 'Daily streak',
                      value: '0',
                      path: Assets.svgs.streak,
                    )),
                    12.horizontalSpace,
                    Flexible(
                        child: UserStatTile(
                      title: '🌍 Leaderboard',
                      value: '#0',
                      path: Assets.svgs.leader,
                    ))
                  ],
                ),
                12.verticalSpace,
                Row(
                  children: [
                    Flexible(
                        child: UserStatTile(
                      title: 'Matches Played',
                      value: '0',
                      path: Assets.svgs.cloudGaming,
                    )),
                    12.horizontalSpace,
                    Flexible(
                        child: UserStatTile(
                      title: 'Shortest Game',
                      value: '0 Secs',
                      path:
                          Assets.svgs.circleClockClockLoadingMeasureTimeCircle,
                    ))
                  ],
                ),
              ],
            ),
            // 24.verticalSpace,
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     Row(
            //       children: [
            //         Text(
            //           'Achievements',
            //           style: context.textTheme.bodySmall?.copyWith(
            //               color: AppColors.secondaryColor, fontSize: 16.sp),
            //         ),
            //         4.horizontalSpace,
            //         Text(
            //           '(6)',
            //           style: context.textTheme.bodySmall
            //               ?.copyWith(color: Color(0xFFE5770A), fontSize: 14.sp),
            //         )
            //       ],
            //     ),
            //     GestureDetector(
            //       onTap: () => context.pushNamed(AppRouter.myAchievements),
            //       child: Text(
            //         'See all',
            //         style: context.textTheme.bodySmall?.copyWith(
            //           color: AppColors.secondaryColor,
            //           fontSize: 16.sp,
            //           decoration: TextDecoration.underline,
            //           decorationColor: AppColors.secondaryColor,
            //         ),
            //       ),
            //     )
            //   ],
            // ),
            // 14.verticalSpace,
            // SingleChildScrollView(
            //   child: Row(
            //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //       children: List.generate(
            //           4,
            //           (i) => Assets.images.badgeBg.image(
            //                 fit: BoxFit.cover,
            //                 height: 72.h,
            //                 width: 72.w,
            //               ))),
            // ),
            80.verticalSpace,
            GestureDetector(
              onTap: () {
                context.showPopUp(DeletePop(onDelete: () {
                  _deactivate();
                }));
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppSvgIcon(
                    path: Assets.svgs.bin,
                    height: 20.h,
                    width: 20.w,
                    color: AppColors.primaryColor,
                  ),
                  8.horizontalSpace,
                  Text(
                    'Delete Account',
                    style: context.textTheme.bodySmall?.copyWith(
                      fontSize: 16.sp,
                    ),
                  )
                ],
              ).withContainer(
                color: AppColors.indicator,
                borderRadius: BorderRadius.circular(10.r),
                padding: EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 16,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
