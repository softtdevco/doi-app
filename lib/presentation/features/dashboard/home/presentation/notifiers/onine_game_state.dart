import 'package:doi_mobile/core/utils/enums.dart';

class OnlineGameState {
  final LoadState loadState;
  final String type;
  final String pairing;

  OnlineGameState({
    required this.loadState,
    required this.type,
    required this.pairing,
  });

  factory OnlineGameState.initial() {
    return OnlineGameState(
      type: 'Ranked',
      loadState: LoadState.idle,
      pairing: 'Rapid',
    );
  }

  OnlineGameState copyWith({
    LoadState? loadState,
    String? type,
    String? pairing,
  }) {
    return OnlineGameState(
      loadState: loadState ?? this.loadState,
      type: type ?? this.type,
      pairing: pairing?? this.pairing,
    );
  }
}
