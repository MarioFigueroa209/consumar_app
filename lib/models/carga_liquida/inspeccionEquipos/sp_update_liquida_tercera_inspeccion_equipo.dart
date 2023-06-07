// To parse this JSON data, do
//
//     final spUpdateLiquidaTerceraInspeccionEquipo = spUpdateLiquidaTerceraInspeccionEquipoFromJson(jsonString);

import 'dart:convert';

SpUpdateLiquidaTerceraInspeccionEquipo
    spUpdateLiquidaTerceraInspeccionEquipoFromJson(String str) =>
        SpUpdateLiquidaTerceraInspeccionEquipo.fromJson(json.decode(str));

String spUpdateLiquidaTerceraInspeccionEquipoToJson(
        SpUpdateLiquidaTerceraInspeccionEquipo data) =>
    json.encode(data.toJson());

class SpUpdateLiquidaTerceraInspeccionEquipo {
  SpUpdateLiquidaTerceraInspeccionEquipo({
    this.terInsp,
    this.idInspeccionEquipos,
  });

  String? terInsp;
  int? idInspeccionEquipos;

  factory SpUpdateLiquidaTerceraInspeccionEquipo.fromJson(
          Map<String, dynamic> json) =>
      SpUpdateLiquidaTerceraInspeccionEquipo(
        terInsp: json["terInsp"],
        idInspeccionEquipos: json["idInspeccionEquipos"],
      );

  Map<String, dynamic> toJson() => {
        "terInsp": terInsp,
        "idInspeccionEquipos": idInspeccionEquipos,
      };
}
