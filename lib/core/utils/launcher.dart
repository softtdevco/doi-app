import 'package:doi_mobile/core/utils/logger.dart';
import 'package:url_launcher/url_launcher.dart';

class LauncherHelpers {
  static Future<void> openUrl({String? path}) async {
    final linkUri = Uri(
      scheme: 'https',
      host: 'doi-psi.vercel.app',
      path: path,
    );
    try {
      await launchUrl(
        linkUri,
        mode: LaunchMode.inAppBrowserView,
      );
    } catch (e) {
      debugLog(e);
    }
  }

 
}
