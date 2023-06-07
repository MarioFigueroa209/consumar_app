// To parse this JSON data, do
//
//     final vwListVehicleDataByIdServiceOrderEmbarque = vwListVehicleDataByIdServiceOrderEmbarqueFromJson(jsonString);

import 'dart:convert';

List<VwListVehicleDataByIdServiceOrderEmbarque>
    vwListVehicleDataByIdServiceOrderEmbarqueFromJson(String str) =>
        List<VwListVehicleDataByIdServiceOrderEmbarque>.from(json
            .decode(str)
            .map((x) => VwListVehicleDataByIdServiceOrderEmbarque.fromJson(x)));

String vwListVehicleDataByIdServiceOrderEmbarqueToJson(
        List<VwListVehicleDataByIdServiceOrderEmbarque> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class VwListVehicleDataByIdServiceOrderEmbarque {
  VwListVehicleDataByIdServiceOrderEmbarque({
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

  factory VwListVehicleDataByIdServiceOrderEmbarque.fromJson(
          Map<String, dynamic> json) =>
      VwListVehicleDataByIdServiceOrderEmbarque(
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
