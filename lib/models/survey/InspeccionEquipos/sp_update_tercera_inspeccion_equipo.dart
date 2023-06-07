// To parse this JSON data, do
//
//     final spUpdateTerceraInspeccionEquipo = spUpdateTerceraInspeccionEquipoFromJson(jsonString);

import 'dart:convert';

SpUpdateTerceraInspeccionEquipo spUpdateTerceraInspeccionEquipoFromJson(
        String str) =>
    SpUpdateTerceraInspeccionEquipo.fromJson(json.decode(str));

String spUpdateTerceraInspeccionEquipoToJson(
        SpUpdateTerceraInspeccionEquipo data) =>
    json.encode(data.toJson());

class SpUpdateTerceraInspeccionEquipo {
  SpUpdateTerceraInspeccionEquipo({
    this.terInsp,
    this.idInspeccionEquipos,
  });

  String? terInsp;
  int? idInspeccionEquipos;

  factory SpUpdateTerceraInspeccionEquipo.fromJson(Map<String, dynamic> json) =>
      SpUpdateTerceraInspeccionEquipo(
        terInsp: json["terInsp"],
        idInspeccionEquipos: json["idInspeccionEquipos"],
      );

  Map<String, dynamic> toJson() => {
        "terInsp": terInsp,
        "idInspeccionEquipos": idInspeccionEquipos,
      };
}
