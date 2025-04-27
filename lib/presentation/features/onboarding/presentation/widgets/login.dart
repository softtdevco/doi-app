import 'package:doi_mobile/core/extensions/context_extensions.dart';
import 'package:doi_mobile/core/extensions/input.design.extension.dart';
import 'package:doi_mobile/core/extensions/navigation_extensions.dart';
import 'package:doi_mobile/core/extensions/overlay_extensions.dart';
import 'package:doi_mobile/core/extensions/texttheme_extensions.dart';
import 'package:doi_mobile/core/extensions/widget_extensions.dart';
import 'package:doi_mobile/core/utils/colors.dart';
import 'package:doi_mobile/core/utils/enums.dart';
import 'package:doi_mobile/core/utils/validators.dart';
import 'package:doi_mobile/data/third_party_services/device_info_service.dart';
import 'package:doi_mobile/gen/assets.gen.dart';
import 'package:doi_mobile/gen/fonts.gen.dart';
import 'package:doi_mobile/l10n/l10n.dart';
import 'package:doi_mobile/presentation/features/onboarding/data/models/login_sync_request.dart';
import 'package:doi_mobile/presentation/features/onboarding/presentation/notifier/onboarding.notifier.dart';
import 'package:doi_mobile/presentation/general_widgets/doi_button.dart';
import 'package:doi_mobile/presentation/general_widgets/doi_svg_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isEnabled = false;

  _login() async {
    final deviceId = await DeviceInfoService.instance.getDeviceInfo();
    final data = LoginSyncRequest(
      email: _emailController.text.trim().toLowerCase(),
      password: _passwordController.text.trim(),
      deviceId: deviceId,
    );
    ref.read(onboardingNotifierProvider.notifier).syncLogin(
        data: data,
        onError: (p0) {
          context.showError(
            message: p0,
          );
        },
        onCompleted: (p0) {
          context.showSuccess(message: p0);
          context.pop();
        });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        onChanged: () {
          setState(() {
            isEnabled = _formKey.currentState!.validate();
          });
        },
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration().textfielddesign(context,
                  hint: "Email",
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16.r),
                      topRight: Radius.circular(16.r))),
              onChanged: (c) {},
              validator: Validators.email(),
              controller: _emailController,
            ),
            5.verticalSpace,
            TextFormField(
              decoration: InputDecoration().textfielddesign(context,
                  hint: "Password",
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(16.r),
                      bottomRight: Radius.circular(16.r))),
              onChanged: (c) {},
              validator: Validators.password(),
              controller: _passwordController,
            ),
            12.verticalSpace,
            Text(
              'Forgot Password?',
              style: context.textTheme.bodySmall!.copyWith(
                fontFamily: FontFamily.rimouski,
                color: AppColors.darkShadeOrange,
                fontSize: 12.sp,
              ),
            ).withContainer(alignment: Alignment.centerRight),
            12.verticalSpace,
            Consumer(builder: (context, r, c) {
              final loadState = r.watch(onboardingNotifierProvider
                  .select((v) => v.loginSyncLoadState));
              return DoiButton(
                width: context.width,
                height: 48,
                textStyle: context.textTheme.bodySmall!.copyWith(
                  fontFamily: FontFamily.jungleAdventurer,
                  fontSize: 22.sp,
                  color: AppColors.white,
                ),
                text: context.l10n.login.toUpperCase(),
                onPressed: () {
                  if (!isEnabled) {
                    _formKey.currentState?.save();
                    return;
                  }
                  _login();
                },
                isLoading: loadState == LoadState.loading,
              );
            }),
            24.verticalSpace,
            Row(
              children: [
                Expanded(
                    child: Divider(
                  thickness: 1,
                  color: AppColors.primaryColor,
                )),
                Text(
                  'OR',
                  style: context.textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w400,
                      fontFamily: FontFamily.jungleAdventurer,
                      fontSize: 19.2.sp,
                      color: AppColors.primaryColor),
                ).withContainer(
                    padding: EdgeInsets.symmetric(horizontal: 10.24.w)),
                Expanded(
                    child: Divider(
                  thickness: 1,
                  color: AppColors.primaryColor,
                ))
              ],
            ),
            Column(
              children: List.generate(2, (index) {
                var center = Center(
                  child: Text(
                    index == 0
                        ? context.l10n.continueWithGoogle
                        : context.l10n.continueWithX,
                    style: context.textTheme.bodySmall!.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.darkShadeOrange),
                  ),
                );
                return Container(
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
                            AppSvgIcon(
                                path: index == 0
                                    ? Assets.svgs.xLogo
                                    : Assets.svgs.googleLogo),
                            12.horizontalSpace,
                            Expanded(
                              child: center,
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
            )
          ],
          crossAxisAlignment: CrossAxisAlignment.start,
        ).withContainer(padding: EdgeInsets.symmetric(horizontal: 16)));
  }
}
