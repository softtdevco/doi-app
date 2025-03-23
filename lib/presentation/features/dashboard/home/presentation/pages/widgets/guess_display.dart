import 'package:doi_mobile/core/extensions/texttheme_extensions.dart';
import 'package:doi_mobile/core/extensions/widget_extensions.dart';
import 'package:doi_mobile/core/utils/colors.dart';
import 'package:doi_mobile/presentation/features/dashboard/home/data/model/guess_model.dart';
import 'package:doi_mobile/presentation/features/dashboard/home/presentation/pages/widgets/guess_results.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GuessDisplay extends StatelessWidget {
  final List<String> currentInput;
  final List<Guess> playerGuesses;
  final String gameMode;
  final String aiSecretCode;
  final bool isGameOver;
  final String? winner;

  const GuessDisplay({
    Key? key,
    required this.currentInput,
    required this.playerGuesses,
    required this.gameMode,
    required this.aiSecretCode,
    required this.isGameOver,
    required this.winner,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (gameMode == 'hint') ...[
            Text(
              'Your guess',
              style: context.textTheme.bodySmall?.copyWith(
                fontSize: 16.sp,
                color: AppColors.greenBorder,
              ),
            ),
            16.verticalSpace,
          ],
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              4,
              (index) => Container(
                width: 50.w,
                height: 50.h,
                margin: EdgeInsets.symmetric(horizontal: 4.r),
                decoration: BoxDecoration(
                  border: index < currentInput.length
                      ? Border.all(
                          color: AppColors.greenText,
                          width: 2,
                        )
                      : null,
                  color: index < currentInput.length
                      ? AppColors.white
                      : AppColors.lightGreen,
                  borderRadius: BorderRadius.circular(4.r),
                ),
                alignment: Alignment.center,
                child: index < currentInput.length
                    ? Text(
                        currentInput[index],
                        style: context.textTheme.bodyMedium?.copyWith(
                          color: AppColors.greenText,
                          fontSize: 21.67.sp,
                        ),
                      )
                    : null,
              ),
            ),
          ),
          16.verticalSpace,
          Text(
            gameMode == 'mystery' ? 'Your guess' : 'Results',
            style: context.textTheme.bodySmall?.copyWith(
              fontSize: 16.sp,
              color: AppColors.greenBorder,
            ),
          ),
          if (gameMode == 'mystery') 89.verticalSpace,
          Expanded(
            child: ListView(
              children: [
                Column(
                  children: [
                    if (gameMode == 'mystery')
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Previous guesses',
                            style: context.textTheme.bodySmall?.copyWith(
                              fontSize: 12.6.sp,
                              color: AppColors.greenBorder,
                            ),
                          ),
                          Text(
                            'Results',
                            style: context.textTheme.bodySmall?.copyWith(
                              fontSize: 12.6.sp,
                              color: AppColors.greenBorder,
                            ),
                          ),
                        ],
                      ),
                    SizedBox(height: 9.h),
                    ...playerGuesses
                        .asMap()
                        .entries
                        .toList()
                        .reversed
                        .map((entry) {
                      final index = playerGuesses.length - 1 - entry.key;
                      final guess = entry.value;

                      return Opacity(
                        opacity: 1.0 - (index * 0.2).clamp(0.0, 0.6),
                        child: gameMode == 'hint'
                            ? HintWidget(
                                guessCode: guess.code,
                                opacity: 1.0 - (index * 0.2).clamp(0.0, 0.6),
                                aiSecretCode: aiSecretCode,
                              )
                            : Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    guess.code,
                                    style:
                                        context.textTheme.bodyMedium?.copyWith(
                                      color: AppColors.greenText,
                                      fontSize: 14.sp,
                                    ),
                                  ),
                                  GuessResult(
                                    deadCount: guess.deadCount,
                                    injuredCount: guess.injuredCount,
                                  ),
                                ],
                              ).withContainer(
                                padding: EdgeInsets.only(
                                  bottom: 8.h,
                                  top: 8.h,
                                ),
                                border: Border(
                                    bottom: BorderSide(
                                  color: AppColors.lightGreen,
                                ))),
                      );
                    }),
                  ],
                ),
                if (isGameOver)
                  Container(
                    margin: EdgeInsets.only(top: 16.r),
                    padding: EdgeInsets.all(16.r),
                    decoration: BoxDecoration(
                      color: AppColors.lightGreen,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Column(
                      children: [
                        Text(
                          winner == 'player'
                              ? 'You win'
                              : winner == 'ai'
                                  ? 'Ai wins'
                                  : winner == 'draw'
                                      ? 'Draw'
                                      : 'Time Up',
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColors.greenText,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          '${'secreet code'}: $aiSecretCode',
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: AppColors.greenText,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class HintWidget extends StatelessWidget {
  const HintWidget({
    super.key,
    required this.guessCode,
    required this.opacity,
    required this.aiSecretCode,
  });
  final String guessCode;
  final double opacity;
  final String aiSecretCode;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 6.w),
      child: Row(
        spacing: 6.w,
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(4, (index) {
          final digit = guessCode[index];
          bool isCorrectPosition =
              index < aiSecretCode.length && aiSecretCode[index] == digit;
          bool isInCodeWrongPosition =
              !isCorrectPosition && aiSecretCode.contains(digit);
          Color boxColor = isCorrectPosition
              ? AppColors.lightGreen
              : isInCodeWrongPosition
                  ? AppColors.injuredLight
                  : AppColors.outsideBack;
          Color textColor = isCorrectPosition
              ? AppColors.greenText
              : isInCodeWrongPosition
                  ? AppColors.injured
                  : AppColors.outsideGreen;
          return Container(
            width: 50.w,
            height: 50.h,
            decoration: BoxDecoration(
              color: boxColor,
              borderRadius: BorderRadius.circular(4.r),
            ),
            alignment: Alignment.center,
            child: Text(
              digit,
              style: context.textTheme.bodyMedium?.copyWith(
                color: textColor,
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        }),
      ),
    );
  }
}
