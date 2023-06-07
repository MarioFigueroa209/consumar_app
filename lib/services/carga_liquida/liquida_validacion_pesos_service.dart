import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../models/carga_liquida/validacionPeso/sp_create_liquida_peso_historico.dart';
import '../../models/carga_liquida/validacionPeso/sp_create_liquida_validacion_peso.dart';
import '../../models/carga_liquida/validacionPeso/vw_lista_liquida_pesos_historicos.dart';
import '../api_services.dart';

class LiquidaValidacionPesosService {
  List<VwListaLiquidaPesosHistoricos> parsePesosHistoricos(
      String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<VwListaLiquidaPesosHistoricos>(
            (json) => VwListaLiquidaPesosHistoricos.fromJson(json))
        .toList();
  }

  Future<List<VwListaLiquidaPesosHistoricos>> getPesosHistoricosProducto(
      String producto) async {
    final response =
        await http.get(Uri.parse(urlGetListaLiquidaPesoHistoricos + producto));
    if (response.statusCode == 200) {
      // Si el servidor devuelve una repuesta OK, parseamos el JSON
      return parsePesosHistoricos(response.body);
    } else {
      //Si esta respuesta no fue OK, lanza un error.
      throw Exception('No se pudo obtener los registros');
    }
  }

  Future<SpCreateLiquidaValidacionPeso> createValidacionPeso(
      SpCreateLiquidaValidacionPeso value) async {
    Map data = value.toJson();

    final http.Response response = await http.post(
      urlCreateLiquidaValidacionPeso,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
    );
    if (response.statusCode == 200) {
      return SpCreateLiquidaValidacionPeso.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to post data');
    }
  }

  Future<SpCreateLiquidaPesoHistorico> createPesoHistorico(
      SpCreateLiquidaPesoHistorico value) async {
    Map data = value.toJson();

    final http.Response response = await http.post(
      urlCreateLiquidaPesoHistorico,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
    );
    if (response.statusCode == 200) {
      return SpCreateLiquidaPesoHistorico.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to post data');
    }
  }
}
