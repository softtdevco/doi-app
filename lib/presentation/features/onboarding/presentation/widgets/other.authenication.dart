import 'package:doi_mobile/core/extensions/context_extensions.dart';
import 'package:doi_mobile/core/extensions/texttheme_extensions.dart';
import 'package:doi_mobile/core/extensions/widget_extensions.dart';
import 'package:doi_mobile/core/utils/colors.dart';
import 'package:doi_mobile/gen/assets.gen.dart';
import 'package:doi_mobile/gen/fonts.gen.dart';
import 'package:doi_mobile/l10n/l10n.dart';
import 'package:doi_mobile/presentation/general_widgets/doi_svg_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OtherAuthenication extends StatelessWidget {
  const OtherAuthenication({super.key});

  @override
  Widget build(BuildContext context) {
    return           Column(
      children: [
        Row(
  children: [
    Expanded(child: Divider(thickness: 1,color: AppColors.primaryColor,))
   ,Text('OR',
   style:context.textTheme.bodyMedium!.copyWith(
    fontWeight: FontWeight.w400,
    fontSize: 19.2.sp,
     fontFamily: FontFamily.jungleAdventurer,
    color: AppColors.primaryColor
   ) ,
   ).withContainer(
    padding: EdgeInsets.symmetric(
      vertical: 24,
      horizontal: 10.24.w)
   ),
    Expanded(child: Divider(thickness: 1,color: AppColors.primaryColor,))
  
  ],
 )
          , 

        Column(
                children: List.generate(2, (index){
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
              ),
      ],
    )
;
  }
}