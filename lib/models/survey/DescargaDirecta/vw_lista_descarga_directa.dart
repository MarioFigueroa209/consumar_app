// To parse this JSON data, do
//
//     final vwListaDescargaDirecta = vwListaDescargaDirectaFromJson(jsonString);

import 'dart:convert';

List<VwListaDescargaDirecta> vwListaDescargaDirectaFromJson(String str) =>
    List<VwListaDescargaDirecta>.from(
        json.decode(str).map((x) => VwListaDescargaDirecta.fromJson(x)));

String vwListaDescargaDirectaToJson(List<VwListaDescargaDirecta> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class VwListaDescargaDirecta {
  VwListaDescargaDirecta({
    this.idVista,
    this.idDescargaDirecta,
    this.bodega,
    this.toneldaMetrica,
    this.silos,
    this.idServiceOrder,
  });

  int? idVista;
  int? idDescargaDirecta;
  String? bodega;
  double? toneldaMetrica;
  String? silos;
  int? idServiceOrder;

  factory VwListaDescargaDirecta.fromJson(Map<String, dynamic> json) =>
      VwListaDescargaDirecta(
        idVista: json["idVista"],
        idDescargaDirecta: json["idDescargaDirecta"],
        bodega: json["bodega"],
        toneldaMetrica: double.parse(json["toneldaMetrica"].toString()),
        silos: json["silos"],
        idServiceOrder: json["idServiceOrder"],
      );

  Map<String, dynamic> toJson() => {
        "idVista": idVista,
        "idDescargaDirecta": idDescargaDirecta,
        "bodega": bodega,
        "toneldaMetrica": toneldaMetrica,
        "silos": silos,
        "idServiceOrder": idServiceOrder,
      };
}
