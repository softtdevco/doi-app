// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'leader_board_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LeaderBoardResponse _$LeaderBoardResponseFromJson(Map<String, dynamic> json) =>
    LeaderBoardResponse(
      success: json['success'] as bool?,
      message: json['message'] as String?,
      code: (json['code'] as num?)?.toInt(),
      returnStatus: json['returnStatus'] as String?,
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LeaderBoardResponseToJson(
        LeaderBoardResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'code': instance.code,
      'returnStatus': instance.returnStatus,
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      globalLeaderboard: (json['globalLeaderboard'] as List<dynamic>?)
          ?.map((e) => GlobalLeaderboard.fromJson(e as Map<String, dynamic>))
          .toList(),
      leaderboardByCountries: json['leaderboardByCountries'] == null
          ? null
          : LeaderboardByCountries.fromJson(
              json['leaderboardByCountries'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'globalLeaderboard': instance.globalLeaderboard,
      'leaderboardByCountries': instance.leaderboardByCountries,
    };

GlobalLeaderboard _$GlobalLeaderboardFromJson(Map<String, dynamic> json) =>
    GlobalLeaderboard(
      id: json['_id'] as String?,
      username: json['username'] as String?,
      totalPoints: (json['totalPoints'] as num?)?.toInt(),
      totalCoins: (json['totalCoins'] as num?)?.toInt(),
      activeStreak: (json['activeStreak'] as num?)?.toInt(),
      matchesPlayed: (json['matchesPlayed'] as num?)?.toInt(),
      user: json['user'] == null
          ? null
          : DoiUser.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GlobalLeaderboardToJson(GlobalLeaderboard instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'username': instance.username,
      'totalPoints': instance.totalPoints,
      'totalCoins': instance.totalCoins,
      'activeStreak': instance.activeStreak,
      'matchesPlayed': instance.matchesPlayed,
      'user': instance.user,
    };

LeaderboardByCountries _$LeaderboardByCountriesFromJson(
        Map<String, dynamic> json) =>
    LeaderboardByCountries(
      unknown: (json['unknown'] as List<dynamic>?)
          ?.map((e) => GlobalLeaderboard.fromJson(e as Map<String, dynamic>))
          .toList(),
      nigeria: (json['nigeria'] as List<dynamic>?)
          ?.map((e) => GlobalLeaderboard.fromJson(e as Map<String, dynamic>))
          .toList(),
      us: (json['us'] as List<dynamic>?)
          ?.map((e) => GlobalLeaderboard.fromJson(e as Map<String, dynamic>))
          .toList(),
      usa: (json['usa'] as List<dynamic>?)
          ?.map((e) => GlobalLeaderboard.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$LeaderboardByCountriesToJson(
        LeaderboardByCountries instance) =>
    <String, dynamic>{
      'unknown': instance.unknown,
      'nigeria': instance.nigeria,
      'us': instance.us,
      'usa': instance.usa,
    };
