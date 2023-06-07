// To parse this JSON data, do
//
//     final vwReestibasFinalAbordo = vwReestibasFinalAbordoFromJson(jsonString);

import 'dart:convert';

List<VwReestibasFinalAbordo> vwReestibasFinalAbordoFromJson(String str) =>
    List<VwReestibasFinalAbordo>.from(
        json.decode(str).map((x) => VwReestibasFinalAbordo.fromJson(x)));

String vwReestibasFinalAbordoToJson(List<VwReestibasFinalAbordo> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class VwReestibasFinalAbordo {
  VwReestibasFinalAbordo({
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
    this.nivelTemporal,
    this.bodegaTemporal,
    this.nivelFinal,
    this.bodegaFinal,
    this.cantidadFinal,
    this.idApmtc,
    this.idReestibasFirmantes,
    this.subTotalPesos,
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
  String? nivelTemporal;
  String? bodegaTemporal;
  String? nivelFinal;
  String? bodegaFinal;
  int? cantidadFinal;
  int? idApmtc;
  int? idReestibasFirmantes;
  double? subTotalPesos;
  int? idServiceOrder;

  factory VwReestibasFinalAbordo.fromJson(Map<String, dynamic> json) =>
      VwReestibasFinalAbordo(
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
        nivelTemporal: json["nivelTemporal"],
        bodegaTemporal: json["bodegaTemporal"],
        nivelFinal: json["nivelFinal"],
        bodegaFinal: json["bodegaFinal"],
        cantidadFinal: json["cantidadFinal"],
        idApmtc: json["idApmtc"],
        idReestibasFirmantes: json["idReestibasFirmantes"],
        subTotalPesos: double.parse(json["subTotalPesos"].toString()),
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
        "nivelTemporal": nivelTemporal,
        "bodegaTemporal": bodegaTemporal,
        "nivelFinal": nivelFinal,
        "bodegaFinal": bodegaFinal,
        "cantidadFinal": cantidadFinal,
        "idApmtc": idApmtc,
        "idReestibasFirmantes": idReestibasFirmantes,
        "subTotalPesos": subTotalPesos,
        "idServiceOrder": idServiceOrder,
      };
}
