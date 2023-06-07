// To parse this JSON data, do
//
//     final spDistribucionEmbarqueModel = spDistribucionEmbarqueModelFromJson(jsonString);

import 'dart:convert';

List<SpDistribucionEmbarqueModel> spDistribucionEmbarqueModelFromJson(
        String str) =>
    List<SpDistribucionEmbarqueModel>.from(
        json.decode(str).map((x) => SpDistribucionEmbarqueModel.fromJson(x)));

String spDistribucionEmbarqueModelToJson(
        List<SpDistribucionEmbarqueModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SpDistribucionEmbarqueModel {
  SpDistribucionEmbarqueModel({
    this.jornada,
    this.fecha,
    this.maker,
    this.cantidad,
    this.nivel,
    this.idServiceOrder,
    this.idUsuarios,
    this.idShip,
  });

  int? jornada;
  DateTime? fecha;
  String? maker;
  int? cantidad;
  int? nivel;
  int? idServiceOrder;
  int? idUsuarios;
  int? idShip;

  factory SpDistribucionEmbarqueModel.fromJson(Map<String, dynamic> json) =>
      SpDistribucionEmbarqueModel(
        jornada: json["jornada"],
        fecha: DateTime.parse(json["fecha"]),
        maker: json["maker"],
        cantidad: json["cantidad"],
        nivel: json["nivel"],
        idServiceOrder: json["idServiceOrder"],
        idUsuarios: json["idUsuarios"],
        idShip: json["idShip"],
      );

  Map<String, dynamic> toJson() => {
        "jornada": jornada,
        "fecha": fecha?.toIso8601String(),
        "maker": maker,
        "cantidad": cantidad,
        "nivel": nivel,
        "idServiceOrder": idServiceOrder,
        "idUsuarios": idUsuarios,
        "idShip": idShip,
      };
}
