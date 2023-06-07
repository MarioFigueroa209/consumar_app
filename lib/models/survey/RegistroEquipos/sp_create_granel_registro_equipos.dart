// To parse this JSON data, do
//
//     final spCreateGranelRegistroEquipos = spCreateGranelRegistroEquiposFromJson(jsonString);

import 'dart:convert';

SpCreateGranelRegistroEquipos? spCreateGranelRegistroEquiposFromJson(
        String str) =>
    SpCreateGranelRegistroEquipos.fromJson(json.decode(str));

String spCreateGranelRegistroEquiposToJson(
        SpCreateGranelRegistroEquipos? data) =>
    json.encode(data!.toJson());

class SpCreateGranelRegistroEquipos {
  SpCreateGranelRegistroEquipos({
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

  factory SpCreateGranelRegistroEquipos.fromJson(Map<String, dynamic> json) =>
      SpCreateGranelRegistroEquipos(
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
