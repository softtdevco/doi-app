import 'package:json_annotation/json_annotation.dart';

part 'register_device_response.g.dart';

@JsonSerializable()
class RegisterDeviceResponse {
  final String reqStatus;
  final Msg msg;

  const RegisterDeviceResponse({
    required this.reqStatus,
    required this.msg,
  });

  factory RegisterDeviceResponse.fromJson(Map<String, dynamic> json) =>
      _$RegisterDeviceResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterDeviceResponseToJson(this);
}

@JsonSerializable()
class Msg {
  final DoiUser data;

  const Msg({
    required this.data,
  });

  factory Msg.fromJson(Map<String, dynamic> json) => _$MsgFromJson(json);

  Map<String, dynamic> toJson() => _$MsgToJson(this);
}

@JsonSerializable()
class DoiUser {
  @JsonKey(defaultValue: '')
  final String? authToken;
  @JsonKey(defaultValue: [])
  final List<String>? username;
  @JsonKey(defaultValue: '')
  final String? country;
  @JsonKey(defaultValue: '')
  final String? avatar;
  @JsonKey(name: 'deviceID', defaultValue: '')
  final String? deviceId;

  const DoiUser({
    this.authToken,
    this.username,
    this.country,
    this.avatar,
    this.deviceId,
  });

  factory DoiUser.fromJson(Map<String, dynamic> json) =>
      _$DoiUserFromJson(json);

  Map<String, dynamic> toJson() => _$DoiUserToJson(this);
}
