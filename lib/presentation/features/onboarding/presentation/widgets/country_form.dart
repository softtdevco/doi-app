import 'package:country_picker/country_picker.dart';
import 'package:doi_mobile/core/extensions/input.design.extension.dart';
import 'package:doi_mobile/core/extensions/navigation_extensions.dart';
import 'package:doi_mobile/core/extensions/texttheme_extensions.dart';
import 'package:doi_mobile/core/extensions/widget_extensions.dart';
import 'package:doi_mobile/core/router/router.dart';
import 'package:doi_mobile/core/utils/colors.dart';
import 'package:doi_mobile/gen/assets.gen.dart';
import 'package:doi_mobile/l10n/l10n.dart';
import 'package:doi_mobile/presentation/general_widgets/doi_button.dart';
import 'package:doi_mobile/presentation/general_widgets/doi_svg_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CountryForm extends StatefulWidget {
  const CountryForm({super.key});

  @override
  State<CountryForm> createState() => _CountryFormState();
}

class _CountryFormState extends State<CountryForm> {
  String countryInput = '';
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          context.l10n.hey + ' Alex!',
          style: context.textTheme.bodySmall?.copyWith(
            fontSize: 22,
          ),
        ),
        13.verticalSpace,
        Text(
          context.l10n.whereAreYouFrom,
          style: context.textTheme.bodySmall?.copyWith(
            fontSize: 22,
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
                inputDecoration: InputDecoration().textfielddesign(context,
                    isOutline: true,
                    borderRadius: BorderRadius.circular(2.r),
                    hint: 'Search for country'),
              ),
            );
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppSvgIcon(path: Assets.svgs.infocircle),
                  12.horizontalSpace,
                  Text(
                    countryInput.isEmpty
                        ? context.l10n.selectCountry
                        : countryInput,
                    style: context.textTheme.bodySmall!.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: countryInput.isEmpty
                            ? AppColors.darkShadeOrange
                            : AppColors.black),
                  )
                ],
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
            onPressed: () => {context.replaceAll(AppRouter.dashboard)}),
        44.verticalSpace,
      ],
    );
  }
}
