import 'package:doi_mobile/presentation/features/dashboard/home/presentation/notifiers/home_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeNotifier extends AutoDisposeNotifier<HomeState> {
  HomeNotifier();

  @override
  HomeState build() {
    return HomeState.initial();
  }

  void selectGameModeIndex(int index) {
    state = state.copyWith(gameModeIndex: index);
  }

  void selectPlayBacksIndex(int index) {
    state = state.copyWith(playBackIndex: index);
  }
   void updateTimer(String timer) {
    state = state.copyWith(timer: timer);
  }
}

final homeNotifierProvider =
    NotifierProvider.autoDispose<HomeNotifier, HomeState>(HomeNotifier.new);
