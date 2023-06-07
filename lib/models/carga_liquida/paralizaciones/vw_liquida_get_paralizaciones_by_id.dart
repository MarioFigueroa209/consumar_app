// To parse this JSON data, do
//
//     final vwLiquidaGetParalizacionesById = vwLiquidaGetParalizacionesByIdFromJson(jsonString);

import 'dart:convert';

VwLiquidaGetParalizacionesById vwLiquidaGetParalizacionesByIdFromJson(
        String str) =>
    VwLiquidaGetParalizacionesById.fromJson(json.decode(str));

String vwLiquidaGetParalizacionesByIdToJson(
        VwLiquidaGetParalizacionesById data) =>
    json.encode(data.toJson());

class VwLiquidaGetParalizacionesById {
  VwLiquidaGetParalizacionesById({
    this.idParalizaciones,
    this.detalle,
    this.tanque,
    this.responsable,
    this.inicioParalizaciones,
  });

  int? idParalizaciones;
  String? detalle;
  String? tanque;
  String? responsable;
  DateTime? inicioParalizaciones;

  factory VwLiquidaGetParalizacionesById.fromJson(Map<String, dynamic> json) =>
      VwLiquidaGetParalizacionesById(
        idParalizaciones: json["idParalizaciones"],
        detalle: json["detalle"],
        tanque: json["tanque"],
        responsable: json["responsable"],
        inicioParalizaciones: DateTime.parse(json["inicioParalizaciones"]),
      );

  Map<String, dynamic> toJson() => {
        "idParalizaciones": idParalizaciones,
        "detalle": detalle,
        "tanque": tanque,
        "responsable": responsable,
        "inicioParalizaciones": inicioParalizaciones!.toIso8601String(),
      };
}
