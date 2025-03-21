import 'package:doi_mobile/core/utils/enums.dart';

class HomeState {
  final LoadState loadState;
  final int gameModeIndex;
  final int playBackIndex;
  final String timer;
  HomeState({
    required this.loadState,
    required this.gameModeIndex,
    required this.playBackIndex,
    required this.timer,
  });
  factory HomeState.initial() {
    return HomeState(
      loadState: LoadState.loading,
      gameModeIndex: 0,
      playBackIndex: 0,
      timer: '5',
    );
  }
  HomeState copyWith({
    LoadState? loadState,
    int? gameModeIndex,
    int? playBackIndex,
    String? timer,
  }) {
    return HomeState(
      loadState: loadState ?? this.loadState,
      gameModeIndex: gameModeIndex ?? this.gameModeIndex,
      playBackIndex: playBackIndex ?? this.playBackIndex,
      timer: timer ?? this.timer,
    );
  }
}
