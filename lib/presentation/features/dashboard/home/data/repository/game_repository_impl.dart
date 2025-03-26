import 'dart:convert';

import 'package:doi_mobile/core/utils/logger.dart';
import 'package:doi_mobile/data/local_storage/storage.dart';
import 'package:doi_mobile/data/local_storage/storage_impl.dart';
import 'package:doi_mobile/data/local_storage/storage_keys.dart';
import 'package:doi_mobile/presentation/features/dashboard/home/data/repository/game_repository.dart';
import 'package:doi_mobile/presentation/features/dashboard/home/presentation/notifiers/home_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GameRepositoryImpl implements GameRepository {
  GameRepositoryImpl(this._storage, this._ref);

  final LocalStorage _storage;
  final Ref _ref;

  @override
  Map<String, dynamic>? getCurrentGame() {
    final gameData = _storage.get<String?>(HiveKeys.currentGame);
    if (gameData == null) return null;

    try {
      return json.decode(gameData) as Map<String, dynamic>;
    } catch (e) {
      debugLog('Error parsing game data: $e');
      return null;
    }
  }

  @override
  Future<void> saveGame(Map<String, dynamic> gameState) async {
    await _storage.put(HiveKeys.currentGame, json.encode(gameState));
    _notifyGameStateChange(gameState);
  }

  @override
  Future<void> clearGame() async {
    await _storage.delete(HiveKeys.currentGame);
    _notifyGameStateChange(null);
  }

  @override
  int getAiDifficulty() {
    final homeState = _ref.read(homeNotifierProvider);
    return homeState.playBackIndex;
  }

  @override
  String getGameMode() {
    final homeState = _ref.read(homeNotifierProvider);
    return homeState.gameModeIndex == 0 ? 'hint' : 'mystery';
  }

  @override
  bool isAiPlaybackEnabled() {
    final gameData = getCurrentGame();
    return gameData?['aiPlaybackEnabled'] ?? false;
  }

  @override
  String getTimerValue() {
    final homeState = _ref.read(homeNotifierProvider);
    return homeState.timer;
  }

  void _notifyGameStateChange(Map<String, dynamic>? gameState) {
    _ref.read(currentGameStateProvider.notifier).state = gameState;
  }

  @override
  getTotalPoints() {
    return _storage.get(HiveKeys.totalPoints) ?? 0;
  }

  @override
  void updatePoints(int points) {
    final currentPoints = getTotalPoints();
    final newPoints = currentPoints + points;
    _storage.put(HiveKeys.totalPoints, newPoints);
    _ref.read(totalPointsProvider.notifier).state = newPoints;
  }

  @override
  int getTotalCoins() {
    return _storage.get(HiveKeys.totalCoins) ?? 0;
  }

  @override
  void updateCoins(int coins) {
    final currentCoins = getTotalCoins();
    final newCoins = currentCoins + coins;
    _storage.put(HiveKeys.totalCoins, newCoins);
    _ref.read(totalCoinsProvider.notifier).state = newCoins;
  }

  @override
  List<int> getRecentScores() {
    final scoresData = _storage.get(HiveKeys.recentScores);
    if (scoresData == null) return [];

    try {
      final List decodedList = json.decode(scoresData) as List;
      return decodedList.map((score) => score as int).toList();
    } catch (e) {
      debugLog('Error parsing scores data: $e');
      return [];
    }
  }

  void addToLeaderboard(int score) {
    List<int> recentScores = getRecentScores();
    recentScores.add(score);

    if (recentScores.length > 10) {
      recentScores = recentScores.sublist(recentScores.length - 10);
    }

    _storage.put(HiveKeys.recentScores, json.encode(recentScores));
    _ref.read(recentScoresProvider.notifier).state = recentScores;
  }

  @override
  Future<int> getMaxCodeSwaps() async {
    return _storage.get<int>(HiveKeys.maxCodeSwaps) ?? 1;
  }

  @override
  Future<void> setMaxCodeSwaps(int swaps) async {
    await _storage.put(HiveKeys.maxCodeSwaps, swaps);
  }

  @override
  Future<int> getCodeSwapsRemaining() async {
    return _storage.get<int>(HiveKeys.codeSwapsRemaining) ?? 1;
  }
    @override
  Future<void> setCodeSwapsRemaining(int swaps) async {
    await _storage.put(HiveKeys.codeSwapsRemaining, swaps);
  }
}

final gameRepositoryProvider = Provider<GameRepository>(
  (ref) => GameRepositoryImpl(
    ref.read(localDB),
    ref,
  ),
);

final currentGameStateProvider = StateProvider<Map<String, dynamic>?>(
  (ref) => ref.read(gameRepositoryProvider).getCurrentGame(),
);
final totalPointsProvider = StateProvider<int>((ref) {
  final repo = ref.read(gameRepositoryProvider);
  return repo.getTotalPoints();
});

final totalCoinsProvider = StateProvider<int>((ref) {
  final repo = ref.read(gameRepositoryProvider);
  return repo.getTotalCoins();
});

final recentScoresProvider = StateProvider<List<int>>((ref) {
  final repo = ref.read(gameRepositoryProvider);
  return repo.getRecentScores();
});
