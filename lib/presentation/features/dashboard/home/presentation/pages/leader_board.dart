import 'package:doi_mobile/core/extensions/context_extensions.dart';
import 'package:doi_mobile/core/extensions/texttheme_extensions.dart';
import 'package:doi_mobile/core/extensions/widget_extensions.dart';
import 'package:doi_mobile/core/utils/colors.dart';
import 'package:doi_mobile/gen/assets.gen.dart';
import 'package:doi_mobile/gen/fonts.gen.dart';
import 'package:doi_mobile/presentation/features/dashboard/home/presentation/notifiers/home_notifier.dart';
import 'package:doi_mobile/presentation/features/dashboard/home/presentation/pages/widgets/leaderboard_switch.dart';
import 'package:doi_mobile/presentation/features/profile/presentation/widgets/leader_profile_pop.dart';
import 'package:doi_mobile/presentation/general_widgets/doi_appbar.dart';
import 'package:doi_mobile/presentation/general_widgets/doi_scaffold.dart';
import 'package:doi_mobile/presentation/general_widgets/doi_svg_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LeaderBoard extends ConsumerStatefulWidget {
  const LeaderBoard({super.key});

  @override
  ConsumerState<LeaderBoard> createState() => _LeaderBoardState();
}

class _LeaderBoardState extends ConsumerState<LeaderBoard> {
  @override
  Widget build(BuildContext context) {
    final selectedIndex =
        ref.watch(homeNotifierProvider.select((v) => v.leaderboardIndex));
    return DoiScaffold(
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
          trailing: AppSvgIcon(
            path: Assets.svgs.help,
            color: selectedIndex == 1
                ? AppColors.greenText
                : AppColors.secondaryColor,
          ),
        ),
        bodyPadding: EdgeInsets.all(24),
        body: Column(
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
            24.verticalSpace,
            Assets.images.mobileLeaderboard.image(
              fit: BoxFit.cover,
            ),
            24.verticalSpace,
            Expanded(
              child: ListView(
                children: [
                  Text(
                    switch (selectedIndex) {
                      0 => 'Lagos  🌆',
                      1 => 'Nigeria  🇳🇬',
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
                  Column(
                    children: List.generate(
                        10,
                        (i) => GestureDetector(
                            onTap: () => context.showPopUp(LeaderProfilePop()),
                            child: PlayerRankTile(index: i, isYou: i == 5))),
                  )
                ],
              ).withContainer(
                color: selectedIndex == 1 ? Color(0xFFFBFFF2) : AppColors.white,
                borderRadius: BorderRadius.circular(12.r),
              ),
            )
          ],
        ));
  }
}

class PlayerRankTile extends ConsumerWidget {
  const PlayerRankTile({
    super.key,
    required this.index,
    required this.isYou,
  });
  final int index;
  final bool isYou;

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
              'Kevin${index + 1}real',
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
          '33,590',
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
