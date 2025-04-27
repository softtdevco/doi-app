import 'package:doi_mobile/core/extensions/texttheme_extensions.dart';
import 'package:doi_mobile/core/utils/colors.dart';
import 'package:doi_mobile/core/utils/logger.dart';
import 'package:doi_mobile/gen/assets.gen.dart';
import 'package:doi_mobile/gen/fonts.gen.dart';
import 'package:doi_mobile/presentation/features/dashboard/onlineGame/presentation/notifiers/online_game_notifier.dart';
import 'package:doi_mobile/presentation/features/dashboard/home/presentation/pages/widgets/waiting_friend_tile.dart';
import 'package:doi_mobile/presentation/general_widgets/doi_appbar.dart';
import 'package:doi_mobile/presentation/general_widgets/doi_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WaitingScreen extends ConsumerStatefulWidget {
  const WaitingScreen({super.key, required this.arg});
  final (int, String) arg;
  @override
  ConsumerState<WaitingScreen> createState() => _WaitingScreenState();
}

class _WaitingScreenState extends ConsumerState<WaitingScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(onlineGameNotifierProvider.notifier).startPolling(
          joinCode: widget.arg.$2,
          expectedPlayerCount: widget.arg.$1,
          onAllPlayersJoined: () {
            debugLog('All players joined');
          });
    });
  }

  @override
  void dispose() {
    ref.read(onlineGameNotifierProvider.notifier).stopPolling();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final joinedPlayers = ref.watch(onlineGameNotifierProvider
        .select((v) => v.gameSessionData?.players ?? []));

    return DoiScaffold(
      bodyPadding: EdgeInsets.all(24),
      showBackImage: false,
      appbar: DoiAppbar(
        leading: Assets.svgs.close,
      ),
      body: Column(
        children: [
          11.verticalSpace,
          Text(
            'Waiting for friend to join',
            style: context.textTheme.bodySmall?.copyWith(fontSize: 20.sp),
          ),
          46.verticalSpace,
          ClipRRect(
            child: Assets.images.avatar1.image(
              height: 61.h,
              width: 61.w,
            ),
            borderRadius: BorderRadius.circular(32.r),
          ),
          8.verticalSpace,
          Text(
            'YOU',
            style: context.textTheme.bodyMedium?.copyWith(
              fontFamily: FontFamily.jungleAdventurer,
              fontSize: 17.28.sp,
              color: AppColors.secondaryColor,
            ),
          ),
          40.verticalSpace,
          Expanded(
              child: ListView.separated(
                  separatorBuilder: (context, i) => 16.verticalSpace,
                  itemCount: widget.arg.$1,
                  itemBuilder: (context, i) {
                    if (i < joinedPlayers.length) {
                      final player = joinedPlayers[i];
                      return JoinedFriendTile(
                        player: player,
                      );
                    } else {
                      return WaitingFriendTile();
                    }
                  }))
        ],
      ),
      footerButton: Assets.images.mobileLeaderboard.image(),
    );
  }
}
