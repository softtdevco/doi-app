import 'package:doi_mobile/core/utils/enums.dart';
import 'package:doi_mobile/presentation/features/dashboard/home/data/model/create_game_response.dart';
import 'package:doi_mobile/presentation/features/dashboard/onlineGame/data/model/join_game_response.dart';

class OnlineGameState {
  final LoadState loadState;
  final String type;
  final String pairing;
  final JoinGameData? joinGameData;
  final LoadState createGameLoadState;
  final GameSessionData? gameSessionData;
  final LoadState joinGameLoadState;
  final LoadState gameSessionLoadState;
  final int expectedPlayerCount;
  final String? joinCode;
  final bool yourTurn;
  OnlineGameState({
    required this.loadState,
    required this.type,
    required this.pairing,
    this.joinGameData,
    required this.createGameLoadState,
    this.gameSessionData,
    required this.joinGameLoadState,
    required this.gameSessionLoadState,
    required this.expectedPlayerCount,
    this.joinCode,
    required this.yourTurn,
  });

  factory OnlineGameState.initial() {
    return OnlineGameState(
      type: 'Ranked',
      loadState: LoadState.idle,
      pairing: 'Rapid',
      createGameLoadState: LoadState.idle,
      joinGameLoadState: LoadState.idle,
      gameSessionLoadState: LoadState.idle,
      expectedPlayerCount: 0,
      yourTurn: false,
    );
  }

  OnlineGameState copyWith({
    LoadState? loadState,
    String? type,
    String? pairing,
    JoinGameData? joinGameData,
    LoadState? createGameLoadState,
    GameSessionData? gameSessionData,
    LoadState? joinGameLoadState,
    LoadState? gameSessionLoadState,
    int? expectedPlayerCount,
    String? joinCode,
    bool? yourTurn,
  }) {
    return OnlineGameState(
      loadState: loadState ?? this.loadState,
      type: type ?? this.type,
      pairing: pairing ?? this.pairing,
      joinGameData: joinGameData ?? this.joinGameData,
      createGameLoadState: createGameLoadState ?? this.createGameLoadState,
      gameSessionData: gameSessionData ?? this.gameSessionData,
      joinGameLoadState: joinGameLoadState ?? this.joinGameLoadState,
      gameSessionLoadState: gameSessionLoadState ?? this.gameSessionLoadState,
      expectedPlayerCount: expectedPlayerCount ?? this.expectedPlayerCount,
      joinCode: joinCode ?? this.joinCode,
      yourTurn: yourTurn ?? this.yourTurn,
    );
  }
}
