// To parse this JSON data, do
//
//     final spCreateLiquidaPesoHistorico = spCreateLiquidaPesoHistoricoFromJson(jsonString);

import 'dart:convert';

SpCreateLiquidaPesoHistorico spCreateLiquidaPesoHistoricoFromJson(String str) =>
    SpCreateLiquidaPesoHistorico.fromJson(json.decode(str));

String spCreateLiquidaPesoHistoricoToJson(SpCreateLiquidaPesoHistorico data) =>
    json.encode(data.toJson());

class SpCreateLiquidaPesoHistorico {
  SpCreateLiquidaPesoHistorico({
    this.pesoBruto,
    this.taraCamion,
    this.pesoNeto,
    this.producto,
  });

  double? pesoBruto;
  double? taraCamion;
  double? pesoNeto;
  String? producto;

  factory SpCreateLiquidaPesoHistorico.fromJson(Map<String, dynamic> json) =>
      SpCreateLiquidaPesoHistorico(
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
