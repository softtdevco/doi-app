import 'package:json_annotation/json_annotation.dart';

part 'create_game_response.g.dart';

@JsonSerializable()
class CreateGameResponse {
  final String? reqStatus;
  final Msg? msg;

  const CreateGameResponse({
    this.reqStatus,
    this.msg,
  });

  factory CreateGameResponse.fromJson(Map<String, dynamic> json) =>
      _$CreateGameResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CreateGameResponseToJson(this);
}

@JsonSerializable()
class Msg {
  final JoinGameData? data;

  const Msg({
    this.data,
  });

  factory Msg.fromJson(Map<String, dynamic> json) => _$MsgFromJson(json);

  Map<String, dynamic> toJson() => _$MsgToJson(this);
}

@JsonSerializable()
class JoinGameData {
  final String? code;
  final String? link;
  final String? sessionInfo;

  const JoinGameData({
    this.code,
    this.link,
    this.sessionInfo,
  });

  factory JoinGameData.fromJson(Map<String, dynamic> json) => _$JoinGameDataFromJson(json);

  Map<String, dynamic> toJson() => _$JoinGameDataToJson(this);
}
