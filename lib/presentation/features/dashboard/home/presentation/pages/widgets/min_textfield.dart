import 'package:doi_mobile/core/extensions/texttheme_extensions.dart';
import 'package:doi_mobile/core/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MinFormField extends StatefulWidget {
  const MinFormField(
      {super.key,
      this.textStyle,
      this.width = 157,
      this.height = 68,
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
      this.cursorColor,
      this.textAlign});
  final double? width;
  final double? height;
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
  final bool enableErrorMessage;
  final void Function(String)? onFieldSubmitted;
  final void Function()? onTap;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final Color? bordercolor;
  final Color? backgroundColor;
  final Color? labelColor;
  final Color? cursorColor;
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
  final TextAlign? textAlign;
  final TextCapitalization textCapitalization;

  @override
  State<MinFormField> createState() => _MinFormFieldState();
}

class _MinFormFieldState extends State<MinFormField> {
  String? error;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: widget.width,
          child: TextFormField(
            textCapitalization: widget.textCapitalization,
            onTap: widget.onTap,
            readOnly: widget.readOnly,
            initialValue: widget.initialValue,
            textAlign: widget.textAlign ?? TextAlign.center,
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
              widget.validateFunction != null
                  ? error = widget.validateFunction!(val)
                  : error = null;
              setState(() {});

              if (widget.onSaved != null) widget.onSaved!.call(val!);
            },
            onChanged: (val) {
              widget.validateFunction != null
                  ? error = widget.validateFunction!(val)
                  : error = null;
              setState(() {});
              if (widget.onChange != null) widget.onChange!.call(val);
            },
            style: widget.textStyle ??
                context.textTheme.bodySmall?.copyWith(
                  fontSize: 14.sp,
                  color: widget.cursorColor ?? AppColors.greenText,
                ),
            cursorColor: widget.cursorColor ?? AppColors.greenText,
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
                  errorStyle: const TextStyle(fontSize: 0, height: -30),
                  hintText: widget.hintText,
                  hintStyle: widget.hintStyle ??
                      context.textTheme.bodySmall!.copyWith(
                        fontSize: 20.sp,
                        color: AppColors.greenText.withValues(alpha: 0.5),
                      ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: widget.bordercolor ?? AppColors.greenBorder,
                      width: 2,
                    ),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: widget.bordercolor ?? AppColors.greenBorder,
                      width: 2,
                    ),
                  ),
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: widget.bordercolor ?? AppColors.greenBorder,
                      width: 2,
                    ),
                  ),
                ),
          ),
        ),
        if (widget.enableErrorMessage) ...[
          if (error != null)
            SizedBox(
              height: 5.h,
            ),
          if (error != null)
            Text(
              error!,
              style: context.textTheme.bodySmall?.copyWith(
                fontSize: 14.sp,
                color: AppColors.errorText,
              ),
            ),
        ]
      ],
    );
  }
}
