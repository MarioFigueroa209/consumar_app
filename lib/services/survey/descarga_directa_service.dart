import 'package:http/http.dart' as http;
import '../../models/survey/DescargaDirecta/sp_create_descarga_directa.dart';
import '../../models/survey/DescargaDirecta/vw_lista_descarga_directa.dart';
import '../api_services.dart';
import 'dart:convert';

class DescargaDirectaService {
  Future<SpCreateDescargaDirecta> createDescargaDirecta(
      SpCreateDescargaDirecta value) async {
    Map data = value.toJson();

    final http.Response response = await http.post(
      urlCreateDescargaDirecta,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
    );
    if (response.statusCode == 200) {
      return SpCreateDescargaDirecta.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to post data');
    }
  }

  List<VwListaDescargaDirecta> parseDescargaDirecta(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<VwListaDescargaDirecta>(
            (json) => VwListaDescargaDirecta.fromJson(json))
        .toList();
  }

  Future<List<VwListaDescargaDirecta>> getDescargaDirectaByIdServiceOrder(
      int idServiceOrder) async {
    final response = await http.get(Uri.parse(
        urlGetDescargaDirectaByIdServiceOrder + idServiceOrder.toString()));
    if (response.statusCode == 200) {
      // Si el servidor devuelve una repuesta OK, parseamos el JSON
      return parseDescargaDirecta(response.body);
    } else {
      //Si esta respuesta no fue OK, lanza un error.
      throw Exception('No se pudo obtener los registros');
    }
  }

  Future<void> delecteLogicDescargaDirecta(int id) async {
    http.Response res = await http
        .put(Uri.parse(urlDeleteLogicDescargaDirecta + id.toString()));

    if (res.statusCode == 204) {
      //print(" Actualizado");
    } else {
      throw "Fallo al actualizar";
    }
  }
}
