// To parse this JSON data, do
//
//     final spCreateDescargaDirecta = spCreateDescargaDirectaFromJson(jsonString);

import 'dart:convert';

SpCreateDescargaDirecta spCreateDescargaDirectaFromJson(String str) =>
    SpCreateDescargaDirecta.fromJson(json.decode(str));

String spCreateDescargaDirectaToJson(SpCreateDescargaDirecta data) =>
    json.encode(data.toJson());

class SpCreateDescargaDirecta {
  SpCreateDescargaDirecta({
    this.jornada,
    this.fecha,
    this.bodega,
    this.toneladasMetricas,
    this.silo,
    this.idServiceOrder,
    this.idUsuario,
  });

  int? jornada;
  DateTime? fecha;
  String? bodega;
  double? toneladasMetricas;
  String? silo;
  int? idServiceOrder;
  int? idUsuario;

  factory SpCreateDescargaDirecta.fromJson(Map<String, dynamic> json) =>
      SpCreateDescargaDirecta(
        jornada: json["jornada"],
        fecha: DateTime.parse(json["fecha"]),
        bodega: json["bodega"],
        toneladasMetricas: json["toneladasMetricas"].toDouble(),
        silo: json["silo"],
        idServiceOrder: json["idServiceOrder"],
        idUsuario: json["idUsuario"],
      );

  Map<String, dynamic> toJson() => {
        "jornada": jornada,
        "fecha": fecha!.toIso8601String(),
        "bodega": bodega,
        "toneladasMetricas": toneladasMetricas,
        "silo": silo,
        "idServiceOrder": idServiceOrder,
        "idUsuario": idUsuario,
      };
}
