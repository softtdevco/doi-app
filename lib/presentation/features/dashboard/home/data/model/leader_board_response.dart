import 'package:doi_mobile/presentation/features/onboarding/data/models/login_device_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'leader_board_response.g.dart';

@JsonSerializable()
class LeaderBoardResponse {
  final bool? success;
  final String? message;
  final int? code;
  final String? returnStatus;
  final Data? data;

  const LeaderBoardResponse({
    this.success,
    this.message,
    this.code,
    this.returnStatus,
    this.data,
  });

  factory LeaderBoardResponse.fromJson(Map<String, dynamic> json) =>
      _$LeaderBoardResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LeaderBoardResponseToJson(this);
}

@JsonSerializable()
class Data {
  final List<GlobalLeaderboard>? globalLeaderboard;
  final LeaderboardByCountries? leaderboardByCountries;

  const Data({
    this.globalLeaderboard,
    this.leaderboardByCountries,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable()
class GlobalLeaderboard {
  @JsonKey(name: '_id')
  final String? id;
  final String? username;
  final int? totalPoints;
  final int? totalCoins;
  final int? activeStreak;
  final int? matchesPlayed;
  final DoiUser? user;

  const GlobalLeaderboard({
    this.id,
    this.username,
    this.totalPoints,
    this.totalCoins,
    this.activeStreak,
    this.matchesPlayed,
    this.user,
  });

  factory GlobalLeaderboard.fromJson(Map<String, dynamic> json) =>
      _$GlobalLeaderboardFromJson(json);

  Map<String, dynamic> toJson() => _$GlobalLeaderboardToJson(this);
}

@JsonSerializable()
class LeaderboardByCountries {
  final List<GlobalLeaderboard>? unknown;
  final List<GlobalLeaderboard>? nigeria;
  final List<GlobalLeaderboard>? us;
  final List<GlobalLeaderboard>? usa;

  const LeaderboardByCountries({
    this.unknown,
    this.nigeria,
    this.us,
    this.usa,
  });

  factory LeaderboardByCountries.fromJson(Map<String, dynamic> json) =>
      _$LeaderboardByCountriesFromJson(json);

  Map<String, dynamic> toJson() => _$LeaderboardByCountriesToJson(this);
}
