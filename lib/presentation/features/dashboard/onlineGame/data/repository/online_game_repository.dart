import 'package:dio/dio.dart';
import 'package:doi_mobile/core/config/exceptions/exceptions_handler.dart';
import 'package:doi_mobile/core/extensions/object_extensions.dart';
import 'package:doi_mobile/core/utils/type_defs.dart';
import 'package:doi_mobile/data/client/rest_client.dart';
import 'package:doi_mobile/presentation/features/dashboard/home/data/model/create_game_request.dart';
import 'package:doi_mobile/presentation/features/dashboard/home/data/model/create_game_response.dart';
import 'package:doi_mobile/presentation/features/dashboard/home/data/model/leader_board_response.dart';
import 'package:doi_mobile/presentation/features/dashboard/onlineGame/data/model/join_game_response.dart';
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

  Future<BaseResponse<JoinGameResponse>> joinGame({
    required String joinCode,
    required String secretCode,
  }) async {
    try {
      final r = await _restClient.joinGame(
        joinCode: joinCode,
        secretCode: secretCode,
      );
      return r.toBaseResponse(
        message: 'Joined Game Successfully',
        status: true,
      );
    } on DioException catch (e) {
      return AppException.handleError(e);
    }
  }

  Future<BaseResponse<JoinGameResponse>> getGameSession({
    required String joinCode,
  }) async {
    try {
      final r = await _restClient.getGameSession(
        joinCode: joinCode,
      );
      return r.toBaseResponse(
        message: 'Game session retrieved successfully',
        status: true,
      );
    } on DioException catch (e) {
      return AppException.handleError(e);
    }
  }

  Future<BaseResponse<LeaderBoardResponse>> getLeaderBoard() async {
    try {
      final r = await _restClient.getLeaderBoard();
      return r.toBaseResponse(
        message: r.message ?? '',
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
