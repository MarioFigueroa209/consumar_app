// To parse this JSON data, do
//
//     final spCreatePesoHistorico = spCreatePesoHistoricoFromJson(jsonString);

import 'dart:convert';

SpCreatePesoHistorico spCreatePesoHistoricoFromJson(String str) =>
    SpCreatePesoHistorico.fromJson(json.decode(str));

String spCreatePesoHistoricoToJson(SpCreatePesoHistorico data) =>
    json.encode(data.toJson());

class SpCreatePesoHistorico {
  SpCreatePesoHistorico({
    this.pesoBruto,
    this.taraCamion,
    this.pesoNeto,
    this.producto,
  });

  double? pesoBruto;
  double? taraCamion;
  double? pesoNeto;
  String? producto;

  factory SpCreatePesoHistorico.fromJson(Map<String, dynamic> json) =>
      SpCreatePesoHistorico(
        pesoBruto: json["pesoBruto"].toDouble(),
        taraCamion: json["taraCamion"].toDouble(),
        pesoNeto: json["pesoNeto"].toDouble(),
        producto: json["producto"],
      );

  Map<String, dynamic> toJson() => {
        "pesoBruto": pesoBruto,
        "taraCamion": taraCamion,
        "pesoNeto": pesoNeto,
        "producto": producto,
      };
}
