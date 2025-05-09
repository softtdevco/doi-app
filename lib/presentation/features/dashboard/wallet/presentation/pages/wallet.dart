import 'package:doi_mobile/core/extensions/texttheme_extensions.dart';
import 'package:doi_mobile/gen/assets.gen.dart';
import 'package:doi_mobile/presentation/features/dashboard/home/presentation/pages/widgets/home_appbar.dart';
import 'package:doi_mobile/presentation/general_widgets/doi_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Wallet extends StatelessWidget {
  const Wallet({super.key});

  @override
  Widget build(BuildContext context) {
    return DoiScaffold(
      appbar: DoiHomeAppbar(),
      bodyPadding: EdgeInsets.symmetric(
        horizontal: 34.w,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Column(
              children: [
                79.verticalSpace,
                Assets.images.productLocked.image(
                  height: 206.h,
                  width: 206.w,
                ),
                33.verticalSpace,
                Text(
                  'Reach 1,000 XP playing to unlock Rewards',
                  style: context.textTheme.bodySmall?.copyWith(
                    fontSize: 16.sp,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
