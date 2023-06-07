import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../models/survey/MonitoreoProducto/create_monitoreo_producto.dart';
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
}
