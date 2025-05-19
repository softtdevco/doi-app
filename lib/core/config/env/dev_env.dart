import 'package:doi_mobile/core/config/env/base_env.dart';


class DevEnv implements BaseEnv {
  factory DevEnv() => _instance;
  DevEnv._internal();
  static final DevEnv _instance = DevEnv._internal();
  @override
  String get baseUrl => 'https://doi-new-production.up.railway.app';
  
  @override
  String get socketUrl => 'https://observant-optimism-production.up.railway.app';
}
