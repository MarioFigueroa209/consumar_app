// To parse this JSON data, do
//
//     final vwLiquidaInspeccionFotosByIdInspeccion = vwLiquidaInspeccionFotosByIdInspeccionFromJson(jsonString);

import 'dart:convert';

List<VwLiquidaInspeccionFotosByIdInspeccion>
    vwLiquidaInspeccionFotosByIdInspeccionFromJson(String str) =>
        List<VwLiquidaInspeccionFotosByIdInspeccion>.from(json
            .decode(str)
            .map((x) => VwLiquidaInspeccionFotosByIdInspeccion.fromJson(x)));

String vwLiquidaInspeccionFotosByIdInspeccionToJson(
        List<VwLiquidaInspeccionFotosByIdInspeccion> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class VwLiquidaInspeccionFotosByIdInspeccion {
  VwLiquidaInspeccionFotosByIdInspeccion({
    this.idVista,
    this.idInspeccionEquipo,
    this.nombreEquipo,
    this.codEquipo,
    this.urlImagen,
    this.numInspeccion,
    this.estado,
  });

  int? idVista;
  int? idInspeccionEquipo;
  String? nombreEquipo;
  String? codEquipo;
  String? urlImagen;
  String? numInspeccion;
  String? estado;

  factory VwLiquidaInspeccionFotosByIdInspeccion.fromJson(
          Map<String, dynamic> json) =>
      VwLiquidaInspeccionFotosByIdInspeccion(
        idVista: json["idVista"],
        idInspeccionEquipo: json["idInspeccionEquipo"],
        nombreEquipo: json["nombreEquipo"],
        codEquipo: json["codEquipo"],
        urlImagen: json["urlImagen"],
        numInspeccion: json["numInspeccion"],
        estado: json["estado"],
      );

  Map<String, dynamic> toJson() => {
        "idVista": idVista,
        "idInspeccionEquipo": idInspeccionEquipo,
        "nombreEquipo": nombreEquipo,
        "codEquipo": codEquipo,
        "urlImagen": urlImagen,
        "numInspeccion": numInspeccion,
        "estado": estado,
      };
}
