import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../models/survey/ControlCarguio/create_control_carguio.dart';
import '../../models/survey/ControlCarguio/update_granel_control_carguio.dart';
import '../../models/survey/ControlCarguio/vw_count_granel_dam_by_idServiceOrder.dart';
import '../../models/survey/ControlCarguio/vw_granel_consulta_transporte_by_cod.dart';
import '../../models/survey/ControlCarguio/vw_granel_do_dam_by_idserviceorder.dart';
import '../../models/survey/ControlCarguio/vw_granel_lista_bodegas.dart';
import '../../models/survey/ControlCarguio/vw_granel_placas_inicio_carguio.dart';
import '../../models/survey/ControlCarguio/vw_list_granel_placas_inicio_carguio_idserviceorder.dart';
import '../api_services.dart';

class ControlCarguioService {
  Future<String> createControlCarguio(CreateControlCarguio value) async {
    Map data = value.toJson();

    final http.Response response = await http.post(
      urlCreateGranelControlCarguio,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
    );
    if (response.statusCode == 200) {
      return response.body;
    } else {
      print(response);
      print(response.statusCode);
      throw Exception('Failed to post data');
    }
  }

  Future<int> createGranelFotoTerminoCarguio(
      List<SpCreateGranelFotosCarguio> value) async {
    List<SpCreateGranelFotosCarguio> data = value.toList();

    final http.Response response = await http.post(
      urlCreateGranelFotosControlCarguio,
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

  Future<UpdateGranelControlCarguio> updateTerminoGranelCarguioById(
      UpdateGranelControlCarguio value) async {
    Map data = value.toJson();

    final http.Response response = await http.put(
      urlUpdateGranelControlCarguioTermino,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
    );
    if (response.statusCode == 200) {
      return UpdateGranelControlCarguio.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to update data');
    }
  }

  List<VwGranelListaBodegas> parseGranelListaBodegas(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<VwGranelListaBodegas>(
            (json) => VwGranelListaBodegas.fromJson(json))
        .toList();
  }

  Future<List<VwGranelListaBodegas>> getGranelListaBodegas(
      int serviceOrder) async {
    final response = await http
        .get(Uri.parse(urlGetGranelListaBodegas + serviceOrder.toString()));
    if (response.statusCode == 200) {
      // Si el servidor devuelve una repuesta OK, parseamos el JSON
      return parseGranelListaBodegas(response.body);
    } else {
      //Si esta respuesta no fue OK, lanza un error.
      throw Exception('No se pudo obtener los registros');
    }
  }

  List<VwGranelDoDamByIdserviceorder> parseGranelDoDamByIdserviceorder(
      String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<VwGranelDoDamByIdserviceorder>(
            (json) => VwGranelDoDamByIdserviceorder.fromJson(json))
        .toList();
  }

  Future<List<VwGranelDoDamByIdserviceorder>> getGranelDoDamByIdserviceorder(
      int idServiceOrder, String dodam, String dam) async {
    var url = Uri.parse(
        "$urlGetGranelDoDamByIdServiceOrder$idServiceOrder&dodam=$dodam&dam=$dam");

    final response = await http.get(url);

    if (response.statusCode == 200) {
      return parseGranelDoDamByIdserviceorder(response.body);
    } else {
      throw Exception('No se pudo obtener los registros');
    }
  }

  List<VwListGranelPlacasInicioCarguioIdserviceorder>
      parseListGranelPlacasInicioCarguioIdserviceorder(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<VwListGranelPlacasInicioCarguioIdserviceorder>((json) =>
            VwListGranelPlacasInicioCarguioIdserviceorder.fromJson(json))
        .toList();
  }

  Future<List<VwListGranelPlacasInicioCarguioIdserviceorder>>
      getListGranelPlacasInicioCarguioIdserviceorder(int serviceOrder) async {
    final response = await http.get(Uri.parse(
        urlGetGranelListaPlacasInicioCarguioByIdServiceOrder +
            serviceOrder.toString()));
    if (response.statusCode == 200) {
      // Si el servidor devuelve una repuesta OK, parseamos el JSON
      return parseListGranelPlacasInicioCarguioIdserviceorder(response.body);
    } else {
      //Si esta respuesta no fue OK, lanza un error.
      throw Exception('No se pudo obtener los registros');
    }
  }

  List<VwGranelPlacasInicioCarguio> parseGranelPlacasInicioCarguio(
      String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<VwGranelPlacasInicioCarguio>(
            (json) => VwGranelPlacasInicioCarguio.fromJson(json))
        .toList();
  }

  Future<List<VwGranelPlacasInicioCarguio>> getGranelPlacasInicioCarguio(
      int idServiceOrder, int idCarguio) async {
    var url = Uri.parse(
        "$urlGetGranelPlacasInicioCarguio$idServiceOrder&IdCarguio=$idCarguio");

    final response = await http.get(url);

    if (response.statusCode == 200) {
      return parseGranelPlacasInicioCarguio(response.body);
    } else {
      throw Exception('No se pudo obtener los registros');
    }
  }

  List<VwCountGranelDamByIdServiceOrder> parseCountDamByIdServiceOrder(
      String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<VwCountGranelDamByIdServiceOrder>(
            (json) => VwCountGranelDamByIdServiceOrder.fromJson(json))
        .toList();
  }

  Future<List<VwCountGranelDamByIdServiceOrder>>
      getGranelCountDamByIdServiceOrder(
          int idServiceOrder, String CodDam) async {
    var url = Uri.parse(
        "$urlGetGranelCountDamByIdServiceOrder$idServiceOrder&CodDam=$CodDam");

    final response = await http.get(url);

    if (response.statusCode == 200) {
      return parseCountDamByIdServiceOrder(response.body);
    } else {
      throw Exception('No se pudo obtener los registros');
    }
  }

  List<VwGranelConsultaTransporteByCod> parseGranelConsultaTransporteByCod(
      String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<VwGranelConsultaTransporteByCod>(
            (json) => VwGranelConsultaTransporteByCod.fromJson(json))
        .toList();
  }

  Future<List<VwGranelConsultaTransporteByCod>>
      getGranelConsultaTransporteByCod(
          int idServiceOrder, String codTransporte) async {
    var url = Uri.parse(urlGetGranelConsultaTransporteByCod +
        idServiceOrder.toString() +
        "&placa=" +
        codTransporte);
    final response = await http.get(url);
    if (response.statusCode == 200) {
      // Si el servidor devuelve una repuesta OK, parseamos el JSON
      return parseGranelConsultaTransporteByCod(response.body);
    } else {
      //Si esta respuesta no fue OK, lanza un error.
      throw Exception('No se pudo obtener los registros');
    }
  }
}
