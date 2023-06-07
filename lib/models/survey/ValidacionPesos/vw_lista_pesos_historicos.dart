// To parse this JSON data, do
//
//     final vwListaPesosHistoricos = vwListaPesosHistoricosFromJson(jsonString);

import 'dart:convert';

List<VwListaPesosHistoricos> vwListaPesosHistoricosFromJson(String str) =>
    List<VwListaPesosHistoricos>.from(
        json.decode(str).map((x) => VwListaPesosHistoricos.fromJson(x)));

String vwListaPesosHistoricosToJson(List<VwListaPesosHistoricos> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class VwListaPesosHistoricos {
  VwListaPesosHistoricos({
    this.pesoBruto,
    this.taraCamion,
    this.pesoNeto,
    this.producto,
  });

  double? pesoBruto;
  double? taraCamion;
  double? pesoNeto;
  String? producto;

  factory VwListaPesosHistoricos.fromJson(Map<String, dynamic> json) =>
      VwListaPesosHistoricos(
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
