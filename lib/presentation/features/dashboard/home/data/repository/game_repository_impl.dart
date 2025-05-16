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

  @override
  Future<bool> checkDailyStreak() async {
    final today = _getTodayDateString();
    final lastRecorded = _storage.get<String>(HiveKeys.streakLastRecorded);

    if (lastRecorded == today) {
      return false;
    }

    final isNewDay = await _isFirstPlayOfDay();
    if (!isNewDay) {
      return false;
    }

    return true;
  }

  @override
  Future<bool> recordDailyStreak() async {
    try {
      return true;

      // if (response.statusCode == 200) {
      //   final today = _getTodayDateString();

      //   await _storage.put(HiveKeys.streakLastRecorded, today);

      //   await _storage.put(HiveKeys.lastPlayDate, today);

      //   final streakFromApi = response.data['streak'] as int?;
      //   if (streakFromApi != null) {
      //     await _storage.put(HiveKeys.currentStreak, streakFromApi);
      //   } else {
      //     await _updateLocalStreak();
      //   }

      //   final currentStreak = await getCurrentStreak();
      //   _ref.read(currentStreakProvider.notifier).state = currentStreak;

      //   return true;
      // } else {
      //   debugLog('Failed to record streak: ${response.statusCode}');
      //   return false;
      // }
    } catch (e) {
      debugLog('Error recording streak: $e');
      return false;
    }
  }

  @override
  Future<int> getCurrentStreak() async {
    return _storage.get<int>(HiveKeys.currentStreak) ?? 0;
  }

  @override
  Future<DateTime?> getLastPlayDate() async {
    final dateStr = _storage.get<String>(HiveKeys.lastPlayDate);
    if (dateStr == null) return null;

    try {
      return DateTime.parse(dateStr);
    } catch (e) {
      debugLog('Error parsing lastPlayDate: $e');
      return null;
    }
  }

  // Helper methods

  Future<bool> _isFirstPlayOfDay() async {
    final lastPlayDateStr = _storage.get<String>(HiveKeys.lastPlayDate);
    if (lastPlayDateStr == null) {
      return true;
    }

    try {
      final today = _getTodayDateString();
      return lastPlayDateStr != today;
    } catch (e) {
      debugLog('Error checking if first play of day: $e');
      return true;
    }
  }

  String _getTodayDateString() {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day).toIso8601String();
  }

  Future<void> _updateLocalStreak() async {
    final lastPlayDateStr = _storage.get<String>(HiveKeys.lastPlayDate);
    final currentStreak = _storage.get<int>(HiveKeys.currentStreak) ?? 0;

    if (lastPlayDateStr == null) {
      await _storage.put(HiveKeys.currentStreak, 1);
      return;
    }

    try {
      final lastPlayDate = DateTime.parse(lastPlayDateStr);
      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day);
      final yesterday = today.subtract(const Duration(days: 1));

      final lastPlayDay =
          DateTime(lastPlayDate.year, lastPlayDate.month, lastPlayDate.day);

      if (lastPlayDay == yesterday) {
        await _storage.put(HiveKeys.currentStreak, currentStreak + 1);
      } else if (lastPlayDay != today) {
        await _storage.put(HiveKeys.currentStreak, 1);
      }
    } catch (e) {
      debugLog('Error updating streak: $e');

      await _storage.put(HiveKeys.currentStreak, 1);
    }
  }
}

final currentStreakProvider = StateProvider<int>((ref) => 0);
final streakRecordedTodayProvider = StateProvider<bool>((ref) => false);

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
