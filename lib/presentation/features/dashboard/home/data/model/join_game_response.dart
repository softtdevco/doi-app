import 'package:json_annotation/json_annotation.dart';

part 'join_game_response.g.dart';

@JsonSerializable()
class JoinGameResponse {
  final bool? success;
  final String? message;
  final int? code;
  final String? returnStatus;
  final GameSessionData? data;

  const JoinGameResponse({
    this.success,
    this.message,
    this.code,
    this.returnStatus,
    this.data,
  });

  factory JoinGameResponse.fromJson(Map<String, dynamic> json) =>
      _$JoinGameResponseFromJson(json);

  Map<String, dynamic> toJson() => _$JoinGameResponseToJson(this);
}

@JsonSerializable()
class GameSessionData {
  @JsonKey(name: "_id", defaultValue: '')
  final String? id;
  @JsonKey(name: "gameID", defaultValue: '')
  final String? gameId;
  @JsonKey(defaultValue: false)
  final bool? hasStart;
  @JsonKey(defaultValue: false)
  final bool? isEnd;
  @JsonKey(name: 'hostID', defaultValue: '')
  final String? hostId;
  @JsonKey(defaultValue: '')
  final String? invitableCode;
  @JsonKey(defaultValue: '')
  final String? gameMode;
  @JsonKey(defaultValue: 0)
  final int? timelimit;
  @JsonKey(defaultValue: [])
  final List<dynamic>? playerPairs;
  @JsonKey(defaultValue: [])
  final List<Player>? players;
  @JsonKey(defaultValue: 0)
  final int? connectionTrack;
  @JsonKey(defaultValue: 0)
  final int? playersCount;
  @JsonKey(defaultValue: '')
  final String? gameType;
  @JsonKey(defaultValue: 0)
  final int? currentRound;
  @JsonKey(defaultValue: [])
  final List<dynamic>? bracket;
  @JsonKey(defaultValue: [])
  final List<dynamic>? rounds;
  @JsonKey(defaultValue: '')
  final String? createdAt;
  @JsonKey(defaultValue: '')
  final String? updatedAt;
  @JsonKey(name: "__v", defaultValue: 0)
  final int? v;

  const GameSessionData({
    this.id,
    this.gameId,
    this.hasStart,
    this.isEnd,
    this.hostId,
    this.invitableCode,
    this.gameMode,
    this.timelimit,
    this.playerPairs,
    this.players,
    this.connectionTrack,
    this.playersCount,
    this.gameType,
    this.currentRound,
    this.bracket,
    this.rounds,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory GameSessionData.fromJson(Map<String, dynamic> json) =>
      _$GameSessionDataFromJson(json);

  Map<String, dynamic> toJson() => _$GameSessionDataToJson(this);
}

@JsonSerializable()
class Player {
  final String? playerId;
  final String? username;
  final String? secretCode;
  @JsonKey(name: "_id", defaultValue: '')
  final String? id;

  const Player({
    this.playerId,
    this.username,
    this.secretCode,
    this.id,
  });

  factory Player.fromJson(Map<String, dynamic> json) => _$PlayerFromJson(json);

  Map<String, dynamic> toJson() => _$PlayerToJson(this);
}
