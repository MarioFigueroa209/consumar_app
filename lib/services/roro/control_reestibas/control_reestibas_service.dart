import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../models/roro/control_reestibas/sp_create_reestibas_primer_movimiento_model.dart';

import '../../../models/roro/control_reestibas/sp_create_update_reestibas_firmante.dart';
import '../../../models/roro/control_reestibas/sp_create_update_reestibas_firmante_segunMov.dart';
import '../../../models/roro/control_reestibas/sp_update_reestibas_idApm_segunMov.dart';
import '../../../models/roro/control_reestibas/vw_primer_movimiento_data_by_id.dart';
import '../../../models/roro/control_reestibas/vw_reestibas_final_abordo.dart';
import '../../../models/roro/control_reestibas/vw_reestibas_final_muelle.dart';
import '../../../models/roro/control_reestibas/vw_reestibas_primer_movimiento_abordo.dart';
import '../../../models/roro/control_reestibas/vw_reestibas_primer_movimiento_muelle.dart';
import '../../../models/roro/control_reestibas/vw_reestibas_segundo_movimiento_muelle.dart';
import '../../../models/roro/control_reestibas/sp_create_reestibas_segundo_movimiento.dart';
import '../../../models/roro/control_reestibas/vw_reestibas_segundo_movimiento_abordo.dart';
import '../../api_services.dart';

class ControlReestibasService {
  List<VwReestibasPrimerMovimientoMuelle>
      parseVwReestibasPrimerMovimientoMuelle(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<VwReestibasPrimerMovimientoMuelle>(
            (json) => VwReestibasPrimerMovimientoMuelle.fromJson(json))
        .toList();
  }

  Future<List<VwReestibasPrimerMovimientoMuelle>>
      getVwReestibasPrimerMovimientoMuelle(BigInt idServiceOrder) async {
    final response = await http.get(Uri.parse(
        urlGetReestibasPrimerMovimientoMuelle + idServiceOrder.toString()));
    if (response.statusCode == 200) {
      // Si el servidor devuelve una repuesta OK, parseamos el JSON
      return parseVwReestibasPrimerMovimientoMuelle(response.body);
    } else {
      //Si esta respuesta no fue OK, lanza un error.
      throw Exception('No se pudo obtener las registros');
    }
  }

  List<VwReestibasPrimerMovimientoAbordo>
      parseVwReestibasPrimerMovimientoAbordo(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<VwReestibasPrimerMovimientoAbordo>(
            (json) => VwReestibasPrimerMovimientoAbordo.fromJson(json))
        .toList();
  }

  Future<List<VwReestibasPrimerMovimientoAbordo>>
      getVwReestibasPrimerMovimientoAbordo(BigInt idServiceOrder) async {
    final response = await http.get(Uri.parse(
        urlGetReestibasPrimerMovimientoAbordo + idServiceOrder.toString()));
    if (response.statusCode == 200) {
      // Si el servidor devuelve una repuesta OK, parseamos el JSON
      return parseVwReestibasPrimerMovimientoAbordo(response.body);
    } else {
      //Si esta respuesta no fue OK, lanza un error.
      throw Exception('No se pudo obtener las registros');
    }
  }

  Future<VwPrimerMovimientoDataById> getPrimerMovimientoDataById(
      BigInt idPrimerMovimiento) async {
    var url =
        Uri.parse(urlPrimerMovimientoDataById + idPrimerMovimiento.toString());

    final response = await http.get(url);

    if (response.statusCode == 200) {
      return VwPrimerMovimientoDataById.fromJson(jsonDecode(response.body));
    }
    /*else if (response.statusCode == 404) {
      VwPrimerMovimientoDataById value = VwPrimerMovimientoDataById();
      value.marca = 'no encontrado';
      return value;
    } */
    else {
      throw Exception('Fallo al cargar');
    }
  }

  List<VwReestibasSegundoMovimientoMuelle>
      parseVwReestibasSegundoMovimientoMuelle(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<VwReestibasSegundoMovimientoMuelle>(
            (json) => VwReestibasSegundoMovimientoMuelle.fromJson(json))
        .toList();
  }

  Future<List<VwReestibasSegundoMovimientoMuelle>>
      getVwReestibasSegundoMovimientoMuelle(BigInt idServiceOrder) async {
    final response = await http.get(Uri.parse(
        urlGetVwReestibasSegundoMovimientoMuelle + idServiceOrder.toString()));
    if (response.statusCode == 200) {
      // Si el servidor devuelve una repuesta OK, parseamos el JSON
      return parseVwReestibasSegundoMovimientoMuelle(response.body);
    } else {
      //Si esta respuesta no fue OK, lanza un error.
      throw Exception('No se pudo obtener los registros');
    }
  }

  List<VwReestibasSegundoMovimientoAbordo>
      parseVwReestibasSegundoMovimientoAbordo(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<VwReestibasSegundoMovimientoAbordo>(
            (json) => VwReestibasSegundoMovimientoAbordo.fromJson(json))
        .toList();
  }

  Future<List<VwReestibasSegundoMovimientoAbordo>>
      getVwReestibasSegundoMovimientoAbordo(BigInt idServiceOrder) async {
    final response = await http.get(Uri.parse(
        urlGetReestibasSegundoMovimientoAbordo + idServiceOrder.toString()));
    if (response.statusCode == 200) {
      // Si el servidor devuelve una repuesta OK, parseamos el JSON
      return parseVwReestibasSegundoMovimientoAbordo(response.body);
    } else {
      //Si esta respuesta no fue OK, lanza un error.
      throw Exception('No se pudo obtener las registros');
    }
  }

