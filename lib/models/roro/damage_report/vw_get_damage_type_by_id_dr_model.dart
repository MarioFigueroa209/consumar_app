// To parse this JSON data, do
//
//     final vwGetDamageTypeByIdDrModel = vwGetDamageTypeByIdDrModelFromJson(jsonString);

import 'dart:convert';

List<VwGetDamageTypeByIdDrModel> vwGetDamageTypeByIdDrModelFromJson(
        String str) =>
    List<VwGetDamageTypeByIdDrModel>.from(
        json.decode(str).map((x) => VwGetDamageTypeByIdDrModel.fromJson(x)));

String vwGetDamageTypeByIdDrModelToJson(
        List<VwGetDamageTypeByIdDrModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class VwGetDamageTypeByIdDrModel {
  VwGetDamageTypeByIdDrModel({
    this.idDamageReport,
    this.idDamageType,
    this.codigoDano,
    this.danoRegistrado,
    this.parteVehiculo,
    this.zonaVehiculo,
    this.fotoDano,
    this.descipcionFaltantes,
  });

  int? idDamageReport;
  int? idDamageType;
  String? codigoDano;
  String? danoRegistrado;
  String? parteVehiculo;
  String? zonaVehiculo;
  String? fotoDano;
  String? descipcionFaltantes;

  factory VwGetDamageTypeByIdDrModel.fromJson(Map<String, dynamic> json) =>
      VwGetDamageTypeByIdDrModel(
        idDamageReport: json["idDamageReport"],
        idDamageType: json["idDamageType"],
        codigoDano: json["codigoDano"],
        danoRegistrado: json["danoRegistrado"],
        parteVehiculo: json["parteVehiculo"],
        zonaVehiculo: json["zonaVehiculo"],
        fotoDano: json["fotoDano"],
        descipcionFaltantes: json["descipcionFaltantes"],
      );

  Map<String, dynamic> toJson() => {
        "idDamageReport": idDamageReport,
        "idDamageType": idDamageType,
        "codigoDano": codigoDano,
        "danoRegistrado": danoRegistrado,
        "parteVehiculo": parteVehiculo,
        "zonaVehiculo": zonaVehiculo,
        "fotoDano": fotoDano,
        "descipcionFaltantes": descipcionFaltantes,
      };
}
