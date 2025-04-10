import 'package:doi_mobile/core/extensions/texttheme_extensions.dart';
import 'package:doi_mobile/gen/assets.gen.dart';
import 'package:doi_mobile/presentation/features/dashboard/home/data/model/friend_model.dart';
import 'package:doi_mobile/presentation/features/dashboard/home/presentation/pages/widgets/waiting_friend_tile.dart';
import 'package:doi_mobile/presentation/general_widgets/doi_appbar.dart';
import 'package:doi_mobile/presentation/general_widgets/doi_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WaitingScreen extends StatelessWidget {
  const WaitingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DoiScaffold(
      bodyPadding: EdgeInsets.all(24),
      showBackImage: false,
      appbar: DoiAppbar(
        leading: Assets.svgs.close,
      ),
      body: Column(
        children: [
          11.verticalSpace,
          Text(
            'Waiting for friend to join',
            style: context.textTheme.bodySmall?.copyWith(fontSize: 20.sp),
          ),
          46.verticalSpace,
          ClipRRect(
            child: Assets.images.avatar1.image(
              height: 61.h,
              width: 61.w,
            ),
            borderRadius: BorderRadius.circular(32.r),
          ),
          63.verticalSpace,
          Column(
            spacing: 16,
            children: List.generate(
              waitingFriends.length,
              (i) => WaitingFriendTile(
                friend: waitingFriends[i],
              ),
            ),
          )
        ],
      ),
      footerButton: Assets.images.mobileLeaderboard.image(),
    );
  }
}
