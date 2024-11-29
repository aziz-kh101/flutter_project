

import 'package:flutter/cupertino.dart';
import 'package:project/helpers/token_storage.dart';
import 'package:project/models/user.dart';

class UserProvider with ChangeNotifier {
  User? _user;
  bool _isUserLoading = true;

  User? get user => _user;
  bool get isUserLoading => _isUserLoading;

  void setUser(User? user) {
    _user = user;
    notifyListeners();
  }

  void setLoading(bool loading) {
    _isUserLoading = loading;
    notifyListeners();
  }

  void setUserAndLoading(User? user, bool loading) {
    _user = user;
    _isUserLoading = loading;
    notifyListeners();
  }

  void logout() {
    _user = null;
    tokenStorage.removeToken();
    notifyListeners();
  }
}