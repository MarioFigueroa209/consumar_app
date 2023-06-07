// To parse this JSON data, do
//
//     final spCreateRampaEmbarqueModel = spCreateRampaEmbarqueModelFromJson(jsonString);

import 'dart:convert';

List<SpCreateRampaEmbarqueModel> spCreateRampaEmbarqueModelFromJson(
        String str) =>
    List<SpCreateRampaEmbarqueModel>.from(
        json.decode(str).map((x) => SpCreateRampaEmbarqueModel.fromJson(x)));

String spCreateRampaEmbarqueModelToJson(
        List<SpCreateRampaEmbarqueModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SpCreateRampaEmbarqueModel {
  SpCreateRampaEmbarqueModel({
    this.jornada,
    this.fecha,
    this.nivel,
    this.horaLectura,
    this.idServiceOrder,
    this.idUsuarios,
    this.idVehicle,
    this.idConductor,
    this.idShipOrigen,
    this.idShipDestino,
    this.idBl,
  });

  int? jornada;
  DateTime? fecha;
  String? nivel;
  DateTime? horaLectura;
  int? idServiceOrder;
  int? idUsuarios;
  int? idVehicle;
  int? idConductor;
  int? idShipOrigen;
  int? idShipDestino;
  int? idBl;

  factory SpCreateRampaEmbarqueModel.fromJson(Map<String, dynamic> json) =>
      SpCreateRampaEmbarqueModel(
        jornada: json["jornada"],
        fecha: DateTime.parse(json["fecha"]),
        nivel: json["nivel"],
        horaLectura: DateTime.parse(json["horaLectura"]),
        idServiceOrder: json["idServiceOrder"],
        idUsuarios: json["idUsuarios"],
        idVehicle: json["idVehicle"],
        idConductor: json["idConductor"],
        idShipOrigen: json["idShipOrigen"],
        idShipDestino: json["idShipDestino"],
        idBl: json["idBl"],
      );

  Map<String, dynamic> toJson() => {
        "jornada": jornada,
        "fecha": fecha!.toIso8601String(),
        "nivel": nivel,
        "horaLectura": horaLectura!.toIso8601String(),
        "idServiceOrder": idServiceOrder,
        "idUsuarios": idUsuarios,
        "idVehicle": idVehicle,
        "idConductor": idConductor,
        "idShipOrigen": idShipOrigen,
        "idShipDestino": idShipDestino,
        "idBl": idBl,
      };
}
