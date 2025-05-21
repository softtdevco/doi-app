import 'package:doi_mobile/core/extensions/context_extensions.dart';
import 'package:doi_mobile/core/extensions/data_type_extension.dart';
import 'package:doi_mobile/core/extensions/string_extensions.dart';
import 'package:doi_mobile/core/extensions/texttheme_extensions.dart';
import 'package:doi_mobile/core/extensions/widget_extensions.dart';
import 'package:doi_mobile/core/utils/colors.dart';
import 'package:doi_mobile/core/utils/enums.dart';
import 'package:doi_mobile/gen/assets.gen.dart';
import 'package:doi_mobile/gen/fonts.gen.dart';
import 'package:doi_mobile/presentation/features/dashboard/home/data/model/leader_board_response.dart';
import 'package:doi_mobile/presentation/features/dashboard/home/presentation/notifiers/home_notifier.dart';
import 'package:doi_mobile/presentation/features/dashboard/home/presentation/pages/widgets/leaderboard_switch.dart';
import 'package:doi_mobile/presentation/features/dashboard/onlineGame/presentation/notifiers/online_game_notifier.dart';
import 'package:doi_mobile/presentation/features/profile/data/repository/user_repository_impl.dart';
import 'package:doi_mobile/presentation/features/profile/presentation/widgets/leader_profile_pop.dart';
import 'package:doi_mobile/presentation/general_widgets/banner_ads_widget.dart';
import 'package:doi_mobile/presentation/general_widgets/doi_appbar.dart';
import 'package:doi_mobile/presentation/general_widgets/doi_scaffold.dart';
import 'package:doi_mobile/presentation/general_widgets/doi_svg_widget.dart';
import 'package:doi_mobile/presentation/general_widgets/shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LeaderBoard extends ConsumerStatefulWidget {
  const LeaderBoard({super.key});

  @override
  ConsumerState<LeaderBoard> createState() => _LeaderBoardState();
}

class _LeaderBoardState extends ConsumerState<LeaderBoard> {
  bool lock = false;
  @override
  void initState() {
    super.initState();
    ref.read(onlineGameNotifierProvider.notifier).getLeaderboard();
  }

