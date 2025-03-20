import 'package:doi_mobile/presentation/features/dashboard/dashboard.dart';
import 'package:doi_mobile/presentation/features/onboarding/presentation/pages/authentication.dart';
import 'package:doi_mobile/presentation/features/onboarding/presentation/pages/setup.profile.dart';
import 'package:doi_mobile/presentation/features/onboarding/presentation/pages/setup.profile.loggedin.dart';
import 'package:doi_mobile/presentation/features/onboarding/presentation/pages/welcome.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static const String welcome = '/welcome';
  static const String dashboard = '/dashboard';
  static const String setUpProfileLoggedIn= '/setUpProfileLoggedIn';
  static const String setUpProfile= '/setUpProfile';

  static final Map<String, Widget Function(BuildContext)> _routes = {
    welcome: (context) => Welcome(),
    dashboard: (context) => Dashboard(),
    setUpProfileLoggedIn: (context) => SetUpProfileLoggedIn(),
    setUpProfile: (context) => SetUpProfile(),
  };

  static Map<String, Widget Function(BuildContext)> get routes => _routes;
}
