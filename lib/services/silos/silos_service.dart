import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../models/silos/create_silos_control_ticket.dart';
import '../../models/silos/create_silos_control_visual.dart';
import '../../models/silos/create_silos_distribucion.dart';
import '../../models/silos/get_distribucion_silos.dart';
import '../../models/silos/get_silos_control_ticket_visual_by_idServiceOrder.dart';
import '../api_services.dart';

class SilosService {
  Future<CreateSilosControlTicket> createSilosControlTicket(
      CreateSilosControlTicket value) async {
    Map data = value.toJson();

    final http.Response response = await http.post(
      urlCreateSilosControlTicket,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
    );
    if (response.statusCode == 200) {
      return CreateSilosControlTicket.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to post data');
    }
  }

  Future<CreateSilosControlVisual> createSilosControlVisual(
      CreateSilosControlVisual value) async {
    Map data = value.toJson();

    final http.Response response = await http.post(
      urlCreateSilosControlVisual,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
    );
    if (response.statusCode == 200) {
      return CreateSilosControlVisual.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to post data');
    }
  }

  Future<CreateSilosDistribucion> createSilosDistribucion(
      CreateSilosDistribucion value) async {
    Map data = value.toJson();

    final http.Response response = await http.post(
      urlCreateSilosDistribucion,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
    );
    if (response.statusCode == 200) {
      return CreateSilosDistribucion.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to post data');
    }
  }

  List<GetSilosControlTicketVisualByIdServiceOrder>
      parseSilosControlTicketVisual(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<GetSilosControlTicketVisualByIdServiceOrder>((json) =>
            GetSilosControlTicketVisualByIdServiceOrder.fromJson(json))
        .toList();
  }

  Future<List<GetSilosControlTicketVisualByIdServiceOrder>>
      getSilosControlTicketVisual(int idServiceOrder) async {
    final response = await http.get(Uri.parse(
        urlGetSilosControlTicketVisualByIdServiceOrder +
            idServiceOrder.toString()));
    if (response.statusCode == 200) {
      // Si el servidor devuelve una repuesta OK, parseamos el JSON
      return parseSilosControlTicketVisual(response.body);
    } else {
      //Si esta respuesta no fue OK, lanza un error.
      throw Exception('No se pudo obtener registros');
    }
  }

  Future<GetSilosControlTicketVisualByIdServiceOrder> getSilosControlTicketById(
      int idControlTicket) async {
    var url =
        Uri.parse(urlGetSilosControlTicketById + idControlTicket.toString());

    final response = await http.get(url);

    if (response.statusCode == 200) {
      return GetSilosControlTicketVisualByIdServiceOrder.fromJson(
          jsonDecode(response.body));
    } else {
      throw Exception('Fallo al cargar');
    }
  }

  List<GetDistribucionSilos> parserDistribucionSilos(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<GetDistribucionSilos>(
            (json) => GetDistribucionSilos.fromJson(json))
        .toList();
  }

  Future<List<GetDistribucionSilos>> getDistribucionSilos() async {
    final response = await http.get(urlGetDistribucionSilos);
    if (response.statusCode == 200) {
      // Si el servidor devuelve una repuesta OK, parseamos el JSON
      return parserDistribucionSilos(response.body);
    } else {
      //Si esta respuesta no fue OK, lanza un error.
      throw Exception('No se pudo obtener el registro');
    }
  }
}
