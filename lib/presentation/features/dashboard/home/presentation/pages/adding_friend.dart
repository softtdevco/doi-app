import 'package:doi_mobile/core/extensions/texttheme_extensions.dart';
import 'package:doi_mobile/gen/assets.gen.dart';
import 'package:doi_mobile/presentation/general_widgets/doi_appbar.dart';
import 'package:doi_mobile/presentation/general_widgets/doi_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddingFriend extends StatelessWidget {
  const AddingFriend({super.key});

  @override
  Widget build(BuildContext context) {
    return DoiScaffold(
        appbar: DoiAppbar(
          leading: Assets.svgs.close,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              child: Assets.images.avatar1.image(
                height: 116.h,
                width: 116.w,
              ),
              borderRadius: BorderRadius.circular(70.r),
            ),
            25.verticalSpace,
            Text(
              'Adding Collins as \nyour friend...',
              style: context.textTheme.bodySmall?.copyWith(fontSize: 20.sp),
              textAlign: TextAlign.center,
            ),
          ],
        ));
  }
}
