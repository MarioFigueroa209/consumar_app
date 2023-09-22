import 'dart:convert';

import 'package:consumar_app/models/survey/Precintos/vw_ticket_granel_descarga_bodega.dart';
import 'package:consumar_app/models/survey/Precintos/vw_ticket_granel_precintos_carguio.dart';

import '../../models/survey/Precintos/sp_create_precintados.dart';
import '../../models/survey/Precintos/vw_granel_precinto.dart';
import 'package:http/http.dart' as http;

import '../api_services.dart';

class PrecintadoService {
  List<VwGranelPrecinto> parsePrecintados(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<VwGranelPrecinto>((json) => VwGranelPrecinto.fromJson(json))
        .toList();
  }

  Future<List<VwGranelPrecinto>> getGranelPrecintados(int serviceOrder) async {
    final response = await http
        .get(Uri.parse(urlGetPrecintoCarguio + serviceOrder.toString()));
    if (response.statusCode == 200) {
      // Si el servidor devuelve una repuesta OK, parseamos el JSON
      return parsePrecintados(response.body);
    } else {
      print(response.statusCode);
      //Si esta respuesta no fue OK, lanza un error.
      throw Exception('No se pudo obtener los registros');
    }
  }

  Future<VwGranelPrecinto> getPrecintadoById(int idPrecinto) async {
    var url = Uri.parse(urlGetPrecintoById + idPrecinto.toString());

    final response = await http.get(url);

    if (response.statusCode == 200) {
      return VwGranelPrecinto.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Fallo al cargar');
    }
  }

  Future<SpCreatePrecintados> createGranelPrecinto(
      SpCreatePrecintados value) async {
    Map data = value.toJson();

    final http.Response response = await http.post(
      urlCreatePrecintados,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
    );
    if (response.statusCode == 200) {
      return SpCreatePrecintados.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to post data');
    }
  }

  Future<void> delecteLogicGranelPrecintoCarguio(int id) async {
    http.Response res = await http
        .put(Uri.parse(urlDeleteGranelPrecintoCarguio + id.toString()));

    if (res.statusCode == 200) {
      throw "Eliminado con exito";
    } else {
      throw "Fallo al actualizar";
    }
  }

  List<VwTicketGranelDescargaBodega> parseGranelDescargaTolva(
      String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<VwTicketGranelDescargaBodega>(
            (json) => VwTicketGranelDescargaBodega.fromJson(json))
        .toList();
  }

  Future<List<VwTicketGranelDescargaBodega>> getGranelDescargaTolva(
      int idServiceOrder, int idCarguio) async {
    var url = Uri.parse(
        "$urlGetGranelDescargaBodega$idServiceOrder&idCarguio=$idCarguio");

    final response = await http.get(url);

    if (response.statusCode == 200) {
      return parseGranelDescargaTolva(response.body);
    } else {
      throw Exception('No se pudo obtener los registros');
    }
  }

  List<VwTicketGranelPrecintosCarguio> parseTicketGranelPrecintosCarguio(
      String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<VwTicketGranelPrecintosCarguio>(
            (json) => VwTicketGranelPrecintosCarguio.fromJson(json))
        .toList();
  }

  Future<List<VwTicketGranelPrecintosCarguio>> getTicketGranelPrecintosCarguio(
      int idServiceOrder, int idCarguio) async {
    var url = Uri.parse(
        "$urlGetGranelPrecintosCarguio$idServiceOrder&idCarguio=$idCarguio");

    final response = await http.get(url);

    if (response.statusCode == 200) {
      return parseTicketGranelPrecintosCarguio(response.body);
    } else {
      throw Exception('No se pudo obtener los registros');
    }
  }
}
