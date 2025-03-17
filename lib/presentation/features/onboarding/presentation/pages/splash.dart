import 'package:flutter/material.dart';

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
      backgroundColor: Color(0xFFFFF8F3),
      body: Center(
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
                  height: 80,
                  width: 200,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Transform(
                        alignment: Alignment.center,
                        transform: Matrix4.identity()
                          ..translate(
                              dCurrentX, -elevationOffset - (stackOffset * 4))
                          ..rotateZ(dCurrentAngle),
                        child: _buildCard("D", const Color(0xFF7CD244)),
                      ),
                      Transform(
                        alignment: Alignment.center,
                        transform: Matrix4.identity()
                          ..translate(oCurrentX, -(stackOffset * 2))
                          ..rotateZ(oCurrentAngle),
                        child: _buildCard("O", Colors.black),
                      ),
                      Transform(
                        alignment: Alignment.center,
                        transform: Matrix4.identity()
                          ..translate(iCurrentX, -elevationOffset)
                          ..rotateZ(iCurrentAngle),
                        child: _buildCard("I", const Color(0xFFF77F2C)),
                      ),
                    ],
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
            const Text(
              "Loading",
              style: TextStyle(
                color: Color(0xFFF77F2C),
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 5),
            AnimatedBuilder(
              animation: _loadingAnimation,
              builder: (context, child) {
                return SizedBox(
                  width: 150,
                  height: 4,
                  child: Stack(
                    children: [
                      Container(
                        width: 150,
                        height: 4,
                        decoration: BoxDecoration(
                          color: const Color(0xFFF77F2C).withOpacity(0.3),
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      Container(
                        width: 150 * _loadingAnimation.value,
                        height: 4,
                        decoration: BoxDecoration(
                          color: const Color(0xFFF77F2C),
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            const SizedBox(height: 200),
            const Text(
              "Dead or Injured",
              style: TextStyle(
                color: Color(0xFFF77F2C),
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
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

  Widget _buildCard(String letter, Color color) {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(6),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Center(
        child: Text(
          letter,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
