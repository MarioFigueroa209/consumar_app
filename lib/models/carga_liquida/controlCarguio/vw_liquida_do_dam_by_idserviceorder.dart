// To parse this JSON data, do
//
//     final vwLiquidaDoDamByIdserviceorder = vwLiquidaDoDamByIdserviceorderFromJson(jsonString);

import 'dart:convert';

List<VwLiquidaDoDamByIdserviceorder> vwLiquidaDoDamByIdserviceorderFromJson(
        String str) =>
    List<VwLiquidaDoDamByIdserviceorder>.from(json
        .decode(str)
        .map((x) => VwLiquidaDoDamByIdserviceorder.fromJson(x)));

String vwLiquidaDoDamByIdserviceorderToJson(
        List<VwLiquidaDoDamByIdserviceorder> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class VwLiquidaDoDamByIdserviceorder {
  int? idDam;
  int? idServiceOrder;
  String? codDo;
  String? codDam;
  int? pesoDam;
  int? totalViajes;

  VwLiquidaDoDamByIdserviceorder({
    this.idDam,
    this.idServiceOrder,
    this.codDo,
    this.codDam,
    this.pesoDam,
    this.totalViajes,
  });

  factory VwLiquidaDoDamByIdserviceorder.fromJson(Map<String, dynamic> json) =>
      VwLiquidaDoDamByIdserviceorder(
        idDam: json["idDam"],
        idServiceOrder: json["idServiceOrder"],
        codDo: json["codDo"],
        codDam: json["codDam"],
        pesoDam: json["pesoDam"],
        totalViajes: json["totalViajes"],
      );

  Map<String, dynamic> toJson() => {
        "idDam": idDam,
        "idServiceOrder": idServiceOrder,
        "codDo": codDo,
        "codDam": codDam,
        "pesoDam": pesoDam,
        "totalViajes": totalViajes,
      };
}
