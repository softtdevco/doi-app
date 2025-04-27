import 'package:json_annotation/json_annotation.dart';

part 'login_sync_request.g.dart';

@JsonSerializable()
class LoginSyncRequest {
  final String email;
  final String password;
  @JsonKey(name: 'deviceID')
  final String deviceId;

  const LoginSyncRequest({
    required this.email,
    required this.password,
    required this.deviceId,
  });

  factory LoginSyncRequest.fromJson(Map<String, dynamic> json) =>
      _$LoginSyncRequestFromJson(json);

  Map<String, dynamic> toJson() => _$LoginSyncRequestToJson(this);
}
