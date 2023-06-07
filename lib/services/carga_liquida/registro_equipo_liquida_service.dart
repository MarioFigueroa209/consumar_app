import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../models/carga_liquida/registroEquipos/sp_create_liquida_registro_equipos.dart';
import '../../models/carga_liquida/registroEquipos/vw_equipos_registrados_liquida.dart';
import '../api_services.dart';

class RegistroEquipoLiquidaService {
  List<VwEquiposRegistradosLiquida> parseEquiposRegistradosLiquida(
      String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<VwEquiposRegistradosLiquida>(
            (json) => VwEquiposRegistradosLiquida.fromJson(json))
        .toList();
  }

  Future<List<VwEquiposRegistradosLiquida>>
      getEquiposRegistradosLiquida() async {
    final response = await http.get(urlListLiquidaRegistroEquipos);
    if (response.statusCode == 200) {
      // Si el servidor devuelve una repuesta OK, parseamos el JSON
      return parseEquiposRegistradosLiquida(response.body);
    } else {
      //Si esta respuesta no fue OK, lanza un error.
      throw Exception('No se pudo obtener los registros');
    }
  }

  List<VwEquiposRegistradosLiquida> parseEquipoRegistradoByCod(
      String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<VwEquiposRegistradosLiquida>(
            (json) => VwEquiposRegistradosLiquida.fromJson(json))
        .toList();
  }

  Future<List<VwEquiposRegistradosLiquida>> getEquipoLiquidaRegistradoByCod(
      String codEquipo) async {
    final response =
        await http.get(Uri.parse(urlGetLiquidaEquipoByCod + codEquipo));
    if (response.statusCode == 200) {
      // Si el servidor devuelve una repuesta OK, parseamos el JSON
      return parseEquipoRegistradoByCod(response.body);
    } else {
      //Si esta respuesta no fue OK, lanza un error.
      throw Exception('No se pudo obtener los registros');
    }
  }

  Future<SpCreateLiquidaRegistroEquipos> createLiquidaRegistroEquipos(
      SpCreateLiquidaRegistroEquipos value) async {
    Map data = value.toJson();

    final http.Response response = await http.post(
      urlCreateLiquidaRegistroEquipos,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
    );
    if (response.statusCode == 200) {
      return SpCreateLiquidaRegistroEquipos.fromJson(
          json.decode(response.body));
    } else {
      throw Exception('Failed to post data');
    }
  }

  Future<void> delecteLogicLiquidaRegistroEquipo(int id) async {
    http.Response res = await http
        .put(Uri.parse(urlDeleteLogicLiquidaRegistroEquipo + id.toString()));

    if (res.statusCode == 204) {
      //print(" Actualizado");
    } else {
      throw "Fallo al actualizar";
    }
  }
}
