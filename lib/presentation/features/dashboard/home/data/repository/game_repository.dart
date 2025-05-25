import 'package:doi_mobile/core/utils/type_defs.dart';
import 'package:doi_mobile/presentation/features/dashboard/home/data/model/streak_response.dart';

abstract interface class GameRepository {
  Map<String, dynamic>? getCurrentGame();
  Future<void> saveGame(Map<String, dynamic> gameState);
  Future<void> clearGame();
  int getAiDifficulty();
  String getGameMode();
  bool isAiPlaybackEnabled();
  String getTimerValue();
  void updatePoints(int points);
  void updateCoins(int coins);
  int getTotalPoints();
  int getTotalCoins();
  void addToLeaderboard(int score);
  List<int> getRecentScores();
  Future<int> getMaxCodeSwaps();
  Future<void> setMaxCodeSwaps(int swaps);
  Future<int> getCodeSwapsRemaining();
  Future<void> setCodeSwapsRemaining(int swaps);
  Future<bool> checkDailyStreak();
  Future<bool> recordDailyStreak();
  int getCurrentStreak();
  Future<DateTime?> getLastPlayDate();
  Future<BaseResponse<StreakResponse>> sendDailyStreak();
}
