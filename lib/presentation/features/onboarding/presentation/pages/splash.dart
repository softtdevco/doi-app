import 'package:doi_mobile/core/extensions/navigation_extensions.dart';
import 'package:doi_mobile/core/extensions/texttheme_extensions.dart';
import 'package:doi_mobile/core/router/router.dart';
import 'package:doi_mobile/core/utils/colors.dart';
import 'package:doi_mobile/core/utils/enums.dart';
import 'package:doi_mobile/gen/assets.gen.dart';
import 'package:doi_mobile/l10n/l10n.dart';
import 'package:doi_mobile/presentation/features/profile/data/repository/user_repository_impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Splash extends ConsumerStatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  ConsumerState<Splash> createState() => _SplashState();
}

class _SplashState extends ConsumerState<Splash>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  late Animation<double> _loadingAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _loadingAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.linear,
      ),
    );
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _navigate();
      }
    });
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Assets.images.doi.image(
                      fit: BoxFit.cover,
                      width: 144.w,
                    ),
                    23.verticalSpace,
                    Text(
                      "Loading",
                      style: context.textTheme.bodySmall?.copyWith(
                        fontSize: 14.sp,
                      ),
                    ),
                    6.verticalSpace,
                    AnimatedBuilder(
                      animation: _loadingAnimation,
                      builder: (context, child) {
                        return SizedBox(
                          width: 150.w,
                          height: 4.h,
                          child: Center(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Container(
                                width: 102,
                                height: 7.h,
                                decoration: BoxDecoration(
                                  color: AppColors.indicator,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Container(
                                    width: 102 * _loadingAnimation.value,
                                    height: 7.h,
                                    decoration: BoxDecoration(
                                      color: AppColors.secondaryColor,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              Text(context.l10n.deadOrInjured,
                  style: context.textTheme.bodySmall),
              66.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }

  _navigate() {
    final data = ref.read(userRepositoryProvider).getCurrentState();
    return switch (data) {
      CurrentState.loggedIn => context.replaceNamed(AppRouter.dashboard),
      _ => context.replaceNamed(AppRouter.welcome),
    };
  }
}
