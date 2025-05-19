import 'package:doi_mobile/core/utils/enums.dart';
import 'package:doi_mobile/presentation/features/dashboard/home/data/model/create_game_response.dart';
import 'package:doi_mobile/presentation/features/dashboard/home/data/model/guess_model.dart';
import 'package:doi_mobile/presentation/features/dashboard/home/data/model/leader_board_response.dart';
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
  final List<Guess> playerGuesses;
  final List<Guess> friendGuesses;
  final int timeRemaining;
  final bool timerActive;
  final bool isGameOver;
  final String? winnerName;
  final String? winnerId;
  final int? pointsEarned;
  final int? coinsEarned;
  final bool isTimeExpired;
  final String? lastTurnEventId;
  final LoadState leaderLoadState;
  final List<GlobalLeaderboard>? globalLeaderboard;
  final LoadState streakLoadState;
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
    required this.playerGuesses,
    required this.friendGuesses,
    required this.timeRemaining,
    required this.timerActive,
    required this.isGameOver,
    this.coinsEarned,
    this.pointsEarned,
    this.winnerId,
    this.winnerName,
    required this.isTimeExpired,
    this.lastTurnEventId,
    required this.leaderLoadState,
    required this.globalLeaderboard,
    required this.streakLoadState,
  });

  factory OnlineGameState.initial() {
    return OnlineGameState(
      type: 'Ranked',
      loadState: LoadState.idle,
      playerGuesses: [],
      friendGuesses: [],
      pairing: 'Rapid',
      createGameLoadState: LoadState.idle,
      joinGameLoadState: LoadState.idle,
      gameSessionLoadState: LoadState.idle,
      expectedPlayerCount: 0,
      yourTurn: false,
      timeRemaining: 0,
      timerActive: false,
      isGameOver: false,
      isTimeExpired: false,
      leaderLoadState: LoadState.loading,
      globalLeaderboard: [],
      streakLoadState: LoadState.idle,
    );
  }

  OnlineGameState copyWith({
    LoadState? loadState,
    List<Guess>? playerGuesses,
    List<Guess>? friendGuesses,
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
    bool? timerActive,
    int? timeRemaining,
    bool? isGameOver,
    String? winnerName,
    String? winnerId,
    int? coinsEarned,
    int? pointsEarned,
    bool? isTimeExpired,
    String? lastTurnEventId,
    LoadState? leaderLoadSate,
    List<GlobalLeaderboard>? globalLeaderboard,
    LoadState? streakLoadState,
  }) {
    return OnlineGameState(
      loadState: loadState ?? this.loadState,
      playerGuesses: playerGuesses ?? this.playerGuesses,
      friendGuesses: friendGuesses ?? this.friendGuesses,
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
      timeRemaining: timeRemaining ?? this.timeRemaining,
      timerActive: timerActive ?? this.timerActive,
      isGameOver: isGameOver ?? this.isGameOver,
      winnerId: winnerId ?? this.winnerId,
      winnerName: winnerName ?? this.winnerName,
      coinsEarned: coinsEarned ?? this.coinsEarned,
      pointsEarned: pointsEarned ?? this.pointsEarned,
      isTimeExpired: isTimeExpired ?? this.isTimeExpired,
      lastTurnEventId: lastTurnEventId ?? this.lastTurnEventId,
      leaderLoadState: leaderLoadSate ?? this.leaderLoadState,
      globalLeaderboard: globalLeaderboard ?? this.globalLeaderboard,
      streakLoadState: streakLoadState ?? this.streakLoadState,
    );
  }
}
