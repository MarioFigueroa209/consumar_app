// To parse this JSON data, do
//
//     final vwEquiposRegistradosGranel = vwEquiposRegistradosGranelFromJson(jsonString);

import 'dart:convert';

List<VwEquiposRegistradosGranel?>? vwEquiposRegistradosGranelFromJson(
        String str) =>
    json.decode(str) == null
        ? []
        : List<VwEquiposRegistradosGranel?>.from(json
            .decode(str)!
            .map((x) => VwEquiposRegistradosGranel.fromJson(x)));

String vwEquiposRegistradosGranelToJson(
        List<VwEquiposRegistradosGranel?>? data) =>
    json.encode(
        data == null ? [] : List<dynamic>.from(data.map((x) => x!.toJson())));

class VwEquiposRegistradosGranel {
  VwEquiposRegistradosGranel({
    this.idVista,
    this.idEquipo,
    this.codEquipo,
    this.equipo,
    this.detalle,
    this.puerto,
    this.operacion,
  });

  int? idVista;
  int? idEquipo;
  String? codEquipo;
  String? equipo;
  String? detalle;
  String? puerto;
  String? operacion;

  factory VwEquiposRegistradosGranel.fromJson(Map<String, dynamic> json) =>
      VwEquiposRegistradosGranel(
        idVista: json["idVista"],
        idEquipo: json["idEquipo"],
        codEquipo: json["codEquipo"],
        equipo: json["equipo"],
        detalle: json["detalle"],
        puerto: json["puerto"],
        operacion: json["operacion"],
      );

  Map<String, dynamic> toJson() => {
        "idVista": idVista,
        "idEquipo": idEquipo,
        "codEquipo": codEquipo,
        "equipo": equipo,
        "detalle": detalle,
        "puerto": puerto,
        "operacion": operacion,
      };
}
