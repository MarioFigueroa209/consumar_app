// To parse this JSON data, do
//
//     final vwLecturaByQrCarguioLiquida = vwLecturaByQrCarguioLiquidaFromJson(jsonString);

import 'dart:convert';

VwLecturaByQrCarguioLiquida vwLecturaByQrCarguioLiquidaFromJson(String str) =>
    VwLecturaByQrCarguioLiquida.fromJson(json.decode(str));

String vwLecturaByQrCarguioLiquidaToJson(VwLecturaByQrCarguioLiquida data) =>
    json.encode(data.toJson());

class VwLecturaByQrCarguioLiquida {
  VwLecturaByQrCarguioLiquida({
    this.idPrecintado,
    this.idCarguio,
    this.codPrecintado,
    this.placa,
    this.cisterna,
    this.empresaTransporte,
  });

  int? idPrecintado;
  int? idCarguio;
  String? codPrecintado;
  String? placa;
  String? cisterna;
  String? empresaTransporte;

  factory VwLecturaByQrCarguioLiquida.fromJson(Map<String, dynamic> json) =>
      VwLecturaByQrCarguioLiquida(
        idPrecintado: json["idPrecintado"],
        idCarguio: json["idCarguio"],
        codPrecintado: json["codPrecintado"],
        placa: json["placa"],
        cisterna: json["cisterna"],
        empresaTransporte: json["empresaTransporte"],
      );

  Map<String, dynamic> toJson() => {
        "idPrecintado": idPrecintado,
        "idCarguio": idCarguio,
        "codPrecintado": codPrecintado,
        "placa": placa,
        "cisterna": cisterna,
        "empresaTransporte": empresaTransporte,
      };
}
