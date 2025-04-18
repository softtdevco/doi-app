import 'package:doi_mobile/core/extensions/texttheme_extensions.dart';
import 'package:doi_mobile/core/extensions/widget_extensions.dart';
import 'package:doi_mobile/core/utils/colors.dart';
import 'package:doi_mobile/core/utils/styles.dart';
import 'package:doi_mobile/gen/fonts.gen.dart';
import 'package:doi_mobile/presentation/general_widgets/app_loader.dart';
import 'package:doi_mobile/presentation/general_widgets/doi_svg_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// A custom Doi button. This was built to adapt to the our in-house button style.
/// Works similarly to default flutter button except for its aesthetic changes.
/// It currently support various DoiButtonStyles
/// [DoiButtonStyle.primary],
/// [DoiButtonStyle.secondary],
/// which primarily decides the background and foreground colors of the buttons only.
/// Its represented by various states such as *isEnabled* which alters the state of the button
/// view and also disable it click action, similar to the *isLoading* which enables the loading view of the button.
/// ### Params
/// * [text] - represents the text to show in the button
/// * [height] - default button height
/// * [width] - default button width
/// * [isEnabled] - determines whether button should be clickable, invoke callback or not. Can also be use to modify
/// how button view reacts to click events and UI changes.
/// * [isLoading] - determines whether button should show loading state or not
/// * [buttonStyle] - can be use to determine the style applied to button as mentioned above
/// * [onPressed] - a simple callback that gets triggered when button is pressed
///

class DoiButton extends StatefulWidget {
  final String text;
  final double height;
  final double width;
  final double cornerRadius;
  final bool isEnabled;
  final bool isLoading;
  final bool? isOutline;
  final Color? color;
  final Color? borderColor;
  final DoiButtonStyle? buttonStyle;
  final TextStyle? textStyle;

  final VoidCallback onPressed;
  final String? leading;
  final String? trailing;
  const DoiButton({
    this.height = DoiButtonStyle.buttonDefaultHeight,
    this.width = DoiButtonStyle.buttonDefaultWidth,
    this.isLoading = DoiButtonStyle.buttonIsLoading,
    this.isEnabled = DoiButtonStyle.buttonIsEnable,
    this.cornerRadius = DoiButtonStyle.buttonCornerRadius,
    this.buttonStyle,
    required this.text,
    required this.onPressed,
    this.leading,
    this.trailing,
    this.textStyle,
    this.color,
    this.borderColor,
    this.isOutline,
    Key? key,
  }) : super(key: key);

  @override
  State<DoiButton> createState() => _DoiButton();
}

class _DoiButton extends State<DoiButton> {
  bool isClicked = false;
  late DoiButtonStyle _buttonStyle;

  @override
  void initState() {
    _buttonStyle = widget.buttonStyle ?? DoiButtonStyle.primary();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant DoiButton oldWidget) {
    _buttonStyle = widget.buttonStyle ?? DoiButtonStyle.primary();
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: isActive() ? widget.onPressed : null,
        child: Container(
          alignment: Alignment.center,
          height: widget.height,
          width: widget.width,
          decoration: BoxDecoration(
            border: (widget.isOutline == true)
                ? DoiButtonStyle.outline().border
                : Border.all(color: Colors.transparent),
            boxShadow: (widget.isOutline == true)
                ? []
                : [
                    BoxShadow(
                      color: widget.borderColor ?? _buttonStyle.borderColor,
                      offset: const Offset(0, 5),
                      blurRadius: 0,
                      spreadRadius: 0,
                    ),
                  ],
            borderRadius: BorderRadius.circular(widget.cornerRadius),
            color: widget.color ?? _buttonStyle.background,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (!widget.isLoading)
                FittedBox(
                    child: Row(
                  children: [
                    if (widget.leading != null) ...[
                      AppSvgIcon(
                        path: widget.leading!,
                        fit: BoxFit.scaleDown,
                      ).withContainer(
                          width: 32.w,
                          height: 32.h,
                          color: AppColors.white,
                          shape: BoxShape.circle,
                          border: Border.all(
                            width: 1.86,
                            color: AppColors.iconBorder,
                          )),
                      5.horizontalSpace
                    ],
                    Text(widget.text,
                        style: widget.textStyle ??
                            _buttonStyle.textStyle ??
                            context.textTheme.bodyMedium?.copyWith(
                              color: _buttonStyle.textColor,
                              fontFamily: FontFamily.jungleAdventurer,
                              fontSize: 22.sp,
                            )),
                    if (widget.trailing != null) ...[
                      10.horizontalSpace,
                      AppSvgIcon(
                        path: widget.trailing!,
                        fit: BoxFit.scaleDown,
                      ),
                    ],
                  ],
                )),
              if (widget.isLoading) ...[
                const AppLoader(
                  color: AppColors.white,
                )
              ],
            ],
          ),
        ));
  }

  bool isActive() => widget.isEnabled
      ? widget.isLoading
          ? false
          : true
      : false;
}
