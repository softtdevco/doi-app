import 'package:doi_mobile/core/utils/colors.dart';
import 'package:doi_mobile/presentation/features/dashboard/home/presentation/pages/widgets/bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LeaderboardSwitch extends StatefulWidget {
  final void Function(int)? onChanged;
  final int index;

  const LeaderboardSwitch({
    super.key,
    this.onChanged,
    this.index = 0,
  });
  @override
  State<LeaderboardSwitch> createState() => _LeaderboardSwitchState();
}

class _LeaderboardSwitchState extends State<LeaderboardSwitch> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: widget.index == 1 ? AppColors.lightGreen : AppColors.indicator,
        borderRadius: BorderRadius.circular(30.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,

        
        children: [
          Expanded(
            child: Bar(
              color: widget.index == 1
                  ? AppColors.greenText
                  : AppColors.secondaryColor,
              isSelected: widget.index == 0,
              text: 'Lagos',
              onTap: () => widget.onChanged!(0),
            ),
          ),
          Expanded(
            child: Bar(
                color: widget.index == 1
                    ? AppColors.greenText
                    : AppColors.secondaryColor,
                isSelected: widget.index == 1,
                text: 'Nigeria',
                onTap: () {
                  widget.onChanged!(1);
                }),
          ),
          Expanded(
            child: Bar(
                color: widget.index == 1
                    ? AppColors.greenText
                    : AppColors.secondaryColor,
                isSelected: widget.index == 2,
                text: 'Global',
                onTap: () {
                  widget.onChanged!(2);
                }),
          ),
        ],
      ),
    );
  }
}
