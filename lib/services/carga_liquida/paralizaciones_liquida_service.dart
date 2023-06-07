import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../models/carga_liquida/paralizaciones/create_liquida_paralizaciones.dart';
import '../../models/carga_liquida/paralizaciones/sp_liquida_update_paralizaciones_by_id.dart';
import '../../models/carga_liquida/paralizaciones/vw_liquida_get_paralizaciones.dart';
import '../../models/carga_liquida/paralizaciones/vw_liquida_get_paralizaciones_by_id.dart';
import '../api_services.dart';

class ParalizacionesLiquidaService {
  List<VwLiquidaGetParalizaciones> parseLiquidaParalizaciones(
      String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<VwLiquidaGetParalizaciones>(
            (json) => VwLiquidaGetParalizaciones.fromJson(json))
        .toList();
  }

  Future<List<VwLiquidaGetParalizaciones>> getLiquidaParalizaciones(
      int serviceOrder) async {
    final response = await http
        .get(Uri.parse(urlGetLiquidaParalizaciones + serviceOrder.toString()));
    if (response.statusCode == 200) {
      // Si el servidor devuelve una repuesta OK, parseamos el JSON
      return parseLiquidaParalizaciones(response.body);
    } else {
      //Si esta respuesta no fue OK, lanza un error.
      throw Exception('No se pudo obtener los registros');
    }
  }

  Future<VwLiquidaGetParalizacionesById> getParalizacionesById(
      int idParalizacion) async {
    var url =
        Uri.parse(urlGetLiquidaParalizacionById + idParalizacion.toString());

    final response = await http.get(url);

    if (response.statusCode == 200) {
      return VwLiquidaGetParalizacionesById.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Fallo al cargar');
    }
  }

  Future<CreateLiquidaParalizaciones> createLiquidaParalizaciones(
      CreateLiquidaParalizaciones value) async {
    Map data = value.toJson();

    final http.Response response = await http.post(
      urlCreateLiquidaParalizaciones,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
    );
    if (response.statusCode == 200) {
      return CreateLiquidaParalizaciones.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to post data');
    }
  }

  Future<int> createLiquidaFotoParalizaciones(
      List<SpCreateLiquidaFotosParalizacione> value) async {
    List<SpCreateLiquidaFotosParalizacione> data = value.toList();

    final http.Response response = await http.post(
      urlCreateFotoLiquidaParalizaciones,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
    );
    if (response.statusCode == 200) {
      return data.length;
    } else {
      throw Exception('Failed to post data');
    }
  }

  Future<SpLiquidaUpdateParalizacionesById> updateParalizacionesById(
      SpLiquidaUpdateParalizacionesById value) async {
    Map data = value.toJson();

    final http.Response response = await http.put(
      urlUpdateLiquidaParalizacionById,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
    );
    if (response.statusCode == 200) {
      return SpLiquidaUpdateParalizacionesById.fromJson(
          json.decode(response.body));
    } else {
      throw Exception('Failed to update data');
    }
  }
}
