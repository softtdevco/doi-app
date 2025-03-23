import 'package:device_preview/device_preview.dart';
import 'package:doi_mobile/core/router/router.dart';
import 'package:doi_mobile/core/utils/themes.dart';
import 'package:doi_mobile/l10n/l10n.dart';
import 'package:doi_mobile/presentation/features/onboarding/presentation/pages/splash.dart';
import 'package:doi_mobile/presentation/features/profile/data/repository/user_repository_impl.dart';
import 'package:doi_mobile/presentation/general_widgets/app_overlay.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class App extends ConsumerStatefulWidget {
  const App({super.key});

  @override
  ConsumerState<App> createState() => _AppState();
}

class _AppState extends ConsumerState<App> {
  final _controller = OverLayController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final selectedLang = ref.watch(currentUserLanguage);
    return ScreenUtilInit(
        designSize: const Size(360, 800),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, c) {
          return DevicePreview(
              enabled: kDebugMode,
              builder: (context) {
                return GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    FocusScope.of(context).requestFocus(FocusNode());
                  },
                  child: Directionality(
                    textDirection: TextDirection.ltr,
                    child: AppOverLay(
                      controller: _controller,
                      child: MaterialApp(
                        themeMode: ThemeMode.light,
                        theme: AppTheme.lightTheme,
                        darkTheme: AppTheme.darkTheme,
                        localizationsDelegates:
                            AppLocalizations.localizationsDelegates,
                        supportedLocales: AppLocalizations.supportedLocales,
                        home: const Splash(),
                        locale: selectedLang.locale,
                        routes: AppRouter.routes,
                        debugShowCheckedModeBanner: false,
                      ),
                    ),
                  ),
                );
              });
        });
  }
}
