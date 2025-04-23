import 'package:json_annotation/json_annotation.dart';

part 'login_device_response.g.dart';

@JsonSerializable()
class LoginDeviceResponse {
  final bool? success;
  final String? message;
  final int? code;
  final String? returnStatus;
  final Data? data;

  const LoginDeviceResponse({
    this.success,
    this.message,
    this.code,
    this.returnStatus,
    this.data,
  });

  factory LoginDeviceResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginDeviceResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoginDeviceResponseToJson(this);
}

@JsonSerializable()
class Data {
  final String? token;
  final DoiUser? user;

  const Data({
    this.token,
    this.user,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable()
class DoiUser {
  @JsonKey(name: 'deviceID', defaultValue: '')
  final String? deviceId;
  @JsonKey(defaultValue: '')
  final String? username;
  @JsonKey(defaultValue: '')
  final String? country;
  @JsonKey(defaultValue: '')
  final String? avatar;
  @JsonKey(defaultValue: [])
  final List<dynamic>? notification;
  @JsonKey(name: '_id', defaultValue: '')
  final String? id;
  @JsonKey(defaultValue: '')
  final String? createdAt;
  @JsonKey(defaultValue: '')
  final String? updatedAt;
  @JsonKey(name: '__v', defaultValue: 0)
  final int? v;

  const DoiUser({
    this.deviceId,
    this.username,
    this.country,
    this.avatar,
    this.notification,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory DoiUser.fromJson(Map<String, dynamic> json) =>
      _$DoiUserFromJson(json);

  Map<String, dynamic> toJson() => _$DoiUserToJson(this);
}
