import 'package:doi_mobile/core/extensions/context_extensions.dart';
import 'package:doi_mobile/core/extensions/input.design.extension.dart';
import 'package:doi_mobile/core/extensions/navigation_extensions.dart';
import 'package:doi_mobile/core/extensions/overlay_extensions.dart';
import 'package:doi_mobile/core/extensions/texttheme_extensions.dart';
import 'package:doi_mobile/core/extensions/widget_extensions.dart';
import 'package:doi_mobile/core/utils/colors.dart';
import 'package:doi_mobile/core/utils/enums.dart';
import 'package:doi_mobile/core/utils/validators.dart';
import 'package:doi_mobile/gen/fonts.gen.dart';
import 'package:doi_mobile/l10n/l10n.dart';
import 'package:doi_mobile/presentation/features/onboarding/data/models/signup_sync_request.dart';
import 'package:doi_mobile/presentation/features/onboarding/presentation/notifier/onboarding.notifier.dart';
import 'package:doi_mobile/presentation/features/onboarding/presentation/widgets/other_authenication.dart';
import 'package:doi_mobile/presentation/features/profile/data/repository/user_repository_impl.dart';
import 'package:doi_mobile/presentation/general_widgets/doi_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignPage extends ConsumerStatefulWidget {
  const SignPage({super.key});

  @override
  ConsumerState<SignPage> createState() => _SignPageState();
}

class _SignPageState extends ConsumerState<SignPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isEnabled = false;

  _register() {
    final userRepo = ref.read(userRepositoryProvider);
    final data = SignupSyncRequest(
      jwtToken: userRepo.getToken(),
      email: _emailController.text.trim().toLowerCase(),
      password: _passwordController.text.trim(),
    );
    ref.read(onboardingNotifierProvider.notifier).syncSignUp(
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
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              validator: Validators.email(),
            ),
            5.verticalSpace,
            TextFormField(
              decoration: InputDecoration().textfielddesign(
                context,
                hint: "Password",
              ),
              onChanged: (c) {},
              controller: _passwordController,
              validator: Validators.password(),
            ),
            5.verticalSpace,
            TextFormField(
              decoration: InputDecoration().textfielddesign(context,
                  hint: "Confirm Password",
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(16.r),
                      bottomRight: Radius.circular(16.r))),
              onChanged: (c) {},
              validator: (v) => Validators.confirmPass(
                _passwordController.text,
                _confirmController.text,
              ).call(v),
              controller: _confirmController,
            ),
            12.verticalSpace,
            Consumer(builder: (context, r, c) {
              final loadState = r.watch(onboardingNotifierProvider
                  .select((v) => v.signupSyncLoadState));
              return DoiButton(
                  width: context.width,
                  height: 48.h,
                  textStyle: context.textTheme.bodySmall!.copyWith(
                    fontFamily: FontFamily.jungleAdventurer,
                    fontSize: 22.sp,
                    color: AppColors.white,
                  ),
                  text: context.l10n.signUp.toUpperCase(),
                  isLoading: loadState == LoadState.loading,
                  onPressed: () {
                    if (!isEnabled) {
                      _formKey.currentState?.save();
                      return;
                    }
                    _register();
                  });
            }),
            24.verticalSpace,
            OtherAuthenication(),
          ],
          crossAxisAlignment: CrossAxisAlignment.start,
        ).withContainer(padding: EdgeInsets.symmetric(horizontal: 16)));
  }
}
