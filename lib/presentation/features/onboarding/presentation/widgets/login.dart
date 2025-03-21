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
import 'package:doi_mobile/presentation/general_widgets/doi_button.dart';
import 'package:doi_mobile/presentation/general_widgets/doi_svg_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

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
    ),
 5.verticalSpace
   , TextFormField(
      
      decoration: InputDecoration()
      .textfielddesign(
        context,
        hint: "Password",
      
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(16.r),
          bottomRight: Radius.circular(16.r)
        )
        ),
      onChanged: (c){
       
      },
    )
 ,12.verticalSpace
 ,Text(
  'Forgot Password?',
  style: context.textTheme.bodySmall!
  .copyWith(
    fontFamily: FontFamily.rimouski,
    color: AppColors.darkShadeOrange,
    fontSize: 12.sp,
    
  ),
 ).withContainer(
  alignment: Alignment.centerRight
 ),
 12.verticalSpace,
 DoiButton(
            width: context.width,
            height: 48,
            textStyle: context.textTheme.bodySmall!.copyWith(
              fontFamily: FontFamily.jungleAdventurer,
              fontSize: 22.sp,
              color: AppColors.white,
            ),
            text: context.l10n.login.toUpperCase(),
            onPressed: (){
               context.replaceNamed(AppRouter.setUpProfileLoggedIn);
            } 
           
          ),
          24.verticalSpace,
 Row(
  children: [
    Expanded(child: Divider(thickness: 1,color: AppColors.primaryColor,))
   ,Text('OR',
   style:context.textTheme.bodyMedium!.copyWith(
    fontWeight: FontWeight.w400,
    fontFamily: FontFamily.jungleAdventurer,
    fontSize: 19.2.sp,
    color: AppColors.primaryColor
   ) ,
   ).withContainer(
    padding: EdgeInsets.symmetric(horizontal: 10.24.w)
   ),
    Expanded(child: Divider(thickness: 1,color: AppColors.primaryColor,))
  
  ],
 )
          , 
          Column(
            children: List.generate(2, (index){
var center = Center(
                          child: Text(
                                     index==0?
                                            context.l10n.
                                            continueWithGoogle:context.l10n.continueWithX,
                            style: context.textTheme.bodySmall!
                            .copyWith(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                               color: AppColors.darkShadeOrange
                                            ),
                          ),
                        );
return                   Container(
            width: context.width,
            margin: EdgeInsets.only(bottom: 12.h),
            height: 48.h,
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Row(
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AppSvgIcon(path:
                      index ==0?
                       Assets.svgs.xLogo
                       :Assets.svgs.googleLogo
                       ),
                      12.horizontalSpace,
                      Expanded(
                                                 child: center,
                      )
                  
                    ],
                  ),
                ),
             
               AppSvgIcon(path: Assets.svgs.arrowForwardIos),
              ],
            ),
            decoration: BoxDecoration(
              color: AppColors.indicator,
              borderRadius: BorderRadius.circular(12.r),

            ),
          );
          
            }),
          )

  ],
  crossAxisAlignment: CrossAxisAlignment.start,

 ).withContainer(padding: EdgeInsets.symmetric(horizontal: 16))
 )
;
  }
}