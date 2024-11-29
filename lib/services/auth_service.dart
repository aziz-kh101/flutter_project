import 'dart:convert';

import 'package:project/helpers/apis.dart';
import 'package:project/helpers/http_client.dart';
import 'package:project/helpers/token_storage.dart';
import 'package:project/models/user.dart';

class _AuthService {
  Future<bool> login(String email, String password) async {
    final response = await client.post(Uri.parse(Apis.login), body: {
      'email': email,
      'password': password,
    });

    if(response.statusCode == 200) {
      final token = jsonDecode(response.body)['token'];
      await tokenStorage.saveToken(token);
      return true;
    }

    return false;
  }

  Future<String> register(String email, String password, String firstName, String lastName) async {
    final response = await client.post(Uri.parse(Apis.register), body: {
      'email': email,
      'password': password,
      'firstName': firstName,
      'lastName': lastName,
    });

    return jsonDecode(response.body)['message'];
  }

  Future<User?> getUser() async {
    try {
      final response = await client.get(Uri.parse(Apis.userByToken));

      if(response.statusCode == 200) {
        return User.fromJson(jsonDecode(response.body));
      }
    } catch(e) {
      print(e);
    }

    return null;
  }
}

final authService = _AuthService();