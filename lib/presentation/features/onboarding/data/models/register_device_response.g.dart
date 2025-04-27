// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_device_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisterDeviceResponse _$RegisterDeviceResponseFromJson(
        Map<String, dynamic> json) =>
    RegisterDeviceResponse(
      success: json['success'] as bool?,
      message: json['message'] as String?,
      code: (json['code'] as num?)?.toInt(),
      returnStatus: json['returnStatus'] as String?,
      data: json['data'] == null
          ? null
          : DoiUser.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RegisterDeviceResponseToJson(
        RegisterDeviceResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'code': instance.code,
      'returnStatus': instance.returnStatus,
      'data': instance.data,
    };
