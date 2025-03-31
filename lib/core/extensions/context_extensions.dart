import 'package:doi_mobile/core/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

extension BuildContextExt on BuildContext {
  double get height => MediaQuery.of(this).size.height;

  double get width => MediaQuery.of(this).size.width;

  EdgeInsetsGeometry get bottomPaddingForTextField =>
      EdgeInsets.only(bottom: MediaQuery.of(this).viewInsets.bottom);

  Future<T> showPopUp<T>(
    Widget child, {
    bool? isDismissable,
    double? horizontalPadding,
    double? size,
    Color? color,
  }) async {
    return await showDialog(
        context: this,
        barrierDismissible: isDismissable ?? false,
        builder: (context) {
          return Theme(
            data: ThemeData(
              useMaterial3: true,
              dialogBackgroundColor: color ?? AppColors.background,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Dialog(
                  backgroundColor: color ?? AppColors.background,
                  insetPadding:
                      EdgeInsets.symmetric(horizontal: horizontalPadding ?? 29),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(17),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: color ?? AppColors.background,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: child,
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }

  Future<T?> showBottomSheet<T>({
    required Widget child,
    Color? color,
    bool? isDismissible,
  }) =>
      showModalBottomSheet(
          isScrollControlled: true,
          isDismissible: isDismissible ?? false,
          context: this,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
          ),
          builder: (context) {
            return BackdropFilter(
              filter: ColorFilter.mode(
                Colors.black.withValues(alpha: 0.2),
                BlendMode.srcOver,
              ),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: color ?? AppColors.background,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(16),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: child,
                ),
              ),
            );
          });
}
