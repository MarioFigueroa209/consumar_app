// To parse this JSON data, do
//
//     final vwCountGranelDamByIdServiceOrder = vwCountGranelDamByIdServiceOrderFromJson(jsonString);

import 'dart:convert';

List<VwCountGranelDamByIdServiceOrder> vwCountGranelDamByIdServiceOrderFromJson(
        String str) =>
    List<VwCountGranelDamByIdServiceOrder>.from(json
        .decode(str)
        .map((x) => VwCountGranelDamByIdServiceOrder.fromJson(x)));

String vwCountGranelDamByIdServiceOrderToJson(
        List<VwCountGranelDamByIdServiceOrder> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class VwCountGranelDamByIdServiceOrder {
  int? conteoDam;
  String? codDam;
  int? idServiceOrder;

  VwCountGranelDamByIdServiceOrder({
    this.conteoDam,
    this.codDam,
    this.idServiceOrder,
  });

  factory VwCountGranelDamByIdServiceOrder.fromJson(
          Map<String, dynamic> json) =>
      VwCountGranelDamByIdServiceOrder(
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
