import 'package:doi_mobile/core/extensions/texttheme_extensions.dart';
import 'package:doi_mobile/core/utils/colors.dart';
import 'package:doi_mobile/core/utils/enums.dart';
import 'package:doi_mobile/core/utils/type_defs.dart';
import 'package:doi_mobile/gen/fonts.gen.dart';
import 'package:doi_mobile/presentation/general_widgets/app_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppOverLay extends StatefulWidget {
  const AppOverLay({
    required this.child,
    required this.controller,
    super.key,
    this.messagePadding,
  });
  final Widget child;
  final OverLayController controller;
  final EdgeInsetsGeometry? messagePadding;

  @override
  State<AppOverLay> createState() => AppOverLayState();

  static AppOverLayState of(BuildContext context) {
    final result = context.findAncestorStateOfType<AppOverLayState>();
    if (result != null) return result;
    throw FlutterError.fromParts(<DiagnosticsNode>[
      ErrorSummary(
        '''AppOverLay.of() called with a context that does not contain a AppOverLay.''',
      ),
      ErrorDescription(
        '''No AppOverLay ancestor could be found starting from the context that was passed to AppOverLay.of(). '''
        '''This usually happens when the context provided is from the same StatefulWidget as that '''
        '''whose build function actually creates the AppOverLay widget being sought.''',
      ),
      context.describeElement('The context used was'),
    ]);
  }
}

class AppOverLayState extends State<AppOverLay> {
  OverLayController get controller => widget.controller;
  double scale = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      textDirection: TextDirection.ltr,
      children: [
        widget.child,
        ValueListenableBuilder<
            ({OverLayType type, MessageText? msg, Color? color})>(
          valueListenable: widget.controller._valueNotifier,
          builder: (context, listen, child) {
            if (listen.type == OverLayType.loader) {
              return Positioned.fill(
                child: Material(
                  color: Colors.black.withValues(alpha: .5),
                  child: AppLoader(
                    color: listen.color ?? Colors.white,
                  ),
                ),
              );
            } else if (listen.type == OverLayType.message) {
              return SafeArea(
                child: Container(
                  padding: widget.messagePadding ??
                      EdgeInsets.only(top: 100.h, bottom: 16.h),
                  alignment: Alignment.topCenter,
                  child: TweenAnimationBuilder<double>(
                    tween: Tween(begin: -40, end: 0),
                    curve: Curves.easeInOut,
                    duration: const Duration(
                      milliseconds: 500,
                    ),
                    builder: (context, value, child) {
                      return Transform.translate(
                        offset: Offset(0, value),
                        child: _messageWidget(
                          messageText: listen.msg,
                          onClose: () {
                            controller.removeOverLay();
                          },
                        ),
                      );
                    },
                  ),
                ),
              );
            }
            return const SizedBox();
          },
        ),
      ],
    );
  }

  Widget _messageWidget({
    required MessageText? messageText,
    required VoidCallback onClose,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: messageText?.messageType == MessageType.error
            ? AppColors.lossOverlay
            : AppColors.green,
        border: Border(
          bottom: BorderSide(
            color: messageText?.messageType == MessageType.error
                ? AppColors.lossBorder
                : AppColors.winBorder,
            width: 2,
          ),
        ),
      ),
      child: GestureDetector(
        onTap: onClose,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
          width: double.infinity,
          constraints: BoxConstraints(
            minHeight: 40,
            maxWidth: MediaQuery.of(context).size.width,
            minWidth: MediaQuery.of(context).size.width,
          ),
          child: Text(
            messageText?.message ?? '',
            maxLines: 10,
            overflow: TextOverflow.ellipsis,
            style: context.textTheme.bodyMedium?.copyWith(
              fontFamily: FontFamily.jungleAdventurer,
              fontSize: 22.sp,
              fontWeight: FontWeight.w400,
              color: AppColors.white,
            ),
            textDirection: TextDirection.ltr,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

class OverLayController {
  final ValueNotifier<({OverLayType type, MessageText? msg, Color? color})>
      _valueNotifier =
      ValueNotifier((type: OverLayType.none, msg: null, color: null));

  void showLoader({Color? color}) {
    _valueNotifier.value = (type: OverLayType.loader, msg: null, color: color);
  }

  void showError({required String message}) {
    _valueNotifier.value = (
      type: OverLayType.message,
      msg: (message: message, messageType: MessageType.error),
      color: AppColors.red,
    );
    Future.delayed(const Duration(seconds: 1), removeOverLay);
  }

  void showSuccess({required String message}) {
    _valueNotifier.value = (
      type: OverLayType.message,
      msg: (message: message, messageType: MessageType.success),
      color: AppColors.green,
    );
    Future.delayed(const Duration(seconds: 1), removeOverLay);
  }

  void removeOverLay() {
    _valueNotifier.value = (type: OverLayType.none, msg: null, color: null);
  }

  void dispose() => _valueNotifier.dispose();
}
