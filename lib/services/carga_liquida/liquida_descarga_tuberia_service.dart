import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../models/carga_liquida/descargaTuberias/sp_create_liquida_descarga_tuberia.dart';
import '../../models/carga_liquida/descargaTuberias/vw_lista_descarga_tuberia.dart';
import '../../src/carga_liquida/descarga_tuberias/liquida_descarga_tuberias_page.dart';
import '../api_services.dart';

class LiquidaDescargaTuberiasService {
  Future<int> createDescargaTuberiaList(
      List<DescargaTuberiaTable> value) async {
    List<SpCreateLiquidaDescargaTuberia> spCreateLiquidaDescargaTuberia = [];
    for (int count = 0; count < value.length; count++) {
      SpCreateLiquidaDescargaTuberia aux = SpCreateLiquidaDescargaTuberia();
      aux.jornada = value[count].jornada;
      aux.fecha = DateTime.now();
      aux.tanque = value[count].tanque;
      aux.toneladasMetricas = value[count].toneladasMetricas;
      aux.idServiceOrder = value[count].idServiceOrder;
      aux.idUsuario = value[count].idUsuario;
      spCreateLiquidaDescargaTuberia.add(aux);
    }

    final http.Response response = await http.post(
      urlCreateLiquidaDescargaTuberiaList,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(spCreateLiquidaDescargaTuberia),
    );
    if (response.statusCode == 200) {
      return int.parse(response.body);
    } else {
      throw Exception('Failed to post data');
    }
  }

  Future<SpCreateLiquidaDescargaTuberia> createDescargaTuberia(
      SpCreateLiquidaDescargaTuberia value) async {
    Map data = value.toJson();

    final http.Response response = await http.post(
      urlCreateLiquidaDescargaTuberia,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
    );
    if (response.statusCode == 200) {
      return SpCreateLiquidaDescargaTuberia.fromJson(
          json.decode(response.body));
    } else {
      throw Exception('Failed to post data');
    }
  }

  List<VwListaDescargaTuberia> parseDescargaTuberia(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<VwListaDescargaTuberia>(
            (json) => VwListaDescargaTuberia.fromJson(json))
        .toList();
  }

  Future<List<VwListaDescargaTuberia>> getDescargaTuberiaByIdServiceOrder(
      int idServiceOrder) async {
    final response = await http.get(Uri.parse(
        urlGetDescargaTuberiaByIdServiceOrder + idServiceOrder.toString()));
    if (response.statusCode == 200) {
      // Si el servidor devuelve una repuesta OK, parseamos el JSON
      return parseDescargaTuberia(response.body);
    } else {
      //Si esta respuesta no fue OK, lanza un error.
      throw Exception('No se pudo obtener los registros');
    }
  }

  Future<void> delecteLogicDescargaTuberia(int id) async {
    http.Response res = await http
        .put(Uri.parse(urlDeleteLogicLiquidaDescargaTuberia + id.toString()));

    if (res.statusCode == 204) {
      //print(" Actualizado");
    } else {
      throw "Fallo al actualizar";
    }
  }
}
