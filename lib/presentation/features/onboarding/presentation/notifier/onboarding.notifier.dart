import 'package:doi_mobile/presentation/features/onboarding/presentation/notifier/onboarding.state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OnboardingNotifier extends AutoDisposeNotifier<OnboardingState> {
  @override
  OnboardingState build() {
    return OnboardingState.initial();
  }

  void selectAuthenicationIndex(int index) {
    state = state.copyWith(authenicationIndex: index);
  }
}

final onboardingNotifierProvider =
    NotifierProvider.autoDispose<OnboardingNotifier, OnboardingState>(
        OnboardingNotifier.new);
