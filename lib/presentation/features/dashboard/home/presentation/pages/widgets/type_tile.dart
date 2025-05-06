import 'package:doi_mobile/core/extensions/texttheme_extensions.dart';
import 'package:doi_mobile/core/extensions/widget_extensions.dart';
import 'package:doi_mobile/core/utils/colors.dart';
import 'package:doi_mobile/gen/assets.gen.dart';
import 'package:doi_mobile/presentation/features/dashboard/onlineGame/presentation/notifiers/online_game_notifier.dart';
import 'package:doi_mobile/presentation/general_widgets/doi_svg_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TypeTile extends ConsumerWidget {
  const TypeTile({
    super.key,
    required this.text,
  });
  final String text;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedType =
        ref.watch(onlineGameNotifierProvider.select((v) => v.type));
    return GestureDetector(
      onTap: () =>
          ref.read(onlineGameNotifierProvider.notifier).updateType(text),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text,
            style: context.textTheme.bodySmall?.copyWith(
                fontSize: 14.sp,
                color: switch (selectedType == text) {
                  true => AppColors.secondaryColor,
                  false => AppColors.secondaryColor.withValues(alpha: 0.7),
                }),
          ),
          if (selectedType == text) ...[
            10.horizontalSpace,
            AppSvgIcon(path: Assets.svgs.mark)
          ]
        ],
      ).withContainer(
          padding: EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 20,
          ),
          borderRadius: BorderRadius.circular(10),
          color: AppColors.indicator,
          border: switch (selectedType == text) {
            true => Border.all(
                color: AppColors.secondaryColor,
                width: 2,
              ),
            _ => null
          }),
    );
  }
}
