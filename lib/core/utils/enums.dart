// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

enum LoadState { loading, idle, success, error, loadmore, done }

enum LoginLoadState { loading, idle, success, error, unverified }

enum CurrentState { loggedIn, onboarded, initial }

enum OverLayType { loader, message, none }

enum MessageType { error, success }

enum HomeSessionState { logout, initial }

enum Currency { NGN, USD }

extension LoadExtension on LoadState {
  bool get isLoading => this == LoadState.loading;
  bool get isLoaded => this == LoadState.success;
  bool get isError => this == LoadState.error;
  bool get isInitial => this == LoadState.idle;
  bool get isLoadMore => this == LoadState.loadmore;
  bool get isCompleted => this == LoadState.done;
}

enum LocationPermissionStatus {
  denied,
  deniedForever,
  whileInUse,
  always,
  unableToDetermine,
  initial
}

enum Language {
  english(name: 'English', locale: Locale('en')),
  german(name: 'German', locale: Locale('de')),
  french(name: 'French', locale: Locale('fr'));

  const Language({required this.name, required this.locale});
  final String name;
  final Locale locale;
}

enum GameStatus {
  playerTurn,
  aiTurn,
  playerWon,
  aiWon,
  draw,
  timeUp,
}
