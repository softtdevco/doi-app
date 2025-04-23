import 'package:doi_mobile/core/extensions/texttheme_extensions.dart';
import 'package:doi_mobile/core/utils/colors.dart';
import 'package:doi_mobile/gen/assets.gen.dart';
import 'package:doi_mobile/gen/fonts.gen.dart';
import 'package:doi_mobile/presentation/features/dashboard/home/presentation/pages/widgets/coin_count.dart';
import 'package:doi_mobile/presentation/features/dashboard/store/presenation/notifiers/store_notifiers.dart';
import 'package:doi_mobile/presentation/features/dashboard/store/presenation/pages/widgets/store_app_bar.dart';
import 'package:doi_mobile/presentation/features/dashboard/store/presenation/pages/widgets/store_switch.dart';
import 'package:doi_mobile/presentation/general_widgets/doi_scaffold.dart';
import 'package:doi_mobile/presentation/general_widgets/doi_svg_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Store extends ConsumerStatefulWidget {
  const Store({super.key});

  @override
  ConsumerState<Store> createState() => _StoreState();
}

class _StoreState extends ConsumerState<Store> {
  @override
  Widget build(BuildContext context) {
    final selectedIndex =
        ref.watch(storeNotifierProvider.select((s) => s.switchIndex));
    return DoiScaffold(
        appbar: StoreAppbar(
          title: Text(
            'Store'.toUpperCase(),
            style: context.textTheme.bodyMedium?.copyWith(
              color: AppColors.secondaryColor,
              fontSize: 20.sp,
              fontFamily: FontFamily.jungleAdventurer,
              fontWeight: FontWeight.w400,
            ),
          ),
          trailing: CoinCount(),
        ),
        backgroundColor: AppColors.background,
        showBackImage: false,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            24.verticalSpace,
            StoreSwitch(
              index: selectedIndex,
              onChanged: (v) {
                ref.read(storeNotifierProvider.notifier).selectSwitchIndex(v);
              },
            ),
            24.verticalSpace,
            Text(
              'My Items',
              style: context.textTheme.bodySmall?.copyWith(
                fontSize: 16.sp,
              ),
            ),
            19.verticalSpace,
            Column(
              children: [
                AppSvgIcon(
                  path: Assets.svgs.freezeTime,
                )
              ],
            )
          ],
        ));
  }
}
