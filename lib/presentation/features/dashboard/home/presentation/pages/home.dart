import 'package:doi_mobile/core/extensions/texttheme_extensions.dart';
import 'package:doi_mobile/core/utils/colors.dart';
import 'package:doi_mobile/core/utils/styles.dart';
import 'package:doi_mobile/gen/assets.gen.dart';
import 'package:doi_mobile/presentation/general_widgets/doi_button.dart';
import 'package:doi_mobile/presentation/general_widgets/doi_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return DoiScaffold(
      bodyPadding: EdgeInsets.all(24),
      body: Column(
        children: [
          24.verticalSpace,
          Stack(
            alignment: Alignment.center,
            children: [
              Assets.images.doi.image(
                fit: BoxFit.cover,
                width: 144,
              ),
              Positioned(
                bottom: 30,
                child: Text(
                  'Start new game',
                  style: context.textTheme.bodySmall?.copyWith(
                    fontSize: 16.sp,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                44.verticalSpace,
                DoiButton(
                  text: 'New Game',
                  onPressed: () {},
                ),
                16.verticalSpace,
                DoiButton(
                  buttonStyle: DoiButtonStyle(
                    background: AppColors.green,
                    borderColor: AppColors.greenBorder,
                  ),
                  text: 'Single player',
                  onPressed: () {},
                ),
                16.verticalSpace,
                DoiButton(
                  text: 'Story mode',
                  onPressed: () {},
                ),
              ],
            ),
          ),
          89.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Power ups',
                style: context.textTheme.bodySmall?.copyWith(
                  fontSize: 16.sp,
                ),
              ),
              Text(
                'Store',
                style: context.textTheme.bodySmall?.copyWith(
                  fontSize: 16.sp,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
