// To parse this JSON data, do
//
//     final vwPrimerMovimientoDataById = vwPrimerMovimientoDataByIdFromJson(jsonString);

import 'dart:convert';

VwPrimerMovimientoDataById vwPrimerMovimientoDataByIdFromJson(String str) =>
    VwPrimerMovimientoDataById.fromJson(json.decode(str));

String vwPrimerMovimientoDataByIdToJson(VwPrimerMovimientoDataById data) =>
    json.encode(data.toJson());

class VwPrimerMovimientoDataById {
  VwPrimerMovimientoDataById({
    this.idPrimerMovimiento,
    this.marca,
    this.modelo,
    this.cantidadAbordo,
    this.cantidadMuelle,
    this.saldoAbordo,
    this.saldoMuelle,
  });

  int? idPrimerMovimiento;
  String? marca;
  String? modelo;
  int? cantidadAbordo;
  int? cantidadMuelle;
  int? saldoAbordo;
  int? saldoMuelle;

  factory VwPrimerMovimientoDataById.fromJson(Map<String, dynamic> json) =>
      VwPrimerMovimientoDataById(
        idPrimerMovimiento: json["idPrimerMovimiento"],
        marca: json["marca"],
        modelo: json["modelo"],
        cantidadAbordo: json["cantidadAbordo"],
        cantidadMuelle: json["cantidadMuelle"],
        saldoAbordo: json["saldoAbordo"],
        saldoMuelle: json["saldoMuelle"],
      );

  Map<String, dynamic> toJson() => {
        "idPrimerMovimiento": idPrimerMovimiento,
        "marca": marca,
        "modelo": modelo,
        "cantidadAbordo": cantidadAbordo,
        "cantidadMuelle": cantidadMuelle,
        "saldoAbordo": saldoAbordo,
        "saldoMuelle": saldoMuelle,
      };
}
