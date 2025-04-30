import 'package:doi_mobile/core/extensions/texttheme_extensions.dart';
import 'package:doi_mobile/core/extensions/widget_extensions.dart';
import 'package:doi_mobile/core/utils/colors.dart';
import 'package:doi_mobile/presentation/features/dashboard/home/data/model/guess_model.dart';
import 'package:doi_mobile/presentation/features/dashboard/home/presentation/pages/widgets/guess_results.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnlineGuessDisplay extends StatelessWidget {
  final List<String> currentInput;
  final List<Guess> playerGuesses;

  final bool isGameOver;
  final String? winner;

  const OnlineGuessDisplay({
    Key? key,
    required this.currentInput,
    required this.playerGuesses,
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
                          color: AppColors.secondaryColor,
                          width: 2,
                        )
                      : null,
                  color: index < currentInput.length
                      ? AppColors.white
                      : AppColors.indicator,
                  borderRadius: BorderRadius.circular(4.r),
                ),
                alignment: Alignment.center,
                child: index < currentInput.length
                    ? Text(
                        currentInput[index],
                        style: context.textTheme.bodyMedium?.copyWith(
                          color: AppColors.secondaryColor,
                          fontSize: 21.67.sp,
                        ),
                      )
                    : null,
              ),
            ),
          ),
          16.verticalSpace,
          Text(
            'Your guess',
            style: context.textTheme.bodySmall?.copyWith(
              fontSize: 16.sp,
              color: AppColors.disableLock,
            ),
          ),
          89.verticalSpace,
          Expanded(
            child: ListView(
              children: [
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Previous guesses',
                          style: context.textTheme.bodySmall?.copyWith(
                            fontSize: 12.6.sp,
                            color: AppColors.disableLock,
                          ),
                        ),
                        Text(
                          'Results',
                          style: context.textTheme.bodySmall?.copyWith(
                            fontSize: 12.6.sp,
                            color: AppColors.disableLock,
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
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              guess.code,
                              style: context.textTheme.bodyMedium?.copyWith(
                                color: AppColors.secondaryColor,
                                fontSize: 14.sp,
                              ),
                            ),
                            GuessResult(
                              deadCount: guess.deadCount,
                              injuredCount: guess.injuredCount,
                              countColor: AppColors.secondaryColor,
                            ),
                          ],
                        ).withContainer(
                            padding: EdgeInsets.only(
                              bottom: 8.h,
                              top: 8.h,
                            ),
                            border: Border(
                                bottom: BorderSide(
                              color: AppColors.lineGuess,
                            ))),
                      );
                    }),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
