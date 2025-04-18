


import 'package:doi_mobile/core/config/env/base_env.dart';

class ProdEnv implements BaseEnv {
  factory ProdEnv() => _instance;
  ProdEnv._internal();
  static final ProdEnv _instance = ProdEnv._internal();
  @override
  String get baseUrl => 'https://doi-apis.fly.dev';

 
}
