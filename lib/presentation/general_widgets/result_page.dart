import 'package:doi_mobile/core/extensions/context_extensions.dart';
import 'package:doi_mobile/core/extensions/navigation_extensions.dart';
import 'package:doi_mobile/core/extensions/string_extensions.dart';
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
import 'package:doi_mobile/presentation/general_widgets/game_paused.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Result extends StatefulWidget {
  const Result({super.key});

  @override
  State<Result> createState() => _ResultState();
}

class _ResultState extends State<Result> {
bool win = true;

  @override
  Widget build(BuildContext context) {
    return DoiScaffold(
     
      body: Column(
        children: [
 
          Expanded(
            child: 
            Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              
                Text(
                  ''.formatTime(20),
                  style: context.textTheme.bodySmall!.copyWith(
                    color:win? AppColors.green:AppColors.red58
                  ),
                ),
                44.verticalSpace,
                   Text(
                win?  context.l10n.youWin:context.l10n.youLost,
                  style: context.textTheme.bodyMedium!.copyWith(
                    fontSize: 44.sp,
                    color:win? AppColors.greenText:AppColors.red58
                  ),
                ),
               32.verticalSpace,
                 Visibility(
                  visible: win,
                   child: Column(
                                       children: [
                       Text(
                        context.l10n.pointsEarned,
                        style: context.textTheme.bodySmall!.copyWith(
                          color:win? AppColors.greenBorder:AppColors.red58
                        ),
                                       ),
                       Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                         children: [
                           Text(
                            '3200 +',
                            style: context.textTheme.bodyMedium!.copyWith(
                              fontSize: 40,
                              color:win? AppColors.greenText:AppColors.red58
                            ),
                                           ),
                            AppSvgIcon(path: Assets.svgs.coin),
                           Text(
                            '100',
                            style: context.textTheme.bodyMedium!.copyWith(
                              fontSize: 40,
                              color:win? AppColors.greenText:AppColors.red58
                            ),
                                           ),
                       
                       
                         ],
                       ),
                     ],
                   ),
                 ),
                  24.verticalSpace,
                                     Text(
                  context.l10n.newPosition,
                  style: context.textTheme.bodySmall!.copyWith(
                    color:win? AppColors.greenBorder:AppColors.red58
                  ),
                ),
                15.verticalSpace,
                                     Text(
                  context.l10n.leaderBoard,
                  style: context.textTheme.bodySmall!.copyWith(
                    fontSize: 14,
                    color:win? AppColors.greenText:AppColors.red58
                  ),
                ).withContainer(
                  width: context.width,
                  alignment: Alignment.center,
                  height: 36.h,
                  color:win? AppColors.lightGreenC8:AppColors.red98,

                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12.r),
                    topRight: Radius.circular(12.r)
                  )
                ),
                Row(
                  children: [
                    AppSvgIcon(path:win? 
                    Assets.svgs.arrowUp:
                     Assets.svgs.arrowDown),
                    4.horizontalSpace,
   Text(
                  '#6',
                  style: context.textTheme.bodySmall!.copyWith(
                    fontSize: 14,
                    color:win? AppColors.greenText:AppColors.red58
                  ),
                )
                  ,24.horizontalSpace,
                     Text(
                  context.l10n.you,
                  style: context.textTheme.bodySmall!.copyWith(
                    fontSize: 14,
                    color:win? AppColors.greenText:AppColors.red58
                  ),
                ),
                Spacer(),
                     Text(
                  '33,590',
                  style: context.textTheme.bodySmall!.copyWith(
                    fontSize: 14,
                    color:win? AppColors.greenText:AppColors.red58
                  ),
                )
                  ],
                ).withContainer(
                  width: context.width,
                  alignment: Alignment.center,
                  height: 46.h,
                   borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(12.r),
                    bottomRight: Radius.circular(12.r)
                  ),
                  color:win? AppColors.lightGreen:AppColors.redc4,
                  padding: EdgeInsets.symmetric(horizontal: 24)
                )
                
              ],
            )
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
                 Container(
                  
                                    width: 58,height: 58,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: AppColors.green,
                    boxShadow: [
                        BoxShadow(
                color: AppColors.greenBorder,
                offset: const Offset(0, 5),
                blurRadius: 0,
                spreadRadius: 0,
              ),
                    ],
                     borderRadius: BorderRadius.circular(12)
                  ),
                   child: AppSvgIcon(path: 
                    Assets.svgs.home2
                   ),
                 ),
              13.horizontalSpace,
              DoiButton(
                width: 221.h,
                height: 58.w,
                color: AppColors.green,
                borderColor: AppColors.greenBorder,
                text: context.l10n.startNew,
                onPressed: () => {}
               
              ),
            ],
          ),
          32.verticalSpace,
 
         
        ],
      ),
    );
  }
}
