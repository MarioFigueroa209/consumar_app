import 'dart:convert';

import '../../models/carga_liquida/controlCarguio/create_liquida_control_carguio.dart';
import 'package:http/http.dart' as http;

import '../api_services.dart';

class ControlCarguioLiquidaService {
  Future<CreateLiquidaControlCarguio> createLiquidaControlCarguio(
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
      return CreateLiquidaControlCarguio.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to post data');
    }
  }
}
