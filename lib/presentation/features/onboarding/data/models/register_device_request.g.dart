// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_device_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisterDeviceRequest _$RegisterDeviceRequestFromJson(
        Map<String, dynamic> json) =>
    RegisterDeviceRequest(
      deviceId: json['deviceID'] as String,
      username: json['username'] as String,
      country: json['country'] as String,
      countryCode: json['countryCode'] as String,
      avatar: json['avatar'] as String,
    );

Map<String, dynamic> _$RegisterDeviceRequestToJson(
        RegisterDeviceRequest instance) =>
    <String, dynamic>{
      'deviceID': instance.deviceId,
      'username': instance.username,
      'country': instance.country,
      'countryCode': instance.countryCode,
      'avatar': instance.avatar,
    };
