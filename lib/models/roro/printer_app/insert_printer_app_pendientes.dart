// To parse this JSON data, do
//
//     final insertPrinterAppPendientes = insertPrinterAppPendientesFromJson(jsonString);

import 'dart:convert';

List<InsertPrinterAppPendientes> insertPrinterAppPendientesFromJson(
        String str) =>
    List<InsertPrinterAppPendientes>.from(
        json.decode(str).map((x) => InsertPrinterAppPendientes.fromJson(x)));

String insertPrinterAppPendientesToJson(
        List<InsertPrinterAppPendientes> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class InsertPrinterAppPendientes {
  InsertPrinterAppPendientes({
    this.idPrinterAppPendientes,
    this.idServiceOrder,
    this.idVehiculo,
    this.chasis,
    this.marca,
    this.modelo,
    this.operacion,
    this.detalle,
    this.estado,
  });

  int? idPrinterAppPendientes;
  int? idServiceOrder;
  int? idVehiculo;
  String? chasis;
  String? marca;
  String? modelo;
  String? operacion;
  String? detalle;
  String? estado;

  factory InsertPrinterAppPendientes.fromJson(Map<String, dynamic> json) =>
      InsertPrinterAppPendientes(
        idPrinterAppPendientes: json["idPrPendientes"],
        idServiceOrder: json["idOrdenServicio"],
        idVehiculo: json["idVehicle"],
        chasis: json["chasis"],
        marca: json["marca"],
        modelo: json["modelo"],
        operacion: json["operacion"],
        detalle: json["detalle"],
        estado: json["estado"],
      );

  Map<String, dynamic> toJson() => {
        "idPrPendientes": idPrinterAppPendientes,
        "idOrdenServicio": idServiceOrder,
        "idVehicle": idVehiculo,
        "chasis": chasis,
        "marca": marca,
        "modelo": modelo,
        "operacion": operacion,
        "detalle": detalle,
        "estado": estado,
      };
}
