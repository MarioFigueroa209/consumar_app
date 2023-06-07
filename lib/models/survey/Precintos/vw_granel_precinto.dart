// To parse this JSON data, do
//
//     final vwGranelPrecinto = vwGranelPrecintoFromJson(jsonString);

import 'dart:convert';

List<VwGranelPrecinto> vwGranelPrecintoFromJson(String str) =>
    List<VwGranelPrecinto>.from(
        json.decode(str).map((x) => VwGranelPrecinto.fromJson(x)));

String vwGranelPrecintoToJson(List<VwGranelPrecinto> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class VwGranelPrecinto {
  VwGranelPrecinto({
    this.idVista,
    this.idCarguio,
    this.idTransporte,
    this.placa,
    this.tolva,
    this.empresaTransporte,
    this.idServiceOrder,
  });

  int? idVista;
  int? idCarguio;
  int? idTransporte;
  String? placa;
  String? tolva;
  String? empresaTransporte;
  int? idServiceOrder;

  factory VwGranelPrecinto.fromJson(Map<String, dynamic> json) =>
      VwGranelPrecinto(
        idVista: json["idVista"],
        idCarguio: json["idCarguio"],
        idTransporte: json["idTransporte"],
        placa: json["placa"],
        tolva: json["tolva"],
        empresaTransporte: json["empresaTransporte"],
        idServiceOrder: json["idServiceOrder"],
      );

  Map<String, dynamic> toJson() => {
        "idVista": idVista,
        "idCarguio": idCarguio,
        "idTransporte": idTransporte,
        "placa": placa,
        "tolva": tolva,
        "empresaTransporte": empresaTransporte,
        "idServiceOrder": idServiceOrder,
      };
}
