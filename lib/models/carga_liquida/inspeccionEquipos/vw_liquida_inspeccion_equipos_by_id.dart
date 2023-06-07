// To parse this JSON data, do
//
//     final vwLiquidaInspeccionEquiposById = vwLiquidaInspeccionEquiposByIdFromJson(jsonString);

import 'dart:convert';

VwLiquidaInspeccionEquiposById vwLiquidaInspeccionEquiposByIdFromJson(
        String str) =>
    VwLiquidaInspeccionEquiposById.fromJson(json.decode(str));

String vwLiquidaInspeccionEquiposByIdToJson(
        VwLiquidaInspeccionEquiposById data) =>
    json.encode(data.toJson());

class VwLiquidaInspeccionEquiposById {
  VwLiquidaInspeccionEquiposById({
    this.idVista,
    this.idInspeccionEquipo,
    this.idServiceOrder,
    this.idEquipo,
    this.tanque,
    this.nombreEquipo,
    this.codEquipo,
    this.comentario,
    this.primeraInspeccion,
    this.segundoInspeccion,
    this.terceraInspeccion,
  });

  int? idVista;
  int? idInspeccionEquipo;
  int? idServiceOrder;
  int? idEquipo;
  String? tanque;
  String? nombreEquipo;
  String? codEquipo;
  String? comentario;
  String? primeraInspeccion;
  String? segundoInspeccion;
  String? terceraInspeccion;

  factory VwLiquidaInspeccionEquiposById.fromJson(Map<String, dynamic> json) =>
      VwLiquidaInspeccionEquiposById(
        idVista: json["idVista"],
        idInspeccionEquipo: json["idInspeccionEquipo"],
        idServiceOrder: json["idServiceOrder"],
        idEquipo: json["idEquipo"],
        tanque: json["tanque"],
        nombreEquipo: json["nombreEquipo"],
        codEquipo: json["codEquipo"],
        comentario: json["comentario"],
        primeraInspeccion: json["primeraInspeccion"],
        segundoInspeccion: json["segundoInspeccion"],
        terceraInspeccion: json["terceraInspeccion"],
      );

  Map<String, dynamic> toJson() => {
        "idVista": idVista,
        "idInspeccionEquipo": idInspeccionEquipo,
        "idServiceOrder": idServiceOrder,
        "idEquipo": idEquipo,
        "tanque": tanque,
        "nombreEquipo": nombreEquipo,
        "codEquipo": codEquipo,
        "comentario": comentario,
        "primeraInspeccion": primeraInspeccion,
        "segundoInspeccion": segundoInspeccion,
        "terceraInspeccion": terceraInspeccion,
      };
}
