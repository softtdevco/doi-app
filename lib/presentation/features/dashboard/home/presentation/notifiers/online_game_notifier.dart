import 'package:doi_mobile/presentation/features/dashboard/home/presentation/notifiers/onine_game_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OnlineGameNotifier extends Notifier<OnlineGameState> {
  @override
  build() {
    return OnlineGameState.initial();
  }

  void updateType(String type) {
    state = state.copyWith(type: type);
  }

  void updatePairing(String pairing) {
    state = state.copyWith(pairing: pairing);
  }
}

final onlineGameNotifierProvider =
    NotifierProvider<OnlineGameNotifier, OnlineGameState>(
        OnlineGameNotifier.new);
