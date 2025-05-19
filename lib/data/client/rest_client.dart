import 'package:dio/dio.dart';
import 'package:doi_mobile/core/config/env/base_env.dart';
import 'package:doi_mobile/core/config/env/dev_env.dart';
import 'package:doi_mobile/core/config/env/prod_env.dart';
import 'package:doi_mobile/core/config/env/staging_env.dart';
import 'package:doi_mobile/core/config/interceptors/header_interceptors.dart';
import 'package:doi_mobile/data/local_storage/storage_impl.dart';
import 'package:doi_mobile/data/local_storage/storage_keys.dart';
import 'package:doi_mobile/presentation/features/dashboard/home/data/model/create_game_request.dart';
import 'package:doi_mobile/presentation/features/dashboard/home/data/model/create_game_response.dart';
import 'package:doi_mobile/presentation/features/dashboard/home/data/model/leader_board_response.dart';
import 'package:doi_mobile/presentation/features/dashboard/home/data/model/streak_response.dart';
import 'package:doi_mobile/presentation/features/dashboard/onlineGame/data/model/join_game_response.dart';
import 'package:doi_mobile/presentation/features/onboarding/data/models/empty_data.dart';
import 'package:doi_mobile/presentation/features/onboarding/data/models/login_device_response.dart';
import 'package:doi_mobile/presentation/features/onboarding/data/models/login_sync_request.dart';
import 'package:doi_mobile/presentation/features/onboarding/data/models/register_device_request.dart';
import 'package:doi_mobile/presentation/features/onboarding/data/models/register_device_response.dart';
import 'package:doi_mobile/presentation/features/onboarding/data/models/signup_sync_request.dart';
import 'package:doi_mobile/presentation/features/profile/data/repository/user_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:retrofit/retrofit.dart';

part 'rest_client.g.dart';

@RestApi()
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  //<====================> Authentication <====================>
  @POST('/auth/register-without-email')
  Future<RegisterDeviceResponse> registerDevice(
    @Body() RegisterDeviceRequest request,
  );

  @POST('/auth/login-without-email')
  Future<LoginDeviceResponse> loginDevice(
    @Body() Map<String, dynamic> request,
  );

  @POST('/user/sync/signup')
  Future<LoginDeviceResponse> syncSignup(@Body() SignupSyncRequest request);

  @POST('/user/sync/login')
  Future<RegisterDeviceResponse> syncLogin(@Body() LoginSyncRequest request);

  @DELETE('/users')
  Future<Emptydata> deleteUser();

  //<====================> Game Play <====================>
  @POST('/game/create-session')
  Future<CreateGameResponse> createGame(
    @Body() CreateGameRequest request,
  );
  @POST('/game/join-session/{joinCode}/{secretCode}')
  Future<JoinGameResponse> joinGame({
    @Path('joinCode') required String joinCode,
    @Path('secretCode') required String secretCode,
  });
  @GET('/game/session/{joinCode}')
  Future<JoinGameResponse> getGameSession({
    @Path('joinCode') required String joinCode,
  });
  @GET('/game/leaderboard')
  Future<LeaderBoardResponse> getLeaderBoard();
  @POST('/streak')
  Future<StreakResponse> sendDailyStreak();

}

////////////////////////////////////////////////////////////////

ProviderFamily<Dio, BaseEnv> _dio = Provider.family<Dio, BaseEnv>((ref, env) {
  final dio = Dio();
  dio.options.baseUrl = env.baseUrl;
  dio.options.headers = {
    'Content-Type': 'application/json',
    'accept': 'application/json',
  };
  dio.interceptors.add(
    HeaderInterceptor(
      dio: dio,
      userRepository: UserRepositoryImpl(
        LocalStorageImpl(Hive.box(HiveKeys.appBox)),
        ref,
        // RestClient(dio),
      ),
      ref: ref,
    ),
  );
  return dio;
});
final restClient = Provider((_) {
  final env = switch (F.appFlavor) {
    Flavor.prod => ProdEnv(),
    Flavor.staging => StagingEnv(),
    Flavor.dev => DevEnv(),
  };
  return RestClient(_.read(_dio.call(env)));
});
