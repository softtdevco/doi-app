import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:doi_mobile/core/config/api_keys.dart';
import 'package:doi_mobile/core/utils/logger.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdManager {
  static final AdManager _instance = AdManager._internal();
  factory AdManager() => _instance;
  AdManager._internal();

  RewardedAd? _rewardedAd;
  bool _isRewardedAdLoaded = false;
  Timer? _adLoadTimer;

  BannerAd? _bannerAd;
  bool _isBannerAdLoaded = false;

  bool get isRewardedAdLoaded => _isRewardedAdLoaded;
  bool get isBannerAdLoaded => _isBannerAdLoaded;
  BannerAd? get bannerAd => _bannerAd;

  Future<void> initialize() async {
    await MobileAds.instance.initialize();

    final testDeviceId = await _getTestDeviceId();

    debugLog('');
    debugLog('==========================================================');
    debugLog('📱 ADMOB TEST DEVICE ID: $testDeviceId');
    debugLog('==========================================================');
    debugLog('');

    if (testDeviceId != null) {
      MobileAds.instance.updateRequestConfiguration(
        RequestConfiguration(testDeviceIds: [testDeviceId]),
      );

      debugLog('✅ Test device ID has been automatically configured.');
    }

    loadRewardedAd();
  }

  Future<String?> _getTestDeviceId() async {
    try {
      final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

      if (Platform.isAndroid) {
        final androidInfo = await deviceInfo.androidInfo;
        final androidId = androidInfo.id;

        final bytes = utf8.encode(androidId);
        final digest = md5.convert(bytes);
        return digest.toString().toUpperCase();
      } else if (Platform.isIOS) {
        final iosInfo = await deviceInfo.iosInfo;
        final identifierForVendor = iosInfo.identifierForVendor;

        if (identifierForVendor != null) {
          final bytes = utf8.encode(identifierForVendor);
          final digest = md5.convert(bytes);
          return digest.toString().toUpperCase();
        }
      }

      return null;
    } catch (e) {
      debugLog('Error getting test device ID: $e');
      return null;
    }
  }

  void _cancelLoadTimer() {
    _adLoadTimer?.cancel();
    _adLoadTimer = null;
  }

  void loadRewardedAd() {
    _cancelLoadTimer();

    RewardedAd.load(
      adUnitId: ApiKeys.getRewardedAdUnitId(),
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (RewardedAd ad) {
          debugLog('Rewarded ad loaded successfully');
          _rewardedAd = ad;
          _isRewardedAdLoaded = true;

          _rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (RewardedAd ad) {
              debugLog('Ad dismissed');
              ad.dispose();
              _isRewardedAdLoaded = false;

              _adLoadTimer = Timer(const Duration(milliseconds: 500), () {
                loadRewardedAd();
              });
            },
            onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error) {
              debugLog('Ad failed to show: $error');
              ad.dispose();
              _isRewardedAdLoaded = false;

              _adLoadTimer = Timer(const Duration(milliseconds: 500), () {
                loadRewardedAd();
              });
            },
            onAdShowedFullScreenContent: (RewardedAd ad) {
              debugLog('Ad showed fullscreen content');
            },
            onAdImpression: (RewardedAd ad) {
              debugLog('Ad impression recorded');
            },
          );
        },
        onAdFailedToLoad: (LoadAdError error) {
          debugLog('Rewarded ad failed to load: $error');
          _isRewardedAdLoaded = false;

          _adLoadTimer = Timer(const Duration(seconds: 30), () {
            loadRewardedAd();
          });
        },
      ),
    );
  }

  void loadBannerAd({
    AdSize size = AdSize.banner,
    Function(BannerAd ad)? onAdLoaded,
  }) {
    _bannerAd?.dispose();
    _isBannerAdLoaded = false;

    debugLog('Loading banner ad...');

    _bannerAd = BannerAd(
      adUnitId: ApiKeys.getBannerAdUnitId(),
      size: size,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          debugLog('Banner ad loaded successfully');
          _isBannerAdLoaded = true;
          if (onAdLoaded != null) {
            onAdLoaded(ad as BannerAd);
          }
        },
        onAdFailedToLoad: (ad, error) {
          debugLog('Banner ad failed to load: $error');
          _isBannerAdLoaded = false;
          ad.dispose();

          _adLoadTimer = Timer(const Duration(seconds: 30), () {
            loadBannerAd(size: size, onAdLoaded: onAdLoaded);
          });
        },
        onAdOpened: (ad) {
          debugLog('Banner ad opened');
        },
        onAdClosed: (ad) {
          debugLog('Banner ad closed');
        },
        onAdImpression: (ad) {
          debugLog('Banner ad impression recorded');
        },
      ),
    );

    _bannerAd!.load();
  }

  Future<bool> showRewardedAd(
      {required Function(num) onUserEarnedReward}) async {
    if (_rewardedAd == null || !_isRewardedAdLoaded) {
      debugLog('Rewarded ad not ready yet');
      return false;
    }

    try {
      await _rewardedAd!.show(
        onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {
          debugLog('User earned reward: ${reward.amount} ${reward.type}');
          onUserEarnedReward(reward.amount);
        },
      );
      return true;
    } catch (e) {
      debugLog('Error showing rewarded ad: $e');
      _isRewardedAdLoaded = false;

      _adLoadTimer = Timer(const Duration(seconds: 1), () {
        loadRewardedAd();
      });
      return false;
    }
  }

  String getAdAvailabilityStatus() {
    if (_isRewardedAdLoaded) {
      return "ready";
    } else {
      return "unavailable";
    }
  }

  void forceReloadAds() {
    _rewardedAd?.dispose();
    _bannerAd?.dispose();

    _rewardedAd = null;
    _isRewardedAdLoaded = false;
    _bannerAd = null;
    _isBannerAdLoaded = false;

    _cancelLoadTimer();

    loadRewardedAd();
  }

  void dispose() {
    _rewardedAd?.dispose();
    _rewardedAd = null;
    _isRewardedAdLoaded = false;
    _bannerAd?.dispose();
    _bannerAd = null;
    _isBannerAdLoaded = false;
    _cancelLoadTimer();
  }
}
