import 'package:doi_mobile/core/extensions/navigation_extensions.dart';
import 'package:doi_mobile/core/extensions/texttheme_extensions.dart';
import 'package:doi_mobile/core/utils/colors.dart';
import 'package:doi_mobile/gen/assets.gen.dart';
import 'package:doi_mobile/gen/fonts.gen.dart';
import 'package:doi_mobile/presentation/general_widgets/doi_svg_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ScanToJoin extends StatelessWidget {
  const ScanToJoin({super.key, required this.inviteLink});
  final String inviteLink;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 24.w, right: 24.w, bottom: 34.h),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Opacity(
                opacity: 0.0,
                child: AppSvgIcon(path: Assets.svgs.close),
              ),
              Text(
                'SCAN QR',
                style: context.textTheme.bodyMedium?.copyWith(
                  color: AppColors.secondaryColor,
                  fontSize: 22.sp,
                  fontFamily: FontFamily.jungleAdventurer,
                ),
              ),
              AppSvgIcon(
                path: Assets.svgs.close,
                onTap: () => context.pop(),
              )
            ],
          ),
          50.verticalSpace,
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
                color: AppColors.white,
              ),
              width: 260.w,
              child: QrImageView(
                data: inviteLink,
                version: QrVersions.auto,
                eyeStyle: QrEyeStyle(
                  eyeShape: QrEyeShape.square,
                  color: AppColors.secondaryColor,
                ),
                dataModuleStyle: QrDataModuleStyle(
                  dataModuleShape: QrDataModuleShape.square,
                  color: AppColors.secondaryColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
