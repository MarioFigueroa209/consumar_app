// To parse this JSON data, do
//
//     final vwGranelGetParalizacionesById = vwGranelGetParalizacionesByIdFromJson(jsonString);

import 'dart:convert';

VwGranelGetParalizacionesById vwGranelGetParalizacionesByIdFromJson(
        String str) =>
    VwGranelGetParalizacionesById.fromJson(json.decode(str));

String vwGranelGetParalizacionesByIdToJson(
        VwGranelGetParalizacionesById data) =>
    json.encode(data.toJson());

class VwGranelGetParalizacionesById {
  VwGranelGetParalizacionesById({
    this.idParalizaciones,
    this.detalle,
    this.bodega,
    this.responsable,
    this.inicioParalizaciones,
  });

  int? idParalizaciones;
  String? detalle;
  String? bodega;
  String? responsable;
  DateTime? inicioParalizaciones;

  factory VwGranelGetParalizacionesById.fromJson(Map<String, dynamic> json) =>
      VwGranelGetParalizacionesById(
        idParalizaciones: json["idParalizaciones"],
        detalle: json["detalle"],
        bodega: json["bodega"],
        responsable: json["responsable"],
        inicioParalizaciones: DateTime.parse(json["inicioParalizaciones"]),
      );

  Map<String, dynamic> toJson() => {
        "idParalizaciones": idParalizaciones,
        "detalle": detalle,
        "bodega": bodega,
        "responsable": responsable,
        "inicioParalizaciones": inicioParalizaciones?.toIso8601String(),
      };
}
