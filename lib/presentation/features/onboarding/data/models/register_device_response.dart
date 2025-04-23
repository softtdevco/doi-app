import 'package:doi_mobile/presentation/features/onboarding/data/models/login_device_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'register_device_response.g.dart';

@JsonSerializable()
class RegisterDeviceResponse {
  final bool? success;
  final String? message;
  final int? code;
  final String? returnStatus;
  final DoiUser? data;

  const RegisterDeviceResponse({
    this.success,
    this.message,
    this.code,
    this.returnStatus,
    this.data,
  });

  factory RegisterDeviceResponse.fromJson(Map<String, dynamic> json) =>
      _$RegisterDeviceResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterDeviceResponseToJson(this);
}
