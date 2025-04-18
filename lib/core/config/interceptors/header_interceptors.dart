import 'dart:async';

import 'package:dio/dio.dart';
import 'package:doi_mobile/core/utils/logger.dart';
import 'package:doi_mobile/presentation/features/profile/data/repository/user_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HeaderInterceptor extends Interceptor {
  HeaderInterceptor({
    required this.dio,
    required this.userRepository,
    required this.ref,
  });
  final Dio dio;
  final Ref ref;
  final UserRepository userRepository;

  final _authRoutes = [];

  @override
  FutureOr<dynamic> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) {
    try {
      final token = '';
      if (token.isNotEmpty && !_authRoutes.contains(options.path)) {
        options.headers['Authorization'] = 'Bearer $token';
        debugLog('[TOKEN]$token');
      }
    } catch (e) {
      debugLog(e);
    }
    debugLog('[URL]${options.uri}');
    debugLog('[BODY] ${options.data}');
    debugLog('[METHOD] ${options.method}');
    debugLog('[QUERIES]${options.queryParameters}');

    handler.next(options);
    return options;
  }

  @override
  FutureOr<dynamic> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    // if (err.response != null && err.response!.statusCode == 401) {
    //   await _refreshToken(err, handler, dio, userRepository, ref);
    //   return;
    // }
    debugLog('[ERROR] ${err.requestOptions.uri}');
    debugLog('[ERROR] ${err.response}');
    handler.next(err);
    return err;
  }

  @override
  FutureOr<dynamic> onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    debugLog(
      '[RESPONSE FROM ${response.requestOptions.path}]: ${response.data}',
    );
    handler.next(response);
    return response;
  }
}

// Future<void> _refreshToken(DioException error, ErrorInterceptorHandler handler,
//     Dio dio, UserRepository userRepository, Ref ref) async {
//   final deviceId = await DeviceInfoService.instance.getDeviceInfo();
//   ref.read(onboardingNotifierProvider.notifier).loginDevice(
//       deviceId: deviceId,
//       onCompleted: () {
//         handleError(handler, error, dio);
//       },
//       onError: (p0){

//       }
//       );
// }

// Future<void> handleError(
//   ErrorInterceptorHandler handler,
//   DioException err,
//   Dio dio,
// ) async {
//   final opts = Options(
//     method: err.requestOptions.method,
//     headers: err.requestOptions.headers,
//   );
//   final cloneReq = await dio.request<Map<String, dynamic>?>(
//     err.requestOptions.path,
//     options: opts,
//     data: err.requestOptions.data,
//     queryParameters: err.requestOptions.queryParameters,
//   );

//   return handler.resolve(cloneReq);
// }
