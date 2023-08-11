// To parse this JSON data, do
//
//     final vwLiquidaPrecinto = vwLiquidaPrecintoFromJson(jsonString);

import 'dart:convert';

List<VwLiquidaPrecinto> vwLiquidaPrecintoFromJson(String str) =>
    List<VwLiquidaPrecinto>.from(
        json.decode(str).map((x) => VwLiquidaPrecinto.fromJson(x)));

String vwLiquidaPrecintoToJson(List<VwLiquidaPrecinto> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class VwLiquidaPrecinto {
  int? idVista;
  int? idCarguio;
  int? idTransporte;
  String? placa;
  String? nticket;
  String? cisterna;
  String? empresaTransporte;
  int? idServiceOrder;

  VwLiquidaPrecinto({
    this.idVista,
    this.idCarguio,
    this.idTransporte,
    this.placa,
    this.nticket,
    this.cisterna,
    this.empresaTransporte,
    this.idServiceOrder,
  });

  factory VwLiquidaPrecinto.fromJson(Map<String, dynamic> json) =>
      VwLiquidaPrecinto(
        idVista: json["idVista"],
        idCarguio: json["idCarguio"],
        idTransporte: json["idTransporte"],
        placa: json["placa"],
        nticket: json["nticket"],
        cisterna: json["cisterna"],
        empresaTransporte: json["empresaTransporte"],
        idServiceOrder: json["idServiceOrder"],
      );

  Map<String, dynamic> toJson() => {
        "idVista": idVista,
        "idCarguio": idCarguio,
        "idTransporte": idTransporte,
        "placa": placa,
        "nticket": nticket,
        "cisterna": cisterna,
        "empresaTransporte": empresaTransporte,
        "idServiceOrder": idServiceOrder,
      };
}
