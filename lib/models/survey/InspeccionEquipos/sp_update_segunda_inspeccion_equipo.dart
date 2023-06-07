// To parse this JSON data, do
//
//     final spUpdateSegundaInspeccionEquipo = spUpdateSegundaInspeccionEquipoFromJson(jsonString);

import 'dart:convert';

SpUpdateSegundaInspeccionEquipo spUpdateSegundaInspeccionEquipoFromJson(
        String str) =>
    SpUpdateSegundaInspeccionEquipo.fromJson(json.decode(str));

String spUpdateSegundaInspeccionEquipoToJson(
        SpUpdateSegundaInspeccionEquipo data) =>
    json.encode(data.toJson());

class SpUpdateSegundaInspeccionEquipo {
  SpUpdateSegundaInspeccionEquipo({
    this.segInsp,
    this.idInspeccionEquipos,
  });

  String? segInsp;
  int? idInspeccionEquipos;

  factory SpUpdateSegundaInspeccionEquipo.fromJson(Map<String, dynamic> json) =>
      SpUpdateSegundaInspeccionEquipo(
        segInsp: json["segInsp"],
        idInspeccionEquipos: json["idInspeccionEquipos"],
      );

  Map<String, dynamic> toJson() => {
        "segInsp": segInsp,
        "idInspeccionEquipos": idInspeccionEquipos,
      };
}
