// To parse this JSON data, do
//
//     final spCreateReestibasPrimerMovimientoModel = spCreateReestibasPrimerMovimientoModelFromJson(jsonString);

import 'dart:convert';

SpCreateReestibasPrimerMovimientoModel
    spCreateReestibasPrimerMovimientoModelFromJson(String str) =>
        SpCreateReestibasPrimerMovimientoModel.fromJson(json.decode(str));

String spCreateReestibasPrimerMovimientoModelToJson(
        SpCreateReestibasPrimerMovimientoModel data) =>
    json.encode(data.toJson());

class SpCreateReestibasPrimerMovimientoModel {
  SpCreateReestibasPrimerMovimientoModel({
    this.jornada,
    this.fecha,
    this.marca,
    this.tipoMercaderia,
    this.modelo,
    this.pesoBrutoUnitario,
    this.unidad,
    this.conversion,
    this.tipoReestiba,
    this.nivelInicial,
    this.bodegaInicial,
    this.muelle,
    this.cantidadMuelle,
    this.nivelTemporal,
    this.bodegaTemporal,
    this.cantidadAbordo,
    this.comentarios,
    this.idServiceOrder,
    this.idUsuarios,
  });

  int? jornada;
  DateTime? fecha;
  String? marca;
  String? tipoMercaderia;
  String? modelo;
  double? pesoBrutoUnitario;
  String? unidad;
  double? conversion;
  String? tipoReestiba;
  String? nivelInicial;
  String? bodegaInicial;
  String? muelle;
  int? cantidadMuelle;
  String? nivelTemporal;
  String? bodegaTemporal;
  int? cantidadAbordo;
  String? comentarios;
  int? idServiceOrder;
  int? idUsuarios;

  factory SpCreateReestibasPrimerMovimientoModel.fromJson(
          Map<String, dynamic> json) =>
      SpCreateReestibasPrimerMovimientoModel(
        jornada: json["jornada"],
        fecha: DateTime.parse(json["fecha"]),
        marca: json["marca"],
        tipoMercaderia: json["tipoMercaderia"],
        modelo: json["modelo"],
        pesoBrutoUnitario: json["pesoBrutoUnitario"],
        unidad: json["unidad"],
        conversion: json["conversion"],
        tipoReestiba: json["tipoReestiba"],
        nivelInicial: json["nivelInicial"],
        bodegaInicial: json["bodegaInicial"],
        muelle: json["muelle"],
        cantidadMuelle: json["cantidadMuelle"],
        nivelTemporal: json["nivelTemporal"],
        bodegaTemporal: json["bodegaTemporal"],
        cantidadAbordo: json["cantidadAbordo"],
        comentarios: json["comentarios"],
        idServiceOrder: json["idServiceOrder"],
        idUsuarios: json["idUsuarios"],
      );

  Map<String, dynamic> toJson() => {
        "jornada": jornada,
        "fecha": fecha!.toIso8601String(),
        "marca": marca,
        "tipoMercaderia": tipoMercaderia,
        "modelo": modelo,
        "pesoBrutoUnitario": pesoBrutoUnitario,
        "unidad": unidad,
        "conversion": conversion,
        "tipoReestiba": tipoReestiba,
        "nivelInicial": nivelInicial,
        "bodegaInicial": bodegaInicial,
        "muelle": muelle,
        "cantidadMuelle": cantidadMuelle,
        "nivelTemporal": nivelTemporal,
        "bodegaTemporal": bodegaTemporal,
        "cantidadAbordo": cantidadAbordo,
        "comentarios": comentarios,
        "idServiceOrder": idServiceOrder,
        "idUsuarios": idUsuarios,
      };
}
