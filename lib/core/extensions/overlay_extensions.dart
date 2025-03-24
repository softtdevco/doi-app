import 'package:doi_mobile/presentation/general_widgets/app_overlay.dart';
import 'package:flutter/material.dart';

extension AppOverLayExt on BuildContext {
  void showLoading({Color color = Colors.white}) =>
      AppOverLay.of(this).controller.showLoader(color: color);
  void hideOverLay() => AppOverLay.of(this).controller.removeOverLay();

  void showError({
    required String message,
    String? title,
  }) {
    return AppOverLay.of(this)
        .controller
        .showError(message: message);
  }

  void showSuccess({
    required String message,
    String? title,
  }) {
    return AppOverLay.of(this)
        .controller
        .showSuccess(message: message);
  }
}
