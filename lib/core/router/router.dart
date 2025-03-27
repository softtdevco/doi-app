import 'package:doi_mobile/presentation/features/dashboard/dashboard.dart';
import 'package:doi_mobile/presentation/features/dashboard/home/presentation/pages/decide_online_play.dart';
import 'package:doi_mobile/presentation/features/dashboard/home/presentation/pages/game_created.dart';
import 'package:doi_mobile/presentation/features/dashboard/home/presentation/pages/play_game.dart';
import 'package:doi_mobile/presentation/features/onboarding/presentation/pages/setup_profile_loggedin.dart';
import 'package:doi_mobile/presentation/features/onboarding/presentation/pages/welcome.dart';
import 'package:doi_mobile/presentation/general_widgets/result_page.dart';
import 'package:flutter/material.dart';

import '../../presentation/features/onboarding/presentation/pages/setup_profile.dart';

class AppRouter {
  static const String welcome = '/welcome';
  static const String dashboard = '/dashboard';
  static const String setUpProfileLoggedIn = '/setUpProfileLoggedIn';
  static const String setUpProfile = '/setUpProfile';
  static const String playGame = '/playGame';
  static const String result = '/result';
  static const String decideOnlinePlay = '/decideonlineplay';
  static const String gameCreated = '/gameCreated';

  static final Map<String, Widget Function(BuildContext)> _routes = {
    welcome: (context) => Welcome(),
    dashboard: (context) => Dashboard(),
    setUpProfileLoggedIn: (context) => SetUpProfileLoggedIn(),
    setUpProfile: (context) => SetUpProfile(),
    playGame: (context) => PlayGame(),
    result: (context) => Result(),
    decideOnlinePlay: (context) => DecideOnlinePlay(),
    gameCreated: (context) => GameCreated(),
  };

  static Map<String, Widget Function(BuildContext)> get routes => _routes;
}
