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
}
