import 'package:doi_mobile/core/utils/enums.dart';

class StoreState {
  final LoadState loadState;

  final int switchIndex;
  StoreState({
    required this.loadState,
    required this.switchIndex,
  });
  factory StoreState.initial() {
    return StoreState(
      loadState: LoadState.loading,
      switchIndex: 0,
    );
  }
  StoreState copyWith({
    LoadState? loadState,
    int? switchIndex,
  }) {
    return StoreState(
      loadState: loadState ?? this.loadState,
      switchIndex: switchIndex ?? this.switchIndex,
    );
  }
}
