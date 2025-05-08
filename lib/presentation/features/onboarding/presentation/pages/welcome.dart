import 'package:doi_mobile/core/extensions/context_extensions.dart';
import 'package:doi_mobile/core/extensions/navigation_extensions.dart';
import 'package:doi_mobile/core/extensions/overlay_extensions.dart';
import 'package:doi_mobile/core/extensions/texttheme_extensions.dart';
import 'package:doi_mobile/core/extensions/widget_extensions.dart';
import 'package:doi_mobile/core/router/router.dart';
import 'package:doi_mobile/core/utils/colors.dart';
import 'package:doi_mobile/core/utils/styles.dart';
import 'package:doi_mobile/data/third_party_services/device_info_service.dart';
import 'package:doi_mobile/gen/assets.gen.dart';
import 'package:doi_mobile/l10n/l10n.dart';
import 'package:doi_mobile/presentation/features/onboarding/presentation/notifier/onboarding.notifier.dart';
import 'package:doi_mobile/presentation/features/onboarding/presentation/pages/authentication_page.dart';
import 'package:doi_mobile/presentation/features/profile/data/repository/user_repository_impl.dart';
import 'package:doi_mobile/presentation/general_widgets/doi_button.dart';
import 'package:doi_mobile/presentation/general_widgets/doi_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Welcome extends ConsumerStatefulWidget {
  const Welcome({super.key});

  @override
  ConsumerState<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends ConsumerState<Welcome> {
  _loginDevice() async {
    context.showLoading();

    final deviceId =
        await DeviceInfoService.instance.getFirebaseInstallationsId();
    ref.read(onboardingNotifierProvider.notifier).loginDevice(
        deviceId: deviceId,
        onError: (p0) {
          context.hideOverLay();
          context.showError(
            message: p0,
          );
        },
        onCompleted: () {
          context.hideOverLay();
          context.replaceAll(AppRouter.dashboard);
        });
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(currentUserProvider);
    return DoiScaffold(
      body: Column(
        children: [
          Spacer(),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Assets.images.doi.image(
                  fit: BoxFit.cover,
                  width: 144.w,
                ),
                37.verticalSpace,
                Text(
                  context.l10n.welcomeToCrack,
                  style: context.textTheme.bodySmall?.copyWith(
                    fontSize: 22.sp,
                  ),
                ),
              ],
            ).withContainer(
              color: AppColors.background,
              width: context.width,
              shape: BoxShape.circle,
              height: 269.h,
            ),
          ),
          DoiButton(
              width: 197,
              height: 48,
              text: context.l10n.start,
              onPressed: () {
                (user.deviceId ?? '').isEmpty
                    ? context.replaceNamed(AppRouter.setUpProfile)
                    : _loginDevice();
              }),
          32.verticalSpace,
          if ((user.deviceId ?? '').isNotEmpty)
            DoiButton(
              width: 239,
              height: 48,
              leading: Assets.svgs.union,
              buttonStyle: DoiButtonStyle.secondary(),
              text: context.l10n.syncProgress,
              onPressed: () => context.showPopUp(
                  horizontalPadding: 12,
                  Authentication(),
                  color: AppColors.white),
            ),
          82.verticalSpace,
        ],
      ),
    );
  }
}
