// To parse this JSON data, do
//
//     final createRecepcionLiquidaAlmacen = createRecepcionLiquidaAlmacenFromJson(jsonString);

import 'dart:convert';

CreateRecepcionLiquidaAlmacen createRecepcionLiquidaAlmacenFromJson(
        String str) =>
    CreateRecepcionLiquidaAlmacen.fromJson(json.decode(str));

String createRecepcionLiquidaAlmacenToJson(
        CreateRecepcionLiquidaAlmacen data) =>
    json.encode(data.toJson());

class CreateRecepcionLiquidaAlmacen {
  CreateRecepcionLiquidaAlmacen({
    this.jornada,
    this.fecha,
    this.pesoBruto,
    this.taraCamion,
    this.pesoNeto,
    this.estadoValvulaIngreso,
    this.estadoValvulaSalida,
    this.idPrecintado,
    this.idCarguio,
    this.idServiceOrder,
    this.idUsuario,
  });

  int? jornada;
  DateTime? fecha;
  double? pesoBruto;
  double? taraCamion;
  double? pesoNeto;
  String? estadoValvulaIngreso;
  String? estadoValvulaSalida;
  int? idPrecintado;
  int? idCarguio;
  int? idServiceOrder;
  int? idUsuario;

  factory CreateRecepcionLiquidaAlmacen.fromJson(Map<String, dynamic> json) =>
      CreateRecepcionLiquidaAlmacen(
        jornada: json["jornada"],
        fecha: DateTime.parse(json["fecha"]),
        pesoBruto: json["pesoBruto"].toDouble(),
        taraCamion: json["taraCamion"].toDouble(),
        pesoNeto: json["pesoNeto"].toDouble(),
        estadoValvulaIngreso: json["estadoValvulaIngreso"],
        estadoValvulaSalida: json["estadoValvulaSalida"],
        idPrecintado: json["idPrecintado"],
        idCarguio: json["idCarguio"],
        idServiceOrder: json["idServiceOrder"],
        idUsuario: json["idUsuario"],
      );

  Map<String, dynamic> toJson() => {
        "jornada": jornada,
        "fecha": fecha!.toIso8601String(),
        "pesoBruto": pesoBruto,
        "taraCamion": taraCamion,
        "pesoNeto": pesoNeto,
        "estadoValvulaIngreso": estadoValvulaIngreso,
        "estadoValvulaSalida": estadoValvulaSalida,
        "idPrecintado": idPrecintado,
        "idCarguio": idCarguio,
        "idServiceOrder": idServiceOrder,
        "idUsuario": idUsuario,
      };
}
