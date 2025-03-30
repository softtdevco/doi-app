import 'package:doi_mobile/core/extensions/texttheme_extensions.dart';
import 'package:doi_mobile/core/utils/colors.dart';
import 'package:doi_mobile/gen/assets.gen.dart';
import 'package:doi_mobile/presentation/features/dashboard/home/presentation/pages/widgets/coin_count.dart';
import 'package:doi_mobile/presentation/general_widgets/doi_appbar.dart';
import 'package:doi_mobile/presentation/general_widgets/doi_button.dart';
import 'package:doi_mobile/presentation/general_widgets/doi_scaffold.dart';
import 'package:doi_mobile/presentation/general_widgets/doi_svg_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PlayOnline extends StatelessWidget {
  const PlayOnline({super.key});

  @override
  Widget build(BuildContext context) {
    return DoiScaffold(
        showBackImage: false,
        bodyPadding: EdgeInsets.all(24),
        backgroundColor: AppColors.background,
        appbar: DoiAppbar(
          title: CoinCount(),
          trailing: AppSvgIcon(path: Assets.svgs.help),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            26.verticalSpace,
            Stack(
              children: [
                DoiButton(
                  text: 'New Match',
                  onPressed: () {},
                  trailing: Assets.svgs.add,
                ),
                Positioned(
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(15.r),
                        child: Assets.images.a1.image())),
                Positioned(child: Assets.images.a2.image()),
                Positioned(right: 0, child: Assets.images.a3.image()),
              ],
            ),
            50.verticalSpace,
            Text(
              'Your Turn',
              style: context.textTheme.bodySmall?.copyWith(
                fontSize: 14.sp,
                color: Color(0XFFD7A07D),
              ),
            ),
            17.verticalSpace,
            Row(
              children: [
                Stack(
                  children: [
                    Assets.images.avatar2.image(),
                  ],
                )
              ],
            )
          ],
        ));
  }
}
