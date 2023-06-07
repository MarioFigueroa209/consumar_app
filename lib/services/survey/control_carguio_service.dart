import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../models/survey/ControlCarguio/create_control_carguio.dart';
import '../../models/survey/ControlCarguio/vw_granel_consulta_transporte_by_cod.dart';
import '../../models/survey/ControlCarguio/vw_granel_lista_bodegas.dart';
import '../api_services.dart';

class ControlCarguioService {
  Future<VwGranelConsultaTransporteByCod> getGranelConsultaTransporteByCod(
      String codTransporte) async {
    var url = Uri.parse(urlGetGranelConsultaTransporteByCod + codTransporte);

    final response = await http.get(url);

    if (response.statusCode == 200) {
      return VwGranelConsultaTransporteByCod.fromJson(
          jsonDecode(response.body));
    } else if (response.statusCode == 404) {
      VwGranelConsultaTransporteByCod value = VwGranelConsultaTransporteByCod();
      value.codFotocheck = 'no encontrado';
      return value;
    } else {
      throw Exception('Fallo al cargar');
    }
  }

  List<VwGranelListaBodegas> parseGranelListaBodegas(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<VwGranelListaBodegas>(
            (json) => VwGranelListaBodegas.fromJson(json))
        .toList();
  }

  Future<List<VwGranelListaBodegas>> getGranelListaBodegas() async {
    final response = await http.get(urlGetGranelListaBodegas);
    if (response.statusCode == 200) {
      // Si el servidor devuelve una repuesta OK, parseamos el JSON
      return parseGranelListaBodegas(response.body);
    } else {
      //Si esta respuesta no fue OK, lanza un error.
      throw Exception('No se pudo obtener los registros');
    }
  }

  Future<CreateControlCarguio> createControlCarguio(
      CreateControlCarguio value) async {
    Map data = value.toJson();

    final http.Response response = await http.post(
      urlCreateGranelControlCarguio,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
    );
    if (response.statusCode == 200) {
      return CreateControlCarguio.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to post data');
    }
  }
}
