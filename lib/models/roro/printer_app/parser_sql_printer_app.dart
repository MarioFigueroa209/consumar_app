// To parse this JSON data, do
//
//     final parserSqlPrinterApp = parserSqlPrinterAppFromJson(jsonString);

import 'dart:convert';

List<ParserSqlPrinterApp> parserSqlPrinterAppFromJson(String str) =>
    List<ParserSqlPrinterApp>.from(
        json.decode(str).map((x) => ParserSqlPrinterApp.fromJson(x)));

String parserSqlPrinterAppToJson(List<ParserSqlPrinterApp> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ParserSqlPrinterApp {
  ParserSqlPrinterApp({
    this.jornada,
    this.fecha,
    this.estado,
    this.idVehicle,
    this.idServiceOrder,
    this.idUsuarios,
  });

  int? jornada;
  DateTime? fecha;
  String? estado;
  int? idVehicle;
  int? idServiceOrder;
  int? idUsuarios;

  factory ParserSqlPrinterApp.fromJson(Map<String, dynamic> json) =>
      ParserSqlPrinterApp(
        jornada: json["jornada"],
        fecha: DateTime.parse(json["fecha"]),
        estado: json["estado"],
        idVehicle: json["idVehicle"],
        idServiceOrder: json["idServiceOrder"],
        idUsuarios: json["idUsuarios"],
      );

  Map<String, dynamic> toJson() => {
        "jornada": jornada,
        "fecha": fecha!.toIso8601String(),
        "estado": estado,
        "idVehicle": idVehicle,
        "idServiceOrder": idServiceOrder,
        "idUsuarios": idUsuarios,
      };
}
