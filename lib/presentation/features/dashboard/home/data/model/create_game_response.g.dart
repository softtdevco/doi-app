// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_game_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateGameResponse _$CreateGameResponseFromJson(Map<String, dynamic> json) =>
    CreateGameResponse(
      reqStatus: json['reqStatus'] as String?,
      msg: json['msg'] == null
          ? null
          : Msg.fromJson(json['msg'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CreateGameResponseToJson(CreateGameResponse instance) =>
    <String, dynamic>{
      'reqStatus': instance.reqStatus,
      'msg': instance.msg,
    };

Msg _$MsgFromJson(Map<String, dynamic> json) => Msg(
      data: json['data'] == null
          ? null
          : JoinGameData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MsgToJson(Msg instance) => <String, dynamic>{
      'data': instance.data,
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
