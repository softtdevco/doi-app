import 'package:doi_mobile/core/extensions/navigation_extensions.dart';
import 'package:doi_mobile/core/extensions/texttheme_extensions.dart';
import 'package:doi_mobile/gen/assets.gen.dart';
import 'package:doi_mobile/presentation/features/dashboard/widgets/nav_bar.dart';
import 'package:doi_mobile/presentation/general_widgets/doi_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LockTournamentPop extends ConsumerStatefulWidget {
  const LockTournamentPop({super.key});

  @override
  ConsumerState<LockTournamentPop> createState() => _LockTournamentPopState();
}

class _LockTournamentPopState extends ConsumerState<LockTournamentPop> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 44.0,
        vertical: 36,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Assets.images.productLocked.image(
            height: 206.h,
            width: 206.w,
          ),
          33.verticalSpace,
          Text(
            'Reach 1,000 XP playing to unlock Tournaments',
            style: context.textTheme.bodySmall?.copyWith(
              fontSize: 16.sp,
            ),
            textAlign: TextAlign.center,
          ),
          55.verticalSpace,
          DoiButton(
            text: 'Okay',
            //isEnabled: isEnabled,
            onPressed: () {
              context.pop();
              ref.read(currentIndexProvider.notifier).state = 0;
            },
          ),
        ],
      ),
    );
  }
}

class DailyLockPop extends ConsumerStatefulWidget {
  const DailyLockPop({super.key});

  @override
  ConsumerState<DailyLockPop> createState() => _DailyLockPopState();
}

class _DailyLockPopState extends ConsumerState<DailyLockPop> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 44.0,
        vertical: 36,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Assets.images.productLocked.image(
            height: 206.h,
            width: 206.w,
          ),
          33.verticalSpace,
          Text(
            'Reach 1,000 XP playing to unlock Daily Rewards',
            style: context.textTheme.bodySmall?.copyWith(
              fontSize: 16.sp,
            ),
            textAlign: TextAlign.center,
          ),
          55.verticalSpace,
          DoiButton(
            text: 'Okay',
            //isEnabled: isEnabled,
            onPressed: () {
              context.pop();
            },
          ),
        ],
      ),
    );
  }
}
