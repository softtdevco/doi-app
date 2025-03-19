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
      padding: EdgeInsets.all(16.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Current input display
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              4,
              (index) => Container(
                width: 40.w,
                height: 40.h,
                margin: EdgeInsets.symmetric(horizontal: 4.r),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: index < currentInput.length
                        ? AppColors.green
                        : AppColors.lightGreen,
                    width: 2,
                  ),
                  color: index < currentInput.length
                      ? AppColors.lightGreen
                      : Colors.white,
                  borderRadius: BorderRadius.circular(4.r),
                ),
                alignment: Alignment.center,
                child: index < currentInput.length
                    ? Text(
                        currentInput[index],
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.greenText,
                        ),
                      )
                    : null,
              ),
            ),
          ),

          // Your guess label
          Padding(
            padding: EdgeInsets.only(top: 8.r, bottom: 16.r),
            child: Text(
              'Your Guesses',
              style: TextStyle(
                fontSize: 12.sp,
                color: AppColors.greenText,
              ),
            ),
          ),

          // Previous guesses
          Expanded(
            child: ListView(
              children: [
                // Previous guesses header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Previous guesses ',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: AppColors.greenText,
                      ),
                    ),
                    Text(
                      'Results',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: AppColors.greenText,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 8.h),

                // Previous guesses list
                ...playerGuesses.asMap().entries.map((entry) {
                  final index = entry.key;
                  final guess = entry.value;

                  return Padding(
                    padding: EdgeInsets.only(bottom: 8.r),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Guess code
                        Opacity(
                          opacity: 1.0 - (index * 0.2).clamp(0.0, 0.6),
                          child: Text(
                            guess.code,
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                              color: AppColors.greenText,
                              // Fade out older guesses
                            ),
                          ),
                        ),

                        // Guess result
                        GuessResult(
                          deadCount: guess.deadCount,
                          injuredCount: guess.injuredCount,
                          opacity: 1.0 - (index * 0.2).clamp(0.0, 0.6),
                        ),
                      ],
                    ),
                  );
                }),

                // Game over message
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
