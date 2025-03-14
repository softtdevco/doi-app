
import 'package:doi_mobile/bootstrap.dart';
import 'package:doi_mobile/core/config/env/base_env.dart';
import 'package:doi_mobile/presentation/features/app.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';



void main() async {
  F.appFlavor = Flavor.staging;
  bootstrap(() => const ProviderScope(child: App()));
}
