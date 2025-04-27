// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signup_sync_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignupSyncRequest _$SignupSyncRequestFromJson(Map<String, dynamic> json) =>
    SignupSyncRequest(
      email: json['email'] as String,
      password: json['password'] as String,
      jwtToken: json['jwtToken'] as String,
    );

Map<String, dynamic> _$SignupSyncRequestToJson(SignupSyncRequest instance) =>
    <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
      'jwtToken': instance.jwtToken,
    };
