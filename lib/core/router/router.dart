import 'package:flutter/material.dart';

class AppRouter {
  static const String signUp = '/signup';

  static final Map<String, Widget Function(BuildContext)> _routes = {};

  static Map<String, Widget Function(BuildContext)> get routes => _routes;
}
