import 'dart:convert';

// To parse this JSON data, do
//
//     final damageReportConsulta = damageReportConsultaFromJson(jsonString);

List<DamageReportConsultaApi> damageReportConsultaFromJson(String str) =>
    List<DamageReportConsultaApi>.from(
        json.decode(str).map((x) => DamageReportConsultaApi.fromJson(x)));

String damageReportConsultaToJson(List<DamageReportConsultaApi> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DamageReportConsultaApi {
  DamageReportConsultaApi({
    this.idServiceOrder,
    this.idVehiculo,
    this.chasis,
    this.marca,
    this.modelo,
    this.consigntario,
    this.billOfLeading,
  });

  int? idServiceOrder;
  int? idVehiculo;
  String? chasis;
  String? marca;
  String? modelo;
  String? consigntario;
  String? billOfLeading;

  factory DamageReportConsultaApi.fromJson(Map<String, dynamic> json) =>
      DamageReportConsultaApi(
        idServiceOrder: json["idServiceOrder"],
        idVehiculo: json["idVehiculo"],
        chasis: json["chasis"],
        marca: json["marca"],
        modelo: json["modelo"],
        consigntario: json["consigntario"],
        billOfLeading: json["billOfLeading"],
      );

  Map<String, dynamic> toJson() => {
        "idServiceOrder": idServiceOrder,
        "idVehiculo": idVehiculo,
        "chasis": chasis,
        "marca": marca,
        "modelo": modelo,
        "consigntario": consigntario,
        "billOfLeading": billOfLeading,
      };
}
