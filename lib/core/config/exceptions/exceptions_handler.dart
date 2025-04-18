
import 'package:dio/dio.dart';
import 'package:doi_mobile/core/utils/logger.dart';
import 'package:doi_mobile/core/utils/strings.dart';
import 'package:doi_mobile/core/utils/type_defs.dart';

class AppException implements Exception {
  static BaseResponse<T> handleError<T>(
    DioException e, {
    T? data,
  }) {
    debugLog(e);
    if (e.response != null && DioExceptionType.badResponse == e.type) {
      if (e.response!.statusCode! >= 500) {
        return (
          status: false,
          message: Strings.serverError,
          data: data,
        );
      }
      if (e.response?.data is Map<String, dynamic>) {
        debugLog(e.response?.data);
        return (
          status: false,
          data: data,
          message: (e.response?.data as Map<String, dynamic>)['message'] is List
              ? ((e.response?.data as Map<String, dynamic>)['message'] as List)
                  .join(',')
              : (e.response?.data as Map<String, dynamic>)['message'] ?? '',
        );
      } else if (e.response?.data is String) {
        debugLog(e.response?.data);
        return (
          data: e.response?.data,
          status: false,
          message: e.response?.data as String,
        );
      }
    }
    return (
      status: false,
      data: data,
      message: _mapException(e.type),
    );
  }

  static String _mapException(DioExceptionType? error) {
    if (DioExceptionType.connectionTimeout == error ||
        DioExceptionType.receiveTimeout == error ||
        DioExceptionType.sendTimeout == error) {
      return Strings.timeout;
    } else if (DioExceptionType.connectionError == error) {
      return Strings.connectionError;
    }
    return Strings.genericErrorMessage;
  }
}
