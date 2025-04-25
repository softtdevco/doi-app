// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'join_game_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JoinGameResponse _$JoinGameResponseFromJson(Map<String, dynamic> json) =>
    JoinGameResponse(
      success: json['success'] as bool?,
      message: json['message'] as String?,
      code: (json['code'] as num?)?.toInt(),
      returnStatus: json['returnStatus'] as String?,
      data: json['data'] == null
          ? null
          : GameSessionData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$JoinGameResponseToJson(JoinGameResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'code': instance.code,
      'returnStatus': instance.returnStatus,
      'data': instance.data,
    };

GameSessionData _$GameSessionDataFromJson(Map<String, dynamic> json) =>
    GameSessionData(
      id: json['_id'] as String? ?? '',
      gameId: json['gameID'] as String? ?? '',
      hasStart: json['hasStart'] as bool? ?? false,
      isEnd: json['isEnd'] as bool? ?? false,
      hostId: json['hostID'] as String? ?? '',
      invitableCode: json['invitableCode'] as String? ?? '',
      gameMode: json['gameMode'] as String? ?? '',
      timelimit: (json['timelimit'] as num?)?.toInt() ?? 0,
      playerPairs: json['playerPairs'] as List<dynamic>? ?? [],
      players: (json['players'] as List<dynamic>?)
              ?.map((e) => Player.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      connectionTrack: (json['connectionTrack'] as num?)?.toInt() ?? 0,
      playersCount: (json['playersCount'] as num?)?.toInt() ?? 0,
      gameType: json['gameType'] as String? ?? '',
      currentRound: (json['currentRound'] as num?)?.toInt() ?? 0,
      bracket: json['bracket'] as List<dynamic>? ?? [],
      rounds: json['rounds'] as List<dynamic>? ?? [],
      createdAt: json['createdAt'] as String? ?? '',
      updatedAt: json['updatedAt'] as String? ?? '',
      v: (json['__v'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$GameSessionDataToJson(GameSessionData instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'gameID': instance.gameId,
      'hasStart': instance.hasStart,
      'isEnd': instance.isEnd,
      'hostID': instance.hostId,
      'invitableCode': instance.invitableCode,
      'gameMode': instance.gameMode,
      'timelimit': instance.timelimit,
      'playerPairs': instance.playerPairs,
      'players': instance.players,
      'connectionTrack': instance.connectionTrack,
      'playersCount': instance.playersCount,
      'gameType': instance.gameType,
      'currentRound': instance.currentRound,
      'bracket': instance.bracket,
      'rounds': instance.rounds,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      '__v': instance.v,
    };

Player _$PlayerFromJson(Map<String, dynamic> json) => Player(
      playerId: json['playerId'] as String?,
      username: json['username'] as String?,
      secretCode: json['secretCode'] as String?,
      id: json['_id'] as String? ?? '',
    );

Map<String, dynamic> _$PlayerToJson(Player instance) => <String, dynamic>{
      'playerId': instance.playerId,
      'username': instance.username,
      'secretCode': instance.secretCode,
      '_id': instance.id,
    };
