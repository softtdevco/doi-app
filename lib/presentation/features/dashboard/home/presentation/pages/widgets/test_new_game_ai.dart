import 'package:doi_mobile/core/extensions/navigation_extensions.dart';
import 'package:doi_mobile/core/extensions/texttheme_extensions.dart';
import 'package:doi_mobile/core/extensions/widget_extensions.dart';
import 'package:doi_mobile/core/router/router.dart';
import 'package:doi_mobile/core/utils/colors.dart';
import 'package:doi_mobile/core/utils/styles.dart';
import 'package:doi_mobile/core/utils/validators.dart';
import 'package:doi_mobile/gen/assets.gen.dart';
import 'package:doi_mobile/l10n/l10n.dart';
import 'package:doi_mobile/presentation/features/dashboard/home/presentation/notifiers/game_notifier.dart';
import 'package:doi_mobile/presentation/features/dashboard/home/presentation/pages/widgets/min_textfield.dart';
import 'package:doi_mobile/presentation/general_widgets/doi_button.dart';
import 'package:doi_mobile/presentation/general_widgets/doi_svg_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TestNewGameAi extends ConsumerStatefulWidget {
  final bool aiPlayback;
  final String gameMode;
  final String timerValue;
  final int aiDifficulty;

  const TestNewGameAi({
    Key? key,
    this.aiPlayback = false,
    this.gameMode = 'hint',
    this.timerValue = '5',
    this.aiDifficulty = 0,
  }) : super(key: key);

  @override
  ConsumerState<TestNewGameAi> createState() => _TestNewGameAiState();
}

class _TestNewGameAiState extends ConsumerState<TestNewGameAi> {
  final TextEditingController _secretCodeController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isEnabled = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(32, 16, 32, 36),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 28.w,
                height: 3.h,
                decoration: BoxDecoration(
                    color: AppColors.greenText,
                    borderRadius: BorderRadius.circular(8.r)),
              ),
              24.verticalSpace,
              Text(
                context.l10n.newGameWith,
                style: context.textTheme.bodySmall?.copyWith(
                  fontSize: 16.sp,
                  color: AppColors.greenText,
                ),
              ),
              24.verticalSpace,

              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppSvgIcon(
                    path: Assets.svgs.ai,
                    fit: BoxFit.scaleDown,
                  ).withContainer(
                    color: AppColors.white,
                    shape: BoxShape.circle,
                    height: 50.h,
                    width: 50.w,
                  ),
                  8.horizontalSpace,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'AI',
                        style: context.textTheme.bodyMedium?.copyWith(
                          color: AppColors.greenText,
                          fontSize: 20.sp,
                        ),
                      ),
                      Text(
                        context.l10n.online,
                        style: context.textTheme.bodySmall?.copyWith(
                          fontSize: 14.sp,
                          color: AppColors.greenText,
                        ),
                      )
                    ],
                  )
                ],
              ).withContainer(
                color: AppColors.lightGreen,
                padding: EdgeInsets.only(
                  top: 8,
                  left: 8,
                  right: 20,
                  bottom: 8,
                ),
                borderRadius: BorderRadius.circular(
                  49.r,
                ),
              ),
              24.verticalSpace,

              // Display timer if set
              if (widget.timerValue != '0') ...[
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AppSvgIcon(
                      path: Assets.svgs.circleClock,
                    ),
                    4.horizontalSpace,
                    Text(
                      widget.timerValue,
                      style: context.textTheme.bodySmall?.copyWith(
                        fontSize: 14.sp,
                        color: AppColors.greenText,
                      ),
                    ),
                    4.horizontalSpace,
                    Text(
                      context.l10n.mins.toLowerCase(),
                      style: context.textTheme.bodySmall?.copyWith(
                        fontSize: 14.sp,
                        color: AppColors.greenText,
                      ),
                    ),
                  ],
                )
                    .withContainer(
                      color: AppColors.white,
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 11),
                      borderRadius: BorderRadius.circular(10),
                    )
                    .withContainer(
                        color: AppColors.lightGreen,
                        borderRadius: BorderRadius.circular(12),
                        padding: EdgeInsets.all(4)),
                24.verticalSpace,
              ],

              // Only ask for secret code in AI playback mode
              if (widget.aiPlayback) ...[
                Text(
                  context.l10n.enterSecretCode,
                  style: context.textTheme.bodySmall?.copyWith(
                    fontSize: 14.sp,
                    color: AppColors.greenText,
                  ),
                ),
                14.verticalSpace,
                MinFormField(
                  onChange: (p0) {
                    setState(() {
                      isEnabled = _formKey.currentState!.validate();
                    });
                  },
                  controller: _secretCodeController,
                  hintText: '1234',
                  keyboardType: TextInputType.number,
                  validateFunction: Validators.code(),
                ),
              ],

              61.verticalSpace,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 22.w),
                child: DoiButton(
                    buttonStyle: DoiButtonStyle(
                      background: AppColors.green,
                      borderColor: AppColors.greenBorder,
                    ),
                    text: context.l10n.startMatch,
                    onPressed: () {
                      if (widget.aiPlayback) {
                        final secretCode = _secretCodeController.text;

                        ref.read(gameNotifierProvider.notifier).startNewGame(
                              playerCode: secretCode,
                              aiPlayback: widget.aiPlayback,
                              gameMode: widget.gameMode,
                              timerValue: widget.timerValue,
                              aiDifficulty: widget.aiDifficulty,
                            );
                      } else {
                        ref.read(gameNotifierProvider.notifier).startNewGame(
                              playerCode: '',
                              aiPlayback: widget.aiPlayback,
                              gameMode: widget.gameMode,
                              timerValue: widget.timerValue,
                              aiDifficulty: widget.aiDifficulty,
                            );
                      }

                      context.popAndPushNamed(AppRouter.playGame);
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _secretCodeController.dispose();
    super.dispose();
  }
}
