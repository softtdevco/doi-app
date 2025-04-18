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

      final responseData = e.response?.data;
      debugLog(responseData);

      if (responseData is Map<String, dynamic>) {
        final msg = responseData['msg'];

        String extractedMessage = Strings.genericErrorMessage;

        if (msg is Map<String, dynamic> && msg['data'] is String) {
          extractedMessage = msg['data'];
        } else if (msg is String) {
          extractedMessage = msg;
        }

        return (
          status: false,
          data: data,
          message: extractedMessage,
        );
      } else if (responseData is String) {
        return (
          data: data,
          status: false,
          message: responseData,
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
