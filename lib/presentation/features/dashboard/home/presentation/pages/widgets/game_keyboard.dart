// lib/presentation/features/game/presentation/pages/widgets/game_keyboard.dart
import 'package:flutter/material.dart';
import 'package:doi_mobile/core/utils/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GameKeyboard extends StatelessWidget {
  final Function(String) onNumberPressed;
  final VoidCallback onDeletePressed;
  final VoidCallback onSubmitPressed;
  final bool canSubmit;
  
  const GameKeyboard({
    Key? key,
    required this.onNumberPressed,
    required this.onDeletePressed,
    required this.onSubmitPressed,
    required this.canSubmit,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Color indicators for dead/injured
        Padding(
          padding: EdgeInsets.symmetric(vertical: 8.r),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildColorButton(Colors.orange, null),
              SizedBox(width: 8.w),
              _buildColorButton(Colors.green, null),
              SizedBox(width: 8.w),
              _buildColorButton(Colors.blue, null),
              SizedBox(width: 8.w),
              _buildColorButton(Colors.red, null),
              
              // Left arrow
              Icon(
                Icons.chevron_left,
                color: AppColors.greenText,
              ),
            ],
          ),
        ),
        
        // Number keypad
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.r, vertical: 8.r),
          child: Column(
            children: [
              // First row: 1-5
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(
                  5,
                  (index) => _buildNumberButton('${index + 1}'),
                ),
              ),
              SizedBox(height: 8.h),
              
              // Second row: 6-0
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ...List.generate(
                    4,
                    (index) => _buildNumberButton('${index + 6}'),
                  ),
                  _buildNumberButton('0'),
                ],
              ),
              SizedBox(height: 8.h),
              
              // Third row: Controls
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildControlButton(
                    Icons.chevron_left,
                    onDeletePressed,
                  ),
                  _buildControlButton(
                    Icons.chevron_right,
                    () {}, // Not used in the UI
                  ),
                  _buildControlButton(
                    Icons.backspace,
                    onDeletePressed,
                  ),
                  _buildSubmitButton(),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
  
  Widget _buildColorButton(Color color, VoidCallback? onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 36.r,
        height: 36.r,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
  
  Widget _buildNumberButton(String number) {
    return GestureDetector(
      onTap: () => onNumberPressed(number),
      child: Container(
        width: 48.r,
        height: 48.r,
        decoration: BoxDecoration(
          color: AppColors.lightGreen,
          borderRadius: BorderRadius.circular(8.r),
        ),
        alignment: Alignment.center,
        child: Text(
          number,
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.greenText,
          ),
        ),
      ),
    );
  }
  
  Widget _buildControlButton(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 48.r,
        height: 48.r,
        decoration: BoxDecoration(
          color: AppColors.lightGreen,
          borderRadius: BorderRadius.circular(8.r),
        ),
        alignment: Alignment.center,
        child: Icon(
          icon,
          color: AppColors.greenText,
          size: 24.r,
        ),
      ),
    );
  }
  
  Widget _buildSubmitButton() {
    return GestureDetector(
      onTap: canSubmit ? onSubmitPressed : null,
      child: Container(
        width: 98.r,
        height: 48.r,
        decoration: BoxDecoration(
          color: canSubmit ? AppColors.green : AppColors.lightGreen,
          borderRadius: BorderRadius.circular(8.r),
        ),
        alignment: Alignment.center,
        child: Text(
          'SUBMIT',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
            color: canSubmit ? Colors.white : AppColors.greenText,
          ),
        ),
      ),
    );
  }
}