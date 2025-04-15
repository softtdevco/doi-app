import 'package:doi_mobile/core/utils/enums.dart';

class TournamentsState {
  final LoadState loadState;

  final int switchIndex;
  TournamentsState({
    required this.loadState,
    required this.switchIndex,
  });
  factory TournamentsState.initial() {
    return TournamentsState(
      loadState: LoadState.loading,
      switchIndex: 0,
    );
  }
  TournamentsState copyWith({
    LoadState? loadState,
    int? gameModeIndex,
    int? switchIndex,
  }) {
    return TournamentsState(
      loadState: loadState ?? this.loadState,
      switchIndex: switchIndex ?? this.switchIndex,
    );
  }
}
