import 'package:doi_mobile/core/utils/colors.dart';
import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static ThemeData lightTheme = _themeData(_lightColorScheme);

  static ThemeData darkTheme = _themeData(_darkColorScheme);

  static _themeData(ColorScheme colorScheme) => ThemeData(
        appBarTheme: _appBarTheme(colorScheme),
        brightness: colorScheme.brightness,
        scaffoldBackgroundColor: Colors.white,
        iconTheme: _iconThemeData(colorScheme),
        colorScheme: colorScheme,
        textTheme: _textTheme(colorScheme),
      );

  static final ColorScheme _lightColorScheme =
      const ColorScheme.light().copyWith(
    primary: AppColors.primaryColor,
    secondary: AppColors.secondaryColor,
    onPrimary: AppColors.onPrimary,
  );

  static final ColorScheme _darkColorScheme = const ColorScheme.dark().copyWith(
    primary: AppColors.primaryColor,
    secondary: AppColors.onPrimary,
  );

  static AppBarTheme _appBarTheme(ColorScheme colorScheme) => AppBarTheme(
        color: colorScheme.onSurface,
      );

  static IconThemeData _iconThemeData(ColorScheme colorScheme) =>
      IconThemeData(color: colorScheme.onPrimary);

  static TextTheme _textTheme(ColorScheme colorScheme) => TextTheme(
        bodySmall: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w700,
          color: colorScheme.onSurface,
        ),
      );
}
