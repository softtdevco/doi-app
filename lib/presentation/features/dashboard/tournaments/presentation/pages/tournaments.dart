import 'package:doi_mobile/core/extensions/texttheme_extensions.dart';
import 'package:doi_mobile/core/extensions/widget_extensions.dart';
import 'package:doi_mobile/core/utils/colors.dart';
import 'package:doi_mobile/gen/assets.gen.dart';
import 'package:doi_mobile/gen/fonts.gen.dart';
import 'package:doi_mobile/presentation/features/dashboard/home/presentation/pages/widgets/home_appbar.dart';
import 'package:doi_mobile/presentation/features/dashboard/tournaments/presentation/notifiers/tournaments_notifier.dart';
import 'package:doi_mobile/presentation/features/dashboard/tournaments/presentation/pages/widgets/tournament_status_switch.dart';
import 'package:doi_mobile/presentation/general_widgets/doi_scaffold.dart';
import 'package:doi_mobile/presentation/general_widgets/doi_svg_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Tournaments extends ConsumerStatefulWidget {
  const Tournaments({super.key});

  @override
  ConsumerState<Tournaments> createState() => _TournamentsState();
}

class _TournamentsState extends ConsumerState<Tournaments> {
  @override
  Widget build(BuildContext context) {
    final selectedIndex =
        ref.watch(tournamentsNotifierProvider.select((s) => s.switchIndex));
    return DoiScaffold(
      showBackImage: false,
      appbar: DoiHomeAppbar(),
      body: Column(
        children: [
          24.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Tournaments',
                        style: context.textTheme.bodyMedium?.copyWith(
                          fontSize: 24,
                          fontFamily: FontFamily.jungleAdventurer,
                          color: AppColors.secondaryColor,
                        )),
                    Text('Compete with other players to win amazing prices',
                        style: context.textTheme.bodySmall?.copyWith(
                          fontSize: 11.sp,
                          color:
                              AppColors.secondaryColor.withValues(alpha: 0.7),
                        )),
                  ],
                ),
              ),
              16.horizontalSpace,
              GestureDetector(
                onTap: () {},
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 4, horizontal: 14),
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(12.r),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.secondaryColor,
                        offset: const Offset(0, 5),
                        blurRadius: 0,
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'create',
                    style: context.textTheme.bodyMedium?.copyWith(
                      fontFamily: FontFamily.jungleAdventurer,
                      fontSize: 16.sp,
                      color: AppColors.white,
                      fontWeight: FontWeight.w400,
                    ),
                    textScaler: const TextScaler.linear(0.8),
                  ),
                ),
              ),
            ],
          ),
          24.verticalSpace,
          TournamentsStatusSwitch(
            index: selectedIndex,
            onChanged: (v) {
              ref
                  .read(tournamentsNotifierProvider.notifier)
                  .selectSwitchIndex(v);
            },
          ),
          24.verticalSpace,
          Column(
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24.r),
                    topRight: Radius.circular(24.r),
                  ),
                  child: Assets.images.tournament.image()),
              2.verticalSpace,
              Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'The Playoffs',
                          style: context.textTheme.bodyMedium?.copyWith(
                            fontFamily: FontFamily.jungleAdventurer,
                            fontSize: 20.sp,
                            color: AppColors.secondaryColor,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Row(
                          children: [
                            AppSvgIcon(
                              path: Assets.svgs.coin,
                            ),
                            2.horizontalSpace,
                            Text('50,000',
                                style: context.textTheme.bodyMedium?.copyWith(
                                  fontSize: 20.sp,
                                  color: AppColors.secondaryColor,
                                  fontFamily: FontFamily.jungleAdventurer,
                                ))
                          ],
                        )
                      ],
                    ),
                    2.verticalSpace,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(children: [
                          SizedBox(
                            height: 16.h,
                            width: 16.w,
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(8.r),
                                child: Assets.images.opponet.image()),
                          ),
                          4.horizontalSpace,
                          Text(
                            'EA Sports',
                            style: context.textTheme.bodySmall?.copyWith(
                              color: AppColors.orange0A,
                              fontSize: 12.sp,
                            ),
                          )
                        ]),
                        Text(
                          'Price pool',
                          style: context.textTheme.bodySmall?.copyWith(
                            color: AppColors.orange0A,
                            fontSize: 12.sp,
                          ),
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ).withContainer(
            borderRadius: BorderRadius.circular(24.r),
            color: AppColors.background,
            border: Border.all(
              color: Color(0xFFFFE9DC),
            ),
          ),
          24.verticalSpace,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Assets.images.mobileLeaderboard.image(),
          ),
        ],
      ),
    );
  }
}
