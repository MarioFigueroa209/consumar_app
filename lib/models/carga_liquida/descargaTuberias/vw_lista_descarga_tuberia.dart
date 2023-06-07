// To parse this JSON data, do
//
//     final vwListaDescargaTuberia = vwListaDescargaTuberiaFromJson(jsonString);

import 'dart:convert';

List<VwListaDescargaTuberia> vwListaDescargaTuberiaFromJson(String str) =>
    List<VwListaDescargaTuberia>.from(
        json.decode(str).map((x) => VwListaDescargaTuberia.fromJson(x)));

String vwListaDescargaTuberiaToJson(List<VwListaDescargaTuberia> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class VwListaDescargaTuberia {
  VwListaDescargaTuberia({
    this.idVista,
    this.idDescargaTuberia,
    this.tanque,
    this.toneldaMetrica,
    this.idServiceOrder,
  });

  int? idVista;
  int? idDescargaTuberia;
  String? tanque;
  double? toneldaMetrica;
  int? idServiceOrder;

  factory VwListaDescargaTuberia.fromJson(Map<String, dynamic> json) =>
      VwListaDescargaTuberia(
        idVista: json["idVista"],
        idDescargaTuberia: json["idDescargaTuberia"],
        tanque: json["tanque"],
        toneldaMetrica: json["toneldaMetrica"].toDouble(),
        idServiceOrder: json["idServiceOrder"],
      );

  Map<String, dynamic> toJson() => {
        "idVista": idVista,
        "idDescargaTuberia": idDescargaTuberia,
        "tanque": tanque,
        "toneldaMetrica": toneldaMetrica,
        "idServiceOrder": idServiceOrder,
      };
}
