import 'package:doi_mobile/core/utils/colors.dart';
import 'package:doi_mobile/gen/assets.gen.dart';
import 'package:doi_mobile/presentation/features/dashboard/home/data/model/guess_model.dart';
import 'package:doi_mobile/presentation/general_widgets/doi_svg_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GameStatusBar extends StatelessWidget {
  final bool aiPlaybackEnabled;
  final bool timerActive;
  final int timeRemaining;
  final List<Guess> aiGuesses; // Add AI guesses to display progress

  const GameStatusBar({
    Key? key,
    required this.aiPlaybackEnabled,
    required this.timerActive,
    required this.timeRemaining,
    required this.aiGuesses,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get the latest AI guess (if any)
    final latestGuess = aiGuesses.isNotEmpty ? aiGuesses.last : null;

    // Calculate AI progress (0.0 to 1.0) based on the best dead count
    final bestDeadCount = aiGuesses.isEmpty
        ? 0
        : aiGuesses.map((g) => g.deadCount).reduce((a, b) => a > b ? a : b);

    // Progress is proportional to best dead count (4 dead = 100%)
    final aiProgress = bestDeadCount / 4;

    return Container(
      padding: EdgeInsets.all(10.r),
      child: Row(
        children: [
          // AI Progress section
          if (aiPlaybackEnabled)
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10.r, vertical: 5.r),
                decoration: BoxDecoration(
                  color: AppColors.lightGreen,
                  borderRadius: BorderRadius.circular(25.r),
                ),
                child: Row(
                  children: [
                    // AI icon
                    Container(
                      width: 24.r,
                      height: 24.r,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: AppSvgIcon(path: Assets.svgs.ai),
                      ),
                    ),
                    8.horizontalSpace,

                    // AI progress text
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'AI progress',
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: AppColors.greenText,
                          ),
                        ),
                        Text(
                          latestGuess != null
                              ? 'O:${latestGuess.deadCount} △:${latestGuess.injuredCount}'
                              : 'O:0 △:0',
                          style: TextStyle(
                            fontSize: 10.sp,
                            color: AppColors.greenText,
                          ),
                        ),
                      ],
                    ),

                    // Progress bar
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.r),
                        child: LinearProgressIndicator(
                          value:
                              aiProgress, // Progress based on best dead count
                          backgroundColor: Colors.white,
                          valueColor: AlwaysStoppedAnimation(AppColors.green),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

          // Timer section
          if (timeRemaining > 0)
            Container(
              margin: EdgeInsets.only(left: 8.r),
              padding: EdgeInsets.symmetric(horizontal: 15.r, vertical: 8.r),
              decoration: BoxDecoration(
                color: AppColors.green,
                borderRadius: BorderRadius.circular(25.r),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Pause/play button
                  Icon(
                    timerActive ? Icons.pause : Icons.play_arrow,
                    color: Colors.white,
                    size: 18.r,
                  ),
                  8.horizontalSpace,

                  // Time display
                  Text(
                    _formatTime(timeRemaining),
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14.sp,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  String _formatTime(int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }
}
