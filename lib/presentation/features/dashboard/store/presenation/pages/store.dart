import 'package:doi_mobile/core/extensions/overlay_extensions.dart';
import 'package:doi_mobile/core/extensions/texttheme_extensions.dart';
import 'package:doi_mobile/core/utils/colors.dart';
import 'package:doi_mobile/core/utils/logger.dart';
import 'package:doi_mobile/data/third_party_services/ads_service.dart';
import 'package:doi_mobile/gen/assets.gen.dart';
import 'package:doi_mobile/gen/fonts.gen.dart';
import 'package:doi_mobile/l10n/l10n.dart';
import 'package:doi_mobile/presentation/features/dashboard/home/data/model/product_model.dart';
import 'package:doi_mobile/presentation/features/dashboard/home/data/repository/game_repository_impl.dart';
import 'package:doi_mobile/presentation/features/dashboard/home/presentation/notifiers/in_app_notifier.dart';
import 'package:doi_mobile/presentation/features/dashboard/home/presentation/pages/widgets/coin_count.dart';
import 'package:doi_mobile/presentation/features/dashboard/onlineGame/presentation/notifiers/online_game_notifier.dart';
import 'package:doi_mobile/presentation/features/dashboard/store/presenation/pages/widgets/coin_tile.dart';
import 'package:doi_mobile/presentation/features/dashboard/store/presenation/pages/widgets/my_items_tile.dart';
import 'package:doi_mobile/presentation/features/dashboard/store/presenation/pages/widgets/power_up_tile.dart';
import 'package:doi_mobile/presentation/features/dashboard/store/presenation/pages/widgets/store_app_bar.dart';
import 'package:doi_mobile/presentation/general_widgets/banner_ads_widget.dart';
import 'package:doi_mobile/presentation/general_widgets/doi_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Store extends ConsumerStatefulWidget {
  const Store({super.key});

  @override
  ConsumerState<Store> createState() => _StoreState();
}

class _StoreState extends ConsumerState<Store> {
  @override
  void initState() {
    super.initState();
    ref.read(inAppNotifierProvider.notifier).initialize();
  }

  void _buyPowerUps(int coinCost) {
    ref.read(onlineGameNotifierProvider.notifier).buyPowerUps(
          coinCost: coinCost,
          onSuccess: () {
            context.showSuccess(message: 'PowerUps purchased successfully');
          },
          onInsufficientFunds: () {
            context.showError(message: 'Insufficient Coins, Top up your coins');
          },
        );
  }

  @override
  Widget build(BuildContext context) {
    // final selectedIndex =
    //     ref.watch(storeNotifierProvider.select((s) => s.switchIndex));
    final inAppNotifier = ref.read(inAppNotifierProvider.notifier);
    return DoiScaffold(
        appbar: StoreAppbar(
          title: Text(
            'Store'.toUpperCase(),
            style: context.textTheme.bodyMedium?.copyWith(
              color: AppColors.secondaryColor,
              fontSize: 20.sp,
              fontFamily: FontFamily.jungleAdventurer,
              fontWeight: FontWeight.w400,
            ),
          ),
          trailing: CoinCount(),
        ),
        backgroundColor: AppColors.background,
        showBackImage: false,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            24.verticalSpace,
            // StoreSwitch(
            //   index: selectedIndex,
            //   onChanged: (v) {
            //     ref.read(storeNotifierProvider.notifier).selectSwitchIndex(v);
            //   },
            // ),
            24.verticalSpace,
            Text(
              'My Items',
              style: context.textTheme.bodySmall?.copyWith(
                fontSize: 16.sp,
              ),
            ),
            19.verticalSpace,
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                spacing: 16.w,
                children: [
                  MyItemTile(
                    path: Assets.svgs.freezeTime,
                    name: 'Freeze Time',
                    value: '2',
                  ),
                  MyItemTile(
                    path: Assets.svgs.reveal,
                    name: 'Reveal 1 Digit',
                    value: '0',
                  ),
                  MyItemTile(
                    path: Assets.svgs.codeSwap,
                    name: 'Code Swap',
                    value: '0',
                  ),
                ],
              ),
            ),
            24.verticalSpace,
            Center(child: BannerAdWidget()),
            24.verticalSpace,
            Text(
              'Coins',
              style: context.textTheme.bodySmall?.copyWith(fontSize: 16.sp),
            ),
            19.verticalSpace,
            Consumer(builder: (context, r, c) {
              _buy(String id) {
                r.read(inAppNotifierProvider.notifier).buyProduct(
                      productId: id,
                      onCompleted: () {
                        debugLog('google purchase up');
                      },
                      onError: (p0) {
                        context.showError(
                          message: p0,
                        );
                      },
                    );
              }

              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  spacing: 8.w,
                  children: [
                    CoinTile(
                      path: Assets.images.a50Coin.path,
                      value: '50',
                      isFree: true,
                      onBuy: _showAdThenEarn,
                    ),
                    CoinTile(
                      path: Assets.images.a2kCoin.path,
                      value: '2,000',
                      price: inAppNotifier.getPrice(ProductIds.coinPack1),
                      onBuy: () => _buy(ProductIds.coinPack1),
                    ),
                    CoinTile(
                      path: Assets.images.a2kCoin.path,
                      value: '5,000',
                      price: inAppNotifier.getPrice(ProductIds.coinPack2),
                      onBuy: () => _buy(ProductIds.coinPack2),
                    ),
                    CoinTile(
                      path: Assets.images.a2kCoin.path,
                      value: '10,000',
                      price: inAppNotifier.getPrice(ProductIds.coinPack3),
                      onBuy: () => _buy(ProductIds.coinPack3),
                    ),
                  ],
                ),
              );
            }),
            24.verticalSpace,
            Text(
              context.l10n.powerUps,
              style: context.textTheme.bodySmall?.copyWith(
                fontSize: 16.sp,
              ),
            ),
            19.verticalSpace,
            Expanded(
              child: ListView(
                children: [
                  PowerUpTile(
                    label: 'Freeze Time',
                    iconPath: Assets.svgs.freezeTime,
                    onBuy: () => _buyPowerUps(200),
                  ),
                  PowerUpTile(
                    label: 'Reveal 1 Digit',
                    iconPath: Assets.svgs.reveal,
                    onBuy: () => _buyPowerUps(200),
                  ),
                  PowerUpTile(
                    label: 'Code Swap',
                    iconPath: Assets.svgs.codeSwap,
                    onBuy: () => _buyPowerUps(200),
                  ),
                ],
              ),
            ),
          ],
        ));
  }

  void _showAdThenEarn() {
    final adManager = AdManager();

    if (adManager.isRewardedAdLoaded) {
      adManager.showRewardedAd(
        onUserEarnedReward: (p0) {
          ref.read(gameRepositoryProvider).updateCoins(p0.toInt());
          debugLog('You earned a reward!');
        },
      ).then((wasAdShown) {
        if (!wasAdShown) {
          context.showError(
              message: 'Ad not available. Please try again later.');
        }
      });
    } else {
      if (adManager.isRewardedAdLoaded) {
        _showAdThenEarn();
      } else {
        context.showError(message: 'Ad not available. Please try again later.');

        adManager.forceReloadAds();
      }
    }
  }
}
