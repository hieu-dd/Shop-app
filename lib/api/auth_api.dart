import 'dart:convert';

import 'package:http/http.dart' as http;

class AuthApi {
  static const _BASE_URL = 'https://identitytoolkit.googleapis.com/v1/';
  static const _API_KEY = "AIzaSyCjdUHEvKP0PQZ0kwj7jeH42_VwU0_CO34";
  static const SIGNUP_END_POINT = "signUp";
  static const LOGIN_END_POINT = "signInWithPassword";

  Future<http.Response> authenticate(
      String email, String password, String END_POINT) async {
    final url = Uri.parse('${_BASE_URL}accounts:$END_POINT?key=$_API_KEY');
    final response = await http.post(url,
        body: json.encode({
          'email': email,
          'password': password,
          'returnSecureToken': true,
        }));
    final data = json.decode(response.body);

    if (data['error'] != null) {
      throw Exception(data['error']['message']);
    }

    return response;
  }
}
