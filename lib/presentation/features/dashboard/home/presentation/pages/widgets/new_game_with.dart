import 'package:doi_mobile/core/extensions/texttheme_extensions.dart';
import 'package:doi_mobile/core/extensions/widget_extensions.dart';
import 'package:doi_mobile/core/utils/colors.dart';
import 'package:doi_mobile/core/utils/validators.dart';
import 'package:doi_mobile/gen/assets.gen.dart';
import 'package:doi_mobile/l10n/l10n.dart';
import 'package:doi_mobile/presentation/features/dashboard/home/presentation/pages/widgets/min_textfield.dart';
import 'package:doi_mobile/presentation/general_widgets/doi_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NewGameWith extends ConsumerStatefulWidget {
  const NewGameWith({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<NewGameWith> createState() => _NewGameWithState();
}

class _NewGameWithState extends ConsumerState<NewGameWith> {
  final TextEditingController _secretCodeController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isEnabled = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(32, 16, 32, 36),
      child: Form(
        key: _formKey,
        onChanged: () {
          setState(() {
            isEnabled = _formKey.currentState!.validate();
          });
        },
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 28.w,
                height: 3.h,
                decoration: BoxDecoration(
                    color: Color(0xFFD7A07D),
                    borderRadius: BorderRadius.circular(8.r)),
              ),
              24.verticalSpace,
              Text(
                context.l10n.newGameWith,
                style: context.textTheme.bodySmall?.copyWith(
                  fontSize: 16.sp,
                  color: AppColors.secondaryColor,
                ),
              ),
              24.verticalSpace,
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Assets.images.multiple.image(),
                  8.horizontalSpace,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Finneas'.toUpperCase(),
                        style: context.textTheme.bodyMedium?.copyWith(
                          color: AppColors.secondaryColor,
                          fontSize: 20.sp,
                        ),
                      ),
                      Text(
                        '+ 4 others',
                        style: context.textTheme.bodySmall?.copyWith(
                          fontSize: 14.sp,
                          color:
                              AppColors.secondaryColor.withValues(alpha: 0.7),
                        ),
                      )
                    ],
                  )
                ],
              ).withContainer(
                color: AppColors.indicator,
                padding: EdgeInsets.only(
                  top: 8,
                  left: 8,
                  right: 20,
                  bottom: 8,
                ),
                borderRadius: BorderRadius.circular(
                  49.r,
                ),
              ),
              24.verticalSpace,
              Text(
                context.l10n.enterSecretCode,
                style: context.textTheme.bodySmall?.copyWith(
                  fontSize: 14.sp,
                  color: AppColors.primaryColor,
                ),
              ),
              14.verticalSpace,
              MinFormField(
                hintText: '1234',
                keyboardType: TextInputType.number,
                controller: _secretCodeController,
                validateFunction: Validators.code(),
                inputFormatters: [
                  LengthLimitingTextInputFormatter(4),
                ],
                cursorColor: AppColors.secondaryColor,
                backgroundColor: AppColors.textFieldBg,
                bordercolor: AppColors.secondaryColor,
                hintStyle: context.textTheme.bodySmall!.copyWith(
                  fontSize: 20.sp,
                  color: AppColors.secondaryColor.withValues(alpha: 0.5),
                ),
              ),
              61.verticalSpace,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 22.w),
                child: DoiButton(
                    text: context.l10n.startGame,
                    //isEnabled: isEnabled,
                    onPressed: () {
                      if (!isEnabled) {
                        _formKey.currentState?.save();
                        return;
                      }
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _secretCodeController.dispose();
    super.dispose();
  }
}
