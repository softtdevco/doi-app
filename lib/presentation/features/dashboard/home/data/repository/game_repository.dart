abstract interface class GameRepository {
  Map<String, dynamic>? getCurrentGame();
  Future<void> saveGame(Map<String, dynamic> gameState);
  Future<void> clearGame();
  int getAiDifficulty();
  String getGameMode();
  bool isAiPlaybackEnabled();
  String getTimerValue();
}