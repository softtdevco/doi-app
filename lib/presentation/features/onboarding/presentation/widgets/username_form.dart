import 'package:doi_mobile/core/extensions/context_extensions.dart';
import 'package:doi_mobile/core/extensions/texttheme_extensions.dart';
import 'package:doi_mobile/core/extensions/widget_extensions.dart';
import 'package:doi_mobile/core/utils/colors.dart';
import 'package:doi_mobile/core/utils/validators.dart';
import 'package:doi_mobile/l10n/l10n.dart';
import 'package:doi_mobile/presentation/features/dashboard/home/presentation/pages/widgets/min_textfield.dart';
import 'package:doi_mobile/presentation/features/onboarding/presentation/notifier/onboarding.notifier.dart';
import 'package:doi_mobile/presentation/general_widgets/doi_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserNameForm extends ConsumerStatefulWidget {
  const UserNameForm({super.key});

  @override
  ConsumerState<UserNameForm> createState() => _UserNameFormState();
}

class _UserNameFormState extends ConsumerState<UserNameForm> {
  final TextEditingController _userNameController = TextEditingController();
  bool isEnabled = false;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final notifier = ref.read(onboardingNotifierProvider.notifier);
    return Form(
      key: _formKey,
      onChanged: () {
        setState(() {
          isEnabled = _formKey.currentState!.validate();
        });
      },
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: MinFormField(
                enableErrorMessage: false,
                textStyle: context.textTheme.bodySmall?.copyWith(
                  fontSize: 20.sp,
                  color: AppColors.secondaryColor,
                ),
                width: double.infinity,
                hintText: context.l10n.enterYourName,
                keyboardType: TextInputType.name,
                controller: _userNameController,
                validateFunction: Validators.name(),
                cursorColor: AppColors.secondaryColor,
                backgroundColor: AppColors.textFieldBg,
                bordercolor: AppColors.secondaryColor,
                hintStyle: context.textTheme.bodySmall!.copyWith(
                  fontSize: 20.sp,
                  color: AppColors.secondaryColor.withValues(alpha: 0.5),
                ),
              ),
            ),
            24.verticalSpace,
            DoiButton(
                width: 197,
                height: 48,
                text: context.l10n.continues,
                isEnabled: isEnabled,
                onPressed: () {
                  if (!isEnabled) {
                    _formKey.currentState?.save();
                    return;
                  }
                  notifier.selectName(_userNameController.text);
                  notifier.selectAuthenicationIndex(2);
                }),
          ],
        ).withContainer(
          color: AppColors.background,
          width: context.width,
          shape: BoxShape.circle,
          height: 269.h,
        ),
      ),
    );
  }
}
