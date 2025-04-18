// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_device_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginDeviceResponse _$LoginDeviceResponseFromJson(Map<String, dynamic> json) =>
    LoginDeviceResponse(
      reqStatus: json['reqStatus'] as String,
      msg: Msg.fromJson(json['msg'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LoginDeviceResponseToJson(
        LoginDeviceResponse instance) =>
    <String, dynamic>{
      'reqStatus': instance.reqStatus,
      'msg': instance.msg,
    };

Msg _$MsgFromJson(Map<String, dynamic> json) => Msg(
      data: json['data'] as String,
    );

Map<String, dynamic> _$MsgToJson(Msg instance) => <String, dynamic>{
      'data': instance.data,
    };
