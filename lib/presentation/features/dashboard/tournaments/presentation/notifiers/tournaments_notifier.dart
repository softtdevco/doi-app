import 'package:doi_mobile/presentation/features/dashboard/Tournaments/presentation/notifiers/Tournaments_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TournamentsNotifier extends AutoDisposeNotifier<TournamentsState> {
  TournamentsNotifier();

  @override
  TournamentsState build() {
    return TournamentsState.initial();
  }

  void selectSwitchIndex(int index) {
    state = state.copyWith(switchIndex: index);
  }
}

final tournamentsNotifierProvider =
    NotifierProvider.autoDispose<TournamentsNotifier, TournamentsState>(
        TournamentsNotifier.new);
