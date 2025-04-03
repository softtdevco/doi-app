import 'package:doi_mobile/core/extensions/texttheme_extensions.dart';
import 'package:doi_mobile/gen/assets.gen.dart';
import 'package:doi_mobile/l10n/l10n.dart';
import 'package:doi_mobile/presentation/features/onboarding/presentation/notifier/onboarding.notifier.dart';
import 'package:doi_mobile/presentation/features/onboarding/presentation/widgets/country_form.dart';
import 'package:doi_mobile/presentation/features/onboarding/presentation/widgets/username_form.dart';
import 'package:doi_mobile/presentation/general_widgets/doi_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SetUpProfile extends ConsumerStatefulWidget {
  const SetUpProfile({super.key});

  @override
  ConsumerState<SetUpProfile> createState() => _SetUpProfileState();
}

class _SetUpProfileState extends ConsumerState<SetUpProfile> {
  @override
  Widget build(BuildContext context) {
    final selectedAuthenication = ref
        .watch(onboardingNotifierProvider.select((v) => v.authenicationIndex));
    return DoiScaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 24),
        child: Column(
          children: [
            Column(
              children: [
                20.verticalSpace,
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
                Assets.images.listofavatar.image(
                  fit: BoxFit.fitWidth,
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
      ),
    );
  }
}
