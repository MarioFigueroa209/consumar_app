// To parse this JSON data, do
//
//     final vwPrinterAppListByIdServiceOrder = vwPrinterAppListByIdServiceOrderFromJson(jsonString);

import 'dart:convert';

List<VwPrinterAppListByIdServiceOrder> vwPrinterAppListByIdServiceOrderFromJson(
        String str) =>
    List<VwPrinterAppListByIdServiceOrder>.from(json
        .decode(str)
        .map((x) => VwPrinterAppListByIdServiceOrder.fromJson(x)));

String vwPrinterAppListByIdServiceOrderToJson(
        List<VwPrinterAppListByIdServiceOrder> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class VwPrinterAppListByIdServiceOrder {
  VwPrinterAppListByIdServiceOrder({
    this.idVista,
    this.idRoroOperacion,
    this.idServiceOrder,
    this.idVehiculo,
    this.chasis,
    this.marca,
    this.modelo,
    this.operacion,
    this.detalle,
    this.estado,
  });

  int? idVista;
  int? idRoroOperacion;
  int? idServiceOrder;
  int? idVehiculo;
  String? chasis;
  String? marca;
  String? modelo;
  String? operacion;
  String? detalle;
  String? estado;

  factory VwPrinterAppListByIdServiceOrder.fromJson(
          Map<String, dynamic> json) =>
      VwPrinterAppListByIdServiceOrder(
        idVista: json["idVista"],
        idRoroOperacion: json["idRoroOperacion"],
        idServiceOrder: json["idServiceOrder"],
        idVehiculo: json["idVehiculo"],
        chasis: json["chasis"],
        marca: json["marca"],
        modelo: json["modelo"],
        operacion: json["operacion"],
        detalle: json["detalle"],
        estado: json["estado"],
      );

  Map<String, dynamic> toJson() => {
        "idVista": idVista,
        "idRoroOperacion": idRoroOperacion,
        "idServiceOrder": idServiceOrder,
        "idVehiculo": idVehiculo,
        "chasis": chasis,
        "marca": marca,
        "modelo": modelo,
        "operacion": operacion,
        "detalle": detalle,
        "estado": estado,
      };
}
