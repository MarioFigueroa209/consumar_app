// To parse this JSON data, do
//
//     final spRampaDescargaModel = spRampaDescargaModelFromJson(jsonString);

import 'dart:convert';

List<SpRampaDescargaModel> spRampaDescargaModelFromJson(String str) =>
    List<SpRampaDescargaModel>.from(
        json.decode(str).map((x) => SpRampaDescargaModel.fromJson(x)));

String spRampaDescargaModelToJson(List<SpRampaDescargaModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SpRampaDescargaModel {
  SpRampaDescargaModel({
    this.jornada,
    this.fecha,
    this.tipoImportacion,
    this.direccionamiento,
    this.numeroNivel,
    this.horaLectura,
    this.idServiceOrder,
    this.idUsuarios,
    this.idVehicle,
    this.idConductor,
  });

  int? jornada;
  DateTime? fecha;
  String? tipoImportacion;
  String? direccionamiento;
  int? numeroNivel;
  DateTime? horaLectura;
  int? idServiceOrder;
  int? idUsuarios;
  int? idVehicle;
  int? idConductor;

  factory SpRampaDescargaModel.fromJson(Map<String, dynamic> json) =>
      SpRampaDescargaModel(
        jornada: json["jornada"],
        fecha: DateTime.parse(json["fecha"]),
        tipoImportacion: json["tipoImportacion"],
        direccionamiento: json["direccionamiento"],
        numeroNivel: json["numeroNivel"],
        horaLectura: DateTime.parse(json["horaLectura"]),
        idServiceOrder: json["idServiceOrder"],
        idUsuarios: json["idUsuarios"],
        idVehicle: json["idVehicle"],
        idConductor: json["idConductor"],
      );

  Map<String, dynamic> toJson() => {
        "jornada": jornada,
        "fecha": fecha?.toIso8601String(),
        "tipoImportacion": tipoImportacion,
        "direccionamiento": direccionamiento,
        "numeroNivel": numeroNivel,
        "horaLectura": horaLectura?.toIso8601String(),
        "idServiceOrder": idServiceOrder,
        "idUsuarios": idUsuarios,
        "idVehicle": idVehicle,
        "idConductor": idConductor,
      };
}
