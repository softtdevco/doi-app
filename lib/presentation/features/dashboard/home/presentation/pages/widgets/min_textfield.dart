import 'package:doi_mobile/core/extensions/texttheme_extensions.dart';
import 'package:doi_mobile/core/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MinFormField extends StatefulWidget {
  const MinFormField({
    super.key,
    this.textStyle,
    this.width,
    this.labelSpace = 8,
    this.textCapitalization = TextCapitalization.sentences,
    this.onTap,
    this.decoration,
    this.hintStyle,
    this.backgroundColor,
    this.isLoading = false,
    this.readOnly = false,
    this.customLabel,
    this.hintText,
    this.controller,
    this.minLines = 1,
    this.obscureText = false,
    this.enabled = true,
    this.validateFunction,
    this.borderSide,
    this.onSaved,
    this.onChange,
    this.keyboardType,
    this.textInputAction,
    this.focusNode,
    this.nextFocusNode,
    this.submitAction,
    this.enableErrorMessage = true,
    this.maxLines = 1,
    this.onFieldSubmitted,
    this.suffixIcon,
    this.prefixIcon,
    this.bordercolor,
    this.autofocus,
    this.label,
    this.inputFormatters,
    this.borderRadius = 8,
    this.initialValue,
    this.labelSize,
    this.labelColor,
  });
  final double? width;
  final double? labelSize;
  final String? hintText;
  final TextEditingController? controller;
  final int? minLines;
  final int? maxLines;
  final bool? obscureText;
  final bool? enabled;
  final FormFieldValidator<String>? validateFunction;
  final void Function(String)? onSaved;
  final void Function(String)? onChange;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode;
  final FocusNode? nextFocusNode;
  final VoidCallback? submitAction;
  final bool? enableErrorMessage;
  final void Function(String)? onFieldSubmitted;
  final void Function()? onTap;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final Color? bordercolor;
  final Color? backgroundColor;
  final Color? labelColor;
  final bool? autofocus;
  final String? label;
  final InputDecoration? decoration;
  final List<TextInputFormatter>? inputFormatters;
  final bool isLoading;
  final bool readOnly;
  final double borderRadius;
  final double labelSpace;
  final String? initialValue;
  final Widget? customLabel;
  final TextStyle? hintStyle;
  final TextStyle? textStyle;
  final BorderSide? borderSide;

  final TextCapitalization textCapitalization;

  @override
  State<MinFormField> createState() => _MinFormFieldState();
}

class _MinFormFieldState extends State<MinFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textCapitalization: widget.textCapitalization,
      onTap: widget.onTap,
      readOnly: widget.readOnly,
      initialValue: widget.initialValue,
      textAlign: TextAlign.left,
      inputFormatters: widget.inputFormatters,
      autofocus: widget.autofocus ?? false,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      enabled: widget.enabled,
      validator: widget.validateFunction != null
          ? widget.validateFunction!
          : (value) {
              return null;
            },
      onSaved: (val) {
        setState(() {});
        widget.onSaved!(val!);
      },
      onChanged: (val) {
        setState(() {});
        if (widget.onChange != null) widget.onChange!.call(val);
      },
      style: widget.textStyle ??
          context.textTheme.bodySmall?.copyWith(
            fontSize: 14.sp,
            color: AppColors.greenText,
          ),
      cursorColor: AppColors.greenText,
      key: widget.key,
      maxLines: widget.maxLines,
      controller: widget.controller,
      obscureText: widget.obscureText!,
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
      focusNode: widget.focusNode,
      onFieldSubmitted: widget.onFieldSubmitted,
      decoration: widget.decoration ??
          InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 16),
            filled: true,
            fillColor: widget.backgroundColor ?? AppColors.lightGreen,
            prefixIcon: widget.prefixIcon,
            suffixIcon: widget.suffixIcon,
            enabled: false,
            errorStyle: const TextStyle(
              color: AppColors.red,
              fontSize: 12,
            ),
            hintText: widget.hintText,
            hintStyle: widget.hintStyle ??
                context.textTheme.bodySmall?.copyWith(
                  fontSize: 14.sp,
                  color: AppColors.greenText.withValues(alpha: 0.5),
                ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius),
              borderSide: BorderSide(
                color: AppColors.red.withValues(alpha: 0.3),
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius),
              borderSide: BorderSide(
                color: AppColors.red.withValues(alpha: 0.3),
              ),
            ),
            disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(widget.borderRadius),
                borderSide: BorderSide.none),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(widget.borderRadius),
                borderSide: widget.borderSide ?? BorderSide.none),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(widget.borderRadius),
                borderSide:
                    widget.borderSide ?? widget.borderSide ?? BorderSide.none),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius),
              borderSide: widget.borderSide ??
                  const BorderSide(
                    color: AppColors.greenText,
                    width: 2,
                  ),
            ),
          ),
    );
  }
}
