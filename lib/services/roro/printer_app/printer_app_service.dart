import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../models/roro/printer_app/create_sql_lite_printer_app.dart';
import '../../../models/roro/printer_app/sp_create_printer_app_list.dart';
import '../../../models/roro/printer_app/vw_get_count_vehiculos_etiquetados_by_service_order.dart';
import '../../../models/roro/printer_app/vw_printer_app_list_by_id_service_order.dart';
import '../../../models/roro/printer_app/insert_printer_app_pendientes.dart';
import '../../../models/vw_list_vehicle_data_by_id_service_order_embarque.dart';
import '../../../models/vw_list_vehicle_data_by_idserviceorder_descarga.dart';
import '../../../utils/roro/sqliteBD/db_printer_app.dart';
import '../../api_services.dart';

class PrinterAppService {
  List<VwPrinterAppListByIdServiceOrder> parsePrinterAppListByIdServiceOrder(
      String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<VwPrinterAppListByIdServiceOrder>(
            (json) => VwPrinterAppListByIdServiceOrder.fromJson(json))
        .toList();
  }

  Future<List<VwPrinterAppListByIdServiceOrder>>
      getPrinterAppListByIdServiceOrder(BigInt idServiceOrder) async {
    final response = await http.get(Uri.parse(
        urlGetPrinterAppListByIdServiceOrder + idServiceOrder.toString()));
    if (response.statusCode == 200) {
      // Si el servidor devuelve una repuesta OK, parseamos el JSON
      return parsePrinterAppListByIdServiceOrder(response.body);
    } else {
      //Si esta respuesta no fue OK, lanza un error.
      throw Exception('No se pudo obtener registros');
    }
  }

  List<VwListVehicleDataByIdServiceOrderDescarga>
      parseListVehicleDataByIdServiceOrderDescarga(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<VwListVehicleDataByIdServiceOrderDescarga>(
            (json) => VwListVehicleDataByIdServiceOrderDescarga.fromJson(json))
        .toList();
  }

  Future<List<VwListVehicleDataByIdServiceOrderDescarga>>
      getListVehicleDataByIdServiceOrderDescarga(BigInt idServiceOrder) async {
    final response = await http.get(Uri.parse(
        urlGetVehicleDataByIdServiceOrderDescarga + idServiceOrder.toString()));
    if (response.statusCode == 200) {
      // Si el servidor devuelve una repuesta OK, parseamos el JSON
      return parseListVehicleDataByIdServiceOrderDescarga(response.body);
    } else {
      //Si esta respuesta no fue OK, lanza un error.
      throw Exception('No se pudo obtener registros');
    }
  }

  List<VwListVehicleDataByIdServiceOrderEmbarque>
      parseListVehicleDataByIdServiceOrderEmbarque(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<VwListVehicleDataByIdServiceOrderEmbarque>(
            (json) => VwListVehicleDataByIdServiceOrderEmbarque.fromJson(json))
        .toList();
  }

  Future<List<VwListVehicleDataByIdServiceOrderEmbarque>>
      getListVehicleDataByIdServiceOrderEmbarque(BigInt idServiceOrder) async {
    final response = await http.get(Uri.parse(
        urlGetVehicleDataByIdServiceOrderEmbarque + idServiceOrder.toString()));
    if (response.statusCode == 200) {
      // Si el servidor devuelve una repuesta OK, parseamos el JSON
      return parseListVehicleDataByIdServiceOrderEmbarque(response.body);
    } else {
      //Si esta respuesta no fue OK, lanza un error.
      throw Exception('No se pudo obtener registros');
    }
  }

  //mandar la lista de printer app etiquetados al back
  Future<int> createPrinterAppList(
    List<CreateSqlLitePrinterApp> value,
  ) async {
    List<SpCreatePrinterAppList> spCreatePrinterAppList = [];
    for (int count = 0; count < value.length; count++) {
      SpCreatePrinterAppList aux = SpCreatePrinterAppList();
      aux.jornada = value[count].jornada;
      aux.fecha = DateTime.now();
      aux.estado = value[count].estado;
      aux.idServiceOrder = value[count].idServiceOrder;
      aux.idUsuarios = value[count].idUsuarios;
      aux.idVehicle = value[count].idVehicle;
      spCreatePrinterAppList.add(aux);
    }

    final http.Response response = await http.post(
      urlCreateSpPrinterAppList,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(spCreatePrinterAppList),
    );
    if (response.statusCode == 200) {
      return int.parse(response.body);
    } else {
      throw Exception('Failed to post data');
    }
  }

  //parsear lista de la web y mandarla al local
  Future<int> insertPrinterAppDataDescarga(
      List<VwListVehicleDataByIdServiceOrderDescarga> value) async {
    DbPrinterApp dbPrinterApp = DbPrinterApp();
    List<InsertPrinterAppPendientes> insertPrinterAppPendientes = [];
    for (int count = 0; count < value.length; count++) {
      InsertPrinterAppPendientes aux = InsertPrinterAppPendientes();
      aux.idServiceOrder = value[count].idServiceOrder;
      aux.idVehiculo = value[count].idVehiculo;
      aux.chasis = value[count].chasis;
      aux.marca = value[count].marca;
      aux.modelo = value[count].modelo;
      aux.estado = value[count].estado;
      aux.detalle = value[count].detalle;
      aux.operacion = value[count].operacion;
      insertPrinterAppPendientes.add(aux);
    }

    dbPrinterApp.insertPrinterPendientesData(insertPrinterAppPendientes);
    //print("cantida de registros enviados ${insertPrinterAppPendientes.length}");
    return insertPrinterAppPendientes.length;
  }

  Future<int> insertPrinterAppDataEmbarque(
      List<VwListVehicleDataByIdServiceOrderEmbarque> value) async {
    DbPrinterApp dbPrinterApp = DbPrinterApp();
    List<InsertPrinterAppPendientes> insertPrinterAppPendientes = [];
    for (int count = 0; count < value.length; count++) {
      InsertPrinterAppPendientes aux = InsertPrinterAppPendientes();
      aux.idServiceOrder = value[count].idServiceOrder;
      aux.idVehiculo = value[count].idVehiculo;
      aux.chasis = value[count].chasis;
      aux.marca = value[count].marca;
      aux.modelo = value[count].modelo;
      aux.estado = value[count].estado;
      aux.detalle = value[count].detalle;
      aux.operacion = value[count].operacion;
      insertPrinterAppPendientes.add(aux);
    }

    dbPrinterApp.insertPrinterPendientesData(insertPrinterAppPendientes);
    // //print("cantida de registros enviados ${insertPrinterAppPendientes.length}");
    return insertPrinterAppPendientes.length;
  }

  Future<void> delecteLogicOperacion(BigInt id) async {
    http.Response res =
        await http.put(Uri.parse(urlDeleteLogicOperacion + id.toString()));

    if (res.statusCode == 204) {
      // //print(" Actualizado");
    } else {
      throw "Fallo al actualizar";
    }
  }

  Future<VwGetCountVehiculosEtiquetadosByServiceOrder>
      getCountVehiculosEtiquetadosByServiceOrder(BigInt idServiceOrder) async {
    var url = Uri.parse(
        urlGetVehiculosEtiquetadosByServiceOrder + idServiceOrder.toString());

    final response = await http.get(url);

    if (response.statusCode == 200) {
      return VwGetCountVehiculosEtiquetadosByServiceOrder.fromJson(
          jsonDecode(response.body));
    } else {
      throw Exception('Fallo al cargar');
    }
  }
}
