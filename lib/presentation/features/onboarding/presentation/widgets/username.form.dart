import 'package:doi_mobile/core/extensions/texttheme_extensions.dart';
import 'package:doi_mobile/core/utils/colors.dart';
import 'package:doi_mobile/l10n/l10n.dart';
import 'package:doi_mobile/presentation/features/onboarding/notifier/onboarding.notifier.dart';
import 'package:doi_mobile/presentation/general_widgets/doi_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserNameForm extends ConsumerStatefulWidget {
  const UserNameForm({super.key});

  @override
  ConsumerState<UserNameForm> createState() => _UserNameFormState();
}

class _UserNameFormState extends ConsumerState<UserNameForm> {
  @override
  Widget build(BuildContext context) {
     var notifier = ref.watch(onboardingNotifierProvider
     );
    return Column(
       children: [
         TextField(
          onChanged: (c){
  notifier.updateUserName(c);
 
          },
          textAlign: TextAlign.center,
 style: context.textTheme.bodySmall!.copyWith(
              fontSize: 20.sp,
              color: AppColors.darkShadeOrange
            ),
          decoration: InputDecoration(
            filled: true,
            hintText: context.l10n.enterYourName,
            hintStyle: context.textTheme.bodySmall!.copyWith(
              fontSize: 20.sp,
              color: AppColors.orangeFade
            ),
           
            fillColor: AppColors.textFieldBg,
            border: UnderlineInputBorder()
          ),
         ),
         24.verticalSpace,
          DoiButton(
            width: 197,
            height: 48,
            text: context.l10n.continues,
            onPressed: () {
              if(notifier.username.isNotEmpty){
   notifier.updateSubmitUsername(true);
              
              }
            }
 
          ),
      ],
    )
    
    ;
  }
}