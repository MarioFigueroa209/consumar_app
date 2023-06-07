import 'dart:convert';

import '../../models/survey/ValidacionPesos/sp_create_peso_historico.dart';
import '../../models/survey/ValidacionPesos/sp_create_validacion_peso.dart';
import 'package:http/http.dart' as http;

import '../../models/survey/ValidacionPesos/vw_lista_pesos_historicos.dart';
import '../api_services.dart';

class ValidacionPesosService {
  List<VwListaPesosHistoricos> parsePesosHistoricos(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<VwListaPesosHistoricos>(
            (json) => VwListaPesosHistoricos.fromJson(json))
        .toList();
  }

  Future<List<VwListaPesosHistoricos>> getPesosHistoricosProducto(
      String producto) async {
    final response =
        await http.get(Uri.parse(urlGetListaPesoHistoricos + producto));
    if (response.statusCode == 200) {
      // Si el servidor devuelve una repuesta OK, parseamos el JSON
      return parsePesosHistoricos(response.body);
    } else {
      //Si esta respuesta no fue OK, lanza un error.
      throw Exception('No se pudo obtener los registros');
    }
  }

  Future<SpCreateValidacionPeso> createValidacionPeso(
      SpCreateValidacionPeso value) async {
    Map data = value.toJson();

    final http.Response response = await http.post(
      urlCreateValidacionPeso,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
    );
    if (response.statusCode == 200) {
      return SpCreateValidacionPeso.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to post data');
    }
  }

  Future<SpCreatePesoHistorico> createPesoHistorico(
      SpCreatePesoHistorico value) async {
    Map data = value.toJson();

    final http.Response response = await http.post(
      urlCreatePesoHistorico,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
    );
    if (response.statusCode == 200) {
      return SpCreatePesoHistorico.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to post data');
    }
  }
}
