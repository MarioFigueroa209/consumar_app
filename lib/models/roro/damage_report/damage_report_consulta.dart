// To parse this JSON data, do
//
//     final damageReportConsultaApi = damageReportConsultaApiFromJson(jsonString);

import 'dart:convert';

List<DamageReportConsultaApi> damageReportConsultaApiFromJson(String str) =>
    List<DamageReportConsultaApi>.from(
        json.decode(str).map((x) => DamageReportConsultaApi.fromJson(x)));

String damageReportConsultaApiToJson(List<DamageReportConsultaApi> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DamageReportConsultaApi {
  int? idServiceOrder;
  int? idVehiculo;
  String? chasis;
  String? marca;
  String? modelo;
  String? lineaNaviera;
  String? consigntario;
  String? billOfLeading;

  DamageReportConsultaApi({
    this.idServiceOrder,
    this.idVehiculo,
    this.chasis,
    this.marca,
    this.modelo,
    this.lineaNaviera,
    this.consigntario,
    this.billOfLeading,
  });

  factory DamageReportConsultaApi.fromJson(Map<String, dynamic> json) =>
      DamageReportConsultaApi(
        idServiceOrder: json["idServiceOrder"],
        idVehiculo: json["idVehiculo"],
        chasis: json["chasis"],
        marca: json["marca"],
        modelo: json["modelo"],
        lineaNaviera: json["lineaNaviera"],
        consigntario: json["consigntario"],
        billOfLeading: json["billOfLeading"],
      );

  Map<String, dynamic> toJson() => {
        "idServiceOrder": idServiceOrder,
        "idVehiculo": idVehiculo,
        "chasis": chasis,
        "marca": marca,
        "modelo": modelo,
        "lineaNaviera": lineaNaviera,
        "consigntario": consigntario,
        "billOfLeading": billOfLeading,
      };
}
