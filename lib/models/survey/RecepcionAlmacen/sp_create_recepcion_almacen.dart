// To parse this JSON data, do
//
//     final spCreateRecepcionAlmacen = spCreateRecepcionAlmacenFromJson(jsonString);

import 'dart:convert';

SpCreateRecepcionAlmacen spCreateRecepcionAlmacenFromJson(String str) =>
    SpCreateRecepcionAlmacen.fromJson(json.decode(str));

String spCreateRecepcionAlmacenToJson(SpCreateRecepcionAlmacen data) =>
    json.encode(data.toJson());

class SpCreateRecepcionAlmacen {
  SpCreateRecepcionAlmacen({
    this.jornada,
    this.fecha,
    this.pesoBruto,
    this.taraCamion,
    this.pesoNeto,
    this.estadoCompuertaTolva,
    this.estadoCajaHidraulica,
    this.estadoToldo,
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
  String? estadoCompuertaTolva;
  String? estadoCajaHidraulica;
  String? estadoToldo;
  int? idPrecintado;
  int? idCarguio;
  int? idServiceOrder;
  int? idUsuario;

  factory SpCreateRecepcionAlmacen.fromJson(Map<String, dynamic> json) =>
      SpCreateRecepcionAlmacen(
        jornada: json["jornada"],
        fecha: DateTime.parse(json["fecha"]),
        pesoBruto: json["pesoBruto"].toDouble(),
        taraCamion: json["taraCamion"].toDouble(),
        pesoNeto: json["pesoNeto"].toDouble(),
        estadoCompuertaTolva: json["estadoCompuertaTolva"],
        estadoCajaHidraulica: json["estadoCajaHidraulica"],
        estadoToldo: json["estadoToldo"],
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
        "estadoCompuertaTolva": estadoCompuertaTolva,
        "estadoCajaHidraulica": estadoCajaHidraulica,
        "estadoToldo": estadoToldo,
        "idPrecintado": idPrecintado,
        "idCarguio": idCarguio,
        "idServiceOrder": idServiceOrder,
        "idUsuario": idUsuario,
      };
}
