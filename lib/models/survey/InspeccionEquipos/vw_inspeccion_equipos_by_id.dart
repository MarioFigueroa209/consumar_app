import 'dart:convert';

List<VwInspeccionEquiposById> vwInspeccionEquiposByIdFromJson(String str) =>
    List<VwInspeccionEquiposById>.from(
        json.decode(str).map((x) => VwInspeccionEquiposById.fromJson(x)));

String vwInspeccionEquiposByIdToJson(List<VwInspeccionEquiposById> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class VwInspeccionEquiposById {
  VwInspeccionEquiposById({
    this.idVista,
    this.idInspeccionEquipo,
    this.idServiceOrder,
    this.idEquipo,
    this.bodega,
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
  String? bodega;
  String? nombreEquipo;
  String? codEquipo;
  String? comentario;
  String? primeraInspeccion;
  String? segundoInspeccion;
  String? terceraInspeccion;

  factory VwInspeccionEquiposById.fromJson(Map<String, dynamic> json) =>
      VwInspeccionEquiposById(
        idVista: json["idVista"],
        idInspeccionEquipo: json["idInspeccionEquipo"],
        idServiceOrder: json["idServiceOrder"],
        idEquipo: json["idEquipo"],
        bodega: json["bodega"],
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
        "bodega": bodega,
        "nombreEquipo": nombreEquipo,
        "codEquipo": codEquipo,
        "comentario": comentario,
        "primeraInspeccion": primeraInspeccion,
        "segundoInspeccion": segundoInspeccion,
        "terceraInspeccion": terceraInspeccion,
      };
}
