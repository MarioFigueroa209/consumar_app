// To parse this JSON data, do
//
//     final spUpdateLiquidaSegundaInspeccionEquipo = spUpdateLiquidaSegundaInspeccionEquipoFromJson(jsonString);

import 'dart:convert';

SpUpdateLiquidaSegundaInspeccionEquipo
    spUpdateLiquidaSegundaInspeccionEquipoFromJson(String str) =>
        SpUpdateLiquidaSegundaInspeccionEquipo.fromJson(json.decode(str));

String spUpdateLiquidaSegundaInspeccionEquipoToJson(
        SpUpdateLiquidaSegundaInspeccionEquipo data) =>
    json.encode(data.toJson());

class SpUpdateLiquidaSegundaInspeccionEquipo {
  SpUpdateLiquidaSegundaInspeccionEquipo({
    this.segInsp,
    this.idInspeccionEquipos,
  });

  String? segInsp;
  int? idInspeccionEquipos;

  factory SpUpdateLiquidaSegundaInspeccionEquipo.fromJson(
          Map<String, dynamic> json) =>
      SpUpdateLiquidaSegundaInspeccionEquipo(
        segInsp: json["segInsp"],
        idInspeccionEquipos: json["idInspeccionEquipos"],
      );

  Map<String, dynamic> toJson() => {
        "segInsp": segInsp,
        "idInspeccionEquipos": idInspeccionEquipos,
      };
}
