import 'package:doi_mobile/core/extensions/data_type_extension.dart';
import 'package:doi_mobile/core/extensions/date_extension.dart';
import 'package:doi_mobile/core/extensions/navigation_extensions.dart';
import 'package:doi_mobile/core/extensions/string_extensions.dart';
import 'package:doi_mobile/core/extensions/texttheme_extensions.dart';
import 'package:doi_mobile/core/extensions/widget_extensions.dart';
import 'package:doi_mobile/core/router/router.dart';
import 'package:doi_mobile/core/utils/colors.dart';
import 'package:doi_mobile/gen/assets.gen.dart';
import 'package:doi_mobile/gen/fonts.gen.dart';
import 'package:doi_mobile/presentation/features/dashboard/friends/presentation/pages/widgets/user_stat_tile.dart';
import 'package:doi_mobile/presentation/features/dashboard/home/data/model/leader_board_response.dart';
import 'package:doi_mobile/presentation/general_widgets/doi_svg_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LeaderProfilePop extends ConsumerStatefulWidget {
  const LeaderProfilePop(
      {super.key, required this.model, required this.position});
  final GlobalLeaderboard model;
  final int position;

  @override
  ConsumerState<LeaderProfilePop> createState() => _LeaderProfilePopState();
}

class _LeaderProfilePopState extends ConsumerState<LeaderProfilePop> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              AppSvgIcon(
                path: Assets.svgs.close,
                onTap: () {
                  context.pop();
                },
                fit: BoxFit.scaleDown,
              ),
            ],
          ),
          8.verticalSpace,
          Column(
            children: [
              Row(
                children: [
                  SizedBox(
                    height: 28.h,
                    width: 28.w,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(49.r),
                        child: Assets.images.opponet.image(fit: BoxFit.cover)),
                  ),
                  11.horizontalSpace,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${(widget.model.user?.username ?? 'Player')} ${getFlagEmoji(widget.model.user?.countryCode ?? 'US')}',
                        style: context.textTheme.bodySmall?.copyWith(
                          color: AppColors.secondaryColor,
                          fontSize: 16.sp,
                          fontFamily: FontFamily.rimouski,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${(widget.model.totalPoints ?? 0).formatAmount} XP',
                            style: context.textTheme.bodySmall?.copyWith(
                              fontSize: 14.sp,
                              color: AppColors.orange0A,
                              fontFamily: FontFamily.rimouski,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          8.horizontalSpace,
                          Container(
                            height: 5.h,
                            width: 5.w,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xFFD7A07D),
                            ),
                          ),
                          8.horizontalSpace,
                          Text(
                            'Joined ${(widget.model.user?.createdAt)?.timeAgo ?? ''}',
                            style: context.textTheme.bodySmall?.copyWith(
                                fontSize: 12.sp,
                                fontFamily: FontFamily.rimouski,
                                fontWeight: FontWeight.w600,
                                color: AppColors.secondaryColor),
                          )
                        ],
                      ),
                    ],
                  )
                ],
              ),
              14.verticalSpace,
              Row(
                children: [
                  Flexible(
                      child: UserStatTile(
                    title: 'Daily streak',
                    value: (widget.model.activeStreak ?? 0).toString(),
                    path: Assets.svgs.streak,
                    titleSize: 8.8,
                    valueSize: 12.8,
                  )),
                  12.horizontalSpace,
                  Flexible(
                      child: UserStatTile(
                    title: '🌍 Leaderboard',
                    value: '#${widget.position}',
                    path: Assets.svgs.leader,
                    titleSize: 8.8,
                    valueSize: 12.8,
                  ))
                ],
              ),
              12.verticalSpace,
              Row(
                children: [
                  Flexible(
                      child: UserStatTile(
                    title: 'Matches Played',
                    value: (widget.model.matchesPlayed ?? 0).formatAmount,
                    path: Assets.svgs.cloudGaming,
                    titleSize: 8.8,
                    valueSize: 12.8,
                  )),
                  12.horizontalSpace,
                  Flexible(
                      child: UserStatTile(
                    title: 'Shortest Game',
                    value: '32 Secs',
                    path: Assets.svgs.circleClockClockLoadingMeasureTimeCircle,
                    titleSize: 8.8,
                    valueSize: 12.8,
                  ))
                ],
              ),
              14.verticalSpace,
              Row(
                children: [
                  // GestureDetector(
                  //   onTap: () {},
                  //   child: Container(
                  //     padding:
                  //         EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                  //     decoration: BoxDecoration(
                  //       color: AppColors.primaryColor,
                  //       borderRadius: BorderRadius.circular(12.r),
                  //       boxShadow: [
                  //         BoxShadow(
                  //           color: AppColors.secondaryColor,
                  //           offset: const Offset(0, 5),
                  //           blurRadius: 0,
                  //           spreadRadius: 0,
                  //         ),
                  //       ],
                  //     ),
                  //     alignment: Alignment.center,
                  //     child: Text(
                  //       'Add Friend',
                  //       style: context.textTheme.bodyMedium?.copyWith(
                  //         fontFamily: FontFamily.jungleAdventurer,
                  //         fontSize: 16.sp,
                  //         color: AppColors.white,
                  //       ),
                  //       textScaler: const TextScaler.linear(0.8),
                  //     ),
                  //   ),
                  // ),
                  // 16.horizontalSpace,
                  GestureDetector(
                    onTap: () => context.popAndPushNamed(
                      AppRouter.friendProfile,
                      arguments: (true, widget.model, widget.position),
                    ),
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 4, horizontal: 10),
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
                        'Expand profile',
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
            ],
          )
        ],
      ).withContainer(padding: EdgeInsets.all(20)),
    );
  }
}
