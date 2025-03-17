import 'package:doi_mobile/presentation/features/onboarding/presentation/pages/welcome.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static const String welcome = '/welcome';

  static final Map<String, Widget Function(BuildContext)> _routes = {
    welcome: (context) => Welcome(),
  };

  static Map<String, Widget Function(BuildContext)> get routes => _routes;
}
