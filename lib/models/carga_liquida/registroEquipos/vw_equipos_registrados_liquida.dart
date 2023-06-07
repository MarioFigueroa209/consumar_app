// To parse this JSON data, do
//
//     final vwEquiposRegistradosLiquida = vwEquiposRegistradosLiquidaFromJson(jsonString);

import 'dart:convert';

List<VwEquiposRegistradosLiquida> vwEquiposRegistradosLiquidaFromJson(
        String str) =>
    List<VwEquiposRegistradosLiquida>.from(
        json.decode(str).map((x) => VwEquiposRegistradosLiquida.fromJson(x)));

String vwEquiposRegistradosLiquidaToJson(
        List<VwEquiposRegistradosLiquida> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class VwEquiposRegistradosLiquida {
  VwEquiposRegistradosLiquida({
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

  factory VwEquiposRegistradosLiquida.fromJson(Map<String, dynamic> json) =>
      VwEquiposRegistradosLiquida(
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
