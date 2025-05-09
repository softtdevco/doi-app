import 'package:doi_mobile/core/extensions/context_extensions.dart';
import 'package:doi_mobile/core/extensions/navigation_extensions.dart';
import 'package:doi_mobile/core/extensions/texttheme_extensions.dart';
import 'package:doi_mobile/core/extensions/widget_extensions.dart';
import 'package:doi_mobile/core/router/router.dart';
import 'package:doi_mobile/core/utils/colors.dart';
import 'package:doi_mobile/gen/assets.gen.dart';
import 'package:doi_mobile/gen/fonts.gen.dart';
import 'package:doi_mobile/l10n/l10n.dart';
import 'package:doi_mobile/presentation/features/profile/data/repository/user_repository_impl.dart';
import 'package:doi_mobile/presentation/features/profile/presentation/widgets/how_to_play_pop.dart';
import 'package:doi_mobile/presentation/general_widgets/doi_button.dart';
import 'package:doi_mobile/presentation/general_widgets/doi_svg_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SettingsPop extends ConsumerStatefulWidget {
  const SettingsPop({super.key});

  @override
  ConsumerState<SettingsPop> createState() => _SettingsPopState();
}

class _SettingsPopState extends ConsumerState<SettingsPop> {
  List<String> actions = [
    Assets.svgs.noSound,
    Assets.svgs.snooze,
  ];
  @override
  Widget build(BuildContext context) {
    final user = ref.watch(currentUserProvider);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                child: Center(
                    child: Text(
              'Settings',
              style: context.textTheme.bodyMedium!.copyWith(
                fontFamily: FontFamily.jungleAdventurer,
                fontSize: 24.sp,
                color: AppColors.darkShadeOrange,
                fontWeight: FontWeight.w400,
              ),
            ))),
            AppSvgIcon(
              path: Assets.svgs.close,
              onTap: () {
                context.pop();
              },
              fit: BoxFit.scaleDown,
            ),
          ],
        ).withContainer(alignment: Alignment.centerRight),
        29.verticalSpace,
        Column(
          children: [
            GestureDetector(
              onTap: () => context.popAndPushNamed(AppRouter.profile),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(50.r),
                        child: Image.asset(
                          'assets/images/${(user.avatar ?? 'userPic4.png').toLowerCase()}',
                          height: 50.h,
                          width: 50.w,
                          errorBuilder: (context, error, stackTrace) =>
                              ClipRRect(
                            borderRadius: BorderRadius.circular(25.r),
                            child: Image.asset(
                              Assets.images.userpic3.path,
                              height: 50.h,
                              width: 50.w,
                            ),
                          ),
                        ),
                      ),
                      8.horizontalSpace,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'My Profile',
                            style: context.textTheme.bodySmall?.copyWith(
                              color: AppColors.secondaryColor,
                              fontSize: 20.sp,
                            ),
                          ),
                          Text(
                            'Online',
                            style: context.textTheme.bodySmall?.copyWith(
                              color: AppColors.secondaryColor
                                  .withValues(alpha: 0.7),
                              fontSize: 14.sp,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                  AppSvgIcon(
                    path: Assets.svgs.arrowForwardIos,
                    color: AppColors.secondaryColor,
                  )
                ],
              ).withContainer(
                color: AppColors.indicator,
                borderRadius: BorderRadius.circular(42.r),
                padding: EdgeInsets.only(
                  top: 8,
                  left: 8,
                  right: 20,
                  bottom: 8,
                ),
              ),
            ),
            24.verticalSpace,
            DoiButton(
              width: context.width,
              text: context.l10n.howToPlay,
              onPressed: () {
                context.showPopUp(
                    size: context.height * 0.8,
                    SingleChildScrollView(child: HowToPlayPop()));
              },
            ),
            // 16.verticalSpace,
            // Stack(
            //   children: [
            //     DoiButton(
            //       text: 'Go Ad free',
            //       buttonStyle: DoiButtonStyle(
            //         background: AppColors.green,
            //         borderColor: AppColors.greenBorder,
            //       ),
            //       onPressed: () {},
            //     ),
            //     Positioned(
            //         child: ClipRRect(
            //             borderRadius: BorderRadius.circular(15.r),
            //             child:
            //                 Assets.images.a1.image(color: Color(0xFFCCF084)))),
            //     Positioned(
            //         child: Assets.images.a2.image(color: Color(0xFFCCF084))),
            //     Positioned(
            //         right: 0,
            //         child: Assets.images.a3.image(color: Color(0xFFCCF084))),
            //   ],
            // ),
            // 16.verticalSpace,
            // DoiButton(
            //   width: context.width,
            //   text: 'HELP & SUPPORT',
            //   onPressed: () {},
            // ),
            // 24.verticalSpace,
            // DoiButton(
            //   width: 239,
            //   height: 48,
            //   leading: Assets.svgs.union,
            //   buttonStyle: DoiButtonStyle.secondary(),
            //   text: context.l10n.syncProgress,
            //   onPressed: () {
            //     context.pop();
            //     context.showPopUp(
            //         horizontalPadding: 12,
            //         Authentication(),
            //         color: AppColors.white);
            //   },
            // ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: List.generate(actions.length, (index) {
            //     return AppSvgIcon(path: actions[index]).withContainer(
            //         width: 48.w,
            //         height: 48.h,
            //         alignment: Alignment.center,
            //         margin: EdgeInsets.symmetric(vertical: 33, horizontal: 12),
            //         border: Border.all(
            //           width: 2.w,
            //           color: AppColors.primaryColor,
            //         ),
            //         borderRadius: BorderRadius.circular(12.r));
            //   }),
            // )
          ],
        )
      ],
    ).withContainer(padding: EdgeInsets.all(20));
  }
}
