import 'package:doi_mobile/core/extensions/overlay_extensions.dart';
import 'package:doi_mobile/core/extensions/texttheme_extensions.dart';
import 'package:doi_mobile/core/utils/colors.dart';
import 'package:doi_mobile/gen/assets.gen.dart';
import 'package:doi_mobile/gen/fonts.gen.dart';
import 'package:doi_mobile/presentation/features/dashboard/home/presentation/notifiers/game_notifier.dart';
import 'package:doi_mobile/presentation/general_widgets/doi_svg_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GameKeyboard extends ConsumerStatefulWidget {
  final Function(String) onNumberPressed;
  final VoidCallback onDeletePressed;
  final VoidCallback onSubmitPressed;
  final bool canSubmit;
  final bool aiPlaybackEnabled;
  final bool isOnline;

  const GameKeyboard({
    Key? key,
    required this.onNumberPressed,
    required this.onDeletePressed,
    required this.onSubmitPressed,
    required this.canSubmit,
    required this.aiPlaybackEnabled,
    this.isOnline = false,
  }) : super(key: key);

  @override
  ConsumerState<GameKeyboard> createState() => _GameKeyboardState();
}

class _GameKeyboardState extends ConsumerState<GameKeyboard> {
  bool showPowerUps = false;
  @override
  Widget build(BuildContext context) {
    final swapsRemaining =
        ref.watch(gameNotifierProvider.select((v) => v.codeSwapsRemaining));

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        children: [
          if (widget.aiPlaybackEnabled) ...[
            Row(
              spacing: 20.w,
              children: [
                if (showPowerUps)
                  Row(
                    spacing: 20.w,
                    children: [
                      _buildColorButton(AppColors.primaryColor, () {},
                          Assets.svgs.lightbulb, 0),
                      _buildColorButton(
                          AppColors.wine, () {}, Assets.svgs.wand, 0),
                      _buildColorButton(
                          AppColors.green, () {}, Assets.svgs.alarm, 0),
                    ],
                  ),
                _buildColorButton(
                    AppColors.primaryColor,
                    widget.isOnline
                        ? () {}
                        : () {
                            ref
                                .read(gameNotifierProvider.notifier)
                                .swapPlayerCode(onCodeChange: () {
                              context.showSuccess(
                                  message: 'CODE SWAPPED SUCCESFULLY');
                            });
                          },
                    Assets.svgs.dices,
                    swapsRemaining),
                GestureDetector(
                  onTap: () {
                    // setState(() {
                    //   showPowerUps = !showPowerUps;
                    // });
                  },
                  child: RotatedBox(
                    quarterTurns: showPowerUps ? 0 : 2,
                    child: AppSvgIcon(
                      path: Assets.svgs.left,
                      color: AppColors.dropColor,
                    ),
                  ),
                ),
              ],
            ),
            20.verticalSpace,
          ],
          Column(
            children: [
              Row(
                spacing: 6.w,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(
                  5,
                  (index) =>
                      Flexible(child: _buildNumberButton('${index + 1}')),
                ),
              ),
              SizedBox(height: 8.h),
              Row(
                spacing: 6.w,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ...List.generate(
                    4,
                    (index) =>
                        Flexible(child: _buildNumberButton('${index + 6}')),
                  ),
                  Flexible(child: _buildNumberButton('0')),
                ],
              ),
              SizedBox(height: 8.h),
              Row(
                spacing: 6.w,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: _buildControlButton(
                      Assets.svgs.left,
                      widget.onDeletePressed,
                      false,
                    ),
                  ),
                  Flexible(
                    child: _buildControlButton(
                      Assets.svgs.left,
                      () {},
                      true,
                    ),
                  ),
                  Flexible(
                    child: _buildControlButton(
                      Assets.svgs.delete,
                      widget.onDeletePressed,
                      false,
                    ),
                  ),
                  Flexible(child: _buildSubmitButton(context)),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildColorButton(
      Color color, VoidCallback? onTap, String path, int trial) {
    return GestureDetector(
        onTap: onTap,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
                width: 36.w,
                height: 36.h,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                ),
                child: AppSvgIcon(
                  path: path,
                  fit: BoxFit.scaleDown,
                )),
            if (trial > 0)
              Positioned(
                top: -5,
                right: -1,
                child: Container(
                  padding: EdgeInsets.all(6.r),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    '$trial',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 8.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
          ],
        ));
  }

  Widget _buildNumberButton(String number) {
    return GestureDetector(
      onTap: () => widget.onNumberPressed(number),
      child: Container(
        height: 48.r,
        decoration: BoxDecoration(
          color: AppColors.lightGreen,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: AppColors.lightGreenBorder,
              offset: const Offset(0, 5),
              blurRadius: 0,
              spreadRadius: 0,
            ),
          ],
        ),
        alignment: Alignment.center,
        child: Text(
          number,
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.greenText,
          ),
          textScaler: const TextScaler.linear(1.0),
        ),
      ),
    );
  }

  Widget _buildControlButton(String icon, VoidCallback onTap, bool isRight) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          height: 48.r,
          decoration: BoxDecoration(
            color: AppColors.lightGreen,
            borderRadius: BorderRadius.circular(12.r),
            boxShadow: [
              BoxShadow(
                color: AppColors.lightGreenBorder,
                offset: const Offset(0, 5),
                blurRadius: 0,
                spreadRadius: 0,
              ),
            ],
          ),
          alignment: Alignment.center,
          child: RotatedBox(
            quarterTurns: isRight ? 2 : 0,
            child: AppSvgIcon(
              path: icon,
              fit: BoxFit.scaleDown,
              color: AppColors.greenText,
            ),
          )),
    );
  }

  Widget _buildSubmitButton(BuildContext context) {
    return GestureDetector(
      onTap: widget.canSubmit ? widget.onSubmitPressed : null,
      child: Container(
        padding: EdgeInsets.all(4),
        height: 48.r,
        decoration: BoxDecoration(
          color: AppColors.green,
          borderRadius: BorderRadius.circular(12.r),
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
          'SUBMIT',
          style: context.textTheme.bodyMedium?.copyWith(
            fontFamily: FontFamily.jungleAdventurer,
            fontSize: 22.sp,
            color: AppColors.white,
          ),
          textScaler: const TextScaler.linear(1.0),
        ),
      ),
    );
  }
}
