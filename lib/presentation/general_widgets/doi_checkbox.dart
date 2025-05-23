import 'package:doi_mobile/gen/assets.gen.dart';
import 'package:doi_mobile/presentation/general_widgets/doi_svg_widget.dart';
import 'package:flutter/material.dart';

class DoiCheckbox extends StatelessWidget {
  final bool isChecked;
  final bool isGreenCheck;
  final void Function(bool) onChecked;
  const DoiCheckbox({
    super.key,
    this.isChecked = false,
    required this.onChecked,
    this.isGreenCheck = false,
  });

  @override
  Widget build(BuildContext context) {
    return AppSvgIcon(
      path: switch (isChecked) {
        true => isGreenCheck ? Assets.svgs.greenChecked : Assets.svgs.checked,
        _ => Assets.svgs.unchecked,
      },
      onTap: () {
        onChecked.call(isChecked);
      },
    );
  }
}
