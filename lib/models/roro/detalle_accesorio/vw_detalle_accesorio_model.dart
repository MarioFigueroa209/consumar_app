// To parse this JSON data, do
//
//     final vwDetalleAccesorioModel = vwDetalleAccesorioModelFromJson(jsonString);

import 'dart:convert';

VwDetalleAccesorioModel vwDetalleAccesorioModelFromJson(String str) =>
    VwDetalleAccesorioModel.fromJson(json.decode(str));

String vwDetalleAccesorioModelToJson(VwDetalleAccesorioModel data) =>
    json.encode(data.toJson());

class VwDetalleAccesorioModel {
  VwDetalleAccesorioModel({
    this.idVista,
    this.codDetalleAccesorio,
    this.idDetalleAccesorio,
    this.chasis,
    this.marca,
    this.pdf,
    this.idServiceOrder,
  });

  int? idVista;
  String? codDetalleAccesorio;
  int? idDetalleAccesorio;
  String? chasis;
  String? marca;
  String? pdf;
  int? idServiceOrder;

  factory VwDetalleAccesorioModel.fromJson(Map<String, dynamic> json) =>
      VwDetalleAccesorioModel(
        idVista: json["idVista"],
        codDetalleAccesorio: json["codDetalleAccesorio"],
        idDetalleAccesorio: json["idDetalleAccesorio"],
        chasis: json["chasis"],
        marca: json["marca"],
        pdf: json["pdf"],
        idServiceOrder: json["idServiceOrder"],
      );

  Map<String, dynamic> toJson() => {
        "idVista": idVista,
        "codDetalleAccesorio": codDetalleAccesorio,
        "idDetalleAccesorio": idDetalleAccesorio,
        "chasis": chasis,
        "marca": marca,
        "pdf": pdf,
        "idServiceOrder": idServiceOrder,
      };
}
