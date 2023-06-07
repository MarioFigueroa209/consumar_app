// To parse this JSON data, do
//
//     final vehicleModel = vehicleModelFromJson(jsonString);

import 'dart:convert';

VehicleModel vehicleModelFromJson(String str) =>
    VehicleModel.fromJson(json.decode(str));

String vehicleModelToJson(VehicleModel data) => json.encode(data.toJson());

class VehicleModel {
  VehicleModel({
    this.idVehicle,
    this.chasis,
    this.marca,
    this.modelo,
    this.detalle,
    this.fechaCreacion,
    this.fechaUltimaModificacion,
    this.fechaEliminacion,
    this.usuarioCreacion,
    this.flagDelete,
    this.usuarioEliminacion,
  });

  int? idVehicle;
  String? chasis;
  String? marca;
  String? modelo;
  String? detalle;
  DateTime? fechaCreacion;
  DateTime? fechaUltimaModificacion;
  DateTime? fechaEliminacion;
  String? usuarioCreacion;
  String? flagDelete;
  String? usuarioEliminacion;

  factory VehicleModel.fromJson(Map<String, dynamic> json) => VehicleModel(
        idVehicle: json["idVehicle"],
        chasis: json["chasis"],
        marca: json["marca"],
        modelo: json["modelo"],
        detalle: json["detalle"],
        fechaCreacion: DateTime.parse(json["fechaCreacion"]),
        fechaUltimaModificacion:
            DateTime.parse(json["fechaUltimaModificacion"]),
        fechaEliminacion: DateTime.parse(json["fechaEliminacion"]),
        usuarioCreacion: json["usuarioCreacion"],
        flagDelete: json["flagDelete"],
        usuarioEliminacion: json["usuarioEliminacion"],
      );

  Map<String, dynamic> toJson() => {
        "idVehicle": idVehicle,
        "chasis": chasis,
        "marca": marca,
        "modelo": modelo,
        "detalle": detalle,
        "fechaCreacion": fechaCreacion?.toIso8601String(),
        "fechaUltimaModificacion": fechaUltimaModificacion?.toIso8601String(),
        "fechaEliminacion": fechaEliminacion?.toIso8601String(),
        "usuarioCreacion": usuarioCreacion,
        "flagDelete": flagDelete,
        "usuarioEliminacion": usuarioEliminacion,
      };
}
