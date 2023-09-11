import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/roro/damage_report/vw_get_damage_report_list_model.dart';
import '../models/vehicle_model.dart';
import '../models/vw_vehicle_data_model.dart';
import 'api_services.dart';

class VehicleService {
  List<VehicleModel> parseVehicles(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<VehicleModel>((json) => VehicleModel.fromJson(json))
        .toList();
  }

  Future<List<VehicleModel>> getVehicles() async {
    final response = await http.get(urlGetVehicle);
    if (response.statusCode == 200) {
      // Si el servidor devuelve una repuesta OK, parseamos el JSON
      return parseVehicles(response.body);
    } else {
      //Si esta respuesta no fue OK, lanza un error.
      throw Exception('No se pudo obtener las naves');
    }
  }

  Future<VehicleModel> getVehicleById(BigInt idVehicle) async {
    var url = Uri.parse(urlGetVehicleById + idVehicle.toString());

    final response = await http.get(url);

    if (response.statusCode == 200) {
      return VehicleModel.fromJson(jsonDecode(response.body));
    } else if (response.statusCode == 404) {
      VehicleModel vehicleModel = VehicleModel();
      vehicleModel.chasis = 'no encontrado';
      return vehicleModel;
    } else {
      throw Exception('Fallo al cargar');
    }
  }

  List<VwVehicleDataModel> parseVehiclesByIdAndIdServiceOrder(
      String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<VwVehicleDataModel>((json) => VwVehicleDataModel.fromJson(json))
        .toList();
  }

  Future<List<VwVehicleDataModel>> getVehicleByIdAndIdServiceOrder(
      BigInt idVehicle, BigInt idServiceOrder) async {
    var url = Uri.parse(
        "$urlGetVehicleDataByIdVehicleAndIdServiceOrder?idVehicle=$idVehicle&idServiceOrder=$idServiceOrder");

    final response = await http.get(url);

    if (response.statusCode == 200) {
      return parseVehiclesByIdAndIdServiceOrder(response.body);
    } else {
      List<VwVehicleDataModel> list = [];
      return list;
    }
  }

  List<VwGetDamageReportListModel> parsegetVehiculoPendientAprob(
      String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<VwGetDamageReportListModel>(
            (json) => VwGetDamageReportListModel.fromJson(json))
        .toList();
  }

  Future<List<VwGetDamageReportListModel>> getVehiculoPendientAprob(
      int idVehicle, int idServiceOrder) async {
    var url = Uri.parse(
        "$urlGetVehiculoPendientAprobByIdVehicleAndIdServiceOrder$idVehicle&idServiceOrder=$idServiceOrder");

    final response = await http.get(url);

    if (response.statusCode == 200) {
      return parsegetVehiculoPendientAprob(response.body);
    } else {
      List<VwGetDamageReportListModel> list = [];
      return list;
    }
  }
}
