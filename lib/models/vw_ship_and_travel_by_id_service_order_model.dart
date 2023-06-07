// To parse this JSON data, do
//
//     final vwShipAndTravelByIdServiceOrderModel = vwShipAndTravelByIdServiceOrderModelFromJson(jsonString);

import 'dart:convert';

VwShipAndTravelByIdServiceOrderModel
    vwShipAndTravelByIdServiceOrderModelFromJson(String str) =>
        VwShipAndTravelByIdServiceOrderModel.fromJson(json.decode(str));

String vwShipAndTravelByIdServiceOrderModelToJson(
        VwShipAndTravelByIdServiceOrderModel data) =>
    json.encode(data.toJson());

class VwShipAndTravelByIdServiceOrderModel {
  VwShipAndTravelByIdServiceOrderModel({
    this.idServiceOrder,
    this.estado,
    this.idNave,
    this.idTravel,
    this.nombreNave,
    this.numeroViaje,
  });

  int? idServiceOrder;
  String? estado;
  int? idNave;
  int? idTravel;
  String? nombreNave;
  String? numeroViaje;

  factory VwShipAndTravelByIdServiceOrderModel.fromJson(
          Map<String, dynamic> json) =>
      VwShipAndTravelByIdServiceOrderModel(
        idServiceOrder: json["idServiceOrder"],
        estado: json["estado"],
        idNave: json["idNave"],
        idTravel: json["idTravel"],
        nombreNave: json["nombreNave"],
        numeroViaje: json["numeroViaje"],
      );

  Map<String, dynamic> toJson() => {
        "idServiceOrder": idServiceOrder,
        "estado": estado,
        "idNave": idNave,
        "idTravel": idTravel,
        "nombreNave": nombreNave,
        "numeroViaje": numeroViaje,
      };
}
