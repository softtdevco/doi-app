// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_game_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateGameRequest _$CreateGameRequestFromJson(Map<String, dynamic> json) =>
    CreateGameRequest(
      jwtToken: json['jwtToken'] as String,
      gameDuration:
          GameDuration.fromJson(json['gameDuration'] as Map<String, dynamic>),
      playersCount: json['playersCount'] as String,
      gameType: json['gameType'] as String,
      gameMode: json['gameMode'] as String,
      guessDigitCount: json['guessDigitCount'] as String,
    );

Map<String, dynamic> _$CreateGameRequestToJson(CreateGameRequest instance) =>
    <String, dynamic>{
      'jwtToken': instance.jwtToken,
      'gameDuration': instance.gameDuration,
      'playersCount': instance.playersCount,
      'gameType': instance.gameType,
      'gameMode': instance.gameMode,
      'guessDigitCount': instance.guessDigitCount,
    };

GameDuration _$GameDurationFromJson(Map<String, dynamic> json) => GameDuration(
      minute: (json['minute'] as num).toInt(),
      seconds: (json['seconds'] as num).toInt(),
    );

Map<String, dynamic> _$GameDurationToJson(GameDuration instance) =>
    <String, dynamic>{
      'minute': instance.minute,
      'seconds': instance.seconds,
    };
