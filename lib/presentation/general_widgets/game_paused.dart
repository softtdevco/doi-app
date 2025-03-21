 
import 'dart:async';

import 'package:doi_mobile/core/extensions/context_extensions.dart';
import 'package:doi_mobile/core/extensions/navigation_extensions.dart';
import 'package:doi_mobile/core/extensions/string_extensions.dart';
import 'package:doi_mobile/core/extensions/texttheme_extensions.dart';
import 'package:doi_mobile/core/extensions/widget_extensions.dart';
import 'package:doi_mobile/core/router/router.dart';
import 'package:doi_mobile/core/utils/colors.dart';
import 'package:doi_mobile/core/utils/styles.dart';
import 'package:doi_mobile/gen/assets.gen.dart';
import 'package:doi_mobile/gen/fonts.gen.dart';
import 'package:doi_mobile/l10n/l10n.dart';
import 'package:doi_mobile/presentation/features/onboarding/presentation/notifier/onboarding.notifier.dart';
import 'package:doi_mobile/presentation/features/onboarding/presentation/widgets/login.dart';
import 'package:doi_mobile/presentation/features/onboarding/presentation/widgets/signup.dart';
import 'package:doi_mobile/presentation/features/onboarding/presentation/widgets/authenication_bar.dart';
import 'package:doi_mobile/presentation/general_widgets/doi_button.dart';
import 'package:doi_mobile/presentation/general_widgets/doi_svg_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';

class GamePaused extends ConsumerStatefulWidget {
  const GamePaused({super.key});

  @override
  ConsumerState<GamePaused> createState() => _GamePausedState();
}

class _GamePausedState extends ConsumerState<GamePaused> {
 void startTimer(){
    _timer?.cancel();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (timeRemaining <= 0) {
        timer.cancel();
       context.pop();
        return;
      }
      setState(() {
        timeRemaining = timeRemaining -1;
      });
      });
 }
 @override
  void dispose() {
   _timer?.cancel();
    super.dispose();
  }
 @override
 void initState() {
   super.initState();
   startTimer();
 }
 int timeRemaining = 5;
Timer? _timer;
 List<String> actions=[
  Assets.svgs.music,
  Assets.svgs.settings2,
  Assets.svgs.headphone,
 ];
  @override
  Widget build(BuildContext context) {
    return 
     Column(
children: [
 
  Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
 
Expanded(child: Center(child: Text(
  context.l10n.gamePaused,style: context.textTheme.bodyMedium!.copyWith(
    fontFamily: FontFamily.jungleAdventurer,
    fontSize: 24.sp,
    color: AppColors.darkShadeOrange,
    fontWeight: FontWeight.w400,
  ),)
  
  )),
      AppSvgIcon(
          path: 
         Assets.svgs.close,
         onTap: (){
          context.pop();
         },
         fit: BoxFit.scaleDown,
         ),
    ],
  ).withContainer(alignment: Alignment.centerRight),
12.verticalSpace,
                  Text(
                    ''.formatTime(timeRemaining),
                    style: context.textTheme.bodySmall!.copyWith(
fontSize: 18,
color: AppColors.orange0A
 
                    ),
                  ),
            29.verticalSpace,
Column(
  children: [
  
  DoiButton(
            width: context.width,
            height: 48.h,
            textStyle: context.textTheme.bodyMedium!.copyWith(
              fontFamily: FontFamily.jungleAdventurer,
              fontSize: 22.sp,
              fontWeight: FontWeight.w400,
              color: AppColors.white,
            ),
            text: context.l10n.resume,
            onPressed: (){
                
            } 
           
          ),
          16.verticalSpace,
  DoiButton(
            width: context.width,
            height: 48.h,
            textStyle: context.textTheme.bodyMedium!.copyWith(
              fontFamily: FontFamily.jungleAdventurer,
              fontSize: 22.sp,
              fontWeight: FontWeight.w400,
              color: AppColors.white,
            ),
            text: context.l10n.howToPlay,
            onPressed: (){
                
            } 
           
          ),
          16.verticalSpace,
  DoiButton(
            width: context.width,
            height: 48.h,
            isOutline: true,
            
            buttonStyle:DoiButtonOutline(
              
            ),
            textStyle: context.textTheme.bodyMedium!.copyWith(
              fontFamily: FontFamily.jungleAdventurer,
              fontSize: 22.sp,
              fontWeight: FontWeight.w400,
              color: AppColors.darkShadeOrange,
            ),
            text: context.l10n.forfeitMatch,
            onPressed: (){
              
            } 
           
          ),
  
15.verticalSpace,
Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: List.generate(actions.length,
   (index){
    return   AppSvgIcon(path: actions[index]).withContainer(
     width: 48.w,height: 48.h,
     alignment: Alignment.center,
     margin: EdgeInsets.symmetric(vertical: 33,horizontal: 12),
         border: Border.all(width: 2.w,color: AppColors.primaryColor,),
      borderRadius: BorderRadius.circular(12.r)
    );
   }),
)
 
  ],
)
]
,
    ).withContainer(padding: EdgeInsets.all(20)) ;
  }
}