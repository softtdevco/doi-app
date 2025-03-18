import 'package:doi_mobile/presentation/features/dashboard/dashboard.dart';
import 'package:doi_mobile/presentation/features/onboarding/presentation/pages/welcome.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static const String welcome = '/welcome';
  static const String dashboard = '/dashboard';

  static final Map<String, Widget Function(BuildContext)> _routes = {
    welcome: (context) => Welcome(),
    dashboard: (context) => Dashboard(),
  };

  static Map<String, Widget Function(BuildContext)> get routes => _routes;
}