  @override
  Widget build(BuildContext context) {
    final selectedIndex =
        ref.watch(homeNotifierProvider.select((v) => v.leaderboardIndex));
    final loadState =
        ref.watch(onlineGameNotifierProvider.select((v) => v.leaderLoadState));
    final leaderBoard = ref
        .watch(onlineGameNotifierProvider.select((v) => v.globalLeaderboard));

    final user = ref.watch(currentUserProvider);
    final usaLeaderBoard =
        leaderBoard!.where((e) => e.user?.countryCode == 'US').toList();
    final myCountryLeaderBoard = leaderBoard
        .where((e) => e.user?.countryCode == user.countryCode)
        .toList();
    return Shimmer(
      linearGradient: shimmerGradient,
      child: DoiScaffold(
          showBackImage: false,
          appbar: DoiAppbar(
            color: selectedIndex == 1
                ? AppColors.greenText
                : AppColors.secondaryColor,
            title: Text(
              'Leaderboard',
              style: context.textTheme.bodyMedium?.copyWith(
                color: selectedIndex == 1
                    ? AppColors.greenText
                    : AppColors.secondaryColor,
                fontSize: 20.sp,
                fontFamily: FontFamily.jungleAdventurer,
                fontWeight: FontWeight.w400,
              ),
            ),
            showBackButton: true,
            trailing: Visibility(
              visible: false,
              child: AppSvgIcon(
                path: Assets.svgs.help,
                color: selectedIndex == 1
                    ? AppColors.greenText
                    : AppColors.secondaryColor,
              ),
            ),
          ),
          bodyPadding: EdgeInsets.all(24),
          body: SizedBox(
            height: context.height,
            child: Column(
              children: [
                switch (selectedIndex) {
                  1 => Assets.images.winnerGreen.image(
                      fit: BoxFit.cover,
                    ),
                  _ => Assets.images.winner.image(
                      fit: BoxFit.cover,
                    ),
                },
                20.verticalSpace,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.w),
                  child: Text(
                    'Stay at the top of the leaderboard and win cool prices',
                    style: context.textTheme.bodySmall?.copyWith(
                      fontSize: 12.sp,
                      color: selectedIndex == 1
                          ? AppColors.greenText.withValues(alpha: 0.7)
                          : AppColors.secondaryColor.withValues(alpha: 0.7),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                16.verticalSpace,
                LeaderboardSwitch(
                  index: selectedIndex,
                  onChanged: (v) {
                    ref
                        .read(homeNotifierProvider.notifier)
                        .selectLeaderboardIndex(v);
                  },
                ),
                if (lock) ...[
                  Expanded(
                    child: ListView(
                      children: [
                        79.verticalSpace,
                        Assets.images.productLocked.image(
                          height: 206.h,
                          width: 206.w,
                        ),
                        33.verticalSpace,
                        Text(
                          'Reach 1,000 XP playing to unlock Leaderboards',
                          style: context.textTheme.bodySmall?.copyWith(
                            fontSize: 16.sp,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ] else ...[
                  24.verticalSpace,
                  Center(child: BannerAdWidget()),
                  24.verticalSpace,
                  Expanded(
                    child: ListView(
                      children: [
                        Text(
                          switch (selectedIndex) {
                            0 => 'USA  ${getFlagEmoji('US')}',
                            1 =>
                              '${user.country ?? ''} ${getFlagEmoji(user.countryCode ?? '')}',
                            _ => 'Global  🌍',
                          },
                          style: context.textTheme.bodySmall?.copyWith(
                            fontSize: 14.sp,
                            color: selectedIndex == 1
                                ? AppColors.greenText
                                : AppColors.secondaryColor,
                          ),
                        ).withContainer(
                            alignment: Alignment.center,
                            padding: EdgeInsets.all(6),
                            color: selectedIndex == 1
                                ? Color(0xFFCCE0A3)
                                : Color(0xFFFFC098),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(12.r),
                              topRight: Radius.circular(12.r),
                            )),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Rank',
                                  style: context.textTheme.bodySmall?.copyWith(
                                      fontSize: 12.sp,
                                      color: selectedIndex == 1
                                          ? AppColors.greenBorder
                                          : AppColors.orange0A),
                                ),
                                16.horizontalSpace,
                                Text(
                                  'Players',
                                  style: context.textTheme.bodySmall?.copyWith(
                                      fontSize: 12.sp,
                                      color: selectedIndex == 1
                                          ? AppColors.greenBorder
                                          : AppColors.orange0A),
                                )
                              ],
                            ),
                            Text(
                              'XP',
                              style: context.textTheme.bodySmall?.copyWith(
                                  fontSize: 12.sp,
                                  color: selectedIndex == 1
                                      ? AppColors.greenBorder
                                      : AppColors.orange0A),
                            )
                          ],
                        ).withContainer(
                          color: selectedIndex == 1
                              ? Color(0xFFEFFED2)
                              : AppColors.indicator,
                          border: Border(
                            bottom: BorderSide(
                              color: selectedIndex == 1
                                  ? Color(0xFFBFE17A)
                                  : Color(0xFFF6C19F),
                              width: 1,
                            ),
                          ),
                          padding: EdgeInsets.symmetric(
                            vertical: 8.h,
                            horizontal: 32.w,
                          ),
                        ),
                        switch (loadState) {
                          LoadState.error => Center(
                                child: Column(
                              children: [
                                100.verticalSpace,
                                Text('An Error Occurred'),
                              ],
                            )),
                          _ => ShimmerLoading(
                              isLoading: loadState.isLoading,
                              child: switch (selectedIndex) {
                                0 => ListView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: (usaLeaderBoard).length,
                                    itemBuilder: (c, i) =>
                                        Consumer(builder: (context, r, c) {
                                      final user = r.watch(currentUserProvider);
                                      return GestureDetector(
                                        onTap: () =>
                                            context.showPopUp(LeaderProfilePop(
                                          position: i + 1,
                                          model: usaLeaderBoard[i],
                                        )),
                                        child: PlayerRankTile(
                                          index: i,
                                          isYou: user.id ==
                                              (usaLeaderBoard[i].user?.id ??
                                                  ''),
                                          model: usaLeaderBoard[i],
                                        ),
                                      );
                                    }),
                                  ),
                                1 => ListView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: (myCountryLeaderBoard).length,
                                    itemBuilder: (c, i) =>
                                        Consumer(builder: (context, r, c) {
                                      final user = r.watch(currentUserProvider);
                                      return GestureDetector(
                                        onTap: () =>
                                            context.showPopUp(LeaderProfilePop(
                                          position: i + 1,
                                          model: myCountryLeaderBoard[i],
                                        )),
                                        child: PlayerRankTile(
                                          index: i,
                                          isYou: user.id ==
                                              (myCountryLeaderBoard[i]
                                                      .user
                                                      ?.id ??
                                                  ''),
                                          model: myCountryLeaderBoard[i],
                                        ),
                                      );
                                    }),
                                  ),
                                _ => ListView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: (leaderBoard).length,
                                    itemBuilder: (c, i) =>
                                        Consumer(builder: (context, r, c) {
                                      final user = r.watch(currentUserProvider);
                                      return GestureDetector(
                                        onTap: () =>
                                            context.showPopUp(LeaderProfilePop(
                                          position: i + 1,
                                          model: leaderBoard[i],
                                        )),
                                        child: PlayerRankTile(
                                          index: i,
                                          isYou: user.id ==
                                              (leaderBoard[i].user?.id ?? ''),
                                          model: leaderBoard[i],
                                        ),
                                      );
                                    }),
                                  )
                              }
                                  .withLoadingList(
                                isLoading: loadState.isLoading,
                                height: 38.h,
                              ),
                            ),
                        },
                      ],
                    ).withContainer(
                      color: selectedIndex == 1
                          ? Color(0xFFFBFFF2)
                          : AppColors.white,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  )
                ]
              ],
            ),
          )),
    );
  }
}

