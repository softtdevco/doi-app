import 'package:doi_mobile/presentation/features/onboarding/data/models/login_device_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_response.g.dart';

@JsonSerializable()
class UserResponse {
  final bool? success;
  final String? message;
  final int? code;
  final String? returnStatus;
  final DoiUser? data;

  const UserResponse({
    this.success,
    this.message,
    this.code,
    this.returnStatus,
    this.data,
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) =>
      _$UserResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UserResponseToJson(this);
}
