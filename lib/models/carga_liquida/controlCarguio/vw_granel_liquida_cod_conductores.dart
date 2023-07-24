// To parse this JSON data, do
//
//     final vwGranelLiquidaCodConductores = vwGranelLiquidaCodConductoresFromJson(jsonString);

import 'dart:convert';

VwGranelLiquidaCodConductores vwGranelLiquidaCodConductoresFromJson(
        String str) =>
    VwGranelLiquidaCodConductores.fromJson(json.decode(str));

String vwGranelLiquidaCodConductoresToJson(
        VwGranelLiquidaCodConductores data) =>
    json.encode(data.toJson());

class VwGranelLiquidaCodConductores {
  int? idConductores;
  String? nombreApellidos;
  String? codFotocheck;
  String? dni;
  String? empresaTransporte;
  String? ruc;
  String? brevete;

  VwGranelLiquidaCodConductores({
    this.idConductores,
    this.nombreApellidos,
    this.codFotocheck,
    this.dni,
    this.empresaTransporte,
    this.ruc,
    this.brevete,
  });

  factory VwGranelLiquidaCodConductores.fromJson(Map<String, dynamic> json) =>
      VwGranelLiquidaCodConductores(
        idConductores: json["idConductores"],
        nombreApellidos: json["nombreApellidos"],
        codFotocheck: json["codFotocheck"],
        dni: json["dni"],
        empresaTransporte: json["empresaTransporte"],
        ruc: json["ruc"],
        brevete: json["brevete"],
      );

  Map<String, dynamic> toJson() => {
        "idConductores": idConductores,
        "nombreApellidos": nombreApellidos,
        "codFotocheck": codFotocheck,
        "dni": dni,
        "empresaTransporte": empresaTransporte,
        "ruc": ruc,
        "brevete": brevete,
      };
}
