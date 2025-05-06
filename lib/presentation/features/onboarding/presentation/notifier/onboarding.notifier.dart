import 'package:doi_mobile/core/utils/enums.dart';
import 'package:doi_mobile/core/utils/logger.dart';
import 'package:doi_mobile/presentation/features/onboarding/data/models/login_sync_request.dart';
import 'package:doi_mobile/presentation/features/onboarding/data/models/register_device_request.dart';
import 'package:doi_mobile/presentation/features/onboarding/data/models/signup_sync_request.dart';
import 'package:doi_mobile/presentation/features/onboarding/data/repository/onboarding_repository.dart';
import 'package:doi_mobile/presentation/features/onboarding/presentation/notifier/onboarding.state.dart';
import 'package:doi_mobile/presentation/features/profile/data/repository/user_repository.dart';
import 'package:doi_mobile/presentation/features/profile/data/repository/user_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OnboardingNotifier extends AutoDisposeNotifier<OnboardingState> {
  OnboardingNotifier();
  late OnboardingRepository _onboardingRepository;
  late UserRepository _userRepository;

  @override
  OnboardingState build() {
    _onboardingRepository = ref.read(onboardingRepositoryProvider);
    _userRepository = ref.read(userRepositoryProvider);
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

  Future<void> registerDevice({
    required RegisterDeviceRequest data,
    required void Function(String) onError,
    required void Function() onCompleted,
  }) async {
    state = state.copyWith(registerDeviceLoadstate: LoadState.loading);
    try {
      final response = await _onboardingRepository.registerDevice(data);
      if (!response.status) throw response.message;
      state = state.copyWith(registerDeviceLoadstate: LoadState.success);
      onCompleted();
    } catch (e) {
      state = state.copyWith(registerDeviceLoadstate: LoadState.error);
      onError(e.toString());
    }
  }

  Future<void> loginDevice({
    required String deviceId,
    void Function()? onCompleted,
    void Function(String)? onError,
  }) async {
    try {
      state = state.copyWith(loadState: LoadState.loading);
      final response =
          await _onboardingRepository.loginDevice(deviceId: deviceId);
      if (!response.status) throw response.message;
      _userRepository.saveCurrentState(CurrentState.loggedIn);
      state = state.copyWith(loadState: LoadState.success);
      if (onCompleted != null) onCompleted();
    } catch (e) {
      state = state.copyWith(loadState: LoadState.error);
      if (onError != null) onError(e.toString());
      debugLog("\n\n<==Login Device ==> ${e.toString()}");
    }
  }

  Future<void> syncSignUp({
    required SignupSyncRequest data,
    required void Function(String) onError,
    required void Function(String) onCompleted,
  }) async {
    state = state.copyWith(signupSyncLoadState: LoadState.loading);
    try {
      final response = await _onboardingRepository.syncSignup(data);
      if (!response.status) throw response.message;
      state = state.copyWith(signupSyncLoadState: LoadState.success);
      onCompleted(response.message);
    } catch (e) {
      state = state.copyWith(signupSyncLoadState: LoadState.error);
      onError(e.toString());
    }
  }

  Future<void> syncLogin({
    required LoginSyncRequest data,
    required void Function(String) onError,
    required void Function(String) onCompleted,
  }) async {
    state = state.copyWith(loginSyncLoadState: LoadState.loading);
    try {
      final response = await _onboardingRepository.syncLogin(data);
      if (!response.status) throw response.message;
      state = state.copyWith(loginSyncLoadState: LoadState.success);
      onCompleted(response.message);
    } catch (e) {
      state = state.copyWith(loginSyncLoadState: LoadState.error);
      onError(e.toString());
    }
  }

  // Future<void> logout() async {
  //   _userRepository.saveCurrentState(CurrentState.onboarded);
  //   state = state.copyWith(homeSessionState: HomeSessionState.logout);
  // }
}

final onboardingNotifierProvider =
    NotifierProvider.autoDispose<OnboardingNotifier, OnboardingState>(
        OnboardingNotifier.new);
