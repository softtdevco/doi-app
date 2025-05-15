import 'package:doi_mobile/core/utils/enums.dart';
import 'package:doi_mobile/presentation/features/onboarding/data/models/login_device_response.dart';

abstract interface class UserRepository {
  Language getLanguage();
  Future<void> updateLanguage(Language language);
  DoiUser getUser();
  Future<void> updateUser(DoiUser user);
  String getToken();
  String getRefreshToken();
  Future<void> saveToken(String token);
  void saveRefreshToken(String token);
  Future<void> saveCurrentState(CurrentState val);
  CurrentState getCurrentState();
  void deleteUser();
}
