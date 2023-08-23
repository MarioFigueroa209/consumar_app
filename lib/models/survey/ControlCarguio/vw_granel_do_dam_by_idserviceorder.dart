// To parse this JSON data, do
//
//     final vwGranelDoDamByIdserviceorder = vwGranelDoDamByIdserviceorderFromJson(jsonString);

import 'dart:convert';

List<VwGranelDoDamByIdserviceorder> vwGranelDoDamByIdserviceorderFromJson(
        String str) =>
    List<VwGranelDoDamByIdserviceorder>.from(
        json.decode(str).map((x) => VwGranelDoDamByIdserviceorder.fromJson(x)));

String vwGranelDoDamByIdserviceorderToJson(
        List<VwGranelDoDamByIdserviceorder> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class VwGranelDoDamByIdserviceorder {
  int? idDam;
  int? idServiceOrder;
  String? codDo;
  String? codDam;
  int? pesoDam;
  int? totalViajes;

  VwGranelDoDamByIdserviceorder({
    this.idDam,
    this.idServiceOrder,
    this.codDo,
    this.codDam,
    this.pesoDam,
    this.totalViajes,
  });

  factory VwGranelDoDamByIdserviceorder.fromJson(Map<String, dynamic> json) =>
      VwGranelDoDamByIdserviceorder(
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
