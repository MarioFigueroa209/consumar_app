// To parse this JSON data, do
//
//     final vwLecturaByQrCarguio = vwLecturaByQrCarguioFromJson(jsonString);

import 'dart:convert';

VwLecturaByQrCarguio vwLecturaByQrCarguioFromJson(String str) =>
    VwLecturaByQrCarguio.fromJson(json.decode(str));

String vwLecturaByQrCarguioToJson(VwLecturaByQrCarguio data) =>
    json.encode(data.toJson());

class VwLecturaByQrCarguio {
  int? idPrecintado;
  int? idCarguio;
  String? codPrecintado;
  String? mercaderia;
  String? placa;
  String? tolva;
  String? empresaTransporte;
  String? nticket;

  VwLecturaByQrCarguio({
    this.idPrecintado,
    this.idCarguio,
    this.codPrecintado,
    this.mercaderia,
    this.placa,
    this.tolva,
    this.empresaTransporte,
    this.nticket,
  });

  factory VwLecturaByQrCarguio.fromJson(Map<String, dynamic> json) =>
      VwLecturaByQrCarguio(
        idPrecintado: json["idPrecintado"],
        idCarguio: json["idCarguio"],
        codPrecintado: json["codPrecintado"],
        mercaderia: json["mercaderia"],
        placa: json["placa"],
        tolva: json["tolva"],
        empresaTransporte: json["empresaTransporte"],
        nticket: json["nticket"],
      );

  Map<String, dynamic> toJson() => {
        "idPrecintado": idPrecintado,
        "idCarguio": idCarguio,
        "codPrecintado": codPrecintado,
        "mercaderia": mercaderia,
        "placa": placa,
        "tolva": tolva,
        "empresaTransporte": empresaTransporte,
        "nticket": nticket,
      };
}
