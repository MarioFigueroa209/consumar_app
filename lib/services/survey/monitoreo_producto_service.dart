import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../models/survey/MonitoreoProducto/create_monitoreo_producto.dart';
import '../../models/survey/MonitoreoProducto/vw_bodega_granel_byServiceOrder.dart';
import '../../utils/survey/sqlLiteDB/db_monitoreo_producto.dart';
import '../api_services.dart';

class MonitoreoProductoService {
  Future<int> createMonitoreoProducto(
      CreateMonitoreoProducto createMonitoreoProducto) async {
    Map data = createMonitoreoProducto.toJson();
    // //print(data.toString());
    final http.Response response = await http.post(
      urlCreateMonitoreoProducto,
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

  List<VwBodegaGranelByServiceOrder> parseBodegaPesoConsulta(
      String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<VwBodegaGranelByServiceOrder>(
            (json) => VwBodegaGranelByServiceOrder.fromJson(json))
        .toList();
  }

  Future<List<VwBodegaGranelByServiceOrder>> getBodegaPesoConsulta(
      int idServiceOrder) async {
    final response = await http.get(Uri.parse(
        urlGetBodegasPesosGranelByIdServiceOrder + idServiceOrder.toString()));
    if (response.statusCode == 200) {
      // Si el servidor devuelve una repuesta OK, parseamos el JSON
      return parseBodegaPesoConsulta(response.body);
    } else {
      print(response.statusCode);
      print(response.headers);
      print(response.body);
      //Si esta respuesta no fue OK, lanza un error.
      throw Exception('No se pudo obtener registros');
    }
  }

  Future<List<VwBodegaGranelByServiceOrder>> insertBodegaPesosGranel(
      List<VwBodegaGranelByServiceOrder> value) async {
    DbBodegasPesosGranelSqlLite dbDamageReportSql =
        DbBodegasPesosGranelSqlLite();

    dbDamageReportSql.insertBodegaPesoGranel(value);
    ////print("cantida de registros damage report${damageReportInsertSqlLite.length}");
    return value;
  }
}
