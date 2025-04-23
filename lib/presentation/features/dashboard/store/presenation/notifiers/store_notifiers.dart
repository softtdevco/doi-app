import 'package:doi_mobile/presentation/features/dashboard/store/presenation/notifiers/store_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StoreNotifier extends AutoDisposeNotifier<StoreState> {
  StoreNotifier();

  @override
  StoreState build() {
    return StoreState.initial();
  }

  void selectSwitchIndex(int index) {
    state = state.copyWith(switchIndex: index);
  }
}

final storeNotifierProvider =
    NotifierProvider.autoDispose<StoreNotifier, StoreState>(StoreNotifier.new);
