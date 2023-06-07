// To parse this JSON data, do
//
//     final serviceOrderModel = serviceOrderModelFromJson(jsonString);

import 'dart:convert';

ServiceOrderModel serviceOrderModelFromJson(String str) =>
    ServiceOrderModel.fromJson(json.decode(str));

String serviceOrderModelToJson(ServiceOrderModel data) =>
    json.encode(data.toJson());

class ServiceOrderModel {
  ServiceOrderModel({
    this.idServiceOrder,
    this.serviceOrder,
    this.fecha,
    this.operacion,
    this.fechaCreacion,
    this.fechaUltimaModificacion,
    this.fechaEliminacion,
    this.usuarioCreacion,
    this.flagDelete,
    this.usuarioEliminacion,
  });

  int? idServiceOrder;
  String? serviceOrder;
  DateTime? fecha;
  String? operacion;
  DateTime? fechaCreacion;
  DateTime? fechaUltimaModificacion;
  DateTime? fechaEliminacion;
  String? usuarioCreacion;
  String? flagDelete;
  String? usuarioEliminacion;

  factory ServiceOrderModel.fromJson(Map<String, dynamic> json) =>
      ServiceOrderModel(
        idServiceOrder: json["idServiceOrder"],
        serviceOrder: json["serviceOrder"],
        fecha: DateTime.parse(json["fecha"]),
        operacion: json["operacion"],
        fechaCreacion: DateTime.parse(json["fechaCreacion"]),
        fechaUltimaModificacion:
            DateTime.parse(json["fechaUltimaModificacion"]),
        fechaEliminacion: DateTime.parse(json["fechaEliminacion"]),
        usuarioCreacion: json["usuarioCreacion"],
        flagDelete: json["flagDelete"],
        usuarioEliminacion: json["usuarioEliminacion"],
      );

  Map<String, dynamic> toJson() => {
        "idServiceOrder": idServiceOrder,
        "serviceOrder": serviceOrder,
        "fecha": fecha.toString(),
        "operacion": operacion,
        "fechaCreacion": fechaCreacion.toString(),
        "fechaUltimaModificacion": fechaUltimaModificacion.toString(),
        "fechaEliminacion": fechaEliminacion.toString(),
        "usuarioCreacion": usuarioCreacion,
        "flagDelete": flagDelete,
        "usuarioEliminacion": usuarioEliminacion,
      };
}
