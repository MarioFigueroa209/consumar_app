import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../models/survey/RegistroEquipos/sp_create_granel_registro_equipos.dart';
import '../../models/survey/RegistroEquipos/vw_equipos_registrados_granel.dart';
import '../api_services.dart';

class RegistroEquipoService {
  List<VwEquiposRegistradosGranel> parseEquiposRegistradosGranel(
      String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<VwEquiposRegistradosGranel>(
            (json) => VwEquiposRegistradosGranel.fromJson(json))
        .toList();
  }

  Future<List<VwEquiposRegistradosGranel>> getEquiposRegistradosGranel() async {
    final response = await http.get(urlListRegistroEquipos);
    if (response.statusCode == 200) {
      // Si el servidor devuelve una repuesta OK, parseamos el JSON
      return parseEquiposRegistradosGranel(response.body);
    } else {
      //Si esta respuesta no fue OK, lanza un error.
      throw Exception('No se pudo obtener los registros');
    }
  }

  List<VwEquiposRegistradosGranel> parseEquipoRegistradoByCod(
      String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<VwEquiposRegistradosGranel>(
            (json) => VwEquiposRegistradosGranel.fromJson(json))
        .toList();
  }

  Future<List<VwEquiposRegistradosGranel>> getEquipoRegistradoByCod(
      String codEquipo) async {
    final response = await http.get(Uri.parse(urlGetEquipoByCod + codEquipo));
    if (response.statusCode == 200) {
      // Si el servidor devuelve una repuesta OK, parseamos el JSON
      return parseEquipoRegistradoByCod(response.body);
    } else {
      //Si esta respuesta no fue OK, lanza un error.
      throw Exception('No se pudo obtener los registros');
    }
  }

  Future<SpCreateGranelRegistroEquipos> createGranelRegistroEquipos(
      SpCreateGranelRegistroEquipos value) async {
    Map data = value.toJson();

    final http.Response response = await http.post(
      urlCreateRegistroEquipos,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
    );
    if (response.statusCode == 200) {
      return SpCreateGranelRegistroEquipos.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to post data');
    }
  }

  Future<void> delecteLogicGranelRegistroEquipo(int id) async {
    http.Response res = await http
        .put(Uri.parse(urlDeleteLogicGranelRegistroEquipo + id.toString()));

    if (res.statusCode == 204) {
      //print(" Actualizado");
    } else {
      throw "Fallo al actualizar";
    }
  }
}
