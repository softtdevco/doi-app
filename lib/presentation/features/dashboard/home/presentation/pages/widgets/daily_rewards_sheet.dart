import 'package:doi_mobile/core/extensions/navigation_extensions.dart';
import 'package:doi_mobile/core/extensions/texttheme_extensions.dart';
import 'package:doi_mobile/core/utils/colors.dart';
import 'package:doi_mobile/gen/assets.gen.dart';
import 'package:doi_mobile/gen/fonts.gen.dart';
import 'package:doi_mobile/presentation/features/dashboard/home/presentation/pages/widgets/daily_progress_tile.dart';
import 'package:doi_mobile/presentation/general_widgets/doi_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DailyRewardsSheet extends ConsumerStatefulWidget {
  const DailyRewardsSheet({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<DailyRewardsSheet> createState() => _DailyRewardsSheetState();
}

class _DailyRewardsSheetState extends ConsumerState<DailyRewardsSheet> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(32, 16, 32, 36),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 28.w,
              height: 3.h,
              decoration: BoxDecoration(
                  color: Color(0xFFD7A07D),
                  borderRadius: BorderRadius.circular(8.r)),
            ),
            18.verticalSpace,
            Assets.images.dailyReward.image(),
            11.verticalSpace,
            Text(
              'Day 4',
              style: context.textTheme.bodyMedium?.copyWith(
                fontSize: 24.sp,
                color: AppColors.secondaryColor,
                fontFamily: FontFamily.jungleAdventurer,
              ),
            ),
            4.verticalSpace,
            Text(
              'You\'re on fire! Just 3 more days to hit a 7-day streak and claim your next reward. Keep going!',
              style: context.textTheme.bodySmall?.copyWith(
                fontSize: 14.sp,
                color: AppColors.primaryColor,
              ),
              textAlign: TextAlign.center,
            ),
            23.verticalSpace,
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                spacing: 10.w,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(
                  7,
                  (i) => DayProgressTile(
                    day: i + 1,
                    isCompleted: i < 3,
                    isCurrentDay: i == 3,
                  ),
                ),
              ),
            ),
            44.verticalSpace,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 22.w),
              child: DoiButton(
                text: 'Claim',
                //isEnabled: isEnabled,
                onPressed: () {
                  context.pop();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
