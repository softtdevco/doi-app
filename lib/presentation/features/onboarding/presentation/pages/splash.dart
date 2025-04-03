import 'package:doi_mobile/core/extensions/navigation_extensions.dart';
import 'package:doi_mobile/core/extensions/texttheme_extensions.dart';
import 'package:doi_mobile/core/router/router.dart';
import 'package:doi_mobile/core/utils/colors.dart';
import 'package:doi_mobile/presentation/features/onboarding/presentation/widgets/doi_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _spreadAnimation;
  late Animation<double> _loadingAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 8000),
      vsync: this,
    );

    _spreadAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.15, 0.85, curve: Curves.easeInOutCubic),
      ),
    );

    _loadingAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.linear,
      ),
    );
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _goToWelcome();
      }
    });
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedBuilder(
                    animation: _spreadAnimation,
                    builder: (context, child) {
                      final double dFinalX = -32;
                      final double dFinalAngle = -0.25;
      
                      final double oFinalX = 0;
                      final double oFinalAngle = 0;
      
                      final double iFinalX = 32;
                      final double iFinalAngle = 0.25;
      
                      final double easeValue =
                          _applyCustomEasing(_spreadAnimation.value);
      
                      final double dCurrentX = dFinalX * easeValue;
                      final double dCurrentAngle = dFinalAngle * easeValue;
      
                      final double oCurrentX = oFinalX * easeValue;
                      final double oCurrentAngle = oFinalAngle * easeValue;
      
                      final double iCurrentX = iFinalX * easeValue;
                      final double iCurrentAngle = iFinalAngle * easeValue;
      
                      final double stackOffset = 1.0 - easeValue;
      
                      final double elevationOffset = 2.0 * easeValue;
      
                      return SizedBox(
                        height: 80.h,
                        width: 200.w,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Transform(
                              alignment: Alignment.center,
                              transform: Matrix4.identity()
                                ..translate(dCurrentX,
                                    -elevationOffset - (stackOffset * 4))
                                ..rotateZ(dCurrentAngle),
                              child: DoiCard(
                                letter: "D",
                                color: const Color(0xFF7CD244),
                              ),
                            ),
                            Transform(
                              alignment: Alignment.center,
                              transform: Matrix4.identity()
                                ..translate(oCurrentX, -(stackOffset * 2))
                                ..rotateZ(oCurrentAngle),
                              child:
                                  DoiCard(letter: "O", color: Colors.black),
                            ),
                            Transform(
                              alignment: Alignment.center,
                              transform: Matrix4.identity()
                                ..translate(iCurrentX, -elevationOffset)
                                ..rotateZ(iCurrentAngle),
                              child: DoiCard(
                                letter: "I",
                                color: AppColors.primaryColor,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  23.verticalSpace,
                  Text(
                    "Loading",
                    style: context.textTheme.bodySmall?.copyWith(
                      fontSize: 14.sp,
                    ),
                  ),
                  6.verticalSpace,
                  AnimatedBuilder(
                    animation: _loadingAnimation,
                    builder: (context, child) {
                      return SizedBox(
                        width: 150.w,
                        height: 4.h,
                        child: Center(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Container(
                              width: 102,
                              height: 7.h,
                              decoration: BoxDecoration(
                                color: AppColors.indicator,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  width: 102 * _loadingAnimation.value,
                                  height: 7.h,
                                  decoration: BoxDecoration(
                                    color: AppColors.secondaryColor,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            Text("Dead or Injured", style: context.textTheme.bodySmall),
            66.verticalSpace,
          ],
        ),
      ),
    );
  }

  double _applyCustomEasing(double value) {
    if (value < 0.3) {
      return 3 * value * value;
    } else if (value < 0.7) {
      return 0.27 + 0.7 * (value - 0.3);
    } else {
      double t = (value - 0.7) / 0.3;
      return 0.55 + 0.45 * (1 - (1 - t) * (1 - t));
    }
  }

  _goToWelcome() {
    context.replaceNamed(AppRouter.welcome);
  }
}
