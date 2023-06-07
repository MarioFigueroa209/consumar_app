// To parse this JSON data, do
//
//     final vwLiquidaGetParalizaciones = vwLiquidaGetParalizacionesFromJson(jsonString);

import 'dart:convert';

List<VwLiquidaGetParalizaciones> vwLiquidaGetParalizacionesFromJson(
        String str) =>
    List<VwLiquidaGetParalizaciones>.from(
        json.decode(str).map((x) => VwLiquidaGetParalizaciones.fromJson(x)));

String vwLiquidaGetParalizacionesToJson(
        List<VwLiquidaGetParalizaciones> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class VwLiquidaGetParalizaciones {
  VwLiquidaGetParalizaciones({
    this.idParalizaciones,
    this.idServiceOrder,
    this.inicioParalizaciones,
  });

  int? idParalizaciones;
  int? idServiceOrder;
  DateTime? inicioParalizaciones;

  factory VwLiquidaGetParalizaciones.fromJson(Map<String, dynamic> json) =>
      VwLiquidaGetParalizaciones(
        idParalizaciones: json["idParalizaciones"],
        idServiceOrder: json["idServiceOrder"],
        inicioParalizaciones: DateTime.parse(json["inicioParalizaciones"]),
      );

  Map<String, dynamic> toJson() => {
        "idParalizaciones": idParalizaciones,
        "idServiceOrder": idServiceOrder,
        "inicioParalizaciones": inicioParalizaciones!.toIso8601String(),
      };
}
