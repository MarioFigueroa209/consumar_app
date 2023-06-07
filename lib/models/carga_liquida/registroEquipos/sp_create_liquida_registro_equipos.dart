// To parse this JSON data, do
//
//     final spCreateLiquidaRegistroEquipos = spCreateLiquidaRegistroEquiposFromJson(jsonString);

import 'dart:convert';

SpCreateLiquidaRegistroEquipos spCreateLiquidaRegistroEquiposFromJson(
        String str) =>
    SpCreateLiquidaRegistroEquipos.fromJson(json.decode(str));

String spCreateLiquidaRegistroEquiposToJson(
        SpCreateLiquidaRegistroEquipos data) =>
    json.encode(data.toJson());

class SpCreateLiquidaRegistroEquipos {
  SpCreateLiquidaRegistroEquipos({
    this.codEquipo,
    this.equipo,
    this.detalle,
    this.puerto,
    this.operacion,
  });

  String? codEquipo;
  String? equipo;
  String? detalle;
  String? puerto;
  String? operacion;

  factory SpCreateLiquidaRegistroEquipos.fromJson(Map<String, dynamic> json) =>
      SpCreateLiquidaRegistroEquipos(
        codEquipo: json["codEquipo"],
        equipo: json["equipo"],
        detalle: json["detalle"],
        puerto: json["puerto"],
        operacion: json["operacion"],
      );

  Map<String, dynamic> toJson() => {
        "codEquipo": codEquipo,
        "equipo": equipo,
        "detalle": detalle,
        "puerto": puerto,
        "operacion": operacion,
      };
}
