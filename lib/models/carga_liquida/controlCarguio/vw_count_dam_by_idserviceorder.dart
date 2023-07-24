// To parse this JSON data, do
//
//     final vwCountDamByIdserviceorder = vwCountDamByIdserviceorderFromJson(jsonString);

import 'dart:convert';

List<VwCountDamByIdserviceorder> vwCountDamByIdserviceorderFromJson(
        String str) =>
    List<VwCountDamByIdserviceorder>.from(
        json.decode(str).map((x) => VwCountDamByIdserviceorder.fromJson(x)));

String vwCountDamByIdserviceorderToJson(
        List<VwCountDamByIdserviceorder> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class VwCountDamByIdserviceorder {
  int? conteoDam;
  String? codDam;
  int? idServiceOrder;

  VwCountDamByIdserviceorder({
    this.conteoDam,
    this.codDam,
    this.idServiceOrder,
  });

  factory VwCountDamByIdserviceorder.fromJson(Map<String, dynamic> json) =>
      VwCountDamByIdserviceorder(
        conteoDam: json["conteoDam"],
        codDam: json["codDam"],
        idServiceOrder: json["idServiceOrder"],
      );

  Map<String, dynamic> toJson() => {
        "conteoDam": conteoDam,
        "codDam": codDam,
        "idServiceOrder": idServiceOrder,
      };
}
