// To parse this JSON data, do
//
//     final vwTanquePesosLiquidaByIdServOrder = vwTanquePesosLiquidaByIdServOrderFromJson(jsonString);

import 'dart:convert';

List<VwTanquePesosLiquidaByIdServOrder>
    vwTanquePesosLiquidaByIdServOrderFromJson(String str) =>
        List<VwTanquePesosLiquidaByIdServOrder>.from(json
            .decode(str)
            .map((x) => VwTanquePesosLiquidaByIdServOrder.fromJson(x)));

String vwTanquePesosLiquidaByIdServOrderToJson(
        List<VwTanquePesosLiquidaByIdServOrder> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class VwTanquePesosLiquidaByIdServOrder {
  String? tanque;
  int? peso;
  int? idServiceOrder;

  VwTanquePesosLiquidaByIdServOrder({
    this.tanque,
    this.peso,
    this.idServiceOrder,
  });

  factory VwTanquePesosLiquidaByIdServOrder.fromJson(
          Map<String, dynamic> json) =>
      VwTanquePesosLiquidaByIdServOrder(
        tanque: json["tanque"],
        peso: json["peso"],
        idServiceOrder: json["idServiceOrder"],
      );

  Map<String, dynamic> toJson() => {
        "tanque": tanque,
        "peso": peso,
        "idServiceOrder": idServiceOrder,
      };
}
