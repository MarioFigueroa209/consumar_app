// To parse this JSON data, do
//
//     final vwGetLiquidaListTanque = vwGetLiquidaListTanqueFromJson(jsonString);

import 'dart:convert';

List<VwGetLiquidaListTanque> vwGetLiquidaListTanqueFromJson(String str) =>
    List<VwGetLiquidaListTanque>.from(
        json.decode(str).map((x) => VwGetLiquidaListTanque.fromJson(x)));

String vwGetLiquidaListTanqueToJson(List<VwGetLiquidaListTanque> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class VwGetLiquidaListTanque {
  String? tanque;

  VwGetLiquidaListTanque({
    this.tanque,
  });

  factory VwGetLiquidaListTanque.fromJson(Map<String, dynamic> json) =>
      VwGetLiquidaListTanque(
        tanque: json["tanque"],
      );

  Map<String, dynamic> toJson() => {
        "tanque": tanque,
      };
}
