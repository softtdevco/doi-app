// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_game_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateGameResponse _$CreateGameResponseFromJson(Map<String, dynamic> json) =>
    CreateGameResponse(
      success: json['success'] as bool?,
      message: json['message'] as String?,
      code: (json['code'] as num?)?.toInt(),
      returnStatus: json['returnStatus'] as String?,
      data: json['data'] == null
          ? null
          : CreateGameResponseData.fromJson(
              json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CreateGameResponseToJson(CreateGameResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'code': instance.code,
      'returnStatus': instance.returnStatus,
      'data': instance.data,
    };

CreateGameResponseData _$CreateGameResponseDataFromJson(
        Map<String, dynamic> json) =>
    CreateGameResponseData(
      ok: json['ok'] as bool?,
      data: json['data'] == null
          ? null
          : DataData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CreateGameResponseDataToJson(
        CreateGameResponseData instance) =>
    <String, dynamic>{
      'ok': instance.ok,
      'data': instance.data,
    };

DataData _$DataDataFromJson(Map<String, dynamic> json) => DataData(
      type: json['type'] as String?,
      msg: json['msg'] == null
          ? null
          : JoinGameData.fromJson(json['msg'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DataDataToJson(DataData instance) => <String, dynamic>{
      'type': instance.type,
      'msg': instance.msg,
    };

JoinGameData _$JoinGameDataFromJson(Map<String, dynamic> json) => JoinGameData(
      code: json['code'] as String?,
      link: json['link'] as String?,
      sessionInfo: json['sessionInfo'] as String?,
    );

Map<String, dynamic> _$JoinGameDataToJson(JoinGameData instance) =>
    <String, dynamic>{
      'code': instance.code,
      'link': instance.link,
      'sessionInfo': instance.sessionInfo,
    };
