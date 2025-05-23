import 'package:doi_mobile/core/extensions/context_extensions.dart';
import 'package:doi_mobile/core/extensions/navigation_extensions.dart';
import 'package:doi_mobile/core/extensions/texttheme_extensions.dart';
import 'package:doi_mobile/core/extensions/widget_extensions.dart';
import 'package:doi_mobile/core/router/router.dart';
import 'package:doi_mobile/core/utils/colors.dart';
import 'package:doi_mobile/gen/assets.gen.dart';
import 'package:doi_mobile/gen/fonts.gen.dart';
import 'package:doi_mobile/presentation/features/dashboard/home/presentation/pages/widgets/coin_count.dart';
import 'package:doi_mobile/presentation/features/profile/presentation/widgets/settings_pop.dart';
import 'package:doi_mobile/presentation/general_widgets/doi_svg_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DoiHomeAppbar extends StatelessWidget implements PreferredSizeWidget {
  const DoiHomeAppbar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 10.h,
        left: 24.w,
        right: 24.w,
        bottom: 0,
      ),
      decoration: const BoxDecoration(color: Colors.transparent),
      width: MediaQuery.sizeOf(context).width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AppSvgIcon(
            path: Assets.svgs.leader,
            fit: BoxFit.scaleDown,
            onTap: () => context.pushNamed(
              AppRouter.leaderBoard,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  AppSvgIcon(
                    path: Assets.svgs.streak,
                    fit: BoxFit.scaleDown,
                  ),
                  2.horizontalSpace,
                  Text(
                    '0',
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: AppColors.dark,
                      fontSize: 20.sp,
                      fontFamily: FontFamily.jungleAdventurer,
                    ),
                  )
                ],
              ).withContainer(
                color: AppColors.indicator,
                borderRadius: BorderRadius.circular(15.r),
                padding: EdgeInsets.symmetric(
                  horizontal: 8.w,
                  vertical: 2.h,
                ),
              ),
              57.horizontalSpace,
              Consumer(builder: (context, r, c) {
                return GestureDetector(
                  // onTap: () {
                  //   _buy(ProductIds.coins);
                  // },
                  onTap: () => context.pushNamed(AppRouter.store),
                  //  onTap: () => context.showPopUp(ChallengePop()),
                  child: CoinCount(),
                );
              }),
            ],
          ),
          AppSvgIcon(
            path: Assets.svgs.settings,
            fit: BoxFit.scaleDown,
            onTap: () {
              context.showPopUp(SettingsPop());
            },
          ),
        ],
      ),
    );
  }

  static final _appBar = AppBar();

  @override
  Size get preferredSize => _appBar.preferredSize;
}
