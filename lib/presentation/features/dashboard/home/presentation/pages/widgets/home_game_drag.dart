import 'package:doi_mobile/core/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegisterDrag extends ConsumerStatefulWidget {
  const RegisterDrag({super.key, required this.dragScrollController});
  final DraggableScrollableController dragScrollController;

  @override
  ConsumerState<RegisterDrag> createState() => _RegisterDragState();
}

class _RegisterDragState extends ConsumerState<RegisterDrag> {
  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
        snap: true,
        minChildSize: 0.6,
        maxChildSize: 1.0,
        initialChildSize: 0.6,
        controller: widget.dragScrollController,
        builder: (context, scrollController) {
          return AnimatedContainer(
            curve: Curves.bounceInOut,
            duration: const Duration(milliseconds: 300),
            width: MediaQuery.sizeOf(context).width,
            decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(32.r),
                    topRight: Radius.circular(32.r))),
            child: SingleChildScrollView(
              controller: scrollController,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.background,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(24.r),
                          topRight: Radius.circular(24.r)),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: 8.h,
                        right: 16.w,
                        left: 16.w,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppColors.primaryColor,
                                borderRadius: BorderRadius.circular(100.r),
                              ),
                              width: 60.w,
                              height: 6.h,
                            ),
                          ),
                          20.verticalSpace,
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}
