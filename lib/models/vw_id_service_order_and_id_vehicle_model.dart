// To parse this JSON data, do
//
//     final vwIdServiceOrderAndIdVehicleModel = vwIdServiceOrderAndIdVehicleModelFromJson(jsonString);

import 'dart:convert';

VwIdServiceOrderAndIdVehicleModel vwIdServiceOrderAndIdVehicleModelFromJson(
        String str) =>
    VwIdServiceOrderAndIdVehicleModel.fromJson(json.decode(str));

String vwIdServiceOrderAndIdVehicleModelToJson(
        VwIdServiceOrderAndIdVehicleModel data) =>
    json.encode(data.toJson());

class VwIdServiceOrderAndIdVehicleModel {
  VwIdServiceOrderAndIdVehicleModel({
    this.idServiceOrder,
    this.cantidadVehiculos,
  });

  int? idServiceOrder;
  int? cantidadVehiculos;

  factory VwIdServiceOrderAndIdVehicleModel.fromJson(
          Map<String, dynamic> json) =>
      VwIdServiceOrderAndIdVehicleModel(
        idServiceOrder: json["idServiceOrder"],
        cantidadVehiculos: json["cantidadVehiculos"],
      );

  Map<String, dynamic> toJson() => {
        "idServiceOrder": idServiceOrder,
        "cantidadVehiculos": cantidadVehiculos,
      };
}
