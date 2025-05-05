import 'package:doi_mobile/presentation/features/dashboard/Arcade/presentation/pages/arcade.dart';
import 'package:doi_mobile/presentation/features/dashboard/dashboard.dart';
import 'package:doi_mobile/presentation/features/dashboard/friends/presentation/pages/friend_profile.dart';
import 'package:doi_mobile/presentation/features/dashboard/home/presentation/pages/adding_friend.dart';
import 'package:doi_mobile/presentation/features/dashboard/home/presentation/pages/decide_online_play.dart';
import 'package:doi_mobile/presentation/features/dashboard/home/presentation/pages/finding_opponets.dart';
import 'package:doi_mobile/presentation/features/dashboard/home/presentation/pages/game_created.dart';
import 'package:doi_mobile/presentation/features/dashboard/home/presentation/pages/home.dart';
import 'package:doi_mobile/presentation/features/dashboard/home/presentation/pages/leader_board.dart';
import 'package:doi_mobile/presentation/features/dashboard/home/presentation/pages/play_game.dart';
import 'package:doi_mobile/presentation/features/dashboard/home/presentation/pages/play_online.dart';
import 'package:doi_mobile/presentation/features/dashboard/home/presentation/pages/waiting_screen.dart';
import 'package:doi_mobile/presentation/features/dashboard/onlineGame/presentation/pages/online_game_play.dart';
import 'package:doi_mobile/presentation/features/dashboard/store/presenation/pages/store.dart';
import 'package:doi_mobile/presentation/features/onboarding/presentation/pages/setup_profile_loggedin.dart';
import 'package:doi_mobile/presentation/features/onboarding/presentation/pages/welcome.dart';
import 'package:doi_mobile/presentation/features/profile/presentation/pages/my_achievements.dart';
import 'package:doi_mobile/presentation/features/profile/presentation/pages/my_friends.dart';
import 'package:doi_mobile/presentation/features/profile/presentation/pages/profile.dart';
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
  static const String home = '/home';
  static const String waitingScreen = '/waitingScreen';
  static const String addingFriend = '/addingFriend';
  static const String playOnline = '/playOnline';
  static const String findingOpponents = '/findingOpponents';
  static const String arcade = '/arcade';
  static const String friendProfile = '/friendProfile';
  static const String profile = '/profile';
  static const String myFriends = '/myFriends';
  static const String myAchievements = '/myAchievements';
  static const String leaderBoard = '/leaderBoard';
  static const String store = '/store';
  static const String onlineGame = '/onlineGame';

  static final Map<String, Widget Function(BuildContext)> _routes = {
    welcome: (context) => Welcome(),
    dashboard: (context) => Dashboard(),
    setUpProfileLoggedIn: (context) => SetUpProfileLoggedIn(),
    setUpProfile: (context) => SetUpProfile(),
    playGame: (context) => PlayGame(),
    result: (context) => Result(),
    decideOnlinePlay: (context) => DecideOnlinePlay(),
    gameCreated: (context) => GameCreated(
          arg: ModalRoute.of(context)!.settings.arguments as (
            String,
            int,
            String
          ),
        ),
    home: (context) => Home(),
    waitingScreen: (context) => WaitingScreen(
          arg: ModalRoute.of(context)!.settings.arguments as (
            int,
            String,
            bool,
          ),
        ),
    addingFriend: (context) => AddingFriend(),
    playOnline: (context) => PlayOnline(),
    findingOpponents: (context) => FindingOpponents(),
    arcade: (context) => Arcade(),
    friendProfile: (context) => FriendProfile(),
    profile: (context) => Profile(),
    myFriends: (context) => MyFriends(),
    myAchievements: (context) => MyAchievements(),
    leaderBoard: (context) => LeaderBoard(),
    store: (context) => Store(),
    onlineGame: (context) => OnlineGamePlay(),
  };

  static Map<String, Widget Function(BuildContext)> get routes => _routes;
}
