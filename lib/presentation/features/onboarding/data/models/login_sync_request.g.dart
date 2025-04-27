// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_sync_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginSyncRequest _$LoginSyncRequestFromJson(Map<String, dynamic> json) =>
    LoginSyncRequest(
      email: json['email'] as String,
      password: json['password'] as String,
      deviceId: json['deviceID'] as String,
    );

Map<String, dynamic> _$LoginSyncRequestToJson(LoginSyncRequest instance) =>
    <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
      'deviceID': instance.deviceId,
    };
