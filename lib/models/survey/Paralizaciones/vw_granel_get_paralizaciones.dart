// To parse this JSON data, do
//
//     final vwGranelGetParalizaciones = vwGranelGetParalizacionesFromJson(jsonString);

import 'dart:convert';

List<VwGranelGetParalizaciones> vwGranelGetParalizacionesFromJson(String str) =>
    List<VwGranelGetParalizaciones>.from(
        json.decode(str).map((x) => VwGranelGetParalizaciones.fromJson(x)));

String vwGranelGetParalizacionesToJson(List<VwGranelGetParalizaciones> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class VwGranelGetParalizaciones {
  VwGranelGetParalizaciones({
    this.idParalizaciones,
    this.idServiceOrder,
    this.inicioParalizaciones,
  });

  int? idParalizaciones;
  int? idServiceOrder;
  DateTime? inicioParalizaciones;

  factory VwGranelGetParalizaciones.fromJson(Map<String, dynamic> json) =>
      VwGranelGetParalizaciones(
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
