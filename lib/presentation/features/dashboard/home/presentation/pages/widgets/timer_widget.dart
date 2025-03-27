import 'package:doi_mobile/core/extensions/texttheme_extensions.dart';
import 'package:doi_mobile/core/extensions/widget_extensions.dart';
import 'package:doi_mobile/core/utils/colors.dart';
import 'package:doi_mobile/presentation/features/dashboard/home/presentation/notifiers/home_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TimerTile extends ConsumerStatefulWidget {
  const TimerTile({
    super.key,
    required this.min,
    this.onTap,
    this.textColor = AppColors.greenText,
    this.color = AppColors.lightGreen,
  });
  final String min;
  final void Function()? onTap;
  final Color textColor;
  final Color color;

  @override
  ConsumerState<TimerTile> createState() => _TimerTileState();
}

class _TimerTileState extends ConsumerState<TimerTile> {
  @override
  Widget build(BuildContext context) {
    final selectedMin = ref.watch(homeNotifierProvider.select((v) => v.timer));
    return GestureDetector(
      onTap: widget.onTap,
      child: Text(
        widget.min,
        style: context.textTheme.bodySmall?.copyWith(
          fontSize: 14.sp,
          color: widget.textColor,
        ),
      ).withContainer(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          color: widget.color,
          borderRadius: BorderRadius.circular(
            10.r,
          ),
          border: switch (selectedMin == widget.min) {
            true => Border.all(
                width: 2,
                color: widget.textColor,
              ),
            _ => null
          }),
    );
  }
}
