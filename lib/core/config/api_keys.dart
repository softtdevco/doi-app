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
}
