import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:shop_app/api/auth_api.dart';

class Auth with ChangeNotifier {
  String? _token;
  String? _userId;
  DateTime? _expireTime;

  bool get isLoggedIn {
    return token != null;
  }

  String? get token {
    if (_expireTime?.isAfter(DateTime.now()) ?? false) {
      return _token;
    }
  }

  Future<void> signup(String email, String password) async {
    final response =
        await AuthApi().authenticate(email, password, AuthApi.SIGNUP_END_POINT);
    final data = json.decode(response.body);
    _setupData(data);
  }

  Future<void> login(String email, String password) async {
    final response =
        await AuthApi().authenticate(email, password, AuthApi.LOGIN_END_POINT);
    final data = json.decode(response.body);
    _setupData(data);
  }

  void _setupData(dynamic data) {
    _token = data['idToken'];
    _userId = data['localId'];
    _expireTime = DateTime.now().add(Duration(
      seconds: int.tryParse(data['expiresIn']) ?? 0,
    ));
    notifyListeners();
  }
}
