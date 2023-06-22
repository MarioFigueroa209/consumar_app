// To parse this JSON data, do
//
//     final vwShipAndTravelByIdServiceOrderLiquida = vwShipAndTravelByIdServiceOrderLiquidaFromJson(jsonString);

import 'dart:convert';

VwShipAndTravelByIdServiceOrderLiquida
    vwShipAndTravelByIdServiceOrderLiquidaFromJson(String str) =>
        VwShipAndTravelByIdServiceOrderLiquida.fromJson(json.decode(str));

String vwShipAndTravelByIdServiceOrderLiquidaToJson(
        VwShipAndTravelByIdServiceOrderLiquida data) =>
    json.encode(data.toJson());

class VwShipAndTravelByIdServiceOrderLiquida {
  int? idServiceOrder;
  int? idNave;
  int? idTravel;
  String? nombreNave;
  String? numeroViaje;

  VwShipAndTravelByIdServiceOrderLiquida({
    this.idServiceOrder,
    this.idNave,
    this.idTravel,
    this.nombreNave,
    this.numeroViaje,
  });

  factory VwShipAndTravelByIdServiceOrderLiquida.fromJson(
          Map<String, dynamic> json) =>
      VwShipAndTravelByIdServiceOrderLiquida(
        idServiceOrder: json["idServiceOrder"],
        idNave: json["idNave"],
        idTravel: json["idTravel"],
        nombreNave: json["nombreNave"],
        numeroViaje: json["numeroViaje"],
      );

  Map<String, dynamic> toJson() => {
        "idServiceOrder": idServiceOrder,
        "idNave": idNave,
        "idTravel": idTravel,
        "nombreNave": nombreNave,
        "numeroViaje": numeroViaje,
      };
}
