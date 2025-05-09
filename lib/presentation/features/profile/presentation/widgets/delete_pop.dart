import 'package:doi_mobile/core/extensions/navigation_extensions.dart';
import 'package:doi_mobile/core/extensions/texttheme_extensions.dart';
import 'package:doi_mobile/core/extensions/widget_extensions.dart';
import 'package:doi_mobile/core/utils/colors.dart';
import 'package:doi_mobile/gen/assets.gen.dart';
import 'package:doi_mobile/gen/fonts.gen.dart';
import 'package:doi_mobile/presentation/general_widgets/doi_svg_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DeletePop extends ConsumerStatefulWidget {
  const DeletePop({
    super.key,
    required this.onDelete,
  });
  final void Function() onDelete;

  @override
  ConsumerState<DeletePop> createState() => _DeletePopState();
}

class _DeletePopState extends ConsumerState<DeletePop> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                child: Center(
                    child: Text(
              'Delete account',
              style: context.textTheme.bodyMedium!.copyWith(
                fontFamily: FontFamily.jungleAdventurer,
                fontSize: 24.sp,
                color: AppColors.darkShadeOrange,
                fontWeight: FontWeight.w400,
              ),
            ))),
            AppSvgIcon(
              path: Assets.svgs.close,
              onTap: () {
                context.pop();
              },
              fit: BoxFit.scaleDown,
            ),
          ],
        ).withContainer(alignment: Alignment.centerRight),
        29.verticalSpace,
        Text(
          'Are you sure you want to delete your account? you will not be able to recover your data',
          style: context.textTheme.bodySmall?.copyWith(
            fontSize: 16.sp,
            color: AppColors.secondaryColor,
            fontFamily: FontFamily.rimouski,
          ),
          textAlign: TextAlign.center,
        ),
        40.verticalSpace,
        Row(
          children: [
            Flexible(
              child: GestureDetector(
                onTap: () {
                  context.pop();
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 4, horizontal: 20),
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(12.r),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.secondaryColor,
                        offset: const Offset(0, 5),
                        blurRadius: 0,
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'Cancel',
                    style: context.textTheme.bodyMedium?.copyWith(
                      fontFamily: FontFamily.jungleAdventurer,
                      fontSize: 16.sp,
                      color: AppColors.white,
                    ),
                    textScaler: const TextScaler.linear(1.0),
                  ),
                ),
              ),
            ),
            16.horizontalSpace,
            Flexible(
              child: GestureDetector(
                onTap: () {
                  widget.onDelete;
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 4, horizontal: 20),
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(12.r),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.secondaryColor,
                        offset: const Offset(0, 5),
                        blurRadius: 0,
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'Yes, delete',
                    style: context.textTheme.bodyMedium?.copyWith(
                      fontFamily: FontFamily.jungleAdventurer,
                      fontSize: 16.sp,
                      color: AppColors.white,
                    ),
                    textScaler: const TextScaler.linear(1.0),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    ).withContainer(
      borderRadius: BorderRadius.circular(12.r),
      padding: EdgeInsets.symmetric(
        vertical: 20,
        horizontal: 16,
      ),
    );
  }
}
