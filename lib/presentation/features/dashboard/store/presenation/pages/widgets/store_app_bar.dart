import 'package:doi_mobile/core/extensions/navigation_extensions.dart';
import 'package:doi_mobile/gen/assets.gen.dart';
import 'package:doi_mobile/presentation/general_widgets/doi_svg_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StoreAppbar extends StatelessWidget implements PreferredSizeWidget {
  const StoreAppbar({
    this.showBackButton = true,
    this.title,
    this.trailing,
    this.onTap,
    this.leading,
    this.color,
    super.key,
  });

  final bool showBackButton;
  final Widget? title, trailing;
  final String? leading;

  final Color? color;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: 20.h + MediaQuery.of(context).padding.top,
        left: 24.w,
        right: 24.w,
        bottom: 0,
      ),
      decoration: const BoxDecoration(color: Colors.transparent),
      width: MediaQuery.sizeOf(context).width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          switch (showBackButton == true) {
            true => AppSvgIcon(
                path: leading ?? Assets.svgs.back,
                fit: BoxFit.scaleDown,
                color: color,
                onTap: onTap ?? () => context.pop(),
              ),
            _ => const SizedBox()
          },
          Row(
            children: [
              24.horizontalSpace,
              title ?? SizedBox(),
            ],
          ),
          trailing ?? const SizedBox(),
        ],
      ),
    );
  }

  static final _appBar = AppBar();

  @override
  Size get preferredSize => _appBar.preferredSize;
}
