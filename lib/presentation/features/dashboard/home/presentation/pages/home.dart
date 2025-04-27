import 'dart:async';

import 'package:doi_mobile/core/extensions/context_extensions.dart';
import 'package:doi_mobile/core/extensions/navigation_extensions.dart';
import 'package:doi_mobile/core/extensions/overlay_extensions.dart';
import 'package:doi_mobile/core/extensions/texttheme_extensions.dart';
import 'package:doi_mobile/core/router/router.dart';
import 'package:doi_mobile/core/utils/colors.dart';
import 'package:doi_mobile/core/utils/logger.dart';
import 'package:doi_mobile/core/utils/styles.dart';
import 'package:doi_mobile/data/inapp_purchase/inapp_purchase_service.dart';
import 'package:doi_mobile/data/third_party_services/branch_service.dart';
import 'package:doi_mobile/gen/assets.gen.dart';
import 'package:doi_mobile/l10n/l10n.dart';
import 'package:doi_mobile/presentation/features/dashboard/home/presentation/notifiers/in_app_notifier.dart';
import 'package:doi_mobile/presentation/features/dashboard/home/presentation/pages/widgets/daily_rewards_sheet.dart';
import 'package:doi_mobile/presentation/features/dashboard/home/presentation/pages/widgets/game_invite_sheet.dart';
import 'package:doi_mobile/presentation/features/dashboard/home/presentation/pages/widgets/home_appbar.dart';
import 'package:doi_mobile/presentation/features/dashboard/home/presentation/pages/widgets/start_game.dart';
import 'package:doi_mobile/presentation/features/dashboard/store/presenation/pages/widgets/power_up_tile.dart';
import 'package:doi_mobile/presentation/general_widgets/doi_button.dart';
import 'package:doi_mobile/presentation/general_widgets/doi_scaffold.dart';
import 'package:doi_mobile/presentation/general_widgets/doi_svg_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Home extends ConsumerStatefulWidget {
  const Home({super.key});

  @override
  ConsumerState<Home> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  late DraggableScrollableController dragScrollController;
  late StreamSubscription<Map> _branchStreamSubscription;

  @override
  void initState() {
    super.initState();

    dragScrollController = DraggableScrollableController()..addListener(() {});
    _initDeepLinkListener();
  }

  _buy(String id) {
    ref.read(inAppNotifierProvider.notifier).buyProduct(
          productId: id,
          onCompleted: () {
            context.showSuccess(message: 'Succsesfully purchased');
          },
          onError: (p0) {
            context.showError(
              message: p0,
            );
          },
        );
  }

  void _initDeepLinkListener() {
    _branchStreamSubscription =
        BranchLinkService().setupDeepLinkListener(onLinkOpened: (gameData) {
      _joinGameWithData(gameData);
    });
  }

  void _joinGameWithData(Map<String, dynamic> gameData) {
    context.showBottomSheet(
      isDismissible: true,
      color: AppColors.white,
      child: GameInviteSheet(
        inviteCode: gameData['gameCode'] ?? '',
        invitee: gameData['inviteeName'] ?? '',
        digitCount: int.parse(gameData['digitCount']),
        playerCount: int.parse(gameData['playerCount']),
      ),
    );
    debugLog(gameData);
  }

  @override
  Widget build(BuildContext context) {
    return DoiScaffold(
      appbar: DoiHomeAppbar(),
      bodyPadding: EdgeInsets.only(
        top: 24,
        left: 24,
        right: 24,
      ),
      body: Column(
        children: [
          24.verticalSpace,
          Align(
            alignment: Alignment.topLeft,
            child: AppSvgIcon(path: Assets.svgs.calendarStar),
          ),
          GestureDetector(
            onTap: () => context.showBottomSheet(
              isDismissible: true,
              color: AppColors.background,
              child: DailyRewardsSheet(),
            ),
            child: Assets.images.doi.image(
              fit: BoxFit.cover,
              width: 86.w,
            ),
          ),
          16.verticalSpace,
          Text(
            context.l10n.startNew,
            style: context.textTheme.bodySmall?.copyWith(
              fontSize: 16.sp,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                44.verticalSpace,
                DoiButton(
                  text: context.l10n.newGame,
                  onPressed: () =>
                      context.pushNamed(AppRouter.decideOnlinePlay),
                ),
                16.verticalSpace,
                DoiButton(
                  buttonStyle: DoiButtonStyle(
                    background: AppColors.green,
                    borderColor: AppColors.greenBorder,
                  ),
                  text: context.l10n.singlePlayer,
                  onPressed: () => context.showBottomSheet(
                    isDismissible: true,
                    color: AppColors.white,
                    child: StartGame(),
                  ),
                ),
                16.verticalSpace,
                Stack(
                  children: [
                    DoiButton(
                      text: context.l10n.arcade,
                      onPressed: () => context.pushNamed(AppRouter.arcade),
                    ),
                    Positioned(
                      right: 0,
                      child: Assets.images.cloudGaming.image(),
                    )
                  ],
                ),
              ],
            ),
          ),
          69.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                context.l10n.powerUps,
                style: context.textTheme.bodySmall?.copyWith(
                  fontSize: 16.sp,
                ),
              ),
              GestureDetector(
                onTap: () => context.pushNamed(AppRouter.store),
                child: Row(
                  children: [
                    Text(
                      context.l10n.store,
                      style: context.textTheme.bodySmall?.copyWith(
                        fontSize: 16.sp,
                      ),
                    ),
                    4.horizontalSpace,
                    AppSvgIcon(path: Assets.svgs.store)
                  ],
                ),
              )
            ],
          ),
          19.verticalSpace,
          Expanded(
            child: ListView(
              children: [
                PowerUpTile(
                  label: 'Freeze Time',
                  iconPath: Assets.svgs.freezeTime,
                  onBuy: () => _buy(ProductIds.freezeTime),
                ),
                PowerUpTile(
                  label: 'Reveal 1 Digit',
                  iconPath: Assets.svgs.reveal,
                  onBuy: () => _buy(ProductIds.revealDigit),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _branchStreamSubscription.cancel();
    super.dispose();
  }
}
