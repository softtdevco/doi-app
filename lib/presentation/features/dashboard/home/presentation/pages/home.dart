import 'package:doi_mobile/core/extensions/context_extensions.dart';
import 'package:doi_mobile/core/extensions/texttheme_extensions.dart';
import 'package:doi_mobile/core/utils/colors.dart';
import 'package:doi_mobile/core/utils/styles.dart';
import 'package:doi_mobile/gen/assets.gen.dart';
import 'package:doi_mobile/l10n/l10n.dart';
import 'package:doi_mobile/presentation/features/dashboard/home/presentation/pages/widgets/home_appbar.dart';
import 'package:doi_mobile/presentation/features/dashboard/home/presentation/pages/widgets/start_game.dart';
import 'package:doi_mobile/presentation/general_widgets/doi_button.dart';
import 'package:doi_mobile/presentation/general_widgets/doi_scaffold.dart';
import 'package:doi_mobile/presentation/general_widgets/game_paused.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late DraggableScrollableController dragScrollController;

  @override
  void initState() {
    super.initState();

    dragScrollController = DraggableScrollableController()..addListener(() {});
  }

  @override
  Widget build(BuildContext context) {
    return DoiScaffold(
      appbar: DoiHomeAppbar(),
      bodyPadding: EdgeInsets.all(24),
      body: Column(
        children: [
          24.verticalSpace,
          Assets.images.doi.image(
            fit: BoxFit.cover,
            width: 86.w,
          ),
          16.verticalSpace,
          Text(
            context.l10n.startNew,
            style: context.textTheme.bodySmall?.copyWith(
              fontSize: 16.sp,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                44.verticalSpace,
                DoiButton(
                  text: context.l10n.newGame,
                  onPressed: () {
                                },
                ),
                16.verticalSpace,
                DoiButton(
                  buttonStyle: DoiButtonStyle(
                    background: AppColors.green,
                    borderColor: AppColors.greenBorder,
                  ),
                  text: context.l10n.singlePlayer,
                  onPressed: () => context.showBottomSheet(
                    color: AppColors.white,
                    child: StartGame(),
                  ),
                ),
                16.verticalSpace,
                DoiButton(
                  text: context.l10n.storyMode,
                  onPressed: () {},
                ),
              ],
            ),
          ),
          89.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                context.l10n.powerUps,
                style: context.textTheme.bodySmall?.copyWith(
                  fontSize: 16.sp,
                ),
              ),
              Text(
                context.l10n.store,
                style: context.textTheme.bodySmall?.copyWith(
                  fontSize: 16.sp,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
