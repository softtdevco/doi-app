import 'dart:io';

class ApiKeys {
  static const String map = "AIzaSyAYZN7ujeNMC2LE1JJ-T3v9cqyZkp0WFew";

  static const String androidTestUnitId =
      "ca-app-pub-3940256099942544/5224354917";
  static const String iOSTestUnitId = "ca-app-pub-3940256099942544/1712485313";

  static const String androidProdUnitId = "YOUR_ANDROID_PROD_UNIT_ID";
  static const String iOSProdUnitId = "YOUR_IOS_PROD_UNIT_ID";

  static const bool useTestAds = true;

  static String getRewardedAdUnitId() {
    if (useTestAds) {
      return Platform.isAndroid ? androidTestUnitId : iOSTestUnitId;
    } else {
      return Platform.isAndroid ? androidProdUnitId : iOSProdUnitId;
    }
  }

  static String getBannerAdUnitId() {
    if (useTestAds) {
      if (Platform.isAndroid) {
        return 'ca-app-pub-3940256099942544/6300978111';
      } else if (Platform.isIOS) {
        return 'ca-app-pub-3940256099942544/2934735716';
      }
    }

    if (Platform.isAndroid) {
      return 'YOUR_ANDROID_BANNER_AD_UNIT_ID';
    } else if (Platform.isIOS) {
      return 'YOUR_IOS_BANNER_AD_UNIT_ID';
    }

    return '';
  }
}
