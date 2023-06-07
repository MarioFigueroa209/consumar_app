import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/usuario_model.dart';
import '../models/vw_get_user_data_by_cod_user.dart';
import 'api_services.dart';

class UsuarioService {
  Future<UsuarioModel> getUserById(BigInt idUsuario) async {
    var url = Uri.parse(urlGetUserById + idUsuario.toString());

    final response = await http.get(url);

    if (response.statusCode == 200) {
      return UsuarioModel.fromJson(jsonDecode(response.body));
    } else if (response.statusCode == 404) {
      UsuarioModel usuarioModel = UsuarioModel();
      usuarioModel.nombres = 'no encontrado';
      return usuarioModel;
    } else {
      throw Exception('Fallo al cargar');
    }
  }

  Future<VwgetUserDataByCodUser> getUserDataByCodUser(String codUsuario) async {
    var url = Uri.parse(urlGetUserDataByCodUser + codUsuario);

    final response = await http.get(url);

    if (response.statusCode == 200) {
      return VwgetUserDataByCodUser.fromJson(jsonDecode(response.body));
    } else if (response.statusCode == 404) {
      VwgetUserDataByCodUser usuarioModel = VwgetUserDataByCodUser();
      usuarioModel.nombres = 'no encontrado';
      return usuarioModel;
    } else {
      throw Exception('Fallo al cargar');
    }
  }
}
