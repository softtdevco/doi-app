import 'package:doi_mobile/core/extensions/navigation_extensions.dart';
import 'package:doi_mobile/core/extensions/texttheme_extensions.dart';
import 'package:doi_mobile/core/extensions/widget_extensions.dart';
import 'package:doi_mobile/core/router/router.dart';
import 'package:doi_mobile/core/utils/colors.dart';
import 'package:doi_mobile/gen/assets.gen.dart';
import 'package:doi_mobile/gen/fonts.gen.dart';
import 'package:doi_mobile/presentation/features/dashboard/home/presentation/notifiers/game_notifier.dart';
import 'package:doi_mobile/presentation/features/dashboard/onlineGame/presentation/notifiers/online_game_notifier.dart';
import 'package:doi_mobile/presentation/general_widgets/doi_svg_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ForfietPop extends ConsumerStatefulWidget {
  const ForfietPop({
    super.key,
    required this.isOnline,
    this.fromIsPaused = true,
  });
  final bool isOnline;
  final bool fromIsPaused;
  @override
  ConsumerState<ForfietPop> createState() => _ForfietPopState();
}

class _ForfietPopState extends ConsumerState<ForfietPop> {
  void popAndReset() {
    context.pop();
    if (widget.isOnline) {
      ref.read(onlineGameNotifierProvider.notifier).toggleTimer();
    } else {
      ref.read(gameNotifierProvider.notifier).toggleTimer();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                child: Center(
                    child: Text(
              'Forfeit game',
              style: context.textTheme.bodyMedium!.copyWith(
                fontFamily: FontFamily.jungleAdventurer,
                fontSize: 24.sp,
                color: AppColors.darkShadeOrange,
                fontWeight: FontWeight.w400,
              ),
            ))),
            AppSvgIcon(
              path: Assets.svgs.close,
              onTap: () {
                widget.fromIsPaused ? popAndReset() : context.pop();
              },
              fit: BoxFit.scaleDown,
            ),
          ],
        ).withContainer(alignment: Alignment.centerRight),
        29.verticalSpace,
        Text(
          'Are you sure you want to forfeit this game and loose all your rewards?',
          style: context.textTheme.bodySmall?.copyWith(
            fontSize: 16.sp,
            color: AppColors.secondaryColor,
            fontFamily: FontFamily.rimouski,
          ),
          textAlign: TextAlign.center,
        ),
        40.verticalSpace,
        Row(
          children: [
            Flexible(
              child: GestureDetector(
                onTap: () {
                  widget.fromIsPaused ? popAndReset() : context.pop();
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 4, horizontal: 20),
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(12.r),
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
                    'Return',
                    style: context.textTheme.bodyMedium?.copyWith(
                      fontFamily: FontFamily.jungleAdventurer,
                      fontSize: 16.sp,
                      color: AppColors.white,
                    ),
                    textScaler: const TextScaler.linear(1.0),
                  ),
                ),
              ),
            ),
            16.horizontalSpace,
            Flexible(
              child: GestureDetector(
                onTap: () {
                  context.popUntil(ModalRoute.withName(AppRouter.dashboard));
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 4, horizontal: 20),
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(12.r),
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
                    'Yes, forfeit',
                    style: context.textTheme.bodyMedium?.copyWith(
                      fontFamily: FontFamily.jungleAdventurer,
                      fontSize: 16.sp,
                      color: AppColors.white,
                    ),
                    textScaler: const TextScaler.linear(1.0),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    ).withContainer(
      borderRadius: BorderRadius.circular(12.r),
      padding: EdgeInsets.symmetric(
        vertical: 20,
        horizontal: 16,
      ),
    );
  }
}
