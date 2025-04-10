import 'package:doi_mobile/core/extensions/context_extensions.dart';
import 'package:doi_mobile/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DoiScaffold extends StatelessWidget {
  const DoiScaffold({
    required this.body,
    super.key,
    this.resizeToAvoidBottomInset,
    this.appbar,
    this.floatingActionButton,
    this.bottomNavigationBar,
    this.footerButton,
    this.underFooterChild,
    this.bodyPadding,
    this.extendBody = false,
    this.backgroundColor,
    this.backgroundImage,
    this.showBackImage = true,
    this.footerPadding,
  });
  final Widget body;
  final bool? resizeToAvoidBottomInset;
  final PreferredSizeWidget? appbar;
  final Widget? floatingActionButton;
  final Widget? bottomNavigationBar;
  final Widget? footerButton;
  final Widget? underFooterChild;
  final EdgeInsetsGeometry? bodyPadding, footerPadding;
  final bool extendBody;
  final Color? backgroundColor;
  final ImageProvider? backgroundImage;
  final bool showBackImage;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Theme(
        data: Theme.of(context).copyWith(
          dividerTheme: const DividerThemeData(color: Colors.transparent),
        ),
        child: Scaffold(
          backgroundColor: backgroundColor,
          appBar: appbar,
          resizeToAvoidBottomInset: resizeToAvoidBottomInset,
          body: SafeArea(
            child: Stack(
              fit: StackFit.expand,
              children: [
                if (showBackImage)
                  Positioned.fill(
                    child: Image(
                      image:
                          backgroundImage ?? Assets.images.pattern.provider(),
                      fit: BoxFit.cover,
                      repeat: ImageRepeat.repeat,
                    ),
                  ),
                Padding(
                  padding:
                      bodyPadding ?? EdgeInsets.symmetric(horizontal: 18.w),
                  child: body,
                ),
              ],
            ),
          ),
          floatingActionButton: floatingActionButton,
          bottomNavigationBar: bottomNavigationBar,
          persistentFooterButtons: (footerButton != null)
              ? [
                  Padding(
                    padding: footerPadding ??
                        EdgeInsets.symmetric(
                          horizontal: 10.w,
                        ),
                    child: Container(
                      margin: context.bottomPaddingForTextField,
                      child: Column(
                        children: [
                          footerButton!,
                          16.verticalSpace,
                          if (underFooterChild != null) underFooterChild!
                        ],
                      ),
                    ),
                  ),
                ]
              : null,
          extendBody: extendBody,
        ),
      ),
    );
  }
}
