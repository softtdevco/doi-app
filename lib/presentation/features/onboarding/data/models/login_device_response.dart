import 'package:json_annotation/json_annotation.dart';
part 'login_device_response.g.dart';

@JsonSerializable()
class LoginDeviceResponse {
  final String reqStatus;
  final Msg msg;

  const LoginDeviceResponse({
    required this.reqStatus,
    required this.msg,
  });

  factory LoginDeviceResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginDeviceResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoginDeviceResponseToJson(this);
}

@JsonSerializable()
class Msg {
  final String data;

  const Msg({
    required this.data,
  });

  factory Msg.fromJson(Map<String, dynamic> json) => _$MsgFromJson(json);

  Map<String, dynamic> toJson() => _$MsgToJson(this);
}
