import 'package:doi_mobile/core/extensions/context_extensions.dart';
import 'package:doi_mobile/core/extensions/input.design.extension.dart';
import 'package:doi_mobile/core/extensions/navigation_extensions.dart';
import 'package:doi_mobile/core/extensions/texttheme_extensions.dart';
import 'package:doi_mobile/core/extensions/widget_extensions.dart';
import 'package:doi_mobile/core/utils/colors.dart';
import 'package:doi_mobile/core/utils/styles.dart';
import 'package:doi_mobile/gen/assets.gen.dart';
import 'package:doi_mobile/l10n/l10n.dart';
import 'package:doi_mobile/presentation/features/dashboard/home/presentation/notifiers/home_notifier.dart';
import 'package:doi_mobile/presentation/features/onboarding/presentation/widgets/login.dart';
import 'package:doi_mobile/presentation/features/onboarding/presentation/widgets/signup.dart';
import 'package:doi_mobile/presentation/features/onboarding/presentation/widgets/authenication_bar.dart';
import 'package:doi_mobile/presentation/general_widgets/customizable_row.dart';
import 'package:doi_mobile/presentation/general_widgets/doi_button.dart';
import 'package:doi_mobile/presentation/general_widgets/doi_scaffold.dart';
import 'package:doi_mobile/presentation/general_widgets/doi_svg_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Authentication extends ConsumerStatefulWidget {
  const Authentication({super.key});

  @override
  ConsumerState<Authentication> createState() => _AuthenticationState();
}

class _AuthenticationState extends ConsumerState<Authentication> {
 
 bool switchTab = true;
  @override
  Widget build(BuildContext context) {
     final notifier = ref.read(homeNotifierProvider.notifier);
    final selectedPlay =
        ref.watch(homeNotifierProvider.select((v) => v.playBackIndex));
    return 
     Column(
children: [
 
  AppSvgIcon(
      path: 
     Assets.svgs.close,
     onTap: (){
      context.pop();
     },
     fit: BoxFit.scaleDown,
     ).withContainer(alignment: Alignment.centerRight),
4.verticalSpace,
Column(
  children: [
    AuthenicationBarType(
  index: selectedPlay,
                  onChanged: (p0) {
                  notifier.selectPlayBacksIndex(p0);
                },
  label1: context.l10n.login,
 label2: context.l10n.signUp,).withContainer(
  width: 172.w,
  height: 42.h
 ),
 34.verticalSpace,
  (selectedPlay ==0)?
  LoginPage():SignPage()
  ],
)
]
,
    ).withContainer(padding: EdgeInsets.all(20)) ;
  }
}