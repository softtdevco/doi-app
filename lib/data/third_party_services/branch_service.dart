import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_branch_sdk/flutter_branch_sdk.dart';

class BranchLinkService {
  static final BranchLinkService _instance = BranchLinkService._internal();
  factory BranchLinkService() => _instance;
  BranchLinkService._internal();

  Future<String> createGameInviteLink({
    required String gameCode,
    String? inviteeName,
  }) async {
    BranchUniversalObject buo = BranchUniversalObject(
      canonicalIdentifier: 'game/$gameCode',
      title: 'Join my DOI game!',
      contentDescription: 'Click to join my game',
      keywords: ['game', 'doi', 'multiplayer'],
      publiclyIndex: true,
      locallyIndex: true,
    );

    BranchLinkProperties lp = BranchLinkProperties(
        alias: 'crackein/game_invite/$gameCode',
        channel: 'app_share',
        feature: 'game_invite',
        stage: 'new_game',
        tags: ['game_invite']);

    lp.addControlParam('game_code', gameCode);

    if (inviteeName != null) {
      lp.addControlParam('invitee_name', inviteeName);
    }

    try {
      BranchResponse response = await FlutterBranchSdk.getShortUrl(
        buo: buo,
        linkProperties: lp,
      );

      if (response.success) {
        return response.result;
      } else {
        throw Exception('Failed to create game link');
      }
    } catch (e) {
      throw Exception('Error creating game link: $e');
    }
  }

  StreamSubscription<Map> setupDeepLinkListener(
      {required Function(Map<String, dynamic> gameData) onLinkOpened}) {
    return FlutterBranchSdk.listSession().listen((data) {
      if (data.containsKey("+clicked_branch_link") &&
          data["+clicked_branch_link"] == true) {
        if (data.containsKey("game_code")) {
          String gameCode = data["game_code"];

          Map<String, dynamic> gameData = {
            "gameCode": gameCode,
          };

          if (data.containsKey("invitee_name")) {
            gameData["inviteeName"] = data["invitee_name"];
          }

          onLinkOpened(gameData);
        }
      }
    }, onError: (error) {
      PlatformException platformException = error as PlatformException;
      print(
          'InitSession error: ${platformException.code} - ${platformException.message}');
    });
  }
}
