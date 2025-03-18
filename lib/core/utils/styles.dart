import 'package:doi_mobile/core/utils/colors.dart';
import 'package:doi_mobile/gen/fonts.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DoiButtonStyle {
  final Color background;
  final Color? textColor;
  final Color borderColor;

  final TextStyle? textStyle;

  ///Button default values
  static const double buttonDefaultHeight = 58.0;
  static const double buttonDefaultWidth = double.infinity;
  static const double badgeDefaultHeight = 20.0;
  static const double badgeDefaultWidth = 46.0;
  static const double buttonCornerRadius = 14.0;
  static const double badgeCornerRadius = 100.0;
  static const double fontSize = 100.0;
  static const bool buttonIsEnable = true;
  static const bool buttonIsLoading = false;

  DoiButtonStyle({
    required this.background,
    this.textColor = Colors.white,
    required this.borderColor,
    this.textStyle,
  });

  factory DoiButtonStyle.primary() = DoiButtonPrimary;

  factory DoiButtonStyle.secondary() = DoiButtonSecondary;
}

class DoiButtonPrimary extends DoiButtonStyle {
  DoiButtonPrimary()
      : super(
          background: AppColors.primaryColor,
          textColor: Colors.white,
          borderColor: AppColors.secondaryColor,
        );
}

class DoiButtonSecondary extends DoiButtonStyle {
  DoiButtonSecondary()
      : super(
          background: AppColors.secondaryBackGround,
          textColor: AppColors.primaryColor,
          borderColor: Colors.transparent,
          textStyle: TextStyle(
            color: AppColors.secondaryColor,
            fontSize: 16.sp,
            fontFamily: FontFamily.rimouski,
          ),
        );
}
