// To parse this JSON data, do
//
//     final vwReestibasPrimerMovimientoMuelle = vwReestibasPrimerMovimientoMuelleFromJson(jsonString);

import 'dart:convert';

List<VwReestibasPrimerMovimientoMuelle>
    vwReestibasPrimerMovimientoMuelleFromJson(String str) =>
        List<VwReestibasPrimerMovimientoMuelle>.from(json
            .decode(str)
            .map((x) => VwReestibasPrimerMovimientoMuelle.fromJson(x)));

String vwReestibasPrimerMovimientoMuelleToJson(
        List<VwReestibasPrimerMovimientoMuelle> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class VwReestibasPrimerMovimientoMuelle {
  VwReestibasPrimerMovimientoMuelle({
    this.idFrontPantalla,
    this.idPrimerMovimiento,
    this.tipoMercaderia,
    this.marca,
    this.modelo,
    this.nivelInicial,
    this.bodegaInicial,
    this.muelle,
    this.cantidadMuelle,
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
  String? muelle;
  int? cantidadMuelle;
  int? saldo;
  String? comentarios;
  int? idServiceOrder;

  factory VwReestibasPrimerMovimientoMuelle.fromJson(
          Map<String, dynamic> json) =>
      VwReestibasPrimerMovimientoMuelle(
        idFrontPantalla: json["idFrontPantalla"],
        idPrimerMovimiento: json["idPrimerMovimiento"],
        tipoMercaderia: json["tipoMercaderia"],
        marca: json["marca"],
        modelo: json["modelo"],
        nivelInicial: json["nivelInicial"],
        bodegaInicial: json["bodegaInicial"],
        muelle: json["muelle"],
        cantidadMuelle: json["cantidadMuelle"],
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
        "muelle": muelle,
        "cantidadMuelle": cantidadMuelle,
        "saldo": saldo,
        "comentarios": comentarios,
        "idServiceOrder": idServiceOrder,
      };
}
