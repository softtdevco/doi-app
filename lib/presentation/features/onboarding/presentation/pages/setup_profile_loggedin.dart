import 'package:doi_mobile/core/extensions/context_extensions.dart';
import 'package:doi_mobile/core/extensions/navigation_extensions.dart';
import 'package:doi_mobile/core/extensions/texttheme_extensions.dart';
import 'package:doi_mobile/core/extensions/widget_extensions.dart';
import 'package:doi_mobile/core/router/router.dart';
import 'package:doi_mobile/core/utils/colors.dart';
import 'package:doi_mobile/core/utils/styles.dart';
import 'package:doi_mobile/gen/assets.gen.dart';
import 'package:doi_mobile/l10n/l10n.dart';
import 'package:doi_mobile/presentation/features/onboarding/presentation/pages/authentication_page.dart';
import 'package:doi_mobile/presentation/general_widgets/doi_button.dart';
import 'package:doi_mobile/presentation/general_widgets/doi_scaffold.dart';
import 'package:doi_mobile/presentation/general_widgets/doi_svg_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SetUpProfileLoggedIn extends StatelessWidget {
  const SetUpProfileLoggedIn({super.key});

  @override
  Widget build(BuildContext context) {
    return DoiScaffold(
      body: Column(
        children: [

          Expanded(
            child: 
            Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Assets.images.doi.image(
                  fit: BoxFit.cover,
                  width: 144.w,
                ),
                37.verticalSpace,
                Text(
                  context.l10n.welcomeToDoi,
                  style: context.textTheme.bodySmall?.copyWith(
                    fontSize: 22.sp,
                  ),
                ),
                    40.verticalSpace,
             Assets.images.listofavatar.image(
                  fit: BoxFit.fitWidth, 
                ),
              ],
            )
          ),
 
          DoiButton(
            width: 197,
            height: 48,
            text: context.l10n.start,
            onPressed: () => {}
 
          ),
        32.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
children: [
  Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
  Assets.images.user1.image(
                  fit: BoxFit.cover,
                  width: 29.w,
                ),
      12.horizontalSpace,
      Text(
                        "Alex",
                style: context.textTheme.bodySmall!
                .copyWith(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
      color: AppColors.darkShadeOrange
                                ),
              )
  
    ],
  ),
                 
             
                   AppSvgIcon(path: Assets.svgs.arrowForwardIos),
               
],
          ).withContainer(
            width: 239.w,
            height: 48.h,
            padding: EdgeInsets.symmetric(horizontal: 16,vertical: 9),
            color: AppColors.indicator,
            borderRadius: BorderRadius.circular(12.r)
          ),
          32.verticalSpace,
 
         
        ],
      ),
    );
  }
}
