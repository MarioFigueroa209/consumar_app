// To parse this JSON data, do
//
//     final vwReestibasPrimerMovimientoAbordo = vwReestibasPrimerMovimientoAbordoFromJson(jsonString);

import 'dart:convert';

List<VwReestibasPrimerMovimientoAbordo>
    vwReestibasPrimerMovimientoAbordoFromJson(String str) =>
        List<VwReestibasPrimerMovimientoAbordo>.from(json
            .decode(str)
            .map((x) => VwReestibasPrimerMovimientoAbordo.fromJson(x)));

String vwReestibasPrimerMovimientoAbordoToJson(
        List<VwReestibasPrimerMovimientoAbordo> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class VwReestibasPrimerMovimientoAbordo {
  VwReestibasPrimerMovimientoAbordo({
    this.idFrontPantalla,
    this.idPrimerMovimiento,
    this.tipoMercaderia,
    this.marca,
    this.modelo,
    this.nivelInicial,
    this.bodegaInicial,
    this.nivelTemporal,
    this.bodegaTemporal,
    this.cantidadAbordo,
    this.saldo,
    this.comentarios,
    this.idServiceOrder,
  });

  int? idFrontPantalla;
  int? idPrimerMovimiento;
  String? tipoMercaderia;
  String? marca;
  String? modelo;
  String? nivelInicial;
  String? bodegaInicial;
  String? nivelTemporal;
  String? bodegaTemporal;
  int? cantidadAbordo;
  int? saldo;
  String? comentarios;
  int? idServiceOrder;

  factory VwReestibasPrimerMovimientoAbordo.fromJson(
          Map<String, dynamic> json) =>
      VwReestibasPrimerMovimientoAbordo(
        idFrontPantalla: json["idFrontPantalla"],
        idPrimerMovimiento: json["idPrimerMovimiento"],
        tipoMercaderia: json["tipoMercaderia"],
        marca: json["marca"],
        modelo: json["modelo"],
        nivelInicial: json["nivelInicial"],
        bodegaInicial: json["bodegaInicial"],
        nivelTemporal: json["nivelTemporal"],
        bodegaTemporal: json["bodegaTemporal"],
        cantidadAbordo: json["cantidadAbordo"],
        saldo: json["saldo"],
        comentarios: json["comentarios"],
        idServiceOrder: json["idServiceOrder"],
      );

  Map<String, dynamic> toJson() => {
        "idFrontPantalla": idFrontPantalla,
        "idPrimerMovimiento": idPrimerMovimiento,
        "tipoMercaderia": tipoMercaderia,
        "marca": marca,
        "modelo": modelo,
        "nivelInicial": nivelInicial,
        "bodegaInicial": bodegaInicial,
        "nivelTemporal": nivelTemporal,
        "bodegaTemporal": bodegaTemporal,
        "cantidadAbordo": cantidadAbordo,
        "saldo": saldo,
        "comentarios": comentarios,
        "idServiceOrder": idServiceOrder,
      };
}
