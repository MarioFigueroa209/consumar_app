import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../models/survey/InspeccionEquipos/create_inspeccion_equipos.dart';
import '../../models/survey/InspeccionEquipos/sp_update_segunda_inspeccion_equipo.dart';
import '../../models/survey/InspeccionEquipos/sp_update_tercera_inspeccion_equipo.dart';
import '../../models/survey/InspeccionEquipos/vw_inspeccion_fotos_by_id_inspeccion.dart';
import '../../models/survey/InspeccionEquipos/vw_inspeccion_equipos_by_id.dart';
import '../api_services.dart';

class InspeccionEquipoService {
  Future<CreateInspeccionEquipos> createInspeccionEquipos(
      CreateInspeccionEquipos value) async {
    Map data = value.toJson();

    final http.Response response = await http.post(
      urlCreateInspeccionEquipos,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
    );
    if (response.statusCode == 200) {
      return CreateInspeccionEquipos.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to post data');
    }
  }

  Future<int> createEquiposList(
      List<SpCreateGranelInspeccionFoto> value) async {
    List<SpCreateGranelInspeccionFoto> data = value.toList();

    final http.Response response = await http.post(
      urlCreateGranelInspeccionFotosList,
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

  Future<SpUpdateSegundaInspeccionEquipo> updateSegundaInspeccionEquipo(
      SpUpdateSegundaInspeccionEquipo value) async {
    Map data = value.toJson();

    final http.Response response = await http.put(
      urlUpdateSegundaInspeccionEquipo,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
    );
    if (response.statusCode == 200) {
      return SpUpdateSegundaInspeccionEquipo.fromJson(
          json.decode(response.body));
    } else {
      throw Exception('Failed to update data');
    }
  }

  Future<SpUpdateTerceraInspeccionEquipo> updateTerceraInspeccionEquipo(
      SpUpdateTerceraInspeccionEquipo value) async {
    Map data = value.toJson();

    final http.Response response = await http.put(
      urlUpdateTerceraInspeccionEquipo,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
    );
    if (response.statusCode == 200) {
      return SpUpdateTerceraInspeccionEquipo.fromJson(
          json.decode(response.body));
    } else {
      throw Exception('Failed to update data');
    }
  }

  Future<VwInspeccionEquiposById> getInspeccionEquiposById(
      int idInspeccionEquipo) async {
    var url =
        Uri.parse(urlGetInspeccionEquiposById + idInspeccionEquipo.toString());

    final response = await http.get(url);

    if (response.statusCode == 200) {
      return VwInspeccionEquiposById.fromJson(jsonDecode(response.body));
    } else if (response.statusCode == 404) {
      VwInspeccionEquiposById value = VwInspeccionEquiposById();
      value.codEquipo = 'no encontrado';
      return value;
    } else {
      throw Exception('Fallo al cargar');
    }
  }

  List<VwInspeccionEquiposById> parseInspeccionEquiposByIdServiceOrder(
      String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<VwInspeccionEquiposById>(
            (json) => VwInspeccionEquiposById.fromJson(json))
        .toList();
  }

  Future<List<VwInspeccionEquiposById>> getInspeccionEquiposByIdServiceOrder(
      int idServiceOrder) async {
    final response = await http.get(Uri.parse(
        urlGetInspeccionEquiposByIdServiceOrder + idServiceOrder.toString()));
    if (response.statusCode == 200) {
      // Si el servidor devuelve una repuesta OK, parseamos el JSON
      return parseInspeccionEquiposByIdServiceOrder(response.body);
    } else {
      //Si esta respuesta no fue OK, lanza un error.
      throw Exception('No se pudo obtener los registros');
    }
  }

  List<VwInspeccionFotosByIdInspeccion> parseInspeccionFotosByIdInspeccion(
      String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<VwInspeccionFotosByIdInspeccion>(
            (json) => VwInspeccionFotosByIdInspeccion.fromJson(json))
        .toList();
  }

  Future<List<VwInspeccionFotosByIdInspeccion>>
      getInspeccionFotosByIdInspeccion(int idInspeccionEquipo) async {
    final response = await http.get(Uri.parse(
        urlGetInspeccionFotosByIdEquipo + idInspeccionEquipo.toString()));
    if (response.statusCode == 200) {
      // Si el servidor devuelve una repuesta OK, parseamos el JSON
      return parseInspeccionFotosByIdInspeccion(response.body);
    } else {
      //Si esta respuesta no fue OK, lanza un error.
      throw Exception('No se pudo obtener los registros');
    }
  }

  Future<void> delecteLogicInspeccionEquipo(int id) async {
    http.Response res = await http
        .put(Uri.parse(urlDeleteLogicInspeccionEquipo + id.toString()));

    if (res.statusCode == 204) {
      //print(" Actualizado");
    } else {
      throw "Fallo al actualizar";
    }
  }
}