  List<VwReestibasFinalMuelle> parseVwReestibasFinalMuelle(
      String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<VwReestibasFinalMuelle>(
            (json) => VwReestibasFinalMuelle.fromJson(json))
        .toList();
  }

  Future<List<VwReestibasFinalMuelle>> getVwReestibasFinalMuelle(
      BigInt idServiceOrder) async {
    final response = await http.get(Uri.parse(
        urlGetReestibasFinalMuelleByIdServiceOrder +
            idServiceOrder.toString()));
    if (response.statusCode == 200) {
      // Si el servidor devuelve una repuesta OK, parseamos el JSON
      return parseVwReestibasFinalMuelle(response.body);
    } else {
      //Si esta respuesta no fue OK, lanza un error.
      throw Exception('No se pudo obtener los registros');
    }
  }

  List<VwReestibasFinalAbordo> parseVwReestibasFinalAbordo(
      String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<VwReestibasFinalAbordo>(
            (json) => VwReestibasFinalAbordo.fromJson(json))
        .toList();
  }

  Future<List<VwReestibasFinalAbordo>> getVwReestibasFinalAbordo(
      BigInt idServiceOrder) async {
    final response = await http.get(Uri.parse(
        urlGetReestibasFinalAbordoByIdServiceOrder +
            idServiceOrder.toString()));
    if (response.statusCode == 200) {
      // Si el servidor devuelve una repuesta OK, parseamos el JSON
      return parseVwReestibasFinalAbordo(response.body);
    } else {
      //Si esta respuesta no fue OK, lanza un error.
      throw Exception('No se pudo obtener las registros');
    }
  }

  Future<SpCreateReestibasPrimerMovimientoModel>
      createReestibasPrimerMovimiento(
          SpCreateReestibasPrimerMovimientoModel value) async {
    Map data = value.toJson();

    final http.Response response = await http.post(
      urlCreateReestibasPrimerMovimiento,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
    );
    if (response.statusCode == 200) {
      return SpCreateReestibasPrimerMovimientoModel.fromJson(
          json.decode(response.body));
    } else {
      throw Exception('Failed to post data');
    }
  }

  Future<SpCreateReestibasSegundoMovimiento> createReestibasSegundoMovimiento(
      SpCreateReestibasSegundoMovimiento value) async {
    Map data = value.toJson();

    final http.Response response = await http.post(
      urlCreateReestibasSegundoMovimiento,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
    );
    if (response.statusCode == 200) {
      return SpCreateReestibasSegundoMovimiento.fromJson(
          json.decode(response.body));
    } else {
      throw Exception('Failed to post data');
    }
  }

  Future<SpCreateUpdateReestibasFirmante> createUpdateReestibasFirmante(
      SpCreateUpdateReestibasFirmante value) async {
    Map data = value.toJson();

    final http.Response response = await http.post(
      urlCreateUpdateReestibasFirmante,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
    );
    if (response.statusCode == 200) {
      return SpCreateUpdateReestibasFirmante.fromJson(
          json.decode(response.body));
    } else {
      throw Exception('Failed to post data');
    }
  }

  Future<SpCreateUpdateReestibasFirmanteSegunMov>
      createUpdateReestibasFirmanteSegundoMov(
          SpCreateUpdateReestibasFirmanteSegunMov value) async {
    Map data = value.toJson();

    final http.Response response = await http.post(
      urlCreateUpdateReestibasFirmanteBySegMov,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
    );
    if (response.statusCode == 200) {
      return SpCreateUpdateReestibasFirmanteSegunMov.fromJson(
          json.decode(response.body));
    } else {
      throw Exception('Failed to post data');
    }
  }

  Future<List<SpUpdateReestibasIdApmSegunMov>> updateReestibasIdApmSegundoMov(
    List<SpUpdateReestibasIdApmSegunMov> value,
  ) async {
    List<SpUpdateReestibasIdApmSegunMov> spUpdateReestibas = [];
    for (int count = 0; count < value.length; count++) {
      SpUpdateReestibasIdApmSegunMov aux = SpUpdateReestibasIdApmSegunMov();
      aux.idApmtc = value[count].idApmtc;
      aux.idReestibasSegundoMov = value[count].idReestibasSegundoMov;
      aux.idServiceOrder = value[count].idServiceOrder;
      spUpdateReestibas.add(aux);
    }
    final http.Response response = await http.put(
      urlUpdateReestibasIdApmtc,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(spUpdateReestibas),
    );

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      return parsed
          .map<SpUpdateReestibasIdApmSegunMov>(
              (json) => SpUpdateReestibasIdApmSegunMov.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to post data');
    }
  }

  Future<void> delecteLogicReestibasPrimerMovimiento(BigInt id) async {
    http.Response res = await http.put(
        Uri.parse(urlDeleteLogicReestibasPrimerMovimiento + id.toString()));

    if (res.statusCode == 200) {
      //print(" Actualizado");
    } else {
      throw "Fallo al actualizar";
    }
  }

  Future<void> delecteLogicReestibasSegundoMovimiento(BigInt id) async {
    http.Response res = await http.put(
        Uri.parse(urlDeleteLogicReestibasSegundoMovimiento + id.toString()));

    if (res.statusCode == 200) {
      // //print(" Actualizado");
    } else {
      throw "Fallo al actualizar";
    }
  }
}
