import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/ship_model.dart';
import 'api_services.dart';

class ShipServices {
  List<ShipModel> parseShips(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<ShipModel>((json) => ShipModel.fromJson(json)).toList();
  }

  Future<List<ShipModel>> getShips() async {
    final response = await http.get(urlGetShips);
    if (response.statusCode == 200) {
      // Si el servidor devuelve una repuesta OK, parseamos el JSON
      return parseShips(response.body);
    } else {
      //Si esta respuesta no fue OK, lanza un error.
      throw Exception('No se pudo obtener las naves');
    }
  }
}
