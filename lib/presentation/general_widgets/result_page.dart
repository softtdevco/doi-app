import 'dart:async';

import 'package:doi_mobile/core/extensions/context_extensions.dart';
import 'package:doi_mobile/core/extensions/navigation_extensions.dart';
import 'package:doi_mobile/core/extensions/string_extensions.dart';
import 'package:doi_mobile/core/extensions/texttheme_extensions.dart';
import 'package:doi_mobile/core/extensions/widget_extensions.dart';
import 'package:doi_mobile/core/router/router.dart';
import 'package:doi_mobile/core/utils/colors.dart';
import 'package:doi_mobile/gen/assets.gen.dart';
import 'package:doi_mobile/l10n/l10n.dart';
import 'package:doi_mobile/presentation/features/dashboard/home/data/repository/game_repository_impl.dart';
import 'package:doi_mobile/presentation/features/dashboard/home/presentation/notifiers/game_notifier.dart';
import 'package:doi_mobile/presentation/general_widgets/doi_button.dart';
import 'package:doi_mobile/presentation/general_widgets/doi_scaffold.dart';
import 'package:doi_mobile/presentation/general_widgets/doi_svg_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Result extends ConsumerStatefulWidget {
  const Result({super.key});

  @override
  ConsumerState<Result> createState() => _ResultState();
}

class _ResultState extends ConsumerState<Result> {
  void startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (timeRemaining <= 0) {
        timer.cancel();
        popAndReset();
        return;
      }
      setState(() {
        timeRemaining = timeRemaining - 1;
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void popAndReset() {
    context.popUntil(
      ModalRoute.withName(AppRouter.dashboard),
    );
  }

  int timeRemaining = 20;
  Timer? _timer;

  @override
  Widget build(BuildContext context) {
    final win = ModalRoute.of(context)!.settings.arguments as bool;
    final state = ref.watch(gameNotifierProvider);
    final totalPoints = ref.watch(totalPointsProvider);
    return DoiScaffold(
      backgroundImage:
          win ? Assets.images.win.provider() : Assets.images.loss.provider(),
      body: Column(
        children: [
          Expanded(
              child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                ''.formatTime(timeRemaining),
                style: context.textTheme.bodySmall!
                    .copyWith(color: win ? AppColors.green : AppColors.red58),
              ),
              44.verticalSpace,
              Text(
                win ? context.l10n.youWin : context.l10n.youLost,
                style: context.textTheme.bodyMedium!.copyWith(
                    fontSize: 44.sp,
                    color: win ? AppColors.greenText : AppColors.red58),
              ),
              Visibility(
                visible: win,
                child: Column(
                  children: [
                    32.verticalSpace,
                    Text(
                      context.l10n.pointsEarned,
                      style: context.textTheme.bodySmall!.copyWith(
                          fontSize: 14.sp,
                          color: win ? AppColors.greenBorder : AppColors.red58),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${state.gamePoints} +',
                          style: context.textTheme.bodyMedium?.copyWith(
                              fontSize: 40.sp,
                              color:
                                  win ? AppColors.greenText : AppColors.red58),
                        ),
                        AppSvgIcon(path: Assets.svgs.coin),
                        Text(
                          '${state.gameCoins} ',
                          style: context.textTheme.bodyMedium?.copyWith(
                              fontSize: 40.sp,
                              color:
                                  win ? AppColors.greenText : AppColors.red58),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              24.verticalSpace,
              Text(
                context.l10n.newPosition,
                style: context.textTheme.bodySmall?.copyWith(
                    fontSize: 14.sp,
                    color: win ? AppColors.greenBorder : AppColors.red58),
              ),
              15.verticalSpace,
              Text(
                context.l10n.leaderBoard,
                style: context.textTheme.bodySmall?.copyWith(
                    fontSize: 14.sp,
                    color: win ? AppColors.greenText : AppColors.red58),
              ).withContainer(
                  width: context.width,
                  alignment: Alignment.center,
                  height: 36.h,
                  color: win ? AppColors.lightGreenC8 : AppColors.red98,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12.r),
                      topRight: Radius.circular(12.r))),
              Row(
                children: [
                  AppSvgIcon(
                      path: win ? Assets.svgs.arrowUp : Assets.svgs.arrowDown),
                  4.horizontalSpace,
                  Text(
                    '#6',
                    style: context.textTheme.bodySmall!.copyWith(
                        fontSize: 14.sp,
                        color: win ? AppColors.greenText : AppColors.red58),
                  ),
                  24.horizontalSpace,
                  Text(
                    context.l10n.you,
                    style: context.textTheme.bodySmall!.copyWith(
                        fontSize: 14.sp,
                        color: win ? AppColors.greenText : AppColors.red58),
                  ),
                  Spacer(),
                  Text(
                    totalPoints.toString(),
                    style: context.textTheme.bodySmall!.copyWith(
                        fontSize: 14.sp,
                        color: win ? AppColors.greenText : AppColors.red58),
                  )
                ],
              ).withContainer(
                  width: context.width,
                  alignment: Alignment.center,
                  height: 46.h,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(12.r),
                      bottomRight: Radius.circular(12.r)),
                  color: win ? AppColors.lightGreen : AppColors.redc4,
                  padding: EdgeInsets.symmetric(horizontal: 24))
            ],
          )),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () => context.popUntil(
                  ModalRoute.withName(AppRouter.dashboard),
                ),
                child: Container(
                  width: 58,
                  height: 58,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: AppColors.green,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.greenBorder,
                          offset: const Offset(0, 5),
                          blurRadius: 0,
                          spreadRadius: 0,
                        ),
                      ],
                      borderRadius: BorderRadius.circular(12)),
                  child: AppSvgIcon(path: Assets.svgs.home2),
                ),
              ),
              13.horizontalSpace,
              DoiButton(
                width: 221.h,
                height: 58.w,
                color: AppColors.green,
                borderColor: AppColors.greenBorder,
                text: context.l10n.startNew,
                onPressed: () => context.pop(),
              ),
            ],
          ),
          32.verticalSpace,
        ],
      ),
    );
  }
}
