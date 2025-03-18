import 'package:doi_mobile/core/extensions/context_extensions.dart';
import 'package:doi_mobile/core/extensions/navigation_extensions.dart';
import 'package:doi_mobile/core/extensions/texttheme_extensions.dart';
import 'package:doi_mobile/core/extensions/widget_extensions.dart';
import 'package:doi_mobile/core/router/router.dart';
import 'package:doi_mobile/core/utils/colors.dart';
import 'package:doi_mobile/core/utils/styles.dart';
import 'package:doi_mobile/gen/assets.gen.dart';
import 'package:doi_mobile/l10n/l10n.dart';
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
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Assets.images.doi.image(
                      fit: BoxFit.cover,
                      width: 200.w,
                    ),
                    Positioned(
                      bottom: 30,
                      child: Text(
                        context.l10n.deadOrInjured,
                        style: context.textTheme.bodySmall?.copyWith(
                          fontSize: 22.sp,
                        ),
                      ),
                    ),
                  ],
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
            height: 48.h,
            text: context.l10n.start,
            onPressed: () => context.replaceAll(AppRouter.dashboard),
          ),
          32.verticalSpace,
          DoiButton(
            width: 239.w,
            height: 48.h,
            leading: Assets.svgs.union,
            buttonStyle: DoiButtonStyle.secondary(),
            text: context.l10n.syncProgress,
            onPressed: () {},
          ),
          82.verticalSpace,
        ],
      ),
    );
  }
}
