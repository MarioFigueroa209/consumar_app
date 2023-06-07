import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../models/roro/detalle_accesorio/vw_detalle_accesorio_model.dart';
import '../../../models/roro/detalle_accesorio/sp_detalle_accesorio_model.dart';
import '../../../models/roro/detalle_accesorio/vw_detallea_accesorio_item_list.dart';
import '../../api_services.dart';

class DetalleAccesorioService {
  List<VwDetalleAccesorioModel> parserDetalleAccesorio(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<VwDetalleAccesorioModel>(
            (json) => VwDetalleAccesorioModel.fromJson(json))
        .toList();
  }

  Future<List<VwDetalleAccesorioModel>> getVwDetalleAccesorio(
      BigInt idServiceOrder) async {
    final response = await http
        .get(Uri.parse(urlDetalleAccesorioList + idServiceOrder.toString()));
    if (response.statusCode == 200) {
      // Si el servidor devuelve una repuesta OK, parseamos el JSON
      return parserDetalleAccesorio(response.body);
    } else {
      //Si esta respuesta no fue OK, lanza un error.
      throw Exception('No se pudo obtener el registro');
    }
  }

  Future<VwDetalleAccesorioModel> getDetalleAccesorioModel(
      BigInt idDetalleAccesorio) async {
    var url =
        Uri.parse(urlGetDetalleAccesorioById + idDetalleAccesorio.toString());

    final response = await http.get(url);

    if (response.statusCode == 200) {
      return VwDetalleAccesorioModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Fallo al cargar');
    }
  }

  List<VwDetalleAccesorioItemList> parserDetalleAccesorioItemList(
      String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<VwDetalleAccesorioItemList>(
            (json) => VwDetalleAccesorioItemList.fromJson(json))
        .toList();
  }

  Future<List<VwDetalleAccesorioItemList>> getDetalleAccesorioItemList(
      BigInt idDetalleAccesorio) async {
    final response = await http.get(Uri.parse(
        urlGetDetalleAccesorioItemList + idDetalleAccesorio.toString()));
    if (response.statusCode == 200) {
      // Si el servidor devuelve una repuesta OK, parseamos el JSON
      return parserDetalleAccesorioItemList(response.body);
    } else {
      //Si esta respuesta no fue OK, lanza un error.
      throw Exception('No se pudo obtener el registro');
    }
  }

  Future<BigInt> createDetalleAccesorio(
      SpDetalleAccesorioModel spAutoreportCreate) async {
    Map data = spAutoreportCreate.toJson();

    final response = await http.post(
      urlCreateDetalleAccesorio,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
    );
    if (response.statusCode == 200) {
      //print("respuesta ${response.body}");
      return BigInt.parse(response.body);
    } else {
      throw Exception('Failed to post data');
    }
  }

  Future<void> delecteLogicDetalleAccesorio(BigInt id) async {
    http.Response res = await http
        .put(Uri.parse(urlDeleteLogicDetalleAccesorio + id.toString()));

    if (res.statusCode == 200) {
      //print(" Actualizado");
    } else {
      throw "Fallo al actualizar";
    }
  }
}
