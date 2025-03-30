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
        bodyPadding: EdgeInsets.all(24),
        appbar: DoiAppbar(
          title: CoinCount(),
          trailing: AppSvgIcon(path: Assets.svgs.help),
        ),
        body: Column(
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
          ],
        ));
  }
}
