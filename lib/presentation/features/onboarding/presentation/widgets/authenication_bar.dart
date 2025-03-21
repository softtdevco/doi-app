import 'package:doi_mobile/core/extensions/widget_extensions.dart';
import 'package:doi_mobile/core/utils/colors.dart';
import 'package:doi_mobile/presentation/features/dashboard/home/presentation/pages/widgets/bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AuthenicationBarType extends StatefulWidget {
  final void Function(int)? onChanged;
  final int index;
  final String label1;
  final String label2;
  const AuthenicationBarType({
    super.key,
    this.onChanged,
    this.index = 0,
    required this.label1,
    required this.label2,
  });
  @override
  State<AuthenicationBarType> createState() => _AuthenicationBarTypeState();
}

class _AuthenicationBarTypeState extends State<AuthenicationBarType> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 34,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.indicator,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: Bar(
              isSelected: widget.index == 0,
              text: widget.label1,
              color: AppColors.darkShadeOrange,
              onTap: () => widget.onChanged!(0),
            ),
          ),
          Expanded(
            child: Bar(
               color: AppColors.darkShadeOrange,
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
