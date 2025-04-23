import 'dart:convert';

import 'package:doi_mobile/core/utils/enums.dart';
import 'package:doi_mobile/data/local_storage/storage.dart';
import 'package:doi_mobile/data/local_storage/storage_impl.dart';
import 'package:doi_mobile/data/local_storage/storage_keys.dart';
import 'package:doi_mobile/presentation/features/onboarding/data/models/login_device_response.dart';
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

  @override
  String getToken() {
    return _storage.get(HiveKeys.token) as String? ?? '';
  }

  @override
  Future<void> saveToken(String token) async {
    await _storage.put(HiveKeys.token, token);
  }

  @override
  String getRefreshToken() {
    return _storage.get(HiveKeys.refreshToken) as String? ?? '';
  }

  @override
  Future<void> saveRefreshToken(String token) async {
    await _storage.put(HiveKeys.refreshToken, token);
  }

  @override
  DoiUser getUser() {
    final response = _storage.get<String?>(HiveKeys.user);
    final user = DoiUser.fromJson(
      response == null
          ? {}
          : json.decode(response as String) as Map<String, dynamic>,
    );
    return user;
  }

  @override
  Future<void> updateUser(DoiUser user) async {
    await _storage.put(HiveKeys.user, json.encode(user));
    _ref.read(currentUserProvider.notifier).state = user;
    ;
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

final currentUserProvider = StateProvider<DoiUser>((ref) {
  final user = ref.read(userRepositoryProvider).getUser();
  return user;
});
