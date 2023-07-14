import 'dart:convert';

import 'package:http/http.dart';
import 'package:http/http.dart' as http;

import '../../../models/roro/distribucion_embarque/vw_distribucion_embarque.dart';
import '../../../models/roro/distribucion_embarque/sp_create_distribucion_embarque.dart';
import '../../api_services.dart';

class DistribucionEmbarqueService {

  Future<VwShipAndTravelByIdServiceOrderModel> getShipAndTravelByIdOrderService(
      BigInt idServiceOrder) async {
    var url = Uri.parse(
        urlGetShipAndTravelByIdOrderService + idServiceOrder.toString());

    final response = await http.get(url);

    if (response.statusCode == 200) {
      return VwShipAndTravelByIdServiceOrderModel.fromJson(
          jsonDecode(response.body));
    } else if (response.statusCode == 404) {
      VwShipAndTravelByIdServiceOrderModel value =
          VwShipAndTravelByIdServiceOrderModel();
      value.nombreNave = 'no encontrado';
      value.numeroViaje = 'no encontrado';
      return value;
    } else {
      throw Exception('Fallo al cargar');
    }
  }

  Future<VwShipAndTravelByIdServiceOrderModel>
      getShipAndTravelByIdOrderServiceLiquida(BigInt idServiceOrder) async {
    var url = Uri.parse(
        urlGetShipAndTravelByIdOrderServiceLiquida + idServiceOrder.toString());

    final response = await http.get(url);

    if (response.statusCode == 200) {
      return VwShipAndTravelByIdServiceOrderModel.fromJson(
          jsonDecode(response.body));
    } else if (response.statusCode == 404) {
      VwShipAndTravelByIdServiceOrderModel value =
          VwShipAndTravelByIdServiceOrderModel();
      value.nombreNave = 'no encontrado';
      value.numeroViaje = 'no encontrado';
      return value;
    } else {
      throw Exception('Fallo al cargar');
    }
  }

  Future<VwShipAndTravelByIdServiceOrderGranel>
      getShipAndTravelByIdOrderServiceGranel(BigInt idServiceOrder) async {
    var url = Uri.parse(
        urlGetShipAndTravelByIdServiceOrderGranel + idServiceOrder.toString());

    final response = await http.get(url);

    if (response.statusCode == 200) {
      return VwShipAndTravelByIdServiceOrderGranel.fromJson(
          jsonDecode(response.body));
    } else if (response.statusCode == 404) {
      VwShipAndTravelByIdServiceOrderGranel value =
          VwShipAndTravelByIdServiceOrderGranel();
      value.nombreNave = 'no encontrado';
      value.numeroViaje = 'no encontrado';
      return value;
    } else {
      throw Exception('Fallo al cargar');
    }
  }


  List<VwDistribucionEmbarque> parseDistribucionEmbarque(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<VwDistribucionEmbarque>(
            (json) => VwDistribucionEmbarque.fromJson(json))
        .toList();
  }

  Future<List<VwDistribucionEmbarque>> getDistribucionEmbarque(
      BigInt idServiceOrder) async {
    final response = await http.get(
        Uri.parse(urlGetDistribucionEmbarqueList + idServiceOrder.toString()));
    if (response.statusCode == 200) {
      // Si el servidor devuelve una repuesta OK, parseamos el JSON
      return parseDistribucionEmbarque(response.body);
    } else {
      //Si esta respuesta no fue OK, lanza un error.
      throw Exception('No se pudo obtener los registros');
    }
  }

  Future<String> createDistribucionEmbarque(
    int jornada,
    int idUsuarios,
    String nivel,
    List<VwDistribucionEmbarque> value,
  ) async {
    List<SpCreateDistribucionEmbarque> spCreateDistribucionEmbarque = [];
    for (int count = 0; count < value.length; count++) {
      SpCreateDistribucionEmbarque aux = SpCreateDistribucionEmbarque();
      aux.jornada = jornada;
      aux.fecha = DateTime.now();
      aux.nivel = nivel;
      aux.idServiceOrder = value[count].idServiceOrder;
      aux.idUsuarios = idUsuarios;
      aux.idVehicle = value[count].idVehicle;
      spCreateDistribucionEmbarque.add(aux);
    }

    final Response response = await post(
      urlCreateDistribucionEmbarque,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(spCreateDistribucionEmbarque),
    );
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to post data');
    }
  }
}
