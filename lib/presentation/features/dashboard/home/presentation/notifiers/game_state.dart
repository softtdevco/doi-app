import 'package:doi_mobile/presentation/features/dashboard/home/data/model/guess_model.dart';


class GameState {
  final String playerSecretCode;
  final String aiSecretCode;
  final List<Guess> playerGuesses;
  final List<Guess> aiGuesses;
  final bool isPlayerTurn;
  final bool timerActive;
  final bool aiPlaybackEnabled;
  final String timerValue;
  final int timeRemaining;
  final bool isGameOver;
  final String? winner; // 'player', 'ai', 'draw', 'timeout' or null
  final String gameMode; // 'hint' or 'mystery'
  final int aiDifficulty; // 0 for easy, 1 for hard

  GameState({
    required this.playerSecretCode,
    required this.aiSecretCode,
    required this.playerGuesses,
    required this.aiGuesses,
    required this.isPlayerTurn,
    required this.timerActive,
    required this.aiPlaybackEnabled,
    required this.timerValue,
    required this.timeRemaining,
    required this.isGameOver,
    required this.winner,
    required this.gameMode,
    required this.aiDifficulty,
  });
  
  factory GameState.initial() {
    return GameState(
      playerSecretCode: '',
      aiSecretCode: '',
      playerGuesses: [],
      aiGuesses: [],
      isPlayerTurn: true,
      timerActive: false,
      aiPlaybackEnabled: false,
      timerValue: '0',
      timeRemaining: 0,
      isGameOver: false,
      winner: null,
      gameMode: 'hint',
      aiDifficulty: 0,
    );
  }
  
  GameState copyWith({
    String? playerSecretCode,
    String? aiSecretCode,
    List<Guess>? playerGuesses,
    List<Guess>? aiGuesses,
    bool? isPlayerTurn,
    bool? timerActive,
    bool? aiPlaybackEnabled,
    String? timerValue,
    int? timeRemaining,
    bool? isGameOver,
    String? winner,
    String? gameMode,
    int? aiDifficulty,
  }) {
    return GameState(
      playerSecretCode: playerSecretCode ?? this.playerSecretCode,
      aiSecretCode: aiSecretCode ?? this.aiSecretCode,
      playerGuesses: playerGuesses ?? this.playerGuesses,
      aiGuesses: aiGuesses ?? this.aiGuesses,
      isPlayerTurn: isPlayerTurn ?? this.isPlayerTurn,
      timerActive: timerActive ?? this.timerActive,
      aiPlaybackEnabled: aiPlaybackEnabled ?? this.aiPlaybackEnabled,
      timerValue: timerValue ?? this.timerValue,
      timeRemaining: timeRemaining ?? this.timeRemaining,
      isGameOver: isGameOver ?? this.isGameOver,
      winner: winner ?? this.winner,
      gameMode: gameMode ?? this.gameMode,
      aiDifficulty: aiDifficulty ?? this.aiDifficulty,
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'playerSecretCode': playerSecretCode,
      'aiSecretCode': aiSecretCode,
      'playerGuesses': playerGuesses.map((g) => g.toJson()).toList(),
      'aiGuesses': aiGuesses.map((g) => g.toJson()).toList(),
      'isPlayerTurn': isPlayerTurn,
      'timerActive': timerActive,
      'aiPlaybackEnabled': aiPlaybackEnabled,
      'timerValue': timerValue,
      'timeRemaining': timeRemaining,
      'isGameOver': isGameOver,
      'winner': winner,
      'gameMode': gameMode,
      'aiDifficulty': aiDifficulty,
    };
  }
  
  factory GameState.fromJson(Map<String, dynamic> json) {
    return GameState(
      playerSecretCode: json['playerSecretCode'] as String,
      aiSecretCode: json['aiSecretCode'] as String,
      playerGuesses: (json['playerGuesses'] as List)
          .map((g) => Guess.fromJson(g as Map<String, dynamic>))
          .toList(),
      aiGuesses: (json['aiGuesses'] as List)
          .map((g) => Guess.fromJson(g as Map<String, dynamic>))
          .toList(),
      isPlayerTurn: json['isPlayerTurn'] as bool,
      timerActive: json['timerActive'] as bool,
      aiPlaybackEnabled: json['aiPlaybackEnabled'] as bool,
      timerValue: json['timerValue'] as String,
      timeRemaining: json['timeRemaining'] as int,
      isGameOver: json['isGameOver'] as bool,
      winner: json['winner'] as String?,
      gameMode: json['gameMode'] as String,
      aiDifficulty: json['aiDifficulty'] as int,
    );
  }
}