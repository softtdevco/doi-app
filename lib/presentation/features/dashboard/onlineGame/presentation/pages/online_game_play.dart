import 'package:doi_mobile/core/utils/colors.dart';
import 'package:doi_mobile/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class OnlineGamePlay extends ConsumerStatefulWidget {
  const OnlineGamePlay({super.key});

  @override
  ConsumerState<OnlineGamePlay> createState() => _OnlineGamePlayState();
}

class _OnlineGamePlayState extends ConsumerState<OnlineGamePlay>
    with SingleTickerProviderStateMixin {
  final List<String> currentInput = [];
  bool showKeyboard = true;
  // bool _hasNavigatedAfterWin = false;
  late AnimationController _confettiController;
  bool _showConfetti = false;

  @override
  void initState() {
    super.initState();

    _confettiController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    );
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Container(
                color: AppColors.background,
                child: Column(
                  children: [],
                ),
              ),
            ),
            if (_showConfetti)
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                height: 339.h,
                child: IgnorePointer(
                  child: Lottie.asset(
                    Assets.jsons.success,
                    controller: _confettiController,
                    fit: BoxFit.cover,
                    onLoaded: (composition) {
                      _confettiController.duration = composition.duration;
                    },
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _onNumberPressed(String digit) {
    if (currentInput.length < 4 && !currentInput.contains(digit)) {
      setState(() {
        currentInput.add(digit);
      });
    }
  }

  void _onDeletePressed() {
    if (currentInput.isNotEmpty) {
      setState(() {
        currentInput.removeLast();
      });
    }
  }

  void _onSubmitPressed() {
    if (currentInput.length == 4) {
      final guess = currentInput.join();

      setState(() {
        currentInput.clear();
      });
    }
  }
}
