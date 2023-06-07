// To parse this JSON data, do
//
//     final vwGranelListaBodegas = vwGranelListaBodegasFromJson(jsonString);

import 'dart:convert';

List<VwGranelListaBodegas> vwGranelListaBodegasFromJson(String str) =>
    List<VwGranelListaBodegas>.from(
        json.decode(str).map((x) => VwGranelListaBodegas.fromJson(x)));

String vwGranelListaBodegasToJson(List<VwGranelListaBodegas> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class VwGranelListaBodegas {
  VwGranelListaBodegas({
    this.bodega,
  });

  String? bodega;

  factory VwGranelListaBodegas.fromJson(Map<String, dynamic> json) =>
      VwGranelListaBodegas(
        bodega: json["bodega"],
      );

  Map<String, dynamic> toJson() => {
        "bodega": bodega,
      };
}
