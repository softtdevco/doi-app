import 'package:doi_mobile/core/utils/colors.dart';
import 'package:doi_mobile/presentation/features/dashboard/home/presentation/pages/widgets/bar.dart';
import 'package:doi_mobile/presentation/features/profile/data/repository/user_repository_impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LeaderboardSwitch extends ConsumerStatefulWidget {
  final void Function(int)? onChanged;
  final int index;

  const LeaderboardSwitch({
    super.key,
    this.onChanged,
    this.index = 0,
  });
  @override
  ConsumerState<LeaderboardSwitch> createState() => _LeaderboardSwitchState();
}

class _LeaderboardSwitchState extends ConsumerState<LeaderboardSwitch> {
  @override
  Widget build(BuildContext context) {
    final user = ref.watch(currentUserProvider);
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
              text: 'USA',
              onTap: () => widget.onChanged!(0),
            ),
          ),
          Expanded(
            child: Bar(
                color: widget.index == 1
                    ? AppColors.greenText
                    : AppColors.secondaryColor,
                isSelected: widget.index == 1,
                text: user.country ?? '',
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
