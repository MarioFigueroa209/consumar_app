// To parse this JSON data, do
//
//     final vwGranelConsultaTransporteByCod = vwGranelConsultaTransporteByCodFromJson(jsonString);

import 'dart:convert';

List<VwGranelConsultaTransporteByCod> vwGranelConsultaTransporteByCodFromJson(
        String str) =>
    List<VwGranelConsultaTransporteByCod>.from(json
        .decode(str)
        .map((x) => VwGranelConsultaTransporteByCod.fromJson(x)));

String vwGranelConsultaTransporteByCodToJson(
        List<VwGranelConsultaTransporteByCod> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class VwGranelConsultaTransporteByCod {
  int? idTransporte;
  String? placa;
  String? empresaTransporte;
  String? ruc;
  int? idServiceOrder;

  VwGranelConsultaTransporteByCod({
    this.idTransporte,
    this.placa,
    this.empresaTransporte,
    this.ruc,
    this.idServiceOrder,
  });

  factory VwGranelConsultaTransporteByCod.fromJson(Map<String, dynamic> json) =>
      VwGranelConsultaTransporteByCod(
        idTransporte: json["idTransporte"],
        placa: json["placa"],
        empresaTransporte: json["empresaTransporte"],
        ruc: json["ruc"],
        idServiceOrder: json["idServiceOrder"],
      );

  Map<String, dynamic> toJson() => {
        "idTransporte": idTransporte,
        "placa": placa,
        "empresaTransporte": empresaTransporte,
        "ruc": ruc,
        "idServiceOrder": idServiceOrder,
      };
}
