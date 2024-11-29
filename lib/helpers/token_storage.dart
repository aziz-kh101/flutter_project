import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class _TokenStorage {
  final _key = 'token';
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  Future<void> saveToken(String token) async {
    await _storage.write(key: _key, value: token);
  }

  Future<String?> getToken() async {
    return await _storage.read(key: _key);
  }

  Future<void> removeToken() async {
    await _storage.delete(key: _key);
  }
}

final tokenStorage = _TokenStorage();
