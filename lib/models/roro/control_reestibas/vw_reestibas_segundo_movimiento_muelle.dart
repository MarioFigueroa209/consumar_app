// To parse this JSON data, do
//
//     final vwReestibasSegundoMovimientoMuelle = vwReestibasSegundoMovimientoMuelleFromJson(jsonString);

import 'dart:convert';

List<VwReestibasSegundoMovimientoMuelle>
    vwReestibasSegundoMovimientoMuelleFromJson(String str) =>
        List<VwReestibasSegundoMovimientoMuelle>.from(json
            .decode(str)
            .map((x) => VwReestibasSegundoMovimientoMuelle.fromJson(x)));

String vwReestibasSegundoMovimientoMuelleToJson(
        List<VwReestibasSegundoMovimientoMuelle> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class VwReestibasSegundoMovimientoMuelle {
  VwReestibasSegundoMovimientoMuelle({
    this.idVista,
    this.idSegundoMovimiento,
    this.marca,
    this.modelo,
    this.muelle,
    this.nivelFinal,
    this.bodegaFinal,
    this.cantidadFinal,
    this.comentarios,
    this.idServiceOrder,
  });

  int? idVista;
  int? idSegundoMovimiento;
  String? marca;
  String? modelo;
  String? muelle;
  String? nivelFinal;
  String? bodegaFinal;
  int? cantidadFinal;
  String? comentarios;
  int? idServiceOrder;

  factory VwReestibasSegundoMovimientoMuelle.fromJson(
          Map<String, dynamic> json) =>
      VwReestibasSegundoMovimientoMuelle(
        idVista: json["idVista"],
        idSegundoMovimiento: json["idSegundoMovimiento"],
        marca: json["marca"],
        modelo: json["modelo"],
        muelle: json["muelle"],
        nivelFinal: json["nivelFinal"],
        bodegaFinal: json["bodegaFinal"],
        cantidadFinal: json["cantidadFinal"],
        comentarios: json["comentarios"],
        idServiceOrder: json["idServiceOrder"],
      );

  Map<String, dynamic> toJson() => {
        "idVista": idVista,
        "idSegundoMovimiento": idSegundoMovimiento,
        "marca": marca,
        "modelo": modelo,
        "muelle": muelle,
        "nivelFinal": nivelFinal,
        "bodegaFinal": bodegaFinal,
        "cantidadFinal": cantidadFinal,
        "comentarios": comentarios,
        "idServiceOrder": idServiceOrder,
      };
}
