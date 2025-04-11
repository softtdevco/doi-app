import 'package:doi_mobile/core/extensions/texttheme_extensions.dart';
import 'package:doi_mobile/core/extensions/widget_extensions.dart';
import 'package:doi_mobile/core/utils/colors.dart';
import 'package:doi_mobile/gen/fonts.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Bar extends StatelessWidget {
  final bool isSelected;
  final String text;
  final VoidCallback? onTap;
  final Color color;

  const Bar({
    super.key,
    required this.isSelected,
    required this.text,
    this.onTap,
    this.color = AppColors.greenText,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        text,
        style: context.textTheme.bodySmall?.copyWith(
          fontSize: 14.sp,
          fontFamily: FontFamily.rimouski,
          color: color,
        ),
        overflow: TextOverflow.ellipsis,
      ).withContainer(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
          borderRadius: BorderRadius.circular(10.r),
          color: switch (isSelected) {
            true => AppColors.white,
            _ => Colors.transparent
          }),
    );
  }
}

class GameBarType extends StatefulWidget {
  final void Function(int)? onChanged;
  final int index;
  final String label1;
  final String label2;
  final Color textColor, cardColor;
  const GameBarType({
    super.key,
    this.onChanged,
    this.index = 0,
    required this.label1,
    required this.label2,
    this.textColor = AppColors.greenText,
    this.cardColor = AppColors.lightGreen,
  });
  @override
  State<GameBarType> createState() => _GameBarTypeState();
}

class _GameBarTypeState extends State<GameBarType> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: widget.cardColor,
        borderRadius: BorderRadius.circular(30.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: Bar(
              color: widget.textColor,
              isSelected: widget.index == 0,
              text: widget.label1,
              onTap: () => widget.onChanged!(0),
            ),
          ),
          Expanded(
            child: Bar(
                color: widget.textColor,
                isSelected: widget.index == 1,
                text: widget.label2,
                onTap: () {
                  widget.onChanged!(1);
                }),
          ),
        ],
      ),
    );
  }
}
