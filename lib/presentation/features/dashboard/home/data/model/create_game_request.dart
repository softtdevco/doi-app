
import 'package:json_annotation/json_annotation.dart';
part 'create_game_request.g.dart';

@JsonSerializable()
class CreateGameRequest {
    final String jwtToken;
    final GameDuration gameDuration;
    final String playersCount;
    final String gameType;
    final String gameMode;
    final String guessDigitCount;

    const CreateGameRequest({
        required this.jwtToken,
        required this.gameDuration,
        required this.playersCount,
        required this.gameType,
        required this.gameMode,
        required this.guessDigitCount,
    });

    factory CreateGameRequest.fromJson(Map<String, dynamic> json) => _$CreateGameRequestFromJson(json);

    Map<String, dynamic> toJson() => _$CreateGameRequestToJson(this);
}

@JsonSerializable()
class GameDuration {
    final int minute;
    final int seconds;

    const GameDuration({
        required this.minute,
        required this.seconds,
    });

    factory GameDuration.fromJson(Map<String, dynamic> json) => _$GameDurationFromJson(json);

    Map<String, dynamic> toJson() => _$GameDurationToJson(this);
}
