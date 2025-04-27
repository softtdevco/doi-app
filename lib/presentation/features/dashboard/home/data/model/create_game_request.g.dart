// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_game_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateGameRequest _$CreateGameRequestFromJson(Map<String, dynamic> json) =>
    CreateGameRequest(
      userId: json['userID'] as String,
      tournamentInfo: TournamentInfo.fromJson(
          json['tournamentInfo'] as Map<String, dynamic>),
      duration: GameDuration.fromJson(json['duration'] as Map<String, dynamic>),
      playersCount: (json['playersCount'] as num).toInt(),
      gameType: json['gameType'] as String,
      guessDigitCount: (json['guessDigitCount'] as num).toInt(),
      gameMode: json['gameMode'] as String,
      secretCode: json['secretCode'] as String,
    );

Map<String, dynamic> _$CreateGameRequestToJson(CreateGameRequest instance) =>
    <String, dynamic>{
      'userID': instance.userId,
      'tournamentInfo': instance.tournamentInfo,
      'duration': instance.duration,
      'playersCount': instance.playersCount,
      'gameType': instance.gameType,
      'guessDigitCount': instance.guessDigitCount,
      'gameMode': instance.gameMode,
      'secretCode': instance.secretCode,
    };

TournamentInfo _$TournamentInfoFromJson(Map<String, dynamic> json) =>
    TournamentInfo();

Map<String, dynamic> _$TournamentInfoToJson(TournamentInfo instance) =>
    <String, dynamic>{};

GameDuration _$GameDurationFromJson(Map<String, dynamic> json) => GameDuration(
      minute: (json['minute'] as num).toInt(),
      seconds: (json['seconds'] as num).toInt(),
    );

Map<String, dynamic> _$GameDurationToJson(GameDuration instance) =>
    <String, dynamic>{
      'minute': instance.minute,
      'seconds': instance.seconds,
    };
