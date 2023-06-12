import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../models/registro_unico_fotocheck/sp_create_transporte.dart';
import '../../models/registro_unico_fotocheck/sp_create_usuarios.dart';
import '../../models/registro_unico_fotocheck/vw_registro_transportes_model.dart';
import '../../models/registro_unico_fotocheck/vw_registro_usuarios_model.dart';
import '../../utils/registro_usuarios_models/registro_usuarios_models.dart';
import '../api_services.dart';

class UsuarioTransporteService {
  Future<SpCreateUsuarios> createUsuarios(SpCreateUsuarios value) async {
    Map data = value.toJson();

    final http.Response response = await http.post(
      urlCreateUsuarios,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
    );
    if (response.statusCode == 200) {
      return SpCreateUsuarios.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to post data');
    }
  }

  Future<int> createUsuariosList(
    List<RegistroUsarioItems> value,
  ) async {
    List<SpCreateUsuarios> spCreateUsuarios = [];
    for (int count = 0; count < value.length; count++) {
      SpCreateUsuarios aux = SpCreateUsuarios();
      aux.codFotocheck = value[count].codFotocheck;
      aux.fechaRegistro = DateTime.now();
      aux.tipoUsuario = value[count].usuario;
      aux.puesto = value[count].puesto;
      aux.nombres = value[count].nombres;
      aux.apellidos = value[count].apellidos;
      aux.firmaUrl = value[count].urlFirmaIMG;
      aux.firmaName = value[count].firmaIMG;
      spCreateUsuarios.add(aux);
    }

    final http.Response response = await http.post(
      urlCreateUsuariosList,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(spCreateUsuarios),
    );
    if (response.statusCode == 200) {
      return int.parse(response.body);
    } else {
      throw Exception('Failed to post data');
    }
  }

  Future<SpCreateTransporte> createTransportes(SpCreateTransporte value) async {
    Map data = value.toJson();

    final http.Response response = await http.post(
      urlCreateTransportes,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
    );
    if (response.statusCode == 200) {
      return SpCreateTransporte.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to post data');
    }
  }

  Future<int> createTransportesList(
    List<RegistroTransporteItems> value,
  ) async {
    List<SpCreateTransporte> spCreateTransporte = [];
    for (int count = 0; count < value.length; count++) {
      SpCreateTransporte aux = SpCreateTransporte();
      aux.codFotocheck = value[count].codFotocheckTransporte;
      aux.empresaTransporte = value[count].transporte;
      aux.ruc = value[count].ruc;
      spCreateTransporte.add(aux);
    }

    final http.Response response = await http.post(
      urlCreateTransportesList,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(spCreateTransporte),
    );
    if (response.statusCode == 200) {
      return int.parse(response.body);
    } else {
      throw Exception('Failed to post data');
    }
  }

  List<VwRegistroUsuariosModel> parserRegistroUsuariosList(
      String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<VwRegistroUsuariosModel>(
            (json) => VwRegistroUsuariosModel.fromJson(json))
        .toList();
  }

  Future<List<VwRegistroUsuariosModel>> getRegistroUsuariosList() async {
    final response = await http.get(urlGetRegistroUsuarios);
    if (response.statusCode == 200) {
      // Si el servidor devuelve una repuesta OK, parseamos el JSON
      return parserRegistroUsuariosList(response.body);
    } else {
      //Si esta respuesta no fue OK, lanza un error.
      throw Exception('No se pudo obtener el registro');
    }
  }

  List<VwRegistroTransportesModel> parserRegistroTransportesList(
      String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<VwRegistroTransportesModel>(
            (json) => VwRegistroTransportesModel.fromJson(json))
        .toList();
  }

  Future<List<VwRegistroTransportesModel>> getRegistroTransportesList() async {
    final response = await http.get(urlGetRegistroTransportes);
    if (response.statusCode == 200) {
      // Si el servidor devuelve una repuesta OK, parseamos el JSON
      return parserRegistroTransportesList(response.body);
    } else {
      //Si esta respuesta no fue OK, lanza un error.
      throw Exception('No se pudo obtener el registro');
    }
  }
}
