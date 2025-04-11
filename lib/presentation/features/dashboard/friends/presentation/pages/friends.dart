import 'package:doi_mobile/core/extensions/navigation_extensions.dart';
import 'package:doi_mobile/core/extensions/texttheme_extensions.dart';
import 'package:doi_mobile/core/router/router.dart';
import 'package:doi_mobile/core/utils/colors.dart';
import 'package:doi_mobile/gen/assets.gen.dart';
import 'package:doi_mobile/presentation/features/dashboard/friends/presentation/pages/widgets/play_friend_tile.dart';
import 'package:doi_mobile/presentation/features/dashboard/home/presentation/pages/widgets/bar.dart';
import 'package:doi_mobile/presentation/features/dashboard/home/presentation/pages/widgets/home_appbar.dart';
import 'package:doi_mobile/presentation/features/dashboard/home/presentation/pages/widgets/min_textfield.dart';
import 'package:doi_mobile/presentation/general_widgets/doi_scaffold.dart';
import 'package:doi_mobile/presentation/general_widgets/doi_svg_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Friends extends StatefulWidget {
  const Friends({super.key});

  @override
  State<Friends> createState() => _FriendsState();
}

class _FriendsState extends State<Friends> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return DoiScaffold(
      bodyPadding: EdgeInsets.all(24),
      appbar: DoiHomeAppbar(),
      body: Column(
        children: [
          GameBarType(
            textColor: AppColors.secondaryColor,
            cardColor: AppColors.indicator,
            label1: 'Friends (3)',
            label2: 'Pending (1)',
            index: index,
            onChanged: (p0) {
              setState(() {
                index = p0;
              });
            },
          ),
          24.verticalSpace,
          MinFormField(
            width: double.infinity,
            textAlign: TextAlign.left,
            cursorColor: AppColors.primaryColor,
            decoration: InputDecoration(
              prefixIcon: AppSvgIcon(
                path: Assets.svgs.search,
                fit: BoxFit.scaleDown,
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: 16),
              fillColor: AppColors.indicator,
              filled: true,
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(12.r),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(12.r),
              ),
              hintText: 'Search friends',
              hintStyle: context.textTheme.bodySmall?.copyWith(
                fontSize: 14.sp,
                color: Color(0xFFD7A07D),
              ),
            ),
          ),
          18.verticalSpace,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                spacing: 16,
                children: List.generate(
                  3,
                  (i) => PlayFriendTile(
                    index: i + 1,
                    onTap: () {
                      if (i == 0) {
                        context.pushNamed(AppRouter.addingFriend);
                      }
                    },
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
