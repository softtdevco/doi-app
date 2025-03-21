import 'package:doi_mobile/core/extensions/context_extensions.dart';
import 'package:doi_mobile/core/extensions/navigation_extensions.dart';
import 'package:doi_mobile/core/extensions/texttheme_extensions.dart';
import 'package:doi_mobile/core/extensions/widget_extensions.dart';
import 'package:doi_mobile/core/router/router.dart';
import 'package:doi_mobile/core/utils/colors.dart';
import 'package:doi_mobile/core/utils/styles.dart';
import 'package:doi_mobile/gen/assets.gen.dart';
import 'package:doi_mobile/l10n/l10n.dart';
import 'package:doi_mobile/presentation/features/onboarding/notifier/onboarding.notifier.dart';
import 'package:doi_mobile/presentation/features/onboarding/presentation/pages/authentication_page.dart';
import 'package:doi_mobile/presentation/features/onboarding/presentation/widgets/country_form.dart';
import 'package:doi_mobile/presentation/features/onboarding/presentation/widgets/username_form.dart';
import 'package:doi_mobile/presentation/general_widgets/doi_button.dart';
import 'package:doi_mobile/presentation/general_widgets/doi_scaffold.dart';
import 'package:doi_mobile/presentation/general_widgets/doi_svg_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SetUpProfile extends ConsumerStatefulWidget {
  const SetUpProfile({super.key});

  @override
  ConsumerState<SetUpProfile> createState() => _SetUpProfileState();
}

class _SetUpProfileState extends ConsumerState<SetUpProfile> {
  @override
  Widget build(BuildContext context) {
     var notifier = ref.watch(onboardingNotifierProvider);
    return DoiScaffold(
      body: Column(
        children: [

          Expanded(
            child: 
            Column(
              
              
              children: [
                Assets.images.doi.image(
                  fit: BoxFit.cover,
                  width: 144.w,
                   
                ),
                
                49.verticalSpace,
                Text(
                  context.l10n.whatShouldWeCallYou,
                  style: context.textTheme.bodySmall?.copyWith(
                    fontSize: 16.sp,
                  ),
                ),
                  40.verticalSpace,
             Assets.images.listofavatar.image(
                  fit: BoxFit.fitWidth, 
                ),
              ],
            )
          ),

       

( notifier.submitUserName?
 CountryForm():
 UserNameForm()).withContainer(
              color: AppColors.background,
              width: context.width,
              shape: BoxShape.circle,
              height: 269.h,
            ),
         
        ],
      ),
    );
  }
}