class PlayerRankTile extends ConsumerWidget {
  const PlayerRankTile({
    super.key,
    required this.index,
    required this.isYou,
    required this.model,
  });
  final int index;
  final bool isYou;
  final GlobalLeaderboard model;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final leaderBoardIndex =
        ref.watch(homeNotifierProvider.select((v) => v.leaderboardIndex));
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            switch (index) {
              0 => Assets.images.trophy1.image(),
              1 => Assets.images.trophy2.image(),
              2 => Assets.images.trophy3.image(),
              _ => Row(
                  children: [
                    AppSvgIcon(
                        path: Assets.svgs.arrowUp, fit: BoxFit.scaleDown),
                    4.horizontalSpace,
                    Text('#${index + 1}',
                        style: context.textTheme.bodySmall?.copyWith(
                          fontSize: 14.sp,
                          color: leaderBoardIndex == 1
                              ? AppColors.greenText
                              : AppColors.secondaryColor,
                        )),
                  ],
                )
            },
            16.horizontalSpace,
            SizedBox(
              height: 28.h,
              width: 28.w,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(49.r),
                  child: Assets.images.opponet.image(fit: BoxFit.cover)),
            ),
            8.horizontalSpace,
            Text(
              model.user?.username ?? 'Player',
              style: context.textTheme.bodySmall?.copyWith(
                fontSize: 14.sp,
                color: leaderBoardIndex == 1
                    ? AppColors.greenText
                    : AppColors.secondaryColor,
              ),
            )
          ],
        ),
        Text(
          (model.totalPoints ?? 0).formatAmount,
          style: context.textTheme.bodySmall?.copyWith(
            fontSize: 14.sp,
            color: leaderBoardIndex == 1
                ? AppColors.greenBorder
                : AppColors.orange0A,
          ),
        )
      ],
    ).withContainer(
        padding: EdgeInsets.symmetric(
          vertical: 5.h,
          horizontal: 32.w,
        ),
        color: switch (isYou) {
          true =>
            leaderBoardIndex == 1 ? Color(0xFFEFFED2) : AppColors.indicator,
          _ => null
        });
  }
}
