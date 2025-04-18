// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_device_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisterDeviceResponse _$RegisterDeviceResponseFromJson(
        Map<String, dynamic> json) =>
    RegisterDeviceResponse(
      reqStatus: json['reqStatus'] as String,
      msg: Msg.fromJson(json['msg'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RegisterDeviceResponseToJson(
        RegisterDeviceResponse instance) =>
    <String, dynamic>{
      'reqStatus': instance.reqStatus,
      'msg': instance.msg,
    };

Msg _$MsgFromJson(Map<String, dynamic> json) => Msg(
      data: DoiUser.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MsgToJson(Msg instance) => <String, dynamic>{
      'data': instance.data,
    };

DoiUser _$DoiUserFromJson(Map<String, dynamic> json) => DoiUser(
      authToken: json['authToken'] as String? ?? '',
      username: (json['username'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      country: json['country'] as String? ?? '',
      avatar: json['avatar'] as String? ?? '',
      deviceId: json['deviceID'] as String? ?? '',
    );

Map<String, dynamic> _$DoiUserToJson(DoiUser instance) => <String, dynamic>{
      'authToken': instance.authToken,
      'username': instance.username,
      'country': instance.country,
      'avatar': instance.avatar,
      'deviceID': instance.deviceId,
    };
