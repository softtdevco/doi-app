import 'package:doi_mobile/core/extensions/texttheme_extensions.dart';
import 'package:doi_mobile/core/utils/colors.dart';
import 'package:doi_mobile/presentation/general_widgets/doi_svg_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NavBar extends ConsumerWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = [
      'home',
      'friends',
      'tournaments',
      'wallet',
    ];
    final v = ref.watch(currentIndexProvider);
    return Container(
      padding: EdgeInsets.fromLTRB(
        23.w,
        20.h,
        23.w,
        20.h,
      ),
      color: context.colorScheme.surface,
      width: double.infinity,
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(
            items.length,
            (index) => Expanded(
              child: InkWell(
                onTap: () {
                  ref.read(currentIndexProvider.notifier).state = index;
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  transform: Matrix4.identity()..scale(index == v ? 1.0 : 1.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AppSvgIcon(
                        path: 'assets/svgs/${items[index]}.svg',
                        color: index == v
                            ? AppColors.secondaryColor
                            : AppColors.unSelected,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

final currentIndexProvider = StateProvider.autoDispose<int>((ref) => 0);
