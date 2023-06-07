// To parse this JSON data, do
//
//     final spCreateLiquidaValidacionPeso = spCreateLiquidaValidacionPesoFromJson(jsonString);

import 'dart:convert';

SpCreateLiquidaValidacionPeso spCreateLiquidaValidacionPesoFromJson(
        String str) =>
    SpCreateLiquidaValidacionPeso.fromJson(json.decode(str));

String spCreateLiquidaValidacionPesoToJson(
        SpCreateLiquidaValidacionPeso data) =>
    json.encode(data.toJson());

class SpCreateLiquidaValidacionPeso {
  SpCreateLiquidaValidacionPeso({
    this.jornada,
    this.fecha,
    this.nTicket,
    this.pesoBruto,
    this.taraCamion,
    this.pesoNeto,
    this.factura,
    this.destino,
    this.idPrecintado,
    this.idCarguio,
    this.idServiceOrder,
    this.idUsuario,
  });

  int? jornada;
  DateTime? fecha;
  String? nTicket;
  double? pesoBruto;
  double? taraCamion;
  double? pesoNeto;
  String? factura;
  String? destino;
  int? idPrecintado;
  int? idCarguio;
  int? idServiceOrder;
  int? idUsuario;

  factory SpCreateLiquidaValidacionPeso.fromJson(Map<String, dynamic> json) =>
      SpCreateLiquidaValidacionPeso(
        jornada: json["jornada"],
        fecha: DateTime.parse(json["fecha"]),
        nTicket: json["nTicket"],
        pesoBruto: json["pesoBruto"],
        taraCamion: json["taraCamion"],
        pesoNeto: json["pesoNeto"],
        factura: json["factura"],
        destino: json["destino"],
        idPrecintado: json["idPrecintado"],
        idCarguio: json["idCarguio"],
        idServiceOrder: json["idServiceOrder"],
        idUsuario: json["idUsuario"],
      );

  Map<String, dynamic> toJson() => {
        "jornada": jornada,
        "fecha": fecha!.toIso8601String(),
        "nTicket": nTicket,
        "pesoBruto": pesoBruto,
        "taraCamion": taraCamion,
        "pesoNeto": pesoNeto,
        "factura": factura,
        "destino": destino,
        "idPrecintado": idPrecintado,
        "idCarguio": idCarguio,
        "idServiceOrder": idServiceOrder,
        "idUsuario": idUsuario,
      };
}
