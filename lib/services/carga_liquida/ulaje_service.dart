import 'dart:convert';

import '../../models/carga_liquida/ulaje/create_liquida_ulaje_list.dart';
import 'package:http/http.dart' as http;
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
}
