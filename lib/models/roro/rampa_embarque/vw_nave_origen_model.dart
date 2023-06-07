import 'dart:convert';

VwNaveOrigenModel vwNaveOrigenModelFromJson(String str) =>
    VwNaveOrigenModel.fromJson(json.decode(str));

String vwNaveOrigenModelToJson(VwNaveOrigenModel data) =>
    json.encode(data.toJson());

class VwNaveOrigenModel {
  VwNaveOrigenModel({
    this.idVehicle,
    this.chasis,
    this.idShip,
    this.naveOrigen,
    this.operacion,
  });

  int? idVehicle;
  String? chasis;
  int? idShip;
  String? naveOrigen;
  String? operacion;

  factory VwNaveOrigenModel.fromJson(Map<String, dynamic> json) =>
      VwNaveOrigenModel(
        idVehicle: json["idVehicle"],
        chasis: json["chasis"],
        idShip: json["idShip"],
        naveOrigen: json["naveOrigen"],
        operacion: json["operacion"],
      );

  Map<String, dynamic> toJson() => {
        "idVehicle": idVehicle,
        "chasis": chasis,
        "idShip": idShip,
        "naveOrigen": naveOrigen,
        "operacion": operacion,
      };
}
