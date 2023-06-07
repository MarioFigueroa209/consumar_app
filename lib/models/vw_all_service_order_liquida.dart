// To parse this JSON data, do
//
//     final vwAllServiceOrderLiquida = vwAllServiceOrderLiquidaFromJson(jsonString);

import 'dart:convert';

List<VwAllServiceOrderLiquida> vwAllServiceOrderLiquidaFromJson(String str) =>
    List<VwAllServiceOrderLiquida>.from(
        json.decode(str).map((x) => VwAllServiceOrderLiquida.fromJson(x)));

String vwAllServiceOrderLiquidaToJson(List<VwAllServiceOrderLiquida> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class VwAllServiceOrderLiquida {
  VwAllServiceOrderLiquida({
    this.idServiceOrder,
    this.serviceOrder,
  });

  int? idServiceOrder;
  String? serviceOrder;

  factory VwAllServiceOrderLiquida.fromJson(Map<String, dynamic> json) =>
      VwAllServiceOrderLiquida(
        idServiceOrder: json["idServiceOrder"],
        serviceOrder: json["serviceOrder"],
      );

  Map<String, dynamic> toJson() => {
        "idServiceOrder": idServiceOrder,
        "serviceOrder": serviceOrder,
      };
}
