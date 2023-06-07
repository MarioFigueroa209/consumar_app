// To parse this JSON data, do
//
//     final vwListaLiquidaPesosHistoricos = vwListaLiquidaPesosHistoricosFromJson(jsonString);

import 'dart:convert';

List<VwListaLiquidaPesosHistoricos> vwListaLiquidaPesosHistoricosFromJson(
        String str) =>
    List<VwListaLiquidaPesosHistoricos>.from(
        json.decode(str).map((x) => VwListaLiquidaPesosHistoricos.fromJson(x)));

String vwListaLiquidaPesosHistoricosToJson(
        List<VwListaLiquidaPesosHistoricos> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class VwListaLiquidaPesosHistoricos {
  VwListaLiquidaPesosHistoricos({
    this.pesoBruto,
    this.taraCamion,
    this.pesoNeto,
    this.producto,
  });

  int? pesoBruto;
  int? taraCamion;
  int? pesoNeto;
  String? producto;

  factory VwListaLiquidaPesosHistoricos.fromJson(Map<String, dynamic> json) =>
      VwListaLiquidaPesosHistoricos(
        pesoBruto: json["pesoBruto"],
        taraCamion: json["taraCamion"],
        pesoNeto: json["pesoNeto"],
        producto: json["producto"],
      );

  Map<String, dynamic> toJson() => {
        "pesoBruto": pesoBruto,
        "taraCamion": taraCamion,
        "pesoNeto": pesoNeto,
        "producto": producto,
      };
}
