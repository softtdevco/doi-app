import 'dart:convert';

import 'package:doi_mobile/data/local_storage/storage.dart';
import 'package:doi_mobile/data/local_storage/storage_impl.dart';
import 'package:doi_mobile/data/local_storage/storage_keys.dart';
import 'package:doi_mobile/presentation/features/dashboard/home/data/repository/game_repository.dart';
import 'package:doi_mobile/presentation/features/dashboard/home/presentation/notifiers/home_notifier.dart';
import 'package:flutter/foundation.dart';
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
      debugPrint('Error parsing game data: $e');
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
