// To parse this JSON data, do
//
//     final vwReestibasSegundoMovimientoAbordo = vwReestibasSegundoMovimientoAbordoFromJson(jsonString);

import 'dart:convert';

List<VwReestibasSegundoMovimientoAbordo>
    vwReestibasSegundoMovimientoAbordoFromJson(String str) =>
        List<VwReestibasSegundoMovimientoAbordo>.from(json
            .decode(str)
            .map((x) => VwReestibasSegundoMovimientoAbordo.fromJson(x)));

String vwReestibasSegundoMovimientoAbordoToJson(
        List<VwReestibasSegundoMovimientoAbordo> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class VwReestibasSegundoMovimientoAbordo {
  VwReestibasSegundoMovimientoAbordo({
    this.idVista,
    this.idSegundoMovimiento,
    this.marca,
    this.modelo,
    this.nivelTemporal,
    this.bodegaTemporal,
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
  String? nivelTemporal;
  String? bodegaTemporal;
  String? nivelFinal;
  String? bodegaFinal;
  int? cantidadFinal;
  String? comentarios;
  int? idServiceOrder;

  factory VwReestibasSegundoMovimientoAbordo.fromJson(
          Map<String, dynamic> json) =>
      VwReestibasSegundoMovimientoAbordo(
        idVista: json["idVista"],
        idSegundoMovimiento: json["idSegundoMovimiento"],
        marca: json["marca"],
        modelo: json["modelo"],
        nivelTemporal: json["nivelTemporal"],
        bodegaTemporal: json["bodegaTemporal"],
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
        "nivelTemporal": nivelTemporal,
        "bodegaTemporal": bodegaTemporal,
        "nivelFinal": nivelFinal,
        "bodegaFinal": bodegaFinal,
        "cantidadFinal": cantidadFinal,
        "comentarios": comentarios,
        "idServiceOrder": idServiceOrder,
      };
}
