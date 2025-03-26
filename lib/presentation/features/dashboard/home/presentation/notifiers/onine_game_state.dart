import 'package:doi_mobile/core/utils/enums.dart';

class OnlineGameState {
  final LoadState loadState;

  OnlineGameState({
    required this.loadState,
  });

  factory OnlineGameState.initial() {
    return OnlineGameState(
      loadState: LoadState.idle,
    );
  }

  OnlineGameState copyWith({
    LoadState? loadState,
  }){
    return OnlineGameState(
      loadState: loadState ?? this.loadState,
    );
  }
}
