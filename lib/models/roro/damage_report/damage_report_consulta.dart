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
  String? agenciaMaritima;
  String? consigntario;
  String? billOfLeading;

  DamageReportConsultaApi({
    this.idServiceOrder,
    this.idVehiculo,
    this.chasis,
    this.marca,
    this.modelo,
    this.agenciaMaritima,
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
        agenciaMaritima: json["agenciaMaritima"],
        consigntario: json["consigntario"],
        billOfLeading: json["billOfLeading"],
      );

  Map<String, dynamic> toJson() => {
        "idServiceOrder": idServiceOrder,
        "idVehiculo": idVehiculo,
        "chasis": chasis,
        "marca": marca,
        "modelo": modelo,
        "agenciaMaritima": agenciaMaritima,
        "consigntario": consigntario,
        "billOfLeading": billOfLeading,
      };
}
