import 'package:doi_mobile/core/extensions/data_type_extension.dart';
import 'package:doi_mobile/core/extensions/date_extension.dart';
import 'package:doi_mobile/core/extensions/string_extensions.dart';
import 'package:doi_mobile/core/extensions/texttheme_extensions.dart';
import 'package:doi_mobile/core/utils/colors.dart';
import 'package:doi_mobile/gen/assets.gen.dart';
import 'package:doi_mobile/gen/fonts.gen.dart';
import 'package:doi_mobile/l10n/l10n.dart';
import 'package:doi_mobile/presentation/features/dashboard/friends/presentation/pages/widgets/user_stat_tile.dart';
import 'package:doi_mobile/presentation/features/dashboard/home/data/model/leader_board_response.dart';
import 'package:doi_mobile/presentation/general_widgets/banner_ads_widget.dart';
import 'package:doi_mobile/presentation/general_widgets/doi_appbar.dart';
import 'package:doi_mobile/presentation/general_widgets/doi_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FriendProfile extends StatelessWidget {
  const FriendProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final fromLeaderBoard = ModalRoute.of(context)?.settings.arguments as (
      bool,
      GlobalLeaderboard,
      int
    );
    return DoiScaffold(
      bodyPadding: EdgeInsets.all(24),
      showBackImage: false,
      appbar: DoiAppbar(
        title: Text(
          'USER PROFILE',
          style: context.textTheme.bodyMedium?.copyWith(
            fontSize: 20.sp,
            fontFamily: FontFamily.jungleAdventurer,
            color: AppColors.secondaryColor,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(182.r),
              child: Image.asset(
                'assets/images/${(fromLeaderBoard.$2.user?.avatar ?? 'userPic4.png').toLowerCase()}',
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
              '${fromLeaderBoard.$2.user?.country ?? ''}     ${getFlagEmoji(fromLeaderBoard.$2.user?.countryCode ?? 'US')}',
              style: context.textTheme.bodySmall?.copyWith(
                fontSize: 16.sp,
              ),
            ),

            4.verticalSpace,
            Text(
              '${(fromLeaderBoard.$2.totalPoints ?? 0).formatAmount} XP',
              style: context.textTheme.bodySmall?.copyWith(
                fontSize: 14.sp,
                color: AppColors.orange0A,
              ),
            ),
            16.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //Text(
                //   '32 Friends',
                //   style: context.textTheme.bodySmall?.copyWith(
                //     fontSize: 14.sp,
                //     color: AppColors.orange0A,
                //   ),
                // ),
                // 8.horizontalSpace,
                // Container(
                //   height: 5.h,
                //   width: 5.w,
                //   decoration: BoxDecoration(
                //     shape: BoxShape.circle,
                //     color: Color(0xFFD7A07D),
                //   ),
                // ),
                // 8.horizontalSpace,
                Text(
                  'Joined ${(fromLeaderBoard.$2.user?.createdAt)?.timeAgo ?? ''}',
                  style: context.textTheme.bodySmall?.copyWith(
                    fontSize: 12.sp,
                  ),
                )
              ],
            ),
            14.verticalSpace,
            if (fromLeaderBoard.$1) ...[
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 24),
              //   child: GestureDetector(
              //     onTap: () {},
              //     child: Container(
              //       padding: EdgeInsets.symmetric(vertical: 8, horizontal: 30),
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
              //         'Add Friend'.toUpperCase(),
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
              24.verticalSpace,
              Center(child: BannerAdWidget())
            ] else
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 8, horizontal: 50),
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
                        context.l10n.accept,
                        style: context.textTheme.bodyMedium?.copyWith(
                          fontFamily: FontFamily.jungleAdventurer,
                          fontSize: 16.sp,
                          color: AppColors.white,
                        ),
                        textScaler: const TextScaler.linear(0.8),
                      ),
                    ),
                  ),
                  16.horizontalSpace,
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 8, horizontal: 50),
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
                        context.l10n.remove,
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
              ),
            50.verticalSpace,
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
                      value: (fromLeaderBoard.$2.activeStreak ?? 0).toString(),
                      path: Assets.svgs.streak,
                    )),
                    12.horizontalSpace,
                    Flexible(
                        child: UserStatTile(
                      title: '🌍 Leaderboard',
                      value: '#${fromLeaderBoard.$3}',
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
                      value:
                          (fromLeaderBoard.$2.matchesPlayed ?? 0).formatAmount,
                      path: Assets.svgs.cloudGaming,
                    )),
                    12.horizontalSpace,
                    Flexible(
                        child: UserStatTile(
                      title: 'Shortest Game',
                      value: '32 Secs',
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
            //       onTap: () => context.pushNamed(AppRouter.myAchievements,
            //           arguments: true),
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
            if (!fromLeaderBoard.$1) ...[
              22.verticalSpace,
              Center(child: BannerAdWidget())
            ]
          ],
        ),
      ),
    );
  }
}
