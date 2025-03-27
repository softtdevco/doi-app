import 'package:doi_mobile/gen/assets.gen.dart';
import 'package:doi_mobile/presentation/features/dashboard/home/presentation/pages/widgets/coin_count.dart';
import 'package:doi_mobile/presentation/general_widgets/doi_appbar.dart';
import 'package:doi_mobile/presentation/general_widgets/doi_scaffold.dart';
import 'package:doi_mobile/presentation/general_widgets/doi_svg_widget.dart';
import 'package:flutter/material.dart';

class GameCreated extends StatelessWidget {
  const GameCreated({super.key});

  @override
  Widget build(BuildContext context) {
    return DoiScaffold(
        bodyPadding: EdgeInsets.symmetric(horizontal: 30),
        appbar: DoiAppbar(
          title: CoinCount(),
          trailing: AppSvgIcon(path: Assets.svgs.help),
        ),
        body: Column(
          children: [],
        ));
  }
}
