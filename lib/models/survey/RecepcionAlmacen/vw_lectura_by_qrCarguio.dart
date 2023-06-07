// To parse this JSON data, do
//
//     final vwLecturaBByQrCarguio = vwLecturaBByQrCarguioFromJson(jsonString);

import 'dart:convert';

VwLecturaByQrCarguio vwLecturaBByQrCarguioFromJson(String str) =>
    VwLecturaByQrCarguio.fromJson(json.decode(str));

String vwLecturaBByQrCarguioToJson(VwLecturaByQrCarguio data) =>
    json.encode(data.toJson());

class VwLecturaByQrCarguio {
  VwLecturaByQrCarguio({
    this.idPrecintado,
    this.idCarguio,
    this.codPrecintado,
    this.placa,
    this.tolva,
    this.empresaTransporte,
  });

  int? idPrecintado;
  int? idCarguio;
  String? codPrecintado;
  String? placa;
  String? tolva;
  String? empresaTransporte;

  factory VwLecturaByQrCarguio.fromJson(Map<String, dynamic> json) =>
      VwLecturaByQrCarguio(
        idPrecintado: json["idPrecintado"],
        idCarguio: json["idCarguio"],
        codPrecintado: json["codPrecintado"],
        placa: json["placa"],
        tolva: json["tolva"],
        empresaTransporte: json["empresaTransporte"],
      );

  Map<String, dynamic> toJson() => {
        "idPrecintado": idPrecintado,
        "idCarguio": idCarguio,
        "codPrecintado": codPrecintado,
        "placa": placa,
        "tolva": tolva,
        "empresaTransporte": empresaTransporte,
      };
}
