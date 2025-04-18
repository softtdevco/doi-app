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

  void selectName(String userName) {
    state = state.copyWith(userName: userName);
  }

  void selectCountry(String country) {
    state = state.copyWith(country: country);
  }
}

final onboardingNotifierProvider =
    NotifierProvider.autoDispose<OnboardingNotifier, OnboardingState>(
        OnboardingNotifier.new);
