import 'package:doi_mobile/core/extensions/context_extensions.dart';
import 'package:doi_mobile/core/extensions/input.design.extension.dart';
import 'package:doi_mobile/core/extensions/navigation_extensions.dart';
import 'package:doi_mobile/core/extensions/texttheme_extensions.dart';
import 'package:doi_mobile/core/extensions/widget_extensions.dart';
import 'package:doi_mobile/core/router/router.dart';
import 'package:doi_mobile/core/utils/colors.dart';
import 'package:doi_mobile/gen/assets.gen.dart';
import 'package:doi_mobile/gen/fonts.gen.dart';
import 'package:doi_mobile/l10n/l10n.dart';
import 'package:doi_mobile/presentation/features/onboarding/presentation/widgets/other_authenication.dart';
import 'package:doi_mobile/presentation/general_widgets/doi_button.dart';
import 'package:doi_mobile/presentation/general_widgets/doi_svg_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignPage extends StatelessWidget {
  const SignPage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Form(child: 
 Column(
  children: [
 
    TextFormField(
      
      decoration: InputDecoration()
      .textfielddesign(
        context,
        hint: "Email",
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.r),
          topRight: Radius.circular(16.r)
        )
        ),
      onChanged: (c){
       
      },
    )
 
   , TextFormField(
      
      decoration: InputDecoration()
      .textfielddesign(
        context,
        hint: "Password",
 
        ),
      onChanged: (c){
       
      },
    )
   , TextFormField(
      
      decoration: InputDecoration()
      .textfielddesign(
        context,
        hint: "Confirm Password",
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(16.r),
          bottomRight: Radius.circular(16.r)
        )
        ),
      onChanged: (c){
       
      },
    )
 ,12.verticalSpace
  ,
DoiButton(
            width: context.width,
            height: 48.h,
            textStyle: context.textTheme.bodySmall!.copyWith(
              fontFamily: FontFamily.jungleAdventurer,
              fontSize: 22.sp,
              color: AppColors.white,
            ),
            text: context.l10n.signUp.toUpperCase(),
            onPressed: (){
              context.replaceNamed(AppRouter.setUpProfile);
            } 
           
          ),
          24.verticalSpace,
 OtherAuthenication(),
  ],
  crossAxisAlignment: CrossAxisAlignment.start,

 ).withContainer(padding: EdgeInsets.symmetric(horizontal: 16))
 )
;
  }
}