import 'package:doi_mobile/core/extensions/context_extensions.dart';
import 'package:doi_mobile/core/extensions/texttheme_extensions.dart';
import 'package:doi_mobile/core/utils/colors.dart';
import 'package:doi_mobile/data/location/flag_service.dart';
import 'package:doi_mobile/gen/assets.gen.dart';
import 'package:doi_mobile/gen/fonts.gen.dart';
import 'package:doi_mobile/presentation/features/dashboard/home/presentation/pages/widgets/new_game_with.dart';
import 'package:doi_mobile/presentation/general_widgets/doi_appbar.dart';
import 'package:doi_mobile/presentation/general_widgets/doi_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FindingOpponents extends ConsumerStatefulWidget {
  const FindingOpponents({super.key});

  @override
  ConsumerState<FindingOpponents> createState() => _FindingOpponentsState();
}

class _FindingOpponentsState extends ConsumerState<FindingOpponents> {
  final PageController _pageController = PageController(viewportFraction: 0.28);
  int _currentIndex = 2;
  final List<Map<String, dynamic>> _opponents = [
    {
      'name': 'Alex',
      'avatar': Assets.images.avatar1.path,
      'countryCode': 'US',
    },
    {
      'name': 'Maria',
      'avatar': Assets.images.opponet.path,
      'countryCode': 'ES',
    },
    {
      'name': 'Finneas',
      'avatar': Assets.images.opponet.path,
      'countryCode': 'BR',
    },
    {
      'name': 'Ji-Yong',
      'avatar': Assets.images.avatar1.path,
      'countryCode': 'KR',
    },
    {
      'name': 'Prakash',
      'avatar': Assets.images.opponet.path,
      'countryCode': 'IN',
    },
  ];

  @override
  void initState() {
    super.initState();
    _initFlagService();
  }

  Future<void> _initFlagService() async {
    await ref.read(flagServiceProvider).initialize();
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DoiScaffold(
      bodyPadding: EdgeInsets.zero,
      appbar: DoiAppbar(
        leading: Assets.svgs.close,
      ),
      body: Column(
        children: [
          24.verticalSpace,
          Text(
            'Finding an opponent...',
            style: context.textTheme.bodySmall?.copyWith(fontSize: 20.sp),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 210.h,
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              itemCount: _opponents.length,
              itemBuilder: (context, index) {
                final bool isSelected = index == _currentIndex;
                return Column(
                  children: [
                    46.verticalSpace,
                    Stack(
                      children: [
                        GestureDetector(
                          onTap: () => context.showBottomSheet(
                            isDismissible: true,
                            color: AppColors.background,
                            child: NewGameWith(
                              isGroup: false,
                              timerValue: "5",
                            ),
                          ),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            width: isSelected ? 100.w : 70,
                            height: isSelected ? 100.h : 70,
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? const Color(0xFF7E57FF)
                                  : Colors.grey.shade300,
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 2),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100.r),
                              child: Image.asset(
                                _opponents[index]['avatar'],
                                width: isSelected ? 117.w : 76,
                                height: isSelected ? 116.h : 76,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        // Positioned(
                        //   right: 0,
                        //   child: _buildFlagWidget(
                        //       _opponents[_currentIndex]['countryCode']),
                        // ),
                      ],
                    ),
                    if (isSelected) ...[
                      24.verticalSpace,
                      Text(
                        _opponents[index]['name'],
                        style: context.textTheme.bodyMedium?.copyWith(
                          color: AppColors.secondaryColor,
                          fontFamily: FontFamily.jungleAdventurer,
                          fontSize: 24.sp,
                        ),
                      )
                    ]
                  ],
                );
              },
            ),
          ),
          16.verticalSpace,
          Row(
            spacing: 16.w,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 100.w,
                height: 1.h,
                color: AppColors.primaryColor,
              ),
              Text(
                'Vs',
                style: context.textTheme.bodyMedium?.copyWith(
                    fontSize: 30.sp,
                    color: AppColors.primaryColor,
                    fontFamily: FontFamily.jungleAdventurer),
              ),
              Container(
                width: 100.w,
                height: 1.h,
                color: AppColors.primaryColor,
              ),
            ],
          ),
          47.verticalSpace,
          ClipRRect(
            borderRadius: BorderRadius.circular(71.r),
            child: Assets.images.avatar1.image(height: 116.h, width: 117.w),
          ),
          24.verticalSpace,
          Text(
            'YOU',
            style: context.textTheme.bodyMedium?.copyWith(
              fontSize: 24.sp,
              color: AppColors.secondaryColor,
              fontFamily: FontFamily.jungleAdventurer,
            ),
          )
        ],
      ),
    );
  }

  // Widget _buildFlagWidget(String countryCode) {
  //   final flagService = ref.read(flagServiceProvider);
  //   if (!flagService.isInitialized) {
  //     return Container(
  //       width: 30,
  //       height: 30,
  //       decoration: BoxDecoration(
  //         color: Colors.white,
  //         shape: BoxShape.circle,
  //         border: Border.all(color: Colors.white, width: 2),
  //       ),
  //     );
  //   }

  //   final String? flagUrl = flagService.getFlagImageUrl(countryCode);
  //   final String? flagEmoji = flagService.getFlagEmoji(countryCode);

  //   return Container(
  //     decoration: BoxDecoration(
  //       shape: BoxShape.circle,
  //       border: Border.all(color: Colors.white, width: 2),
  //     ),
  //     child: ClipOval(
  //       child: flagUrl != null
  //           ? CachedNetworkImage(
  //               imageUrl: flagUrl,
  //               width: 30,
  //               height: 30,
  //               fit: BoxFit.cover,
  //               placeholder: (context, url) => Container(
  //                 width: 30,
  //                 height: 30,
  //                 color: Colors.grey.shade200,
  //               ),
  //               errorWidget: (context, url, error) => Container(
  //                 width: 30,
  //                 height: 30,
  //                 color: Colors.white,
  //                 child: Center(
  //                   child: Text(
  //                     flagEmoji ?? countryCode,
  //                     style: const TextStyle(fontSize: 16),
  //                   ),
  //                 ),
  //               ),
  //             )
  //           : Container(
  //               width: 30,
  //               height: 30,
  //               color: Colors.white,
  //               child: Center(
  //                 child: Text(
  //                   flagEmoji ?? countryCode,
  //                   style: const TextStyle(fontSize: 16),
  //                 ),
  //               ),
  //             ),
  //     ),
  //   );
  // }
}
