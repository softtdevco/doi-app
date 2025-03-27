import 'package:doi_mobile/core/utils/enums.dart';

class OnlineGameState {
  final LoadState loadState;
  final String type;

  OnlineGameState({
    required this.loadState,
    required this.type,
  });

  factory OnlineGameState.initial() {
    return OnlineGameState(
      type: 'Ranked',
      loadState: LoadState.idle,
    );
  }

  OnlineGameState copyWith({
    LoadState? loadState,
    String? type,
  }) {
    return OnlineGameState(
      loadState: loadState ?? this.loadState,
      type: type ?? this.type,
    );
  }
}
