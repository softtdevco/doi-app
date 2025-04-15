import 'package:doi_mobile/core/extensions/navigation_extensions.dart';
import 'package:doi_mobile/gen/assets.gen.dart';
import 'package:doi_mobile/presentation/general_widgets/customizable_row.dart';
import 'package:doi_mobile/presentation/general_widgets/doi_svg_widget.dart';
import 'package:flutter/material.dart';

class DoiAppbar extends StatelessWidget implements PreferredSizeWidget {
  const DoiAppbar({
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
        top: MediaQuery.of(context).padding.top,
        left: 0,
        right: 0,
        bottom: 0,
      ),
      decoration: const BoxDecoration(color: Colors.transparent),
      width: MediaQuery.sizeOf(context).width,
      child: Row(
        children: [
          Expanded(
            child: CustomizableRow(
              flexValues: const [1, 4, 1],
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
                Center(
                  child: title ?? SizedBox(),
                ),
                trailing ?? const SizedBox(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static final _appBar = AppBar();

  @override
  Size get preferredSize => _appBar.preferredSize;
}
