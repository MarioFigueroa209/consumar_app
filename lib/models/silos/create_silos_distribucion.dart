// To parse this JSON data, do
//
//     final createSilosDistribucion = createSilosDistribucionFromJson(jsonString);

import 'dart:convert';

CreateSilosDistribucion createSilosDistribucionFromJson(String str) =>
    CreateSilosDistribucion.fromJson(json.decode(str));

String createSilosDistribucionToJson(CreateSilosDistribucion data) =>
    json.encode(data.toJson());

class CreateSilosDistribucion {
  String? silo;
  String? nave;
  String? puntoDespacho;
  DateTime? fecha;
  int? jornada;
  String? bl;
  int? idApm;
  int? idUsuarios;
  int? idServiceOrder;

  CreateSilosDistribucion({
    this.silo,
    this.nave,
    this.puntoDespacho,
    this.fecha,
    this.jornada,
    this.bl,
    this.idApm,
    this.idUsuarios,
    this.idServiceOrder,
  });

  factory CreateSilosDistribucion.fromJson(Map<String, dynamic> json) =>
      CreateSilosDistribucion(
        silo: json["silo"],
        nave: json["nave"],
        puntoDespacho: json["puntoDespacho"],
        fecha: DateTime.parse(json["fecha"]),
        jornada: json["jornada"],
        bl: json["bl"],
        idApm: json["idApm"],
        idUsuarios: json["idUsuarios"],
        idServiceOrder: json["idServiceOrder"],
      );

  Map<String, dynamic> toJson() => {
        "silo": silo,
        "nave": nave,
        "puntoDespacho": puntoDespacho,
        "fecha": fecha!.toIso8601String(),
        "jornada": jornada,
        "bl": bl,
        "idApm": idApm,
        "idUsuarios": idUsuarios,
        "idServiceOrder": idServiceOrder,
      };
}
