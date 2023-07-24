// To parse this JSON data, do
//
//     final vwLiquidaPlacasInicioCarguio = vwLiquidaPlacasInicioCarguioFromJson(jsonString);

import 'dart:convert';

List<VwLiquidaPlacasInicioCarguio> vwLiquidaPlacasInicioCarguioFromJson(
        String str) =>
    List<VwLiquidaPlacasInicioCarguio>.from(
        json.decode(str).map((x) => VwLiquidaPlacasInicioCarguio.fromJson(x)));

String vwLiquidaPlacasInicioCarguioToJson(
        List<VwLiquidaPlacasInicioCarguio> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class VwLiquidaPlacasInicioCarguio {
  String? placa;
  int? idCarguio;
  int? idTransporte;
  String? empresaTransporte;
  int? idServiceOrder;
  DateTime? inicioCarguio;
  String? cisterna;

  VwLiquidaPlacasInicioCarguio({
    this.placa,
    this.idCarguio,
    this.idTransporte,
    this.empresaTransporte,
    this.idServiceOrder,
    this.inicioCarguio,
    this.cisterna,
  });

  factory VwLiquidaPlacasInicioCarguio.fromJson(Map<String, dynamic> json) =>
      VwLiquidaPlacasInicioCarguio(
        placa: json["placa"],
        idCarguio: json["idCarguio"],
        idTransporte: json["idTransporte"],
        empresaTransporte: json["empresaTransporte"],
        idServiceOrder: json["idServiceOrder"],
        inicioCarguio: DateTime.parse(json["inicioCarguio"]),
        cisterna: json["cisterna"],
      );

  Map<String, dynamic> toJson() => {
        "placa": placa,
        "idCarguio": idCarguio,
        "idTransporte": idTransporte,
        "empresaTransporte": empresaTransporte,
        "idServiceOrder": idServiceOrder,
        "inicioCarguio": inicioCarguio!.toIso8601String(),
        "cisterna": cisterna,
      };
}
