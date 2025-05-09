import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:doi_mobile/core/utils/logger.dart';
import 'package:firebase_app_installations/firebase_app_installations.dart';

class DeviceInfoService {
  static DeviceInfoService get instance => _getInstance();
  static DeviceInfoService? _instance;
  late DeviceInfoPlugin _deviceInfo;
  late FirebaseInstallations _firebaseAppInstallation;

  DeviceInfoService._internal() {
    _deviceInfo = DeviceInfoPlugin();
    _firebaseAppInstallation = FirebaseInstallations.instance;
  }

  static DeviceInfoService _getInstance() {
    _instance ??= DeviceInfoService._internal();
    return _instance!;
  }

  ///<====== Device Id would tie a user to a device, to avoid that we are using firebase installation ID =====>\\\
  Future<String> getDeviceInfo() async {
    try {
      if (Platform.isAndroid) {
        AndroidDeviceInfo androidInfo = await _deviceInfo.androidInfo;
        debugLog(androidInfo.id);
        return androidInfo.id;
      } else if (Platform.isIOS) {
        IosDeviceInfo iosInfo = await _deviceInfo.iosInfo;
        debugLog(iosInfo.identifierForVendor);
        return iosInfo.identifierForVendor ?? "";
      } else {
        throw UnsupportedError('Unsupported platform');
      }
    } catch (e) {
      return "Unsupported platform";
    }
  }

  Future<String> getFirebaseInstallationsId() async {
    try {
      final installationId = await _firebaseAppInstallation.getId();
      return installationId;
    } catch (e) {
      debugLog("Error retrieving Installations ID");
      return '';
    }
  }
}
