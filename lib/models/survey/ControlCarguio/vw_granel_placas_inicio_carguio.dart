// To parse this JSON data, do
//
//     final vwGranelPlacasInicioCarguio = vwGranelPlacasInicioCarguioFromJson(jsonString);

import 'dart:convert';

List<VwGranelPlacasInicioCarguio> vwGranelPlacasInicioCarguioFromJson(
        String str) =>
    List<VwGranelPlacasInicioCarguio>.from(
        json.decode(str).map((x) => VwGranelPlacasInicioCarguio.fromJson(x)));

String vwGranelPlacasInicioCarguioToJson(
        List<VwGranelPlacasInicioCarguio> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class VwGranelPlacasInicioCarguio {
  String? placa;
  int? idCarguio;
  int? idTransporte;
  String? empresaTransporte;
  int? idServiceOrder;
  DateTime? inicioCarguio;
  String? tolva;

  VwGranelPlacasInicioCarguio({
    this.placa,
    this.idCarguio,
    this.idTransporte,
    this.empresaTransporte,
    this.idServiceOrder,
    this.inicioCarguio,
    this.tolva,
  });

  factory VwGranelPlacasInicioCarguio.fromJson(Map<String, dynamic> json) =>
      VwGranelPlacasInicioCarguio(
        placa: json["placa"],
        idCarguio: json["idCarguio"],
        idTransporte: json["idTransporte"],
        empresaTransporte: json["empresaTransporte"],
        idServiceOrder: json["idServiceOrder"],
        inicioCarguio: DateTime.parse(json["inicioCarguio"]),
        tolva: json["tolva"],
      );

  Map<String, dynamic> toJson() => {
        "placa": placa,
        "idCarguio": idCarguio,
        "idTransporte": idTransporte,
        "empresaTransporte": empresaTransporte,
        "idServiceOrder": idServiceOrder,
        "inicioCarguio": inicioCarguio!.toIso8601String(),
        "tolva": tolva,
      };
}
