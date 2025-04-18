import 'package:json_annotation/json_annotation.dart';
part 'signup_sync_request.g.dart';

@JsonSerializable()
class SignupSyncRequest {
  final String email;
  final String password;
  final String jwtToken;

  const SignupSyncRequest({
    required this.email,
    required this.password,
    required this.jwtToken,
  });

  factory SignupSyncRequest.fromJson(Map<String, dynamic> json) =>
      _$SignupSyncRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SignupSyncRequestToJson(this);
}
