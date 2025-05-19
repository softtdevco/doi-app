// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'streak_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StreakResponse _$StreakResponseFromJson(Map<String, dynamic> json) =>
    StreakResponse(
      success: json['success'] as bool?,
      message: json['message'] as String?,
      code: (json['code'] as num?)?.toInt(),
      returnStatus: json['returnStatus'] as String?,
      data: json['data'] == null
          ? null
          : StreakData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$StreakResponseToJson(StreakResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'code': instance.code,
      'returnStatus': instance.returnStatus,
      'data': instance.data,
    };

StreakData _$StreakDataFromJson(Map<String, dynamic> json) => StreakData(
      id: json['_id'] as String?,
      userId: json['userId'] as String?,
      streakCount: (json['streakCount'] as num?)?.toInt(),
      lastActivityDate: json['lastActivityDate'] == null
          ? null
          : DateTime.parse(json['lastActivityDate'] as String),
      activityDates: (json['activityDates'] as List<dynamic>?)
          ?.map((e) => DateTime.parse(e as String))
          .toList(),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      v: (json['__v'] as num?)?.toInt(),
    );

Map<String, dynamic> _$StreakDataToJson(StreakData instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'userId': instance.userId,
      'streakCount': instance.streakCount,
      'lastActivityDate': instance.lastActivityDate?.toIso8601String(),
      'activityDates':
          instance.activityDates?.map((e) => e.toIso8601String()).toList(),
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      '__v': instance.v,
    };
