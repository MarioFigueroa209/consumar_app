// To parse this JSON data, do
//
//     final vwLecturaByQrCarguioLiquida = vwLecturaByQrCarguioLiquidaFromJson(jsonString);

import 'dart:convert';

VwLecturaByQrCarguioLiquida vwLecturaByQrCarguioLiquidaFromJson(String str) =>
    VwLecturaByQrCarguioLiquida.fromJson(json.decode(str));

String vwLecturaByQrCarguioLiquidaToJson(VwLecturaByQrCarguioLiquida data) =>
    json.encode(data.toJson());

class VwLecturaByQrCarguioLiquida {
  int? idPrecintado;
  int? idCarguio;
  String? mercaderia;
  String? codPrecintado;
  String? placa;
  String? cisterna;
  String? nTicket;
  String? empresaTransporte;

  VwLecturaByQrCarguioLiquida({
    this.idPrecintado,
    this.idCarguio,
    this.mercaderia,
    this.codPrecintado,
    this.placa,
    this.cisterna,
    this.nTicket,
    this.empresaTransporte,
  });

  factory VwLecturaByQrCarguioLiquida.fromJson(Map<String, dynamic> json) =>
      VwLecturaByQrCarguioLiquida(
        idPrecintado: json["idPrecintado"],
        idCarguio: json["idCarguio"],
        mercaderia: json["mercaderia"],
        codPrecintado: json["codPrecintado"],
        placa: json["placa"],
        cisterna: json["cisterna"],
        nTicket: json["nTicket"],
        empresaTransporte: json["empresaTransporte"],
      );

  Map<String, dynamic> toJson() => {
        "idPrecintado": idPrecintado,
        "idCarguio": idCarguio,
        "mercaderia": mercaderia,
        "codPrecintado": codPrecintado,
        "placa": placa,
        "cisterna": cisterna,
        "nTicket": nTicket,
        "empresaTransporte": empresaTransporte,
      };
}
