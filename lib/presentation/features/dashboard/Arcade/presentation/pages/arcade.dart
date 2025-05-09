import 'package:doi_mobile/core/extensions/texttheme_extensions.dart';
import 'package:doi_mobile/core/utils/colors.dart';
import 'package:doi_mobile/gen/assets.gen.dart';
import 'package:doi_mobile/presentation/features/dashboard/home/presentation/pages/widgets/coin_count.dart';
import 'package:doi_mobile/presentation/general_widgets/doi_appbar.dart';
import 'package:doi_mobile/presentation/general_widgets/doi_scaffold.dart';
import 'package:doi_mobile/presentation/general_widgets/doi_svg_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Arcade extends StatelessWidget {
  const Arcade({super.key});

  @override
  Widget build(BuildContext context) {
    return DoiScaffold(
      showBackImage: false,
      bodyPadding: EdgeInsets.symmetric(
        horizontal: 34,
        vertical: 24,
      ),
      backgroundColor: AppColors.background,
      appbar: DoiAppbar(
        title: CoinCount(),
        trailing: AppSvgIcon(path: Assets.svgs.help),
      ),
      body: Column(
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
                  'Reach 1,000 XP playing to unlock Arcade',
                  style: context.textTheme.bodySmall?.copyWith(
                    fontSize: 16.sp,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
