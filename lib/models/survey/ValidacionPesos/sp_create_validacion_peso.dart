// To parse this JSON data, do
//
//     final spCreateValidacionPeso = spCreateValidacionPesoFromJson(jsonString);

import 'dart:convert';

SpCreateValidacionPeso spCreateValidacionPesoFromJson(String str) =>
    SpCreateValidacionPeso.fromJson(json.decode(str));

String spCreateValidacionPesoToJson(SpCreateValidacionPeso data) =>
    json.encode(data.toJson());

class SpCreateValidacionPeso {
  SpCreateValidacionPeso({
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

  factory SpCreateValidacionPeso.fromJson(Map<String, dynamic> json) =>
      SpCreateValidacionPeso(
        jornada: json["jornada"],
        fecha: DateTime.parse(json["fecha"]),
        nTicket: json["nTicket"],
        pesoBruto: json["pesoBruto"].toDouble(),
        taraCamion: json["taraCamion"].toDouble(),
        pesoNeto: json["pesoNeto"].toDouble(),
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
