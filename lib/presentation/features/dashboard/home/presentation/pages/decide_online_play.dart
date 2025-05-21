import 'package:doi_mobile/core/extensions/context_extensions.dart';
import 'package:doi_mobile/core/extensions/navigation_extensions.dart';
import 'package:doi_mobile/core/extensions/texttheme_extensions.dart';
import 'package:doi_mobile/core/extensions/widget_extensions.dart';
import 'package:doi_mobile/core/router/router.dart';
import 'package:doi_mobile/core/utils/colors.dart';
import 'package:doi_mobile/gen/assets.gen.dart';
import 'package:doi_mobile/gen/fonts.gen.dart';
import 'package:doi_mobile/l10n/l10n.dart';
import 'package:doi_mobile/presentation/features/dashboard/home/presentation/pages/widgets/coin_count.dart';
import 'package:doi_mobile/presentation/features/dashboard/home/presentation/pages/widgets/create_game.dart';
import 'package:doi_mobile/presentation/general_widgets/banner_ads_widget.dart';
import 'package:doi_mobile/presentation/general_widgets/doi_appbar.dart';
import 'package:doi_mobile/presentation/general_widgets/doi_scaffold.dart';
import 'package:doi_mobile/presentation/general_widgets/doi_svg_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DecideOnlinePlay extends StatelessWidget {
  const DecideOnlinePlay({super.key});

  @override
  Widget build(BuildContext context) {
    return DoiScaffold(
      bodyPadding: EdgeInsets.symmetric(horizontal: 30),
      appbar: DoiAppbar(
        title: CoinCount(),
        trailing: Visibility(
            visible: false, child: AppSvgIcon(path: Assets.svgs.help)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            39.verticalSpace,
            Text(
              'How do you want to play?',
              style: context.textTheme.bodySmall,
            ),
            32.verticalSpace,
            GestureDetector(
              onTap: () => context.showBottomSheet(
                isDismissible: true,
                color: AppColors.background,
                child: CreateGame(),
              ),
              child: Column(
                children: [
                  AppSvgIcon(path: Assets.svgs.welcome),
                  Container(
                    padding: EdgeInsets.all(17),
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(12.r),
                        bottomRight: Radius.circular(12.r),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.secondaryColor,
                          offset: const Offset(0, 5),
                          blurRadius: 0,
                          spreadRadius: 0,
                        ),
                      ],
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      'Play with friends'.toUpperCase(),
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: AppColors.white,
                        fontFamily: FontFamily.jungleAdventurer,
                        fontSize: 22.sp,
                      ),
                    ),
                  )
                ],
              ).withContainer(
                borderRadius: BorderRadius.circular(12.r),
                color: Color(0xFFFFF0E6),
                border: Border(
                  top: BorderSide(
                    color: AppColors.primaryColor,
                  ),
                  left: BorderSide(
                    color: AppColors.primaryColor,
                  ),
                  right: BorderSide(
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
            ),
            31.verticalSpace,
            Text(
              context.l10n.or,
              style: context.textTheme.bodyMedium?.copyWith(
                fontFamily: FontFamily.jungleAdventurer,
                color: AppColors.secondaryColor,
                fontSize: 24.sp,
              ),
            ),
            31.verticalSpace,
            GestureDetector(
              onTap: () => context.pushNamed(AppRouter.playOnline),
              child: Column(
                children: [
                  AppSvgIcon(path: Assets.svgs.mapConnect),
                  Container(
                    padding: EdgeInsets.all(17),
                    decoration: BoxDecoration(
                      color: AppColors.green,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(12.r),
                        bottomRight: Radius.circular(12.r),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.greenBorder,
                          offset: const Offset(0, 5),
                          blurRadius: 0,
                          spreadRadius: 0,
                        ),
                      ],
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      'Play online'.toUpperCase(),
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: AppColors.white,
                        fontFamily: FontFamily.jungleAdventurer,
                        fontSize: 22.sp,
                      ),
                    ),
                  )
                ],
              ).withContainer(
                borderRadius: BorderRadius.circular(12.r),
                color: Color(0xFFF4FFDF),
                border: Border(
                  top: BorderSide(
                    color: AppColors.green,
                  ),
                  left: BorderSide(
                    color: AppColors.green,
                  ),
                  right: BorderSide(
                    color: AppColors.green,
                  ),
                ),
              ),
            ),
            //const Spacer(),
          ],
        ),
      ),
      footerButton: Center(child: BannerAdWidget()),
    );
  }
}
