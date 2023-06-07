import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../models/survey/RecepcionAlmacen/sp_create_recepcion_almacen.dart';
import '../../models/survey/RecepcionAlmacen/vw_lectura_by_qr_carguio.dart';
import '../../models/survey/RecepcionAlmacen/vw_lista_precinto_by_id_precinto.dart';
import '../api_services.dart';

class RegistroAlmacenService {
  Future<VwLecturaByQrCarguio> getLecturaByQrCarguio(String codCargio) async {
    var url = Uri.parse(urlGetLecturaByQrCarguio + codCargio);

    final response = await http.get(url);

    if (response.statusCode == 200) {
      return VwLecturaByQrCarguio.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Fallo al cargar');
    }
  }

  List<VwListaPrecintoByIdPrecinto> parseListaPrecintoByIdPrecinto(
      String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<VwListaPrecintoByIdPrecinto>(
            (json) => VwListaPrecintoByIdPrecinto.fromJson(json))
        .toList();
  }

  Future<List<VwListaPrecintoByIdPrecinto>> getListaPrecintoByIdPrecinto(
      String codCarguioPrecintado,
      String codigoPrecinto,
      String tipoPrecinto) async {
    final response = await http.get(Uri.parse(
        "$urlGetListaPrecintosByIdPrecintos$codCarguioPrecintado&CodigoPrecinto=$codigoPrecinto&TipoPrecinto=$tipoPrecinto"));
    if (response.statusCode == 200) {
      // Si el servidor devuelve una repuesta OK, parseamos el JSON
      return parseListaPrecintoByIdPrecinto(response.body);
    } else {
      //Si esta respuesta no fue OK, lanza un error.
      throw Exception('No se pudo obtener los registros');
    }
  }

  Future<SpCreateRecepcionAlmacen> createRecepcionAlmacen(
      SpCreateRecepcionAlmacen value) async {
    Map data = value.toJson();

    final http.Response response = await http.post(
      urlCreateRecepcionAlmacen,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
    );
    if (response.statusCode == 200) {
      return SpCreateRecepcionAlmacen.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to post data');
    }
  }
}
