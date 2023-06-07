// To parse this JSON data, do
//
//     final spUpdateReestibasIdApmSegunMov = spUpdateReestibasIdApmSegunMovFromJson(jsonString);

import 'dart:convert';

List<SpUpdateReestibasIdApmSegunMov> spUpdateReestibasIdApmSegunMovFromJson(
        String str) =>
    List<SpUpdateReestibasIdApmSegunMov>.from(json
        .decode(str)
        .map((x) => SpUpdateReestibasIdApmSegunMov.fromJson(x)));

String spUpdateReestibasIdApmSegunMovToJson(
        List<SpUpdateReestibasIdApmSegunMov> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SpUpdateReestibasIdApmSegunMov {
  SpUpdateReestibasIdApmSegunMov({
    this.idApmtc,
    this.idReestibasSegundoMov,
    this.idServiceOrder,
  });

  int? idApmtc;
  int? idReestibasSegundoMov;
  int? idServiceOrder;

  factory SpUpdateReestibasIdApmSegunMov.fromJson(Map<String, dynamic> json) =>
      SpUpdateReestibasIdApmSegunMov(
        idApmtc: json["idApmtc"],
        idReestibasSegundoMov: json["idReestibasSegundoMov"],
        idServiceOrder: json["idServiceOrder"],
      );

  Map<String, dynamic> toJson() => {
        "idApmtc": idApmtc,
        "idReestibasSegundoMov": idReestibasSegundoMov,
        "idServiceOrder": idServiceOrder,
      };
}
