import 'package:doi_mobile/core/extensions/coin_extensions.dart';
import 'package:doi_mobile/core/extensions/texttheme_extensions.dart';
import 'package:doi_mobile/core/extensions/widget_extensions.dart';
import 'package:doi_mobile/core/utils/colors.dart';
import 'package:doi_mobile/gen/assets.gen.dart';
import 'package:doi_mobile/gen/fonts.gen.dart';
import 'package:doi_mobile/presentation/features/dashboard/home/data/repository/game_repository_impl.dart';
import 'package:doi_mobile/presentation/general_widgets/doi_svg_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CoinCount extends ConsumerWidget {
  const CoinCount({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final totalCoins = ref.watch(totalCoinsProvider);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        AppSvgIcon(
          path: Assets.svgs.coin,
          fit: BoxFit.scaleDown,
        ),
        2.horizontalSpace,
        Text(
          totalCoins.formattedCoins(style: CoinFormatStyle.compact),
          style: context.textTheme.bodyMedium?.copyWith(
            color: AppColors.dark,
            fontSize: 20.sp,
            fontFamily: FontFamily.jungleAdventurer,
          ),
        ),
        2.horizontalSpace,
        AppSvgIcon(
          path: Assets.svgs.addCircle,
          fit: BoxFit.scaleDown,
        ),
      ],
    ).withContainer(
      color: AppColors.indicator,
      borderRadius: BorderRadius.circular(15.r),
      padding: EdgeInsets.all(2),
    );
  }
}
