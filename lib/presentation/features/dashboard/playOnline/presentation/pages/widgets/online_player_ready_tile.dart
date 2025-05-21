import 'package:doi_mobile/core/extensions/string_extensions.dart';
import 'package:doi_mobile/core/extensions/texttheme_extensions.dart';
import 'package:doi_mobile/core/extensions/widget_extensions.dart';
import 'package:doi_mobile/core/utils/colors.dart';
import 'package:doi_mobile/gen/assets.gen.dart';
import 'package:doi_mobile/gen/fonts.gen.dart';
import 'package:doi_mobile/presentation/features/dashboard/onlineGame/data/model/join_game_response.dart';
import 'package:doi_mobile/presentation/general_widgets/doi_svg_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnlinePlayerReadyTile extends StatelessWidget {
  const OnlinePlayerReadyTile({super.key, required this.player});
  final Player player;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(71.r),
              child: Image.asset(
                'assets/images/${('userPic4.png').toLowerCase()}',
                fit: BoxFit.cover,
                height: 116.h,
                width: 117.w,
                errorBuilder: (context, error, stackTrace) => ClipRRect(
                  borderRadius: BorderRadius.circular(182.r),
                  child: Image.asset(
                    Assets.images.userpic3.path,
                    fit: BoxFit.cover,
                    height: 116.h,
                    width: 117.w,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Text(getFlagEmoji('US')),
            )
          ],
        ),
        24.verticalSpace,
        Text(
          player.username ?? '...',
          style: context.textTheme.bodyMedium?.copyWith(
            fontSize: 24.sp,
            color: AppColors.secondaryColor,
            fontFamily: FontFamily.jungleAdventurer,
          ),
        )
      ],
    );
  }
}

class OnlinePlayerWaitingTile extends StatefulWidget {
  const OnlinePlayerWaitingTile({
    super.key,
  });

  @override
  State<OnlinePlayerWaitingTile> createState() =>
      _OnlinePlayerWaitingTileState();
}

class _OnlinePlayerWaitingTileState extends State<OnlinePlayerWaitingTile>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    final curves =
        CurvedAnimation(parent: _controller, curve: Curves.bounceInOut);
    _animation = Tween<double>(begin: 1.0, end: 0.2).animate(curves)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          _controller.forward();
        }
      });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: AnimatedBuilder(
        animation: _animation,
        child: Column(
          children: [
            AppSvgIcon(
              path: Assets.svgs.question,
              fit: BoxFit.scaleDown,
            ).withContainer(
              color: AppColors.iconBorder,
              shape: BoxShape.circle,
              height: 116.h,
              width: 117.w,
            ),
            24.verticalSpace,
            Text(
              '...',
              style: context.textTheme.bodyMedium?.copyWith(
                fontSize: 24.sp,
                color: AppColors.secondaryColor,
                fontFamily: FontFamily.jungleAdventurer,
              ),
            )
          ],
        ),
        builder: (context, child) {
          return AnimatedOpacity(
            opacity: _animation.value,
            duration: const Duration(milliseconds: 500),
            child: child,
          );
        },
      ),
    );
  }
}
