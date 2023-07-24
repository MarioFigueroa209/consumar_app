import 'dart:convert';

import '../../models/carga_liquida/controlCarguio/create_liquida_control_carguio.dart';
import 'package:http/http.dart' as http;

import '../../models/carga_liquida/controlCarguio/update_liquida_control_carguio.dart';
import '../../models/carga_liquida/controlCarguio/vw_count_dam_by_idserviceorder.dart';
import '../../models/carga_liquida/controlCarguio/vw_get_liquida_list_tanque.dart';
import '../../models/carga_liquida/controlCarguio/vw_granel_liquida_cod_conductores.dart';
import '../../models/carga_liquida/controlCarguio/vw_liquida_do_dam_by_idserviceorder.dart';
import '../../models/carga_liquida/controlCarguio/vw_liquida_placas_inicio_carguio.dart';
import '../../models/carga_liquida/controlCarguio/vw_liquida_transporte_by_placa_idserviceorder.dart';
import '../../models/carga_liquida/controlCarguio/vw_list_liquida_placas_inicio_carguio_idserviceorder.dart';
import '../api_services.dart';

class ControlCarguioLiquidaService {
  Future<String> createLiquidaControlCarguio(
      CreateLiquidaControlCarguio value) async {
    Map data = value.toJson();

    final http.Response response = await http.post(
      urlCreateLiquidaControlCarguio,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
    );
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to post data');
    }
  }

  Future<int> createLiquidaFotoTerminoCarguio(
      List<SpCreateLiquidaFotosCarguio> value) async {
    List<SpCreateLiquidaFotosCarguio> data = value.toList();

    final http.Response response = await http.post(
      urlCreateLiquidaFotosControlCarguioList,
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

  Future<UpdateLiquidaControlCarguio> updateTerminoCarguioById(
      UpdateLiquidaControlCarguio value) async {
    Map data = value.toJson();

    final http.Response response = await http.put(
      urlUpdateLiquidaControlCarguioTermino,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
    );
    if (response.statusCode == 200) {
      return UpdateLiquidaControlCarguio.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to update data');
    }
  }

  List<VwGetLiquidaListTanque> parseListTanque(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<VwGetLiquidaListTanque>(
            (json) => VwGetLiquidaListTanque.fromJson(json))
        .toList();
  }

  Future<List<VwGetLiquidaListTanque>> getListTanque() async {
    final response = await http.get(urlGetListTanque);

    if (response.statusCode == 200) {
      return parseListTanque(response.body);
    } else {
      throw Exception('No se pudo obtener los registros');
    }
  }

  Future<VwGranelLiquidaCodConductores> getGranelLiquidaCodConductores(
      String codConductor) async {
    var url = Uri.parse(urlGetGranelLiquidaCodConductores + codConductor);

    final response = await http.get(url);

    if (response.statusCode == 200) {
      return VwGranelLiquidaCodConductores.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Fallo al cargar');
    }
  }

  List<VwLiquidaDoDamByIdserviceorder> parseLiquidaDoDamByIdserviceorder(
      String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<VwLiquidaDoDamByIdserviceorder>(
            (json) => VwLiquidaDoDamByIdserviceorder.fromJson(json))
        .toList();
  }

  Future<List<VwLiquidaDoDamByIdserviceorder>> getLiquidaDoDamByIdserviceorder(
      int idServiceOrder, String dodam, String dam) async {
    var url = Uri.parse(
        "$urlGetLiquidaDoDamByIdServiceOrder$idServiceOrder&dodam=$dodam&dam=$dam");

    final response = await http.get(url);

    if (response.statusCode == 200) {
      return parseLiquidaDoDamByIdserviceorder(response.body);
    } else {
      throw Exception('No se pudo obtener los registros');
    }
  }

  List<VwListLiquidaPlacasInicioCarguioIdserviceorder>
      parseListLiquidaPlacasInicioCarguioIdserviceorder(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<VwListLiquidaPlacasInicioCarguioIdserviceorder>((json) =>
            VwListLiquidaPlacasInicioCarguioIdserviceorder.fromJson(json))
        .toList();
  }

  Future<List<VwListLiquidaPlacasInicioCarguioIdserviceorder>>
      getListLiquidaPlacasInicioCarguioIdserviceorder(int serviceOrder) async {
    final response = await http.get(Uri.parse(
        urlGetLiquidaListaPlacasInicioCarguioByIdServiceOrder +
            serviceOrder.toString()));
    if (response.statusCode == 200) {
      // Si el servidor devuelve una repuesta OK, parseamos el JSON
      return parseListLiquidaPlacasInicioCarguioIdserviceorder(response.body);
    } else {
      //Si esta respuesta no fue OK, lanza un error.
      throw Exception('No se pudo obtener los registros');
    }
  }

  List<VwLiquidaPlacasInicioCarguio> parseLiquidaPlacasInicioCarguio(
      String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<VwLiquidaPlacasInicioCarguio>(
            (json) => VwLiquidaPlacasInicioCarguio.fromJson(json))
        .toList();
  }

  Future<List<VwLiquidaPlacasInicioCarguio>> getLiquidaPlacasInicioCarguio(
      int idServiceOrder, int idCarguio) async {
    var url = Uri.parse(
        "$urlGetLiquidaPlacasInicioCarguio$idServiceOrder&IdCarguio=$idCarguio");

    final response = await http.get(url);

    if (response.statusCode == 200) {
      return parseLiquidaPlacasInicioCarguio(response.body);
    } else {
      throw Exception('No se pudo obtener los registros');
    }
  }

  List<VwCountDamByIdserviceorder> parseCountDamByIdServiceOrder(
      String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<VwCountDamByIdserviceorder>(
            (json) => VwCountDamByIdserviceorder.fromJson(json))
        .toList();
  }

  Future<List<VwCountDamByIdserviceorder>> getLiquidaCountDamByIdServiceOrder(
      int idServiceOrder, String CodDam) async {
    var url = Uri.parse(
        "$urlGetLiquidaCountDamByIdServiceOrder$idServiceOrder&CodDam=$CodDam");

    final response = await http.get(url);

    if (response.statusCode == 200) {
      return parseCountDamByIdServiceOrder(response.body);
    } else {
      throw Exception('No se pudo obtener los registros');
    }
  }

  List<VwLiquidaTransporteByPlacaIdserviceorder> parseLiquidaTransporteByPlacas(
      String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<VwLiquidaTransporteByPlacaIdserviceorder>(
            (json) => VwLiquidaTransporteByPlacaIdserviceorder.fromJson(json))
        .toList();
  }

  Future<List<VwLiquidaTransporteByPlacaIdserviceorder>>
      getLiquidaTransporteByPlacas(int idServiceOrder, String placa) async {
    var url = Uri.parse(
        "$urlGetLiquidaTransporteByPlacaAndIdService$idServiceOrder&placa=$placa");

    final response = await http.get(url);

    if (response.statusCode == 200) {
      return parseLiquidaTransporteByPlacas(response.body);
    } else {
      throw Exception('No se pudo obtener los registros');
    }
  }
}
