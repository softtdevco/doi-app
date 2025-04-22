import 'package:dio/dio.dart';
import 'package:doi_mobile/core/config/exceptions/exceptions_handler.dart';
import 'package:doi_mobile/core/extensions/object_extensions.dart';
import 'package:doi_mobile/core/utils/type_defs.dart';
import 'package:doi_mobile/data/client/rest_client.dart';
import 'package:doi_mobile/presentation/features/dashboard/home/data/model/create_game_request.dart';
import 'package:doi_mobile/presentation/features/dashboard/home/data/model/create_game_response.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

base class OnlineGameRepository {
  OnlineGameRepository(
    this._restClient,
  );

  final RestClient _restClient;

  Future<BaseResponse<CreateGameResponse>> createGame(
    CreateGameRequest request,
  ) async {
    try {
      final r = await _restClient.createGame(request);
      return r.toBaseResponse(
        message: 'Game Created Successful',
        status: true,
      );
    } on DioException catch (e) {
      return AppException.handleError(e);
    }
  }
}

final onlineGameRepositoryProvider = Provider((ref) {
  return OnlineGameRepository(
    ref.read(restClient),
  );
});
