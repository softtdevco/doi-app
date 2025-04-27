import 'dart:async';

import 'package:doi_mobile/core/utils/enums.dart';
import 'package:doi_mobile/core/utils/logger.dart';
import 'package:doi_mobile/presentation/features/dashboard/home/data/model/create_game_request.dart';
import 'package:doi_mobile/presentation/features/dashboard/onlineGame/data/repository/online_game_repository.dart';
import 'package:doi_mobile/presentation/features/dashboard/onlineGame/presentation/notifiers/onine_game_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OnlineGameNotifier extends Notifier<OnlineGameState> {
  OnlineGameNotifier();
  late OnlineGameRepository _onlineGameRepository;

  @override
  build() {
    _onlineGameRepository = ref.read(onlineGameRepositoryProvider);
    ref.onDispose(() {
      stopPolling();
    });
    return OnlineGameState.initial();
  }

  Timer? _pollingTimer;

  void startPolling({
    required String joinCode,
    required int expectedPlayerCount,
    final Function()? onAllPlayersJoined,
  }) {
    state = state.copyWith(
      expectedPlayerCount: expectedPlayerCount,
      joinCode: joinCode,
    );

    getGameSession(
      joinCode: joinCode,
      onAllPlayersJoined: onAllPlayersJoined,
    );

    _pollingTimer = Timer.periodic(Duration(seconds: 3), (_) {
      getGameSession(
        joinCode: joinCode,
        onAllPlayersJoined: onAllPlayersJoined,
      );
    });
  }

  void stopPolling() {
    _pollingTimer?.cancel();
    _pollingTimer = null;
  }

  void updateType(String type) {
    state = state.copyWith(type: type);
  }

  void updatePairing(String pairing) {
    state = state.copyWith(pairing: pairing);
  }

  Future<void> createGame({
    required CreateGameRequest data,
    required void Function(String) onError,
    required void Function(String) onCompleted,
  }) async {
    state = state.copyWith(createGameLoadState: LoadState.loading);
    try {
      final response = await _onlineGameRepository.createGame(data);
      if (!response.status) throw response.message;
      state = state.copyWith(
        createGameLoadState: LoadState.success,
        joinGameData: response.data?.data?.data?.msg,
      );
      onCompleted(response.data?.data?.data?.msg?.code ?? '');
    } catch (e) {
      state = state.copyWith(createGameLoadState: LoadState.error);
      onError(e.toString());
    }
  }

  Future<void> joinGame({
    required String secretCode,
    required String joinCode,
    required void Function(String) onError,
    required void Function() onCompleted,
  }) async {
    state = state.copyWith(joinGameLoadState: LoadState.loading);
    try {
      final response = await _onlineGameRepository.joinGame(
        joinCode: joinCode,
        secretCode: secretCode,
      );
      if (!response.status) throw response.message;
      state = state.copyWith(
        joinGameLoadState: LoadState.success,
        gameSessionData: response.data?.data,
      );
      onCompleted();
    } catch (e) {
      state = state.copyWith(joinGameLoadState: LoadState.error);
      onError(e.toString());
    }
  }

  Future<void> getGameSession({
    required String joinCode,
    final Function()? onAllPlayersJoined,
  }) async {
    state = state.copyWith(gameSessionLoadState: LoadState.loading);
    try {
      final response = await _onlineGameRepository.getGameSession(
        joinCode: joinCode,
      );
      if (!response.status) throw response.message;
      state = state.copyWith(
        gameSessionLoadState: LoadState.success,
        gameSessionData: response.data?.data,
      );

      if (response.data?.data?.players != null &&
          response.data!.data!.players!.length >= state.expectedPlayerCount) {
        stopPolling();
        if (onAllPlayersJoined != null) {
          onAllPlayersJoined();
        }
      }
    } catch (e) {
      state = state.copyWith(gameSessionLoadState: LoadState.error);
      debugLog(e.toString());
    }
  }
}

final onlineGameNotifierProvider =
    NotifierProvider<OnlineGameNotifier, OnlineGameState>(
        OnlineGameNotifier.new);
