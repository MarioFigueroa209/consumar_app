import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../models/survey/Paralizaciones/create_granel_paralizaciones.dart';
import '../../models/survey/Paralizaciones/sp_granel_update_paralizaciones_by_id.dart';
import '../../models/survey/Paralizaciones/vw_granel_get_paralizaciones.dart';
import '../../models/survey/Paralizaciones/vw_granel_get_paralizaciones_by_id.dart';
import '../api_services.dart';

class ParalizacionesService {
  List<VwGranelGetParalizaciones> parseGranelParalizaciones(
      String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<VwGranelGetParalizaciones>(
            (json) => VwGranelGetParalizaciones.fromJson(json))
        .toList();
  }

  Future<List<VwGranelGetParalizaciones>> getGranelParalizaciones(
      int serviceOrder) async {
    final response = await http
        .get(Uri.parse(urlGetParalizaciones + serviceOrder.toString()));
    if (response.statusCode == 200) {
      // Si el servidor devuelve una repuesta OK, parseamos el JSON
      return parseGranelParalizaciones(response.body);
    } else {
      //Si esta respuesta no fue OK, lanza un error.
      throw Exception('No se pudo obtener los registros');
    }
  }

  Future<VwGranelGetParalizacionesById> getParalizacionesById(
      int idParalizacion) async {
    var url = Uri.parse(urlGetParalizacionById + idParalizacion.toString());

    final response = await http.get(url);

    if (response.statusCode == 200) {
      return VwGranelGetParalizacionesById.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Fallo al cargar');
    }
  }

  Future<CreateGranelParalizaciones> createGranelParalizaciones(
      CreateGranelParalizaciones value) async {
    Map data = value.toJson();

    final http.Response response = await http.post(
      urlCreateGranelParalizaciones,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
    );
    if (response.statusCode == 200) {
      return CreateGranelParalizaciones.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to post data');
    }
  }

  Future<int> createGranelFotoParalizaciones(
      List<SpCreateGranelFotosParalizaciones> value) async {
    List<SpCreateGranelFotosParalizaciones> data = value.toList();

    final http.Response response = await http.post(
      urlCreateFotoParalizaciones,
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

  Future<SpGranelUpdateParalizacionesById> updateParalizacionesById(
      SpGranelUpdateParalizacionesById value) async {
    Map data = value.toJson();

    final http.Response response = await http.put(
      urlUpdateParalizacionById,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
    );
    if (response.statusCode == 200) {
      return SpGranelUpdateParalizacionesById.fromJson(
          json.decode(response.body));
    } else {
      throw Exception('Failed to update data');
    }
  }
}
