import 'package:doi_mobile/core/utils/colors.dart';
import 'package:doi_mobile/presentation/features/dashboard/home/presentation/pages/widgets/bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StoreSwitch extends StatefulWidget {
  final void Function(int)? onChanged;
  final int index;

  const StoreSwitch({
    super.key,
    this.onChanged,
    this.index = 0,
  });
  @override
  State<StoreSwitch> createState() => _StoreSwitchState();
}

class _StoreSwitchState extends State<StoreSwitch> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.indicator,
        borderRadius: BorderRadius.circular(30.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: Bar(
              color: AppColors.secondaryColor,
              isSelected: widget.index == 0,
              text: 'Special Offers',
              onTap: () => widget.onChanged!(0),
            ),
          ),
          Expanded(
            child: Bar(
                color: AppColors.secondaryColor,
                isSelected: widget.index == 1,
                text: 'Power Ups',
                onTap: () {
                  widget.onChanged!(1);
                }),
          ),
          Expanded(
            child: Bar(
                color: AppColors.secondaryColor,
                isSelected: widget.index == 2,
                text: 'Customisations',
                onTap: () {
                  widget.onChanged!(2);
                }),
          ),
        ],
      ),
    );
  }
}
