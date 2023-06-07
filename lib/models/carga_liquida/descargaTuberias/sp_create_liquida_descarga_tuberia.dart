// To parse this JSON data, do
//
//     final spCreateLiquidaDescargaTuberia = spCreateLiquidaDescargaTuberiaFromJson(jsonString);

import 'dart:convert';

List<SpCreateLiquidaDescargaTuberia> spCreateLiquidaDescargaTuberiaFromJson(
        String str) =>
    List<SpCreateLiquidaDescargaTuberia>.from(json
        .decode(str)
        .map((x) => SpCreateLiquidaDescargaTuberia.fromJson(x)));

String spCreateLiquidaDescargaTuberiaToJson(
        List<SpCreateLiquidaDescargaTuberia> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SpCreateLiquidaDescargaTuberia {
  SpCreateLiquidaDescargaTuberia({
    this.jornada,
    this.fecha,
    this.tanque,
    this.toneladasMetricas,
    this.idServiceOrder,
    this.idUsuario,
  });

  int? jornada;
  DateTime? fecha;
  String? tanque;
  double? toneladasMetricas;
  int? idServiceOrder;
  int? idUsuario;

  factory SpCreateLiquidaDescargaTuberia.fromJson(Map<String, dynamic> json) =>
      SpCreateLiquidaDescargaTuberia(
        jornada: json["jornada"],
        fecha: DateTime.parse(json["fecha"]),
        tanque: json["tanque"],
        toneladasMetricas: json["toneladasMetricas"],
        idServiceOrder: json["idServiceOrder"],
        idUsuario: json["idUsuario"],
      );

  Map<String, dynamic> toJson() => {
        "jornada": jornada,
        "fecha": fecha!.toIso8601String(),
        "tanque": tanque,
        "toneladasMetricas": toneladasMetricas,
        "idServiceOrder": idServiceOrder,
        "idUsuario": idUsuario,
      };
}
