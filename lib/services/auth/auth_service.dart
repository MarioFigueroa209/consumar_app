import 'dart:convert';

import 'package:http/http.dart' as http;
import '../../models/auth/user_authenticated_model.dart';
import '../api_services.dart';

class AuthService {
  Future<UserAuthenticatedModel> login(String user, String password) async {
    //SharedPreferences prefs = await SharedPreferences.getInstance();
    final response = await http.post(
      urlAuthLogin,
      headers: {
        "accept": "application/json",
        "Content-Type": "application/json"
      },
      body: jsonEncode({
        "login": user,
        "password": password,
      }),
    );

    if (response.statusCode == 200) {
      var result = UserAuthenticatedModel.fromJson(jsonDecode(response.body));
      //prefs.setString("token", result.token);
      return result;
    }
    //throw Exception('Usuario o contraseña incorrecta!');
    return UserAuthenticatedModel();
  }
}
