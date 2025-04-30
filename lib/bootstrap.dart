import 'dart:async';
import 'dart:developer';

import 'package:doi_mobile/data/local_storage/storage_keys.dart';
import 'package:doi_mobile/data/third_party_services/ads_service.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_branch_sdk/flutter_branch_sdk.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> bootstrap(FutureOr<Widget> Function() builder) async {
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };
  // Add cross-flavor configuration here
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterBranchSdk.init();
  // FlutterBranchSdk.validateSDKIntegration();
  await AdManager().initialize();
  await Hive.initFlutter();
  await Hive.openBox(HiveKeys.appBox);
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  runApp(await builder());
}
