import 'package:json_annotation/json_annotation.dart';

part 'create_game_request.g.dart';

@JsonSerializable()
class CreateGameRequest {
  @JsonKey(name: "userID")
  final String userId;
  final TournamentInfo tournamentInfo;
  final GameDuration duration;
  final int playersCount;
  final String gameType;
  final int guessDigitCount;
  final String gameMode;
  final String secretCode;

  CreateGameRequest({
    required this.userId,
    required this.tournamentInfo,
    required this.duration,
    required this.playersCount,
    required this.gameType,
    required this.guessDigitCount,
    required this.gameMode,
    required this.secretCode,
  });

  factory CreateGameRequest.fromJson(Map<String, dynamic> json) =>
     _$CreateGameRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CreateGameRequestToJson(this);
}
@JsonSerializable()
class TournamentInfo {
  TournamentInfo();

  factory TournamentInfo.fromJson(Map<String, dynamic> json) =>_$TournamentInfoFromJson(json);

  Map<String, dynamic> toJson() => _$TournamentInfoToJson(this);
}

@JsonSerializable()
class GameDuration {
  final int minute;
  final int seconds;

  const GameDuration({
    required this.minute,
    required this.seconds,
  });

  factory GameDuration.fromJson(Map<String, dynamic> json) =>
      _$GameDurationFromJson(json);

  Map<String, dynamic> toJson() => _$GameDurationToJson(this);
}
