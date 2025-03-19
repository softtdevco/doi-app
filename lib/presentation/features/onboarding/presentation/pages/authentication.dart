import 'package:doi_mobile/core/extensions/widget_extensions.dart';
import 'package:doi_mobile/core/utils/colors.dart';
import 'package:doi_mobile/core/utils/styles.dart';
import 'package:doi_mobile/gen/assets.gen.dart';
import 'package:doi_mobile/l10n/l10n.dart';
import 'package:doi_mobile/presentation/general_widgets/customizable_row.dart';
import 'package:doi_mobile/presentation/general_widgets/doi_button.dart';
import 'package:doi_mobile/presentation/general_widgets/doi_scaffold.dart';
import 'package:doi_mobile/presentation/general_widgets/doi_svg_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Authentication extends StatefulWidget {
  const Authentication({super.key});

  @override
  State<Authentication> createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {
 
 bool switchTab = true;
  @override
  Widget build(BuildContext context) {
    return  Column(
children: [
 
  AppSvgIcon(
      path: 
     Assets.svgs.close,
     fit: BoxFit.scaleDown,
     ).withContainer(alignment: Alignment.centerRight),
Column(
  children: [
   
  ],
).withContainer(
  
  width: 172.w,
  height: 42,
  padding: EdgeInsets.symmetric(horizontal: 20.w,vertical: 20.h )
)
],
    ) ;
  }
}