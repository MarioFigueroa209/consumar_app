// To parse this JSON data, do
//
//     final getDistribucionSilos = getDistribucionSilosFromJson(jsonString);

import 'dart:convert';

List<GetDistribucionSilos> getDistribucionSilosFromJson(String str) =>
    List<GetDistribucionSilos>.from(
        json.decode(str).map((x) => GetDistribucionSilos.fromJson(x)));

String getDistribucionSilosToJson(List<GetDistribucionSilos> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetDistribucionSilos {
  int? idDistribucion;
  String? silo;
  String? nave;
  String? puntoDespacho;
  DateTime? fecha;
  int? jornada;
  String? bl;
  int? idApm;
  int? idUsuarios;

  GetDistribucionSilos({
    this.idDistribucion,
    this.silo,
    this.nave,
    this.puntoDespacho,
    this.fecha,
    this.jornada,
    this.bl,
    this.idApm,
    this.idUsuarios,
  });

  factory GetDistribucionSilos.fromJson(Map<String, dynamic> json) =>
      GetDistribucionSilos(
        idDistribucion: json["idDistribucion"],
        silo: json["silo"],
        nave: json["nave"],
        puntoDespacho: json["puntoDespacho"],
        fecha: DateTime.parse(json["fecha"]),
        jornada: json["jornada"],
        bl: json["bl"],
        idApm: json["idApm"],
        idUsuarios: json["idUsuarios"],
      );

  Map<String, dynamic> toJson() => {
        "idDistribucion": idDistribucion,
        "silo": silo,
        "nave": nave,
        "puntoDespacho": puntoDespacho,
        "fecha": fecha!.toIso8601String(),
        "jornada": jornada,
        "bl": bl,
        "idApm": idApm,
        "idUsuarios": idUsuarios,
      };
}
