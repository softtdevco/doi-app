import 'package:dio/dio.dart';
import 'package:doi_mobile/core/config/exceptions/exceptions_handler.dart';
import 'package:doi_mobile/core/extensions/object_extensions.dart';
import 'package:doi_mobile/core/utils/type_defs.dart';
import 'package:doi_mobile/data/client/rest_client.dart';
import 'package:doi_mobile/presentation/features/onboarding/data/models/empty_data.dart';
import 'package:doi_mobile/presentation/features/onboarding/data/models/login_device_response.dart';
import 'package:doi_mobile/presentation/features/onboarding/data/models/login_sync_request.dart';
import 'package:doi_mobile/presentation/features/onboarding/data/models/register_device_request.dart';
import 'package:doi_mobile/presentation/features/onboarding/data/models/register_device_response.dart';
import 'package:doi_mobile/presentation/features/onboarding/data/models/signup_sync_request.dart';
import 'package:doi_mobile/presentation/features/profile/data/repository/user_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../profile/data/repository/user_repository.dart';

base class OnboardingRepository {
  OnboardingRepository(
    this._userRepository,
    this._restClient,
  );
  final UserRepository _userRepository;
  final RestClient _restClient;

  Future<BaseResponse<RegisterDeviceResponse>> registerDevice(
    RegisterDeviceRequest request,
  ) async {
    try {
      final r = await _restClient.registerDevice(request);

      await _userRepository.updateUser(r.data!);
      return r.toBaseResponse(
        message: 'Device Registeration Successful',
        status: true,
      );
    } on DioException catch (e) {
      return AppException.handleError(e);
    }
  }

  Future<BaseResponse<LoginDeviceResponse>> loginDevice({
    required String deviceId,
  }) async {
    try {
      final r = await _restClient.loginDevice({"deviceID": deviceId});
      await _userRepository.saveToken(r.data!.token ?? '');
      await _userRepository.updateUser(r.data!.user!);
      return r.toBaseResponse(
        message: 'Device Registeration Successful',
        status: true,
      );
    } on DioException catch (e) {
      return AppException.handleError(e);
    }
  }

  Future<BaseResponse<LoginDeviceResponse>> syncSignup(
      SignupSyncRequest request) async {
    try {
      final r = await _restClient.syncSignup(request);

      return r.toBaseResponse(
        message: r.message ?? '',
        status: true,
      );
    } on DioException catch (e) {
      return AppException.handleError(e);
    }
  }

  Future<BaseResponse<RegisterDeviceResponse>> syncLogin(
    LoginSyncRequest request,
  ) async {
    try {
      final r = await _restClient.syncLogin(request);
      // await _userRepository.saveToken(r.msg.data.authToken ?? '');
      await _userRepository.updateUser(r.data!);
      return r.toBaseResponse(
        message: 'User account synced',
        status: true,
      );
    } on DioException catch (e) {
      return AppException.handleError(e);
    }
  }

  Future<BaseResponse<Emptydata>> deleteAccount() async {
    try {
      final r = await _restClient.deleteUser();

      return r.toBaseResponse(
        message: 'User account deleted',
        status: true,
      );
    } on DioException catch (e) {
      return AppException.handleError(e);
    }
  }
}

final onboardingRepositoryProvider = Provider((ref) {
  return OnboardingRepository(
    ref.read(userRepositoryProvider),
    ref.read(restClient),
  );
});
