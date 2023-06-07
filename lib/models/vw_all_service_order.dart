// To parse this JSON data, do
//
//     final vwAllServiceOrder = vwAllServiceOrderFromJson(jsonString);

import 'dart:convert';

List<VwAllServiceOrder> vwAllServiceOrderFromJson(String str) =>
    List<VwAllServiceOrder>.from(
        json.decode(str).map((x) => VwAllServiceOrder.fromJson(x)));

String vwAllServiceOrderToJson(List<VwAllServiceOrder> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class VwAllServiceOrder {
  VwAllServiceOrder({
    this.idServiceOrder,
    this.serviceOrder,
  });

  int? idServiceOrder;
  String? serviceOrder;

  factory VwAllServiceOrder.fromJson(Map<String, dynamic> json) =>
      VwAllServiceOrder(
        idServiceOrder: json["idServiceOrder"],
        serviceOrder: json["serviceOrder"],
      );

  Map<String, dynamic> toJson() => {
        "idServiceOrder": idServiceOrder,
        "serviceOrder": serviceOrder,
      };
}
