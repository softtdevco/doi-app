import 'package:doi_mobile/core/config/env/base_env.dart';
import 'package:doi_mobile/core/config/env/dev_env.dart';
import 'package:doi_mobile/core/config/env/prod_env.dart';
import 'package:doi_mobile/core/config/env/staging_env.dart';
import 'package:doi_mobile/core/utils/logger.dart';
import 'package:doi_mobile/presentation/features/profile/data/repository/user_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:socket_io_client/socket_io_client.dart';

class SocketClient {
  final SocketManager gamePlaySocketManager;

  SocketClient({
    required this.gamePlaySocketManager,
  });

  startGamePlay({
    required String gameCode,
    required Function(dynamic) onResponse,
  }) {
    gamePlaySocketManager._socket.emitWithAck(
      'startGame',
      {
        "code": gameCode,
      },
      ack: onResponse,
    );
  }

  guessNumber({
    required String gameId,
    required String guess,
    required Function(dynamic) onResponse,
  }) {
    gamePlaySocketManager._socket.emitWithAck(
      'guessNumber',
      {"gameId": gameId, "guess": guess},
      ack: onResponse,
    );
  }
}

class SocketManager {
  late Socket _socket;
  final String websocketUrl;
  final String userToken;
  SocketManager(this.websocketUrl, this.userToken) {
    init();
  }

  void init() {
    _socket = io(
      websocketUrl,
      OptionBuilder()
          .setTransports(['websocket'])
          .enableForceNewConnection()
          .enableAutoConnect()
          .setAuth({
            'token': userToken,
          })
          .build(),
    );

    _socket.connect();

    _socket.onConnect((v) {
      debugLog('connected to web socket');
    });

    _socket.onDisconnect((v) {
      debugLog('disconnected from web socket');
    });
    _socket.onConnectError((data) {
      debugLog(data);
    });
  }
}

final gamePlaySocketManager =
    Provider.family<SocketManager, BaseEnv>((ref, env) {
  return SocketManager(
      env.baseUrl, ref.read(userRepositoryProvider).getToken());
});

final socketclient = Provider<SocketClient>((ref) {
  final env = switch (F.appFlavor) {
    Flavor.prod => ProdEnv(),
    Flavor.staging => StagingEnv(),
    Flavor.dev => DevEnv(),
  };
  return SocketClient(
    gamePlaySocketManager: ref.read(gamePlaySocketManager.call(env)),
  );
});
