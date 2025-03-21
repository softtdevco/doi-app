import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GuessResult extends StatelessWidget {
  final int deadCount;
  final int injuredCount;
  final double opacity;

  const GuessResult({
    Key? key,
    required this.deadCount,
    required this.injuredCount,
    this.opacity = 1.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Dead count (green)
        Container(
          width: 24.r,
          height: 24.r,
          margin: EdgeInsets.only(right: 4.r),
          decoration: BoxDecoration(
            color: Colors.green.withOpacity(opacity),
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: Text(
            '$deadCount',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 14.sp,
            ),
          ),
        ),

        // Injured count (orange)
        Container(
          width: 24.r,
          height: 24.r,
          decoration: BoxDecoration(
            color: Colors.orange.withOpacity(opacity),
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: Text(
            '$injuredCount',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 14.sp,
            ),
          ),
        ),
      ],
    );
  }
}
