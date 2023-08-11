// To parse this JSON data, do
//
//     final vwCountLiquidaPrecitosValvulas = vwCountLiquidaPrecitosValvulasFromJson(jsonString);

import 'dart:convert';

VwCountLiquidaPrecitosValvulas vwCountLiquidaPrecitosValvulasFromJson(
        String str) =>
    VwCountLiquidaPrecitosValvulas.fromJson(json.decode(str));

String vwCountLiquidaPrecitosValvulasToJson(
        VwCountLiquidaPrecitosValvulas data) =>
    json.encode(data.toJson());

class VwCountLiquidaPrecitosValvulas {
  String? codCarguiPrecinto;
  int? cantidadVavulaIngreso;
  int? cantidadVavulaSalida;

  VwCountLiquidaPrecitosValvulas({
    this.codCarguiPrecinto,
    this.cantidadVavulaIngreso,
    this.cantidadVavulaSalida,
  });

  factory VwCountLiquidaPrecitosValvulas.fromJson(Map<String, dynamic> json) =>
      VwCountLiquidaPrecitosValvulas(
        codCarguiPrecinto: json["codCarguiPrecinto"],
        cantidadVavulaIngreso: json["cantidadVavulaIngreso"],
        cantidadVavulaSalida: json["cantidadVavulaSalida"],
      );

  Map<String, dynamic> toJson() => {
        "codCarguiPrecinto": codCarguiPrecinto,
        "cantidadVavulaIngreso": cantidadVavulaIngreso,
        "cantidadVavulaSalida": cantidadVavulaSalida,
      };
}
