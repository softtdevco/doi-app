import 'package:doi_mobile/core/utils/enums.dart';
import 'package:doi_mobile/data/local_storage/storage.dart';
import 'package:doi_mobile/data/local_storage/storage_impl.dart';
import 'package:doi_mobile/data/local_storage/storage_keys.dart';
import 'package:doi_mobile/presentation/features/profile/data/repository/user_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserRepositoryImpl implements UserRepository {
  UserRepositoryImpl(
    this._storage,
    this._ref,
  );
  final LocalStorage _storage;
  final Ref _ref;

  @override
  Language getLanguage() {
    final languageName =
        _storage.get(HiveKeys.language) ?? Language.english.name;
    return Language.values.firstWhere((lang) => lang.name == languageName);
  }

  @override
  Future<void> updateLanguage(Language language) async {
    await _storage.put(HiveKeys.language, language.name);
    _ref.read(currentUserLanguage.notifier).state = language;
  }
}

final userRepositoryProvider = Provider<UserRepository>(
  (ref) => UserRepositoryImpl(
    ref.read(localDB),
    ref,
  ),
);

final currentUserLanguage = StateProvider<Language>((ref) {
  final language = ref.read(userRepositoryProvider).getLanguage();
  return language;
});
