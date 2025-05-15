import 'package:doi_mobile/core/extensions/texttheme_extensions.dart';
import 'package:doi_mobile/core/extensions/widget_extensions.dart';
import 'package:doi_mobile/core/utils/colors.dart';
import 'package:doi_mobile/gen/assets.gen.dart';
import 'package:doi_mobile/l10n/l10n.dart';
import 'package:doi_mobile/presentation/features/onboarding/presentation/notifier/onboarding.notifier.dart';
import 'package:doi_mobile/presentation/features/onboarding/presentation/widgets/country_form.dart';
import 'package:doi_mobile/presentation/features/onboarding/presentation/widgets/username_form.dart';
import 'package:doi_mobile/presentation/general_widgets/doi_scaffold.dart';
import 'package:doi_mobile/presentation/general_widgets/doi_svg_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SetUpProfile extends ConsumerStatefulWidget {
  const SetUpProfile({super.key});

  @override
  ConsumerState<SetUpProfile> createState() => _SetUpProfileState();
}

class _SetUpProfileState extends ConsumerState<SetUpProfile> {
  final PageController _pageController = PageController(initialPage: 2, viewportFraction: 0.28);
  int _currentIndex = 2;
  final List<Map<String, dynamic>> _opponents = [
    {
      'name': 'userPic1.png',
      'avatar': Assets.images.userpic1.path,
    },
    {
      'name': 'userPic2.png',
      'avatar': Assets.images.userpic2.path,
    },
    {
      'name': 'userPic3.png',
      'avatar': Assets.images.userpic3.path,
    },
    {
      'name': 'userPic4.png',
      'avatar': Assets.images.userpic4.path,
    },
    {
      'name': 'userPic5.png',
      'avatar': Assets.images.userpic5.path,
    },
  ];
  
  @override
  void initState() {
    super.initState();
    // Set initial avatar in onboarding notifier
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(onboardingNotifierProvider.notifier)
        .selectAvatar(_opponents[_currentIndex]['name']);
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final selectedAuthenication = ref
        .watch(onboardingNotifierProvider.select((v) => v.authenicationIndex));
    return DoiScaffold(
      bodyPadding: EdgeInsets.symmetric(vertical: 24),
      body: Column(
        children: [
          Column(
            children: [
              Assets.images.doi.image(
                fit: BoxFit.cover,
                width: 86.w,
              ),
              49.verticalSpace,
              Text(
                context.l10n.whatShouldWeCallYou,
                style: context.textTheme.bodySmall?.copyWith(
                  fontSize: 16.sp,
                ),
              ),
              40.verticalSpace,
              SizedBox(
                height: 150.h,
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      _currentIndex = index;
                    });
                    ref
                        .read(onboardingNotifierProvider.notifier)
                        .selectAvatar(_opponents[index]['name']);
                  },
                  itemCount: _opponents.length,
                  itemBuilder: (context, index) {
                    final bool isSelected = index == _currentIndex;
                    return Column(
                      children: [
                        Stack(
                          children: [
                            GestureDetector(
                              onTap: () {},
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                width: isSelected ? 96.w : 66,
                                height: isSelected ? 96.h : 66,
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? const Color(0xFF7E57FF)
                                      : Colors.grey.shade300,
                                  shape: BoxShape.circle,
                                ),
                                child: Opacity(
                                  opacity: isSelected ? 1.0 : 0.3,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(100.r),
                                    child: Image.asset(
                                      _opponents[index]['avatar'],
                                      width: isSelected ? 96.w : 66,
                                      height: isSelected ? 96.h : 66,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ).withContainer(
                                padding: EdgeInsets.all(2),
                                border: isSelected
                                    ? Border.all(
                                        color: AppColors.green,
                                        width: 2,
                                      )
                                    : null,
                                borderRadius: BorderRadius.circular(100.r),
                              ),
                            ),
                            if (isSelected)
                              Positioned(
                                  right: 10,
                                  child: AppSvgIcon(
                                    path: Assets.svgs.avatarCheck,
                                  )),
                          ],
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
          Spacer(),
          switch (selectedAuthenication > 1) {
            true => CountryForm(),
            _ => Expanded(child: UserNameForm())
          }
        ],
      ),
    );
  }
}