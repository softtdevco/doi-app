import 'package:doi_mobile/core/extensions/context_extensions.dart';
import 'package:doi_mobile/core/extensions/texttheme_extensions.dart';
import 'package:doi_mobile/core/extensions/widget_extensions.dart';
import 'package:doi_mobile/core/utils/colors.dart';
import 'package:doi_mobile/core/utils/styles.dart';
import 'package:doi_mobile/gen/assets.gen.dart';
import 'package:doi_mobile/presentation/general_widgets/doi_button.dart';
import 'package:doi_mobile/presentation/general_widgets/doi_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    return DoiScaffold(
      body: Column(
        children: [
          Spacer(),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Assets.images.doi.image(
                  fit: BoxFit.cover,
                  width: 144,
                ),
                Text(
                  'Welcome to DOI',
                  style: context.textTheme.bodySmall?.copyWith(
                    fontSize: 22.sp,
                  ),
                ),
              ],
            ).withContainer(
              color: AppColors.background,
              width: context.width,
              shape: BoxShape.circle,
              height: 269.h,
            ),
          ),
          DoiButton(
            width: 197.w,
            text: 'START',
            onPressed: () {},
          ),
          32.verticalSpace,
          DoiButton(
            width: 239.w,
            leading: Assets.svgs.union,
            buttonStyle: DoiButtonStyle.secondary(),
            text: 'Sync Your Progress',
            onPressed: () {},
          ),
          82.verticalSpace,
        ],
      ),
    );
  }
}
