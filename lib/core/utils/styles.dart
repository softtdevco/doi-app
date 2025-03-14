import 'package:doi_mobile/core/utils/colors.dart';
import 'package:flutter/material.dart';


class RouteAiButtonStyle {
  final Color background;
  final Color textColor;
  final Color borderColor;
  final Color disabledBackgroundColor;
  final Color disabledTextColor;
  final TextStyle? textStyle;

  ///Button default values
  static const double buttonDefaultHeight = 50.0;
  static const double buttonDefaultWidth = double.infinity;
  static const double badgeDefaultHeight = 20.0;
  static const double badgeDefaultWidth = 46.0;
  static const double buttonCornerRadius = 8.0;
  static const double badgeCornerRadius = 100.0;
  static const bool buttonIsEnable = true;
  static const bool buttonIsLoading = false;

  RouteAiButtonStyle({
    required this.background,
    required this.textColor,
    required this.borderColor,
    required this.disabledBackgroundColor,
    required this.disabledTextColor,
    this.textStyle,
  });

  factory RouteAiButtonStyle.primary() = RouteAiButtonPrimary;

  factory RouteAiButtonStyle.secondary() = RouteAiButtonSecondary;
}

class RouteAiButtonPrimary extends RouteAiButtonStyle {
  RouteAiButtonPrimary()
      : super(
          background: AppColors.primaryColor,
          disabledBackgroundColor: AppColors.fill,
          textColor: Colors.white,
          disabledTextColor: AppColors.white,
          borderColor: Colors.transparent,
        );
}

class RouteAiButtonSecondary extends RouteAiButtonStyle {
  RouteAiButtonSecondary()
      : super(
          background: AppColors.white,
          disabledBackgroundColor: AppColors.fill,
          textColor: AppColors.primaryColor,
          disabledTextColor: AppColors.grey,
          borderColor: AppColors.primaryColor,
        );
}
