import 'dart:async';
import 'dart:developer';

import 'package:doi_mobile/data/local_storage/storage_keys.dart';
import 'package:flutter/widgets.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> bootstrap(FutureOr<Widget> Function() builder) async {
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  await Hive.openBox(HiveKeys.appBox);
  // Add cross-flavor configuration here

  runApp(await builder());
}
