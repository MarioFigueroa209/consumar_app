// To parse this JSON data, do
//
//     final spCreateTransporte = spCreateTransporteFromJson(jsonString);

import 'dart:convert';

SpCreateTransporte spCreateTransporteFromJson(String str) =>
    SpCreateTransporte.fromJson(json.decode(str));

String spCreateTransporteToJson(SpCreateTransporte data) =>
    json.encode(data.toJson());

class SpCreateTransporte {
  SpCreateTransporte({
    this.empresaTransporte,
    this.ruc,
    this.codFotocheck,
  });

  String? empresaTransporte;
  String? ruc;
  String? codFotocheck;

  factory SpCreateTransporte.fromJson(Map<String, dynamic> json) =>
      SpCreateTransporte(
        empresaTransporte: json["empresaTransporte"],
        ruc: json["ruc"],
        codFotocheck: json["codFotocheck"],
      );

  Map<String, dynamic> toJson() => {
        "empresaTransporte": empresaTransporte,
        "ruc": ruc,
        "codFotocheck": codFotocheck,
      };
}
