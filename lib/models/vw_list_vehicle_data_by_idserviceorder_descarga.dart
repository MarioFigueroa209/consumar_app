// To parse this JSON data, do
//
//     final vwListVehicleDataByIdServiceOrderDescarga = vwListVehicleDataByIdServiceOrderDescargaFromJson(jsonString);

import 'dart:convert';

List<VwListVehicleDataByIdServiceOrderDescarga>
    vwListVehicleDataByIdServiceOrderDescargaFromJson(String str) =>
        List<VwListVehicleDataByIdServiceOrderDescarga>.from(json
            .decode(str)
            .map((x) => VwListVehicleDataByIdServiceOrderDescarga.fromJson(x)));

String vwListVehicleDataByIdServiceOrderDescargaToJson(
        List<VwListVehicleDataByIdServiceOrderDescarga> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class VwListVehicleDataByIdServiceOrderDescarga {
  VwListVehicleDataByIdServiceOrderDescarga({
    this.idOperacion,
    this.idServiceOrder,
    this.idVehiculo,
    this.chasis,
    this.marca,
    this.modelo,
    this.operacion,
    this.detalle,
    this.estado,
  });

  int? idOperacion;
  int? idServiceOrder;
  int? idVehiculo;
  String? chasis;
  String? marca;
  String? modelo;
  String? operacion;
  String? detalle;
  String? estado;

  factory VwListVehicleDataByIdServiceOrderDescarga.fromJson(
          Map<String, dynamic> json) =>
      VwListVehicleDataByIdServiceOrderDescarga(
        idOperacion: json["idOperacion"],
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
        "idOperacion": idOperacion,
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
