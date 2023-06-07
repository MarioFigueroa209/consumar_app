import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../models/carga_liquida/inspeccionEquipos/create_liquida_inspeccion_equipos.dart';
import '../../models/carga_liquida/inspeccionEquipos/sp_update_liquida_segunda_inspeccion_equipo.dart';
import '../../models/carga_liquida/inspeccionEquipos/sp_update_liquida_tercera_inspeccion_equipo.dart';
import '../../models/carga_liquida/inspeccionEquipos/vw_liquida_inspeccion_equipos_by_id.dart';
import '../../models/carga_liquida/inspeccionEquipos/vw_liquida_inspeccion_fotos_by_id_inspeccion.dart';
import '../api_services.dart';

class InspeccionEquipoLiquidaService {
  Future<CreateLiquidaInspeccionEquipos> createLiquidaInspeccionEquipos(
      CreateLiquidaInspeccionEquipos value) async {
    Map data = value.toJson();

    final http.Response response = await http.post(
      urlCreateLiquidaInspeccionEquipos,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
    );
    if (response.statusCode == 200) {
      return CreateLiquidaInspeccionEquipos.fromJson(
          json.decode(response.body));
    } else {
      throw Exception('Failed to post data');
    }
  }

  Future<int> createLiquidaInspeccionFotoList(
      List<SpCreateLiquidaInspeccionFoto> value) async {
    List<SpCreateLiquidaInspeccionFoto> data = value.toList();

    final http.Response response = await http.post(
      urlCreateLiquidaInspeccionFotosList,
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

  Future<SpUpdateLiquidaSegundaInspeccionEquipo> updateSegundaInspeccionEquipo(
      SpUpdateLiquidaSegundaInspeccionEquipo value) async {
    Map data = value.toJson();

    final http.Response response = await http.put(
      urlUpdateLiquidaSegundaInspeccionEquipo,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
    );
    if (response.statusCode == 200) {
      return SpUpdateLiquidaSegundaInspeccionEquipo.fromJson(
          json.decode(response.body));
    } else {
      throw Exception('Failed to update data');
    }
  }

  Future<SpUpdateLiquidaTerceraInspeccionEquipo> updateTerceraInspeccionEquipo(
      SpUpdateLiquidaTerceraInspeccionEquipo value) async {
    Map data = value.toJson();

    final http.Response response = await http.put(
      urlUpdateLiquidaTerceraInspeccionEquipo,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
    );
    if (response.statusCode == 200) {
      return SpUpdateLiquidaTerceraInspeccionEquipo.fromJson(
          json.decode(response.body));
    } else {
      throw Exception('Failed to update data');
    }
  }

  Future<VwLiquidaInspeccionEquiposById> getInspeccionEquiposById(
      int idInspeccionEquipo) async {
    var url = Uri.parse(
        urlGetLiquidaInspeccionEquiposById + idInspeccionEquipo.toString());

    final response = await http.get(url);

    if (response.statusCode == 200) {
      return VwLiquidaInspeccionEquiposById.fromJson(jsonDecode(response.body));
    } else if (response.statusCode == 404) {
      VwLiquidaInspeccionEquiposById value = VwLiquidaInspeccionEquiposById();
      value.codEquipo = 'no encontrado';
      return value;
    } else {
      throw Exception('Fallo al cargar');
    }
  }

  List<VwLiquidaInspeccionEquiposById>
      parseInspeccionEquiposLiquidaByIdServiceOrder(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<VwLiquidaInspeccionEquiposById>(
            (json) => VwLiquidaInspeccionEquiposById.fromJson(json))
        .toList();
  }

  Future<List<VwLiquidaInspeccionEquiposById>>
      getInspeccionEquiposLiquidaByIdServiceOrder(int idServiceOrder) async {
    final response = await http.get(Uri.parse(
        urlGetLiquidaInspeccionEquiposByIdServiceOrder +
            idServiceOrder.toString()));
    if (response.statusCode == 200) {
      // Si el servidor devuelve una repuesta OK, parseamos el JSON
      return parseInspeccionEquiposLiquidaByIdServiceOrder(response.body);
    } else {
      //Si esta respuesta no fue OK, lanza un error.
      throw Exception('No se pudo obtener los registros');
    }
  }

  List<VwLiquidaInspeccionFotosByIdInspeccion>
      parseLiquidaInspeccionLiquidaFotosByIdInspeccion(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<VwLiquidaInspeccionFotosByIdInspeccion>(
            (json) => VwLiquidaInspeccionFotosByIdInspeccion.fromJson(json))
        .toList();
  }

  Future<List<VwLiquidaInspeccionFotosByIdInspeccion>>
      getInspeccionFotosLiquidaByIdInspeccion(int idInspeccionEquipo) async {
    final response = await http.get(Uri.parse(
        urlGetLiquidaInspeccionFotosByIdEquipo +
            idInspeccionEquipo.toString()));
    if (response.statusCode == 200) {
      // Si el servidor devuelve una repuesta OK, parseamos el JSON
      return parseLiquidaInspeccionLiquidaFotosByIdInspeccion(response.body);
    } else {
      //Si esta respuesta no fue OK, lanza un error.
      throw Exception('No se pudo obtener los registros');
    }
  }

  Future<void> delecteLogicInspeccionEquipo(int id) async {
    http.Response res = await http
        .put(Uri.parse(urlDeleteLogicLiquidaInspeccionEquipo + id.toString()));

    if (res.statusCode == 204) {
      //print(" Actualizado");
    } else {
      throw "Fallo al actualizar";
    }
  }
}
