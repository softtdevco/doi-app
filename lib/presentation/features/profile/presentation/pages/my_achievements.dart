import 'package:doi_mobile/core/extensions/texttheme_extensions.dart';
import 'package:doi_mobile/core/utils/colors.dart';
import 'package:doi_mobile/gen/assets.gen.dart';
import 'package:doi_mobile/gen/fonts.gen.dart';
import 'package:doi_mobile/presentation/features/profile/data/model/achievements_model.dart';
import 'package:doi_mobile/presentation/general_widgets/doi_appbar.dart';
import 'package:doi_mobile/presentation/general_widgets/doi_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyAchievements extends StatelessWidget {
  const MyAchievements({super.key});

  @override
  Widget build(BuildContext context) {
    final isFriend =
        ModalRoute.of(context)?.settings.arguments as bool? ?? false;
    return DoiScaffold(
      bodyPadding: EdgeInsets.all(24),
      showBackImage: false,
      appbar: DoiAppbar(
        title: Text(
          isFriend
              ? 'achievements'.toUpperCase()
              : 'my Achievements'.toUpperCase(),
          style: context.textTheme.bodyMedium?.copyWith(
            fontSize: 20.sp,
            fontFamily: FontFamily.jungleAdventurer,
            color: AppColors.secondaryColor,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (isFriend) ...[
            ClipRRect(
              borderRadius: BorderRadius.circular(182.r),
              child: Assets.images.opponet.image(
                fit: BoxFit.cover,
                height: 106.h,
                width: 106.w,
              ),
            ),
            12.verticalSpace,
          ],
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Assets.images.badgeBg.image(
                height: 20.h,
                width: 20.w,
              ),
              4.horizontalSpace,
              Text(
                '6',
                style: context.textTheme.bodySmall?.copyWith(
                  fontSize: 24.sp,
                ),
              ),
              2.horizontalSpace,
              Text(
                '/300',
                style: context.textTheme.bodySmall?.copyWith(
                  fontSize: 14.sp,
                  color: AppColors.secondaryColor.withValues(alpha: 0.7),
                ),
              )
            ],
          ),
          4.verticalSpace,
          Text(
            'Badges collected',
            style: context.textTheme.bodySmall?.copyWith(
              fontSize: 14.sp,
              color: AppColors.secondaryColor.withValues(alpha: 0.7),
            ),
          ),
          33.verticalSpace,
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 0.8,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: achievements.length,
              itemBuilder: (context, index) {
                return AchievemenTile(model: achievements[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class AchievemenTile extends StatelessWidget {
  const AchievemenTile({super.key, required this.model});
  final AchievementsModel model;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        switch (model.isAchieved) {
          true => Assets.images.badgeBg,
          _ => Assets.images.badgeLock,
        }
            .image(),
        4.verticalSpace,
        Text(
          model.name,
          style: context.textTheme.bodySmall?.copyWith(
              fontSize: 12.sp,
              color: switch (model.isAchieved) {
                true => AppColors.secondaryColor,
                _ => AppColors.disableLock,
              }),
        )
      ],
    );
  }
}
