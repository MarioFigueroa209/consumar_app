// To parse this JSON data, do
//
//     final vwDistribucionEmbarque = vwDistribucionEmbarqueFromJson(jsonString);

import 'dart:convert';

List<VwDistribucionEmbarque> vwDistribucionEmbarqueFromJson(String str) =>
    List<VwDistribucionEmbarque>.from(
        json.decode(str).map((x) => VwDistribucionEmbarque.fromJson(x)));

String vwDistribucionEmbarqueToJson(List<VwDistribucionEmbarque> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class VwDistribucionEmbarque {
  VwDistribucionEmbarque({
    this.idVista,
    this.idServiceOrder,
    this.idVehicle,
    this.chasis,
    this.marca,
    this.modelo,
    this.puerto,
    this.puertoDestino,
    this.numeroViaje,
    this.nombreBarco,
    this.mercaderia,
    this.operacion,
    this.nivel,
  });

  int? idVista;
  int? idServiceOrder;
  int? idVehicle;
  String? chasis;
  String? marca;
  String? modelo;
  String? puerto;
  String? puertoDestino;
  String? numeroViaje;
  String? nombreBarco;
  String? mercaderia;
  String? operacion;
  String? nivel;

  factory VwDistribucionEmbarque.fromJson(Map<String, dynamic> json) =>
      VwDistribucionEmbarque(
        idVista: json["idVista"],
        idServiceOrder: json["idServiceOrder"],
        idVehicle: json["idVehicle"],
        chasis: json["chasis"],
        marca: json["marca"],
        modelo: json["modelo"],
        puerto: json["puerto"],
        puertoDestino: json["puertoDestino"],
        numeroViaje: json["numeroViaje"],
        nombreBarco: json["nombreBarco"],
        mercaderia: json["mercaderia"],
        operacion: json["operacion"],
        nivel: json["nivel"],
      );

  Map<String, dynamic> toJson() => {
        "idVista": idVista,
        "idServiceOrder": idServiceOrder,
        "idVehicle": idVehicle,
        "chasis": chasis,
        "marca": marca,
        "modelo": modelo,
        "puerto": puerto,
        "puertoDestino": puertoDestino,
        "numeroViaje": numeroViaje,
        "nombreBarco": nombreBarco,
        "mercaderia": mercaderia,
        "operacion": operacion,
        "nivel": nivel,
      };
}
