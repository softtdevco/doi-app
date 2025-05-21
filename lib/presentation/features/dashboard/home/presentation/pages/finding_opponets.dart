import 'package:doi_mobile/core/extensions/navigation_extensions.dart';
import 'package:doi_mobile/core/extensions/string_extensions.dart';
import 'package:doi_mobile/core/extensions/texttheme_extensions.dart';
import 'package:doi_mobile/core/router/router.dart';
import 'package:doi_mobile/core/utils/colors.dart';
import 'package:doi_mobile/gen/assets.gen.dart';
import 'package:doi_mobile/gen/fonts.gen.dart';
import 'package:doi_mobile/presentation/features/dashboard/onlineGame/data/model/join_game_response.dart';
import 'package:doi_mobile/presentation/features/dashboard/playOnline/presentation/notifiers/play_online_notifier.dart';
import 'package:doi_mobile/presentation/features/dashboard/playOnline/presentation/pages/widgets/online_player_ready_tile.dart';
import 'package:doi_mobile/presentation/features/profile/data/repository/user_repository_impl.dart';
import 'package:doi_mobile/presentation/general_widgets/doi_appbar.dart';
import 'package:doi_mobile/presentation/general_widgets/doi_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FindingOpponents extends ConsumerStatefulWidget {
  const FindingOpponents({super.key});

  @override
  ConsumerState<FindingOpponents> createState() => _FindingOpponentsState();
}

class _FindingOpponentsState extends ConsumerState<FindingOpponents> {
  @override
  void initState() {
    super.initState();
    ref.listenManual(playOnlineNotifierProvider, (previous, current) {
      if (current.allPlayersJoined) {
        ref.read(playOnlineNotifierProvider.notifier).resumeTimer();
        context.pushNamed(AppRouter.playOnlineGamePlay);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  Player? getOpponent() {
    final joinedPlayers = ref.watch(playOnlineNotifierProvider
        .select((v) => v.gameSessionData?.players ?? []));
    final user = ref.watch(currentUserProvider);
    if (joinedPlayers.length <= 1) {
      return null;
    }

    return joinedPlayers.firstWhere(
      (player) => player.playerId != user.id,
      orElse: () => Player(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(currentUserProvider);
    final opponent = getOpponent();
    return DoiScaffold(
      bodyPadding: EdgeInsets.zero,
      appbar: DoiAppbar(
        leading: Assets.svgs.close,
      ),
      body: Column(
        children: [
          24.verticalSpace,
          Text(
            'Finding an opponent...',
            style: context.textTheme.bodySmall?.copyWith(fontSize: 20.sp),
            textAlign: TextAlign.center,
          ),
          46.verticalSpace,
          switch (opponent == null) {
            true => OnlinePlayerWaitingTile(),
            _ => OnlinePlayerReadyTile(player: opponent!),
          },
          47.verticalSpace,
          Row(
            spacing: 16.w,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 100.w,
                height: 1.h,
                color: AppColors.primaryColor,
              ),
              Text(
                'Vs',
                style: context.textTheme.bodyMedium?.copyWith(
                    fontSize: 30.sp,
                    color: AppColors.primaryColor,
                    fontFamily: FontFamily.jungleAdventurer),
              ),
              Container(
                width: 100.w,
                height: 1.h,
                color: AppColors.primaryColor,
              ),
            ],
          ),
          47.verticalSpace,
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(71.r),
                child: Image.asset(
                  'assets/images/${(user.avatar ?? 'userPic4.png').toLowerCase()}',
                  fit: BoxFit.cover,
                  height: 116.h,
                  width: 117.w,
                  errorBuilder: (context, error, stackTrace) => ClipRRect(
                    borderRadius: BorderRadius.circular(182.r),
                    child: Image.asset(
                      Assets.images.userpic3.path,
                      fit: BoxFit.cover,
                      height: 116.h,
                      width: 117.w,
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Text(getFlagEmoji(user.countryCode ?? 'US')),
              )
            ],
          ),
          24.verticalSpace,
          Text(
            'YOU',
            style: context.textTheme.bodyMedium?.copyWith(
              fontSize: 24.sp,
              color: AppColors.secondaryColor,
              fontFamily: FontFamily.jungleAdventurer,
            ),
          )
        ],
      ),
    );
  }
}
