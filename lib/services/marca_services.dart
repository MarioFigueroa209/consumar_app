import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/marca_model.dart';
import 'api_services.dart';

class MarcaService {
  List<MarcaModel> parseMarcas(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<MarcaModel>((json) => MarcaModel.fromJson(json)).toList();
  }

  Future<List<MarcaModel>> getMarcaDistinc() async {
    final response = await http.get(urlGetMarcas);
    if (response.statusCode == 200) {
      // Si el servidor devuelve una repuesta OK, parseamos el JSON
      return parseMarcas(response.body);
    } else {
      //Si esta respuesta no fue OK, lanza un error.
      throw Exception('No se pudo obtener las marcas');
    }
  }
}
