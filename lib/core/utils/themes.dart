import 'package:doi_mobile/core/utils/colors.dart';
import 'package:doi_mobile/gen/fonts.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTheme {
  AppTheme._();

  static ThemeData lightTheme = _themeData(_lightColorScheme);

  static ThemeData darkTheme = _themeData(_darkColorScheme);

  static _themeData(ColorScheme colorScheme) => ThemeData(
        appBarTheme: _appBarTheme(colorScheme),
        brightness: colorScheme.brightness,
        scaffoldBackgroundColor: AppColors.background,
        iconTheme: _iconThemeData(colorScheme),
        colorScheme: colorScheme,
        textTheme: _textTheme(colorScheme),
      );

  static final ColorScheme _lightColorScheme =
      const ColorScheme.light().copyWith(
    primary: AppColors.primaryColor,
    secondary: AppColors.secondaryColor,
    onPrimary: AppColors.onPrimary,
    surface: AppColors.white,
  );

  static final ColorScheme _darkColorScheme = const ColorScheme.dark().copyWith(
    primary: AppColors.primaryColor,
    secondary: AppColors.secondaryColor,
    onPrimary: AppColors.onPrimary,
    surface: AppColors.black,
  );

  static AppBarTheme _appBarTheme(ColorScheme colorScheme) => AppBarTheme(
        color: colorScheme.onSurface,
      );

  static IconThemeData _iconThemeData(ColorScheme colorScheme) =>
      IconThemeData(color: colorScheme.onPrimary);

  static TextTheme _textTheme(ColorScheme colorScheme) => TextTheme(
        bodyMedium: TextStyle(
          fontSize: 22.sp,
          fontWeight: FontWeight.w400,
          color: AppColors.white,
          fontFamily: FontFamily.jungleAdventurer,
        ),
        titleSmall: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.w600,
          color: colorScheme.secondary,
          fontFamily: FontFamily.jura,
        ),
        bodySmall: TextStyle(
          fontSize: 20.sp,
          fontWeight: FontWeight.w600,
          color: colorScheme.secondary,
          fontFamily: FontFamily.rimouski,
        ),
        bodyLarge: TextStyle(
          fontSize: 22.sp,
          fontWeight: FontWeight.w600,
          color: AppColors.white,
          fontFamily: FontFamily.oswald,
        ),
      );
}
