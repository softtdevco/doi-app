import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:doi_mobile/core/config/api_keys.dart';
import 'package:doi_mobile/core/utils/logger.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdManager {
  // Singleton pattern
  static final AdManager _instance = AdManager._internal();
  factory AdManager() => _instance;
  AdManager._internal();

  // Ad instances
  RewardedAd? _rewardedAd;
  bool _isRewardedAdLoaded = false;
  Timer? _adLoadTimer;

  // Getters
  bool get isRewardedAdLoaded => _isRewardedAdLoaded;

  // Initialize AdMob
  Future<void> initialize() async {
    // Initialize the Mobile Ads SDK
    await MobileAds.instance.initialize();

    // Get and log test device ID
    final testDeviceId = await _getTestDeviceId();

    // Log the ID to the console
    debugLog('');
    debugLog('==========================================================');
    debugLog('📱 ADMOB TEST DEVICE ID: $testDeviceId');
    debugLog('==========================================================');
    debugLog('');

    // Set this device as a test device automatically
    if (testDeviceId != null) {
      MobileAds.instance.updateRequestConfiguration(
        RequestConfiguration(testDeviceIds: [testDeviceId]),
      );

      debugLog('✅ Test device ID has been automatically configured.');
    }

    // Load initial rewarded ad
    loadRewardedAd();
  }

  // Get the test device ID for AdMob
  Future<String?> _getTestDeviceId() async {
    try {
      final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

      if (Platform.isAndroid) {
        final androidInfo = await deviceInfo.androidInfo;
        final androidId = androidInfo.id;

        // Create MD5 hash of the Android ID
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

  // Cancel any pending timers
  void _cancelLoadTimer() {
    _adLoadTimer?.cancel();
    _adLoadTimer = null;
  }

  // Load a rewarded ad
  void loadRewardedAd() {
    // Cancel any pending timers
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

          // Retry after a delay
          _adLoadTimer = Timer(const Duration(seconds: 30), () {
            loadRewardedAd();
          });
        },
      ),
    );
  }

  // Show rewarded ad with callback
  Future<bool> showRewardedAd({required Function onUserEarnedReward}) async {
    if (_rewardedAd == null || !_isRewardedAdLoaded) {
      debugLog('Rewarded ad not ready yet');
      return false;
    }

    try {
      await _rewardedAd!.show(
        onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {
          debugLog('User earned reward: ${reward.amount} ${reward.type}');
          onUserEarnedReward();
        },
      );
      return true;
    } catch (e) {
      debugLog('Error showing rewarded ad: $e');
      _isRewardedAdLoaded = false;

      // Try to load a new ad after error - FIXED: using one-time Timer instead of Timer.periodic
      _adLoadTimer = Timer(const Duration(seconds: 1), () {
        loadRewardedAd();
      });
      return false;
    }
  }

  // Check if ad is available
  String getAdAvailabilityStatus() {
    if (_isRewardedAdLoaded) {
      return "ready";
    } else {
      return "unavailable";
    }
  }

  // Force a reload of ads
  void forceReloadAds() {
    // Dispose current ads
    _rewardedAd?.dispose();

    // Reset states
    _rewardedAd = null;
    _isRewardedAdLoaded = false;

    // Cancel any pending timers
    _cancelLoadTimer();

    // Start fresh
    loadRewardedAd();
  }

  // Dispose ad resources
  void dispose() {
    _rewardedAd?.dispose();
    _rewardedAd = null;
    _isRewardedAdLoaded = false;
    _cancelLoadTimer();
  }
}
