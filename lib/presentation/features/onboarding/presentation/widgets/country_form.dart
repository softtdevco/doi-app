import 'package:country_picker/country_picker.dart';
import 'package:doi_mobile/core/extensions/input.design.extension.dart';
import 'package:doi_mobile/core/extensions/navigation_extensions.dart';
import 'package:doi_mobile/core/extensions/overlay_extensions.dart';
import 'package:doi_mobile/core/extensions/texttheme_extensions.dart';
import 'package:doi_mobile/core/extensions/widget_extensions.dart';
import 'package:doi_mobile/core/router/router.dart';
import 'package:doi_mobile/core/utils/colors.dart';
import 'package:doi_mobile/data/third_party_services/device_info_service.dart';
import 'package:doi_mobile/gen/assets.gen.dart';
import 'package:doi_mobile/l10n/l10n.dart';
import 'package:doi_mobile/presentation/features/onboarding/data/models/register_device_request.dart';
import 'package:doi_mobile/presentation/features/onboarding/presentation/notifier/onboarding.notifier.dart';
import 'package:doi_mobile/presentation/general_widgets/doi_button.dart';
import 'package:doi_mobile/presentation/general_widgets/doi_svg_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CountryForm extends ConsumerStatefulWidget {
  const CountryForm({super.key});

  @override
  ConsumerState<CountryForm> createState() => _CountryFormState();
}

class _CountryFormState extends ConsumerState<CountryForm> {
  String countryInput = '';
  String userCountry = '';

  _registerDevice() async {
    context.showLoading();
    final userName =
        ref.watch(onboardingNotifierProvider.select((v) => v.userName));
    final deviceId = await DeviceInfoService.instance.getDeviceInfo();

    final data = RegisterDeviceRequest(
      username: userName ?? '',
      country: countryInput,
      avatar: 'blank',
      deviceId: deviceId,

      //'Test unhpl',
    );
    ref.read(onboardingNotifierProvider.notifier).registerDevice(
        data: data,
        onError: (p0) {
          context.hideOverLay();
          context.showError(
            message: p0,
          );
        },
        onCompleted: (p0) {
          context
            ..hideOverLay()
            ..showSuccess(message: p0);
          context.replaceAll(AppRouter.dashboard);
        });
  }

  @override
  Widget build(BuildContext context) {
    final userName =
        ref.watch(onboardingNotifierProvider.select((v) => v.userName));

    return Column(
      children: [
        Text(
          '${context.l10n.hey} ${(userName ?? '')}',
          style: context.textTheme.bodySmall?.copyWith(
            fontSize: 22,
          ),
        ),
        13.verticalSpace,
        Text(
          context.l10n.whereAreYouFrom,
          style: context.textTheme.bodySmall?.copyWith(
            fontSize: 16.sp,
            color: AppColors.primaryColor,
          ),
        ),
        22.verticalSpace,
        GestureDetector(
          onTap: () {
            showCountryPicker(
              context: context,
              showPhoneCode: false,
              onSelect: (Country country) {
                setState(() {
                  userCountry = country.name;
                  countryInput =
                      "${country.flagEmoji} ${country.displayNameNoCountryCode}";
                });
              },
              countryListTheme: CountryListThemeData(
                searchTextStyle: context.textTheme.bodySmall!.copyWith(
                  fontSize: 10.sp,
                ),
                textStyle: context.textTheme.bodySmall!.copyWith(
                  fontSize: 10.sp,
                  color: AppColors.black,
                ),
                inputDecoration: InputDecoration().textfielddesign(
                  context,
                  isOutline: true,
                  borderRadius: BorderRadius.circular(2.r),
                  hint: 'Search for country',
                ),
              ),
            );
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppSvgIcon(path: Assets.svgs.infocircle),
                    12.horizontalSpace,
                    Expanded(
                      child: Text(
                        countryInput.isEmpty
                            ? context.l10n.selectCountry
                            : countryInput,
                        style: context.textTheme.bodySmall!.copyWith(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: countryInput.isEmpty
                                ? AppColors.darkShadeOrange
                                : AppColors.black),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    )
                  ],
                ),
              ),
              AppSvgIcon(path: Assets.svgs.dropdown),
            ],
          ).withContainer(
              width: 239.w,
              height: 48.h,
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 9),
              color: AppColors.indicator,
              borderRadius: BorderRadius.circular(12.r)),
        ),
        44.verticalSpace,
        DoiButton(
            width: 197,
            height: 48,
            text: context.l10n.letgo,
            onPressed: () {
              if (countryInput.isEmpty) {
                return;
              }

              _registerDevice();
            }),
        44.verticalSpace,
      ],
    );
  }
}
