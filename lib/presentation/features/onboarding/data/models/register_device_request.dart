import 'package:json_annotation/json_annotation.dart';

part 'register_device_request.g.dart';

@JsonSerializable()
class RegisterDeviceRequest {
  @JsonKey(name: 'deviceID')
  final String deviceId;
  final String username;
  final String country;
  final String avatar;

  const RegisterDeviceRequest({
    required this.deviceId,
    required this.username,
    required this.country,
    required this.avatar,
  });

  factory RegisterDeviceRequest.fromJson(Map<String, dynamic> json) =>
      _$RegisterDeviceRequestFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterDeviceRequestToJson(this);
}
