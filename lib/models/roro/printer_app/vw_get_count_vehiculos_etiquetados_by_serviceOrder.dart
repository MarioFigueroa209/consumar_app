// To parse this JSON data, do
//
//     final vwGetCountVehiculosEtiquetadosByServiceOrder = vwGetCountVehiculosEtiquetadosByServiceOrderFromJson(jsonString);

import 'dart:convert';

VwGetCountVehiculosEtiquetadosByServiceOrder
    vwGetCountVehiculosEtiquetadosByServiceOrderFromJson(String str) =>
        VwGetCountVehiculosEtiquetadosByServiceOrder.fromJson(json.decode(str));

String vwGetCountVehiculosEtiquetadosByServiceOrderToJson(
        VwGetCountVehiculosEtiquetadosByServiceOrder data) =>
    json.encode(data.toJson());

class VwGetCountVehiculosEtiquetadosByServiceOrder {
  VwGetCountVehiculosEtiquetadosByServiceOrder({
    this.idServiceOrder,
    this.numeroVehiculosEtiquetado,
  });

  int? idServiceOrder;
  int? numeroVehiculosEtiquetado;

  factory VwGetCountVehiculosEtiquetadosByServiceOrder.fromJson(
          Map<String, dynamic> json) =>
      VwGetCountVehiculosEtiquetadosByServiceOrder(
        idServiceOrder: json["idServiceOrder"],
        numeroVehiculosEtiquetado: json["numeroVehiculosEtiquetado"],
      );

  Map<String, dynamic> toJson() => {
        "idServiceOrder": idServiceOrder,
        "numeroVehiculosEtiquetado": numeroVehiculosEtiquetado,
      };
}
