import 'package:doi_mobile/core/extensions/context_extensions.dart';
import 'package:doi_mobile/core/extensions/texttheme_extensions.dart';
import 'package:doi_mobile/core/utils/colors.dart';
import 'package:doi_mobile/gen/assets.gen.dart';
import 'package:doi_mobile/l10n/l10n.dart';
import 'package:doi_mobile/presentation/features/dashboard/friends/presentation/pages/widgets/invite_friend_sheet.dart';
import 'package:doi_mobile/presentation/features/dashboard/friends/presentation/pages/widgets/pending_friend_tile.dart';
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
            label1: context.l10n.friends('3'),
            label2: context.l10n.pending('1'),
            index: index,
            onChanged: (p0) {
              setState(() {
                index = p0;
              });
            },
          ),
          24.verticalSpace,
          switch (index) {
            0 => Column(
                children: [
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
                      hintText: context.l10n.searchFriends,
                      hintStyle: context.textTheme.bodySmall?.copyWith(
                        fontSize: 14.sp,
                        color: Color(0xFFD7A07D),
                      ),
                    ),
                  ),
                  18.verticalSpace,
                  Column(
                    spacing: 16,
                    children: List.generate(
                      3,
                      (i) => PlayFriendTile(
                        index: i + 1,
                        onTap: () {
                          context.showBottomSheet(
                            isDismissible: true,
                            color: AppColors.background,
                            child: InviteFriendSheet(),
                          );
                        },
                      ),
                    ),
                  )
                ],
              ),
            _ => Column(
                spacing: 16,
                children: List.generate(
                  1,
                  (i) => PendingFriendTile(
                    index: i + 1,
                    onTap: () {},
                  ),
                ),
              )
          }
        ],
      ),
    );
  }
}
