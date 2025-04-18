import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:doi_mobile/core/utils/logger.dart';


class DeviceInfoService {
  static DeviceInfoService get instance => _getInstance();
  static DeviceInfoService? _instance;
  late DeviceInfoPlugin _deviceInfo;


  DeviceInfoService._internal() {
    _deviceInfo = DeviceInfoPlugin();
  }

  static DeviceInfoService _getInstance() {
    _instance ??= DeviceInfoService._internal();
    return _instance!;
  }

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


}
