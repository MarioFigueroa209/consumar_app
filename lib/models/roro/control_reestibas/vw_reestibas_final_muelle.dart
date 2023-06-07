// To parse this JSON data, do
//
//     final vwReestibasFinalMuelle = vwReestibasFinalMuelleFromJson(jsonString);

import 'dart:convert';

List<VwReestibasFinalMuelle> vwReestibasFinalMuelleFromJson(String str) =>
    List<VwReestibasFinalMuelle>.from(
        json.decode(str).map((x) => VwReestibasFinalMuelle.fromJson(x)));

String vwReestibasFinalMuelleToJson(List<VwReestibasFinalMuelle> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class VwReestibasFinalMuelle {
  VwReestibasFinalMuelle({
    this.idVista,
    this.segundoMovimiento,
    this.idPrimerMovimiento,
    this.marca,
    this.modelo,
    this.pesoBruto,
    this.unidad,
    this.conversion,
    this.nivelInicial,
    this.bodegaInicial,
    this.muelle,
    this.nivelFinal,
    this.bodegaFinal,
    this.cantidadFinal,
    this.subTotalPesos,
    this.idApmtc,
    this.idReestibasFirmantes,
    this.idServiceOrder,
  });

  int? idVista;
  int? segundoMovimiento;
  int? idPrimerMovimiento;
  String? marca;
  String? modelo;
  double? pesoBruto;
  String? unidad;
  double? conversion;
  String? nivelInicial;
  String? bodegaInicial;
  String? muelle;
  String? nivelFinal;
  String? bodegaFinal;
  int? cantidadFinal;
  double? subTotalPesos;
  int? idApmtc;
  int? idReestibasFirmantes;
  int? idServiceOrder;

  factory VwReestibasFinalMuelle.fromJson(Map<String, dynamic> json) =>
      VwReestibasFinalMuelle(
        idVista: json["idVista"],
        segundoMovimiento: json["segundoMovimiento"],
        idPrimerMovimiento: json["idPrimerMovimiento"],
        marca: json["marca"],
        modelo: json["modelo"],
        pesoBruto: double.parse(json["pesoBruto"].toString()),
        unidad: json["unidad"],
        conversion: double.parse(json["conversion"].toString()),
        nivelInicial: json["nivelInicial"],
        bodegaInicial: json["bodegaInicial"],
        muelle: json["muelle"],
        nivelFinal: json["nivelFinal"],
        bodegaFinal: json["bodegaFinal"],
        cantidadFinal: json["cantidadFinal"],
        subTotalPesos: double.parse(json["subTotalPesos"].toString()),
        idApmtc: json["idApmtc"],
        idReestibasFirmantes: json["idReestibasFirmantes"],
        idServiceOrder: json["idServiceOrder"],
      );

  Map<String, dynamic> toJson() => {
        "idVista": idVista,
        "segundoMovimiento": segundoMovimiento,
        "idPrimerMovimiento": idPrimerMovimiento,
        "marca": marca,
        "modelo": modelo,
        "pesoBruto": pesoBruto,
        "unidad": unidad,
        "conversion": conversion,
        "nivelInicial": nivelInicial,
        "bodegaInicial": bodegaInicial,
        "muelle": muelle,
        "nivelFinal": nivelFinal,
        "bodegaFinal": bodegaFinal,
        "cantidadFinal": cantidadFinal,
        "subTotalPesos": subTotalPesos,
        "idApmtc": idApmtc,
        "idReestibasFirmantes": idReestibasFirmantes,
        "idServiceOrder": idServiceOrder,
      };
}
