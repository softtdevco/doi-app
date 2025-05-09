import 'package:doi_mobile/core/utils/enums.dart';

class OnboardingState {
  final String? userName;
  final String? country;
  final String avatar;
  final LoadState loadState;
  final int authenicationIndex;
  final bool submitUsername;
  final LoadState registerDeviceLoadstate;
  final LoadState loginSyncLoadState;
  final LoadState signupSyncLoadState;
  final HomeSessionState homeSessionState;
  final LoadState deleteLoadState;

  OnboardingState({
    required this.submitUsername,
    required this.authenicationIndex,
    required this.loadState,
    required this.avatar,
    this.userName,
    this.country,
    required this.registerDeviceLoadstate,
    required this.loginSyncLoadState,
    required this.signupSyncLoadState,
    required this.homeSessionState,
    required this.deleteLoadState,
  });
  factory OnboardingState.initial() {
    return OnboardingState(
      authenicationIndex: 0,
      submitUsername: false,
      avatar: 'userPic3.png',
      loadState: LoadState.idle,
      registerDeviceLoadstate: LoadState.idle,
      loginSyncLoadState: LoadState.idle,
      signupSyncLoadState: LoadState.idle,
      homeSessionState: HomeSessionState.initial,
      deleteLoadState: LoadState.idle,
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
    String? avatar,
    LoadState? deleteLoadState,
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
      avatar: avatar ?? this.avatar,
      deleteLoadState: deleteLoadState ?? this.deleteLoadState,
    );
  }
}
