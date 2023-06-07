import 'dart:convert';

List<VwInspeccionFotosByIdInspeccion> vwInspeccionFotosByIdInspeccionFromJson(
        String str) =>
    List<VwInspeccionFotosByIdInspeccion>.from(json
        .decode(str)
        .map((x) => VwInspeccionFotosByIdInspeccion.fromJson(x)));

String vwInspeccionFotosByIdInspeccionToJson(
        List<VwInspeccionFotosByIdInspeccion> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class VwInspeccionFotosByIdInspeccion {
  VwInspeccionFotosByIdInspeccion({
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

  factory VwInspeccionFotosByIdInspeccion.fromJson(Map<String, dynamic> json) =>
      VwInspeccionFotosByIdInspeccion(
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
