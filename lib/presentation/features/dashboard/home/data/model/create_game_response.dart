import 'package:json_annotation/json_annotation.dart';

part 'create_game_response.g.dart';

@JsonSerializable()
class CreateGameResponse {
  final bool? success;
  final String? message;
  final int? code;
  final String? returnStatus;
  final CreateGameResponseData? data;

  const CreateGameResponse({
    this.success,
    this.message,
    this.code,
    this.returnStatus,
    this.data,
  });

  factory CreateGameResponse.fromJson(Map<String, dynamic> json) =>
      _$CreateGameResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CreateGameResponseToJson(this);
}

@JsonSerializable()
class CreateGameResponseData {
  final bool? ok;
  final DataData? data;

  const CreateGameResponseData({
    this.ok,
    this.data,
  });

  factory CreateGameResponseData.fromJson(Map<String, dynamic> json) =>
      _$CreateGameResponseDataFromJson(json);

  Map<String, dynamic> toJson() => _$CreateGameResponseDataToJson(this);
}

@JsonSerializable()
class DataData {
  final String? type;
  final JoinGameData? msg;

  const DataData({
    this.type,
    this.msg,
  });

  factory DataData.fromJson(Map<String, dynamic> json) =>
      _$DataDataFromJson(json);

  Map<String, dynamic> toJson() => _$DataDataToJson(this);
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

  factory JoinGameData.fromJson(Map<String, dynamic> json) =>
      _$JoinGameDataFromJson(json);

  Map<String, dynamic> toJson() => _$JoinGameDataToJson(this);
}
