import 'package:doi_mobile/core/extensions/texttheme_extensions.dart';
import 'package:doi_mobile/core/utils/colors.dart';
import 'package:doi_mobile/gen/fonts.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

extension InputDesign on InputDecoration {
  InputDecoration textfielddesign(
    BuildContext context,
    {String? hint,
    Color ?backgroundColor,
    bool?isOutline,
     BorderRadius? borderRadius}) {
    return InputDecoration(
      
      constraints: BoxConstraints(minHeight: 48.h),
      contentPadding: EdgeInsets.symmetric(horizontal:22.w,vertical: 12.h ),
        enabledBorder: OutlineInputBorder(

          borderSide:(isOutline==null)?
          BorderSide.none:
          BorderSide(width: 1,color:
           AppColors.primaryColor )
 ,
          borderRadius: borderRadius??BorderRadius.circular(4.r)
        ),
        focusedBorder: OutlineInputBorder(
           borderSide:(isOutline==null)?
          BorderSide.none:
          BorderSide(width: 1,color:backgroundColor?? AppColors.indicator )
        ,  borderRadius: borderRadius??BorderRadius.circular(4.r)
        ),
        fillColor:
        (isOutline!=null)?
        AppColors.white:
        backgroundColor?? AppColors.indicator,
        filled: true,
        hintStyle: context.textTheme.bodySmall!.copyWith(
          fontSize: 14,
          fontFamily: FontFamily.rimouski,
          color: AppColors.darkShadeOrange),
        hintText:hint );
  }

 

  
}
