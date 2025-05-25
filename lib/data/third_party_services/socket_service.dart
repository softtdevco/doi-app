import 'dart:async';

import 'package:doi_mobile/core/config/env/base_env.dart';
import 'package:doi_mobile/core/config/env/dev_env.dart';
import 'package:doi_mobile/core/config/env/prod_env.dart';
import 'package:doi_mobile/core/config/env/staging_env.dart';
import 'package:doi_mobile/core/utils/logger.dart';
import 'package:doi_mobile/presentation/features/dashboard/home/data/model/create_game_request.dart';
import 'package:doi_mobile/presentation/features/profile/data/repository/user_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:socket_io_client/socket_io_client.dart';

// Events streamer to break circular dependency
final socketEventsProvider = Provider<SocketEventStreamer>((ref) {
  return SocketEventStreamer();
});

class SocketEventStreamer {
  final _yourTurnController = StreamController<dynamic>.broadcast();
  final _mobileEmitController = StreamController<dynamic>.broadcast();
  final _matchupCompleteController = StreamController<dynamic>.broadcast();
  final _guessResultController = StreamController<dynamic>.broadcast();
  final _gameEndedController = StreamController<dynamic>.broadcast();
  final _roundAdvancedController = StreamController<dynamic>.broadcast();
  final _gameStateUpdatedController = StreamController<dynamic>.broadcast();
  final _gameCreatedAndStartedController =
      StreamController<dynamic>.broadcast();

  Stream<dynamic> get yourTurn => _yourTurnController.stream;
  Stream<dynamic> get mobileEmit => _mobileEmitController.stream;
  Stream<dynamic> get matchupComplete => _matchupCompleteController.stream;
  Stream<dynamic> get guessResult => _guessResultController.stream;
  Stream<dynamic> get gameEnded => _gameEndedController.stream;
  Stream<dynamic> get roundAdvanced => _roundAdvancedController.stream;
  Stream<dynamic> get gameStateUpdated => _gameStateUpdatedController.stream;
  Stream<dynamic> get gameCreatedAndStarted =>
      _gameCreatedAndStartedController.stream;

  void emitYourTurn(dynamic data) => _yourTurnController.add(data);
  void emitMobileEmit(dynamic data) => _mobileEmitController.add(data);
  void emitMatchupComplete(dynamic data) =>
      _matchupCompleteController.add(data);
  void emitGuessResult(dynamic data) => _guessResultController.add(data);
  void emitGameEnded(dynamic data) => _gameEndedController.add(data);
  void emitRoundAdvanced(dynamic data) => _roundAdvancedController.add(data);
  void emitGameStateUpdated(dynamic data) =>
      _gameStateUpdatedController.add(data);
  void emitGameCreatedAndStarted(dynamic data) =>
      _gameCreatedAndStartedController.add(data);
  void dispose() {
    _yourTurnController.close();
    _mobileEmitController.close();
    _matchupCompleteController.close();
    _guessResultController.close();
    _gameEndedController.close();
    _roundAdvancedController.close();
    _gameStateUpdatedController.close();
    _gameCreatedAndStartedController.close();
  }
}

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
      {"gameID": gameId, "guess": guess},
      ack: onResponse,
    );
  }

  mobileEmit({
    required String gameId,
    required String message,
    required Function(dynamic) onResponse,
  }) {
    gamePlaySocketManager._socket.emitWithAck(
      'mobileEmit',
      {"gameID": gameId, "message": message},
      ack: onResponse,
    );
  }

  endGame({
    required String gameId,
    required Function(dynamic) onResponse,
  }) {
    gamePlaySocketManager._socket.emitWithAck(
      'endGame',
      {"gameID": gameId},
      ack: onResponse,
    );
  }

  joinPlayOnlineRoom({
    required GameDuration time,
    required String secretCode,
    required Function(dynamic) onResponse,
  }) {
    gamePlaySocketManager._socket.emitWithAck(
      'joinPlayOnlineRoom',
      {
        "time": {
          "minutes": time.minute,
          "seconds": time.seconds,
        },
        "secretCode": secretCode,
      },
      ack: onResponse,
    );
  }
}

class SocketManager {
  late Socket _socket;
  final String websocketUrl;
  final String userToken;
  final SocketEventStreamer eventStreamer;

  SocketManager(
    this.websocketUrl,
    this.userToken,
    this.eventStreamer,
  ) {
    init();
  }

  void init() {
    _socket = io(
      websocketUrl,
      OptionBuilder()
          .setTransports(['websocket'])
          .enableForceNewConnection()
          .enableAutoConnect()
          .setExtraHeaders({
            'Authorization': 'Bearer ${userToken}',
          })
          .build(),
    );

    _socket.connect();

    _socket.onConnect((v) {
      debugLog('connected to web socket');
    });

    _socket.onDisconnect((v) {
      debugLog('disconnected from web socket: $v');
    });

    _socket.onConnectError((data) {
      debugLog('Connection Error due to :$data');
    });

    _socket.on('yourTurn', (data) {
      debugLog('yourTurn event received: $data');
      eventStreamer.emitYourTurn(data);
    });

    _socket.on('matchupComplete', (data) {
      debugLog('matchupComplete event received: $data');
      eventStreamer.emitMatchupComplete(data);
    });

    _socket.on('guessResult', (data) {
      debugLog('guessResult event received: $data');
      eventStreamer.emitGuessResult(data);
    });

    _socket.on('gameEnded', (data) {
      debugLog('gameEnded event received: $data');
      eventStreamer.emitGameEnded(data);
    });

    _socket.on('roundAdvanced', (data) {
      debugLog('roundAdvanced event received: $data');
      eventStreamer.emitRoundAdvanced(data);
    });

    _socket.on('gameStateUpdated', (data) {
      debugLog('gameStateUpdated event received: $data');
      eventStreamer.emitGameStateUpdated(data);
    });

    _socket.on('mobileEmit', (data) {
      debugLog('mobileEmit event received: $data');
      eventStreamer.emitMobileEmit(data);
    });

    _socket.on('gameCreatedAndStarted', (data) {
      debugLog('gameCreatedAndStarted event received: $data');
      eventStreamer.emitGameCreatedAndStarted(data);
    });
  }
}

final gamePlaySocketManager =
    Provider.family<SocketManager, BaseEnv>((ref, env) {
  final eventStreamer = ref.read(socketEventsProvider);
  return SocketManager(
    env.socketUrl,
    ref.read(userRepositoryProvider).getToken(),
    eventStreamer,
  );
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
