// To parse this JSON data, do
//
//     final vwCountDataRampaEmbarqueByServiceOrder = vwCountDataRampaEmbarqueByServiceOrderFromJson(jsonString);

import 'dart:convert';

VwCountDataRampaEmbarqueByServiceOrder
    vwCountDataRampaEmbarqueByServiceOrderFromJson(String str) =>
        VwCountDataRampaEmbarqueByServiceOrder.fromJson(json.decode(str));

String vwCountDataRampaEmbarqueByServiceOrderToJson(
        VwCountDataRampaEmbarqueByServiceOrder data) =>
    json.encode(data.toJson());

class VwCountDataRampaEmbarqueByServiceOrder {
  VwCountDataRampaEmbarqueByServiceOrder({
    this.conteoVehiculoRampaEmbarque,
    this.idServiceOrder,
  });

  int? conteoVehiculoRampaEmbarque;
  int? idServiceOrder;

  factory VwCountDataRampaEmbarqueByServiceOrder.fromJson(
          Map<String, dynamic> json) =>
      VwCountDataRampaEmbarqueByServiceOrder(
        conteoVehiculoRampaEmbarque: json["conteoVehiculoRampaEmbarque"],
        idServiceOrder: json["idServiceOrder"],
      );

  Map<String, dynamic> toJson() => {
        "conteoVehiculoRampaEmbarque": conteoVehiculoRampaEmbarque,
        "idServiceOrder": idServiceOrder,
      };
}
