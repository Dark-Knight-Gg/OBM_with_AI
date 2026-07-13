import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:obm_gen_with_ai/features/login/model/login_model.dart';
import 'dart:convert';
class AppStorage {
  static const _storage = FlutterSecureStorage();
  static const _keyAccessToken = 'access_token';
  static const _keyUserInfo = 'userInfo';

  Future<void> saveAccessToken({
    required String accessToken,
  }) async {
    await _storage.write(key: _keyAccessToken, value: accessToken);
  }

  Future<String?> getAccessToken() async {
    return _storage.read(key: _keyAccessToken);
  }

  Future<void> saveUserInfo(UserInfoModel user) async {
    await _storage.write(
      key: _keyUserInfo,
      value: jsonEncode(user.toJson()),
    );
  }

  /// Get UserInfo
  static Future<UserInfoModel?> getUserInfo() async {
    final data = await _storage.read(key: _keyUserInfo);

    if (data == null || data.isEmpty) {
      return null;
    }

    try {
      final json = jsonDecode(data) as Map<String, dynamic>;
      return UserInfoModel.fromJson(json);
    } catch (e) {
      return null;
    }
  }

  Future<void> clear() async {
    await _storage.delete(key: _keyAccessToken);
    await _storage.delete(key: _keyUserInfo);
  }

  Future<bool> hasToken() async {
    final token = await getAccessToken();
    return token != null && token.isNotEmpty;
  }
}
