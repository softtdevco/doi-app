import 'package:flutter/material.dart';

extension TextThemeExtension on BuildContext {
  TextTheme get textTheme => Theme.of(this).textTheme;
   ColorScheme get colorScheme => Theme.of(this).colorScheme;
}
