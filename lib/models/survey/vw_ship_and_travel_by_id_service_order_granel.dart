// To parse this JSON data, do
//
//     final vwShipAndTravelByIdServiceOrderGranel = vwShipAndTravelByIdServiceOrderGranelFromJson(jsonString);

import 'dart:convert';

VwShipAndTravelByIdServiceOrderGranel
    vwShipAndTravelByIdServiceOrderGranelFromJson(String str) =>
        VwShipAndTravelByIdServiceOrderGranel.fromJson(json.decode(str));

String vwShipAndTravelByIdServiceOrderGranelToJson(
        VwShipAndTravelByIdServiceOrderGranel data) =>
    json.encode(data.toJson());

class VwShipAndTravelByIdServiceOrderGranel {
  VwShipAndTravelByIdServiceOrderGranel({
    this.idServiceOrder,
    this.idNave,
    this.idTravel,
    this.nombreNave,
    this.numeroViaje,
  });

  int? idServiceOrder;
  int? idNave;
  int? idTravel;
  String? nombreNave;
  String? numeroViaje;

  factory VwShipAndTravelByIdServiceOrderGranel.fromJson(
          Map<String, dynamic> json) =>
      VwShipAndTravelByIdServiceOrderGranel(
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
