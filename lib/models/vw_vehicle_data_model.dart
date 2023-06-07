// To parse this JSON data, do
//
//     final vwVehicleDataModel = vwVehicleDataModelFromJson(jsonString);

import 'dart:convert';

List<VwVehicleDataModel> vwVehicleDataModelFromJson(String str) =>
    List<VwVehicleDataModel>.from(
        json.decode(str).map((x) => VwVehicleDataModel.fromJson(x)));

String vwVehicleDataModelToJson(List<VwVehicleDataModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class VwVehicleDataModel {
  VwVehicleDataModel({
    this.idServiceOrder,
    this.idVehiculo,
    this.chasis,
    this.marca,
    this.tipoOperacion,
    this.direccionamiento,
  });

  int? idServiceOrder;
  int? idVehiculo;
  String? chasis;
  String? marca;
  String? tipoOperacion;
  String? direccionamiento;

  factory VwVehicleDataModel.fromJson(Map<String, dynamic> json) =>
      VwVehicleDataModel(
        idServiceOrder: json["idServiceOrder"],
        idVehiculo: json["idVehiculo"],
        chasis: json["chasis"],
        marca: json["marca"],
        tipoOperacion: json["tipoOperacion"],
        direccionamiento: json["direccionamiento"],
      );

  Map<String, dynamic> toJson() => {
        "idServiceOrder": idServiceOrder,
        "idVehiculo": idVehiculo,
        "chasis": chasis,
        "marca": marca,
        "tipoOperacion": tipoOperacion,
        "direccionamiento": direccionamiento,
      };
}
