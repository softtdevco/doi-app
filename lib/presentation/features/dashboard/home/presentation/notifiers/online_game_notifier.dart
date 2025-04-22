import 'package:doi_mobile/core/utils/enums.dart';
import 'package:doi_mobile/presentation/features/dashboard/home/data/model/create_game_request.dart';
import 'package:doi_mobile/presentation/features/dashboard/home/data/repository/online_game_repository.dart';
import 'package:doi_mobile/presentation/features/dashboard/home/presentation/notifiers/onine_game_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OnlineGameNotifier extends Notifier<OnlineGameState> {
  OnlineGameNotifier();
  late OnlineGameRepository _onlineGameRepository;

  @override
  build() {
    _onlineGameRepository = ref.read(onlineGameRepositoryProvider);
    return OnlineGameState.initial();
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
    required void Function() onCompleted,
  }) async {
    state = state.copyWith(createGameLoadState: LoadState.loading);
    try {
      final response = await _onlineGameRepository.createGame(data);
      if (!response.status) throw response.message;
      state = state.copyWith(
        createGameLoadState: LoadState.success,
        joinGameData: response.data?.msg?.data,
      );
      onCompleted();
    } catch (e) {
      state = state.copyWith(createGameLoadState: LoadState.error);
      onError(e.toString());
    }
  }
}

final onlineGameNotifierProvider =
    NotifierProvider<OnlineGameNotifier, OnlineGameState>(
        OnlineGameNotifier.new);
