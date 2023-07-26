import 'dart:convert';

import '../../models/carga_liquida/ulaje/create_liquida_ulaje_list.dart';
import 'package:http/http.dart' as http;
import '../../models/carga_liquida/ulaje/vw_tanque_pesos_liquida_by_idServOrder.dart';
import '../../utils/carga_liquida/db_ulaje.dart';
import '../api_services.dart';

class UlajeService {
  Future<int> createLiquidaUlajeList(
      CreateLiquidaUlajeList createLiquidaUlajeList) async {
    Map data = createLiquidaUlajeList.toJson();
    final http.Response response = await http.post(
      urlCreateUlajeList,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
    );
    if (response.statusCode == 200) {
      // //print("respuesta monitoreo ${response.body}");
      return response.body.length;
    } else {
      throw Exception('Failed to post data');
    }
  }

  List<VwTanquePesosLiquidaByIdServOrder> parseTanquePesoConsulta(
      String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<VwTanquePesosLiquidaByIdServOrder>(
            (json) => VwTanquePesosLiquidaByIdServOrder.fromJson(json))
        .toList();
  }

  Future<List<VwTanquePesosLiquidaByIdServOrder>> getTanquePesoConsulta(
      int idServiceOrder) async {
    final response = await http.get(Uri.parse(
        urlGetTanquePesosLiquidaByIdServiceOrder + idServiceOrder.toString()));
    if (response.statusCode == 200) {
      // Si el servidor devuelve una repuesta OK, parseamos el JSON
      return parseTanquePesoConsulta(response.body);
    } else {
      print(response.body);
      //Si esta respuesta no fue OK, lanza un error.
      throw Exception('No se pudo obtener registros');
    }
  }

  Future<List<VwTanquePesosLiquidaByIdServOrder>> insertTanquePesosLiquida(
      List<VwTanquePesosLiquidaByIdServOrder> value) async {
    DbTanquePesosLiquidaSqlLite dbDamageReportSql =
        DbTanquePesosLiquidaSqlLite();
    /* List<DamageReportInsertSqlLite> damageReportInsertSqlLite = [];
    for (int count = 0; count < value.length; count++) {
      DamageReportInsertSqlLite aux = DamageReportInsertSqlLite();
      aux.idServiceOrder = value[count].idServiceOrder;
      aux.idVehiculo = value[count].idVehiculo;
      aux.chasis = value[count].chasis;
      aux.marca = value[count].marca;
      aux.modelo = value[count].modelo;
      aux.consigntario = value[count].consigntario;
      aux.billOfLeading = value[count].billOfLeading;
      damageReportInsertSqlLite.add(aux);
    } */

    dbDamageReportSql.insertTanquePesoLiquida(value);
    ////print("cantida de registros damage report${damageReportInsertSqlLite.length}");
    return value;
  }
}
