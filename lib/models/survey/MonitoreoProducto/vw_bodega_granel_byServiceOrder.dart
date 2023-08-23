// To parse this JSON data, do
//
//     final vwBodegaGranelByServiceOrder = vwBodegaGranelByServiceOrderFromJson(jsonString);

import 'dart:convert';

List<VwBodegaGranelByServiceOrder> vwBodegaGranelByServiceOrderFromJson(
        String str) =>
    List<VwBodegaGranelByServiceOrder>.from(
        json.decode(str).map((x) => VwBodegaGranelByServiceOrder.fromJson(x)));

String vwBodegaGranelByServiceOrderToJson(
        List<VwBodegaGranelByServiceOrder> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class VwBodegaGranelByServiceOrder {
  String? bodega;
  int? peso;
  int? idServiceOrder;

  VwBodegaGranelByServiceOrder({
    this.bodega,
    this.peso,
    this.idServiceOrder,
  });

  factory VwBodegaGranelByServiceOrder.fromJson(Map<String, dynamic> json) =>
      VwBodegaGranelByServiceOrder(
        bodega: json["bodega"],
        peso: json["peso"],
        idServiceOrder: json["idServiceOrder"],
      );

  Map<String, dynamic> toJson() => {
        "bodega": bodega,
        "peso": peso,
        "idServiceOrder": idServiceOrder,
      };
}
