// To parse this JSON data, do
//
//     final vwLiquidaPrecinto = vwLiquidaPrecintoFromJson(jsonString);

import 'dart:convert';

VwLiquidaPrecinto vwLiquidaPrecintoFromJson(String str) =>
    VwLiquidaPrecinto.fromJson(json.decode(str));

String vwLiquidaPrecintoToJson(VwLiquidaPrecinto data) =>
    json.encode(data.toJson());

class VwLiquidaPrecinto {
  VwLiquidaPrecinto({
    this.idVista,
    this.idCarguio,
    this.idTransporte,
    this.placa,
    this.cisterna,
    this.empresaTransporte,
    this.idServiceOrder,
  });

  int? idVista;
  int? idCarguio;
  int? idTransporte;
  String? placa;
  String? cisterna;
  String? empresaTransporte;
  int? idServiceOrder;

  factory VwLiquidaPrecinto.fromJson(Map<String, dynamic> json) =>
      VwLiquidaPrecinto(
        idVista: json["idVista"],
        idCarguio: json["idCarguio"],
        idTransporte: json["idTransporte"],
        placa: json["placa"],
        cisterna: json["cisterna"],
        empresaTransporte: json["empresaTransporte"],
        idServiceOrder: json["idServiceOrder"],
      );

  Map<String, dynamic> toJson() => {
        "idVista": idVista,
        "idCarguio": idCarguio,
        "idTransporte": idTransporte,
        "placa": placa,
        "cisterna": cisterna,
        "empresaTransporte": empresaTransporte,
        "idServiceOrder": idServiceOrder,
      };
}
