

import 'package:doi_mobile/core/utils/enums.dart';

abstract interface class UserRepository {
  Language getLanguage();
  Future<void> updateLanguage(Language language);
  
}
