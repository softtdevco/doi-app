import 'package:doi_mobile/core/utils/enums.dart';

class OnboardingState {
  final String? userName;
  final String? country;
  final LoadState loadState;
  final int authenicationIndex;
  final bool submitUsername;
  OnboardingState({
    required this.submitUsername,
    required this.authenicationIndex,
    required this.loadState,
    this.userName,
    this.country,
  });
  factory OnboardingState.initial() {
    return OnboardingState(
      authenicationIndex: 0,
      submitUsername: false,
      loadState: LoadState.loading,
    );
  }
  OnboardingState copyWith({
    String? userName,
    String? country,
    LoadState? loadState,
    int? authenicationIndex,
    bool? submitUsername,
  }) {
    return OnboardingState(
        loadState: loadState ?? this.loadState,
        submitUsername: submitUsername ?? this.submitUsername,
        userName: userName ?? this.userName,
        authenicationIndex: authenicationIndex ?? this.authenicationIndex,
        country: country ?? this.country,
        );
  }
}
