import 'package:doi_mobile/core/utils/enums.dart';
import 'package:doi_mobile/presentation/features/dashboard/home/data/model/create_game_response.dart';

class OnlineGameState {
  final LoadState loadState;
  final String type;
  final String pairing;
  final JoinGameData? joinGameData;
  final LoadState createGameLoadState;

  OnlineGameState({
    required this.loadState,
    required this.type,
    required this.pairing,
    this.joinGameData,
    required this.createGameLoadState,
  });

  factory OnlineGameState.initial() {
    return OnlineGameState(
      type: 'Ranked',
      loadState: LoadState.idle,
      pairing: 'Rapid',
      createGameLoadState: LoadState.idle,
    );
  }

  OnlineGameState copyWith({
    LoadState? loadState,
    String? type,
    String? pairing,
    JoinGameData? joinGameData,
    LoadState? createGameLoadState,
  }) {
    return OnlineGameState(
      loadState: loadState ?? this.loadState,
      type: type ?? this.type,
      pairing: pairing ?? this.pairing,
      joinGameData: joinGameData ?? this.joinGameData,
      createGameLoadState: createGameLoadState ?? this.createGameLoadState,
    );
  }
}
