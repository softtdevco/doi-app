import 'package:json_annotation/json_annotation.dart';

part 'streak_response.g.dart';

@JsonSerializable()
class StreakResponse {
  final bool? success;
  final String? message;
  final int? code;
  final String? returnStatus;
  final StreakData? data;

  const StreakResponse({
    this.success,
    this.message,
    this.code,
    this.returnStatus,
    this.data,
  });

  factory StreakResponse.fromJson(Map<String, dynamic> json) =>
      _$StreakResponseFromJson(json);

  Map<String, dynamic> toJson() => _$StreakResponseToJson(this);
}

@JsonSerializable()
class StreakData {
  StreakData({
    required this.id,
    required this.userId,
    required this.streakCount,
    required this.lastActivityDate,
    required this.activityDates,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  @JsonKey(name: '_id')
  final String? id;
  final String? userId;
  final int? streakCount;
  final DateTime? lastActivityDate;
  final List<DateTime>? activityDates;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  @JsonKey(name: '__v')
  final int? v;

  factory StreakData.fromJson(Map<String, dynamic> json) =>
      _$StreakDataFromJson(json);
  Map<String, dynamic> toJson() => _$StreakDataToJson(this);
}
