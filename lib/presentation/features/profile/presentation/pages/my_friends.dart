import 'package:doi_mobile/core/extensions/texttheme_extensions.dart';
import 'package:doi_mobile/core/utils/colors.dart';
import 'package:doi_mobile/gen/fonts.gen.dart';
import 'package:doi_mobile/presentation/features/profile/presentation/widgets/my_friend_tile.dart';
import 'package:doi_mobile/presentation/general_widgets/doi_appbar.dart';
import 'package:doi_mobile/presentation/general_widgets/doi_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyFriends extends StatelessWidget {
  const MyFriends({super.key});

  @override
  Widget build(BuildContext context) {
    return DoiScaffold(
      bodyPadding: EdgeInsets.all(24),
      showBackImage: false,
      appbar: DoiAppbar(
        title: Text(
          'Friends list'.toLowerCase(),
          style: context.textTheme.bodyMedium?.copyWith(
            fontSize: 20.sp,
            fontFamily: FontFamily.jungleAdventurer,
            color: AppColors.secondaryColor,
          ),
        ),
      ),
      body: Column(
        children: [
          Column(
            spacing: 16,
            children: List.generate(
              3,
              (i) => MyFriendTile(
                index: i + 1,
                onTap: () {},
              ),
            ),
          )
        ],
      ),
    );
  }
}
