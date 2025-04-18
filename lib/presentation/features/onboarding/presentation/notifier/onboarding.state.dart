import 'package:doi_mobile/core/utils/enums.dart';

class OnboardingState {
  final String? userName;
  final String? country;
  final LoadState loadState;
  final int authenicationIndex;
  final bool submitUsername;
  final LoadState registerDeviceLoadstate;
  final LoadState loginSyncLoadState;
  final LoadState signupSyncLoadState;
  final HomeSessionState homeSessionState;

  OnboardingState({
    required this.submitUsername,
    required this.authenicationIndex,
    required this.loadState,
    this.userName,
    this.country,
    required this.registerDeviceLoadstate,
    required this.loginSyncLoadState,
    required this.signupSyncLoadState,
    required this.homeSessionState,
  });
  factory OnboardingState.initial() {
    return OnboardingState(
      authenicationIndex: 0,
      submitUsername: false,
      loadState: LoadState.idle,
      registerDeviceLoadstate: LoadState.idle,
      loginSyncLoadState: LoadState.idle,
      signupSyncLoadState: LoadState.idle,
      homeSessionState: HomeSessionState.initial,
    );
  }
  OnboardingState copyWith({
    String? userName,
    String? country,
    LoadState? loadState,
    int? authenicationIndex,
    bool? submitUsername,
    LoadState? registerDeviceLoadstate,
    LoadState? loginSyncLoadState,
    LoadState? signupSyncLoadState,
    HomeSessionState? homeSessionState,
  }) {
    return OnboardingState(
      loadState: loadState ?? this.loadState,
      submitUsername: submitUsername ?? this.submitUsername,
      userName: userName ?? this.userName,
      authenicationIndex: authenicationIndex ?? this.authenicationIndex,
      country: country ?? this.country,
      registerDeviceLoadstate:
          registerDeviceLoadstate ?? this.registerDeviceLoadstate,
      loginSyncLoadState: loginSyncLoadState ?? this.loginSyncLoadState,
      signupSyncLoadState: signupSyncLoadState ?? this.signupSyncLoadState,
      homeSessionState: homeSessionState ?? this.homeSessionState,
    );
  }
}
