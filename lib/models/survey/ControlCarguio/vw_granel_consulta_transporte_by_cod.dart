import 'dart:convert';

VwGranelConsultaTransporteByCod vwGranelConsultaTransporteByCodFromJson(
        String str) =>
    VwGranelConsultaTransporteByCod.fromJson(json.decode(str));

String vwGranelConsultaTransporteByCodToJson(
        VwGranelConsultaTransporteByCod data) =>
    json.encode(data.toJson());

class VwGranelConsultaTransporteByCod {
  VwGranelConsultaTransporteByCod({
    this.idTransporte,
    this.empresaTransporte,
    this.ruc,
    this.codFotocheck,
  });

  int? idTransporte;
  String? empresaTransporte;
  String? ruc;
  String? codFotocheck;

  factory VwGranelConsultaTransporteByCod.fromJson(Map<String, dynamic> json) =>
      VwGranelConsultaTransporteByCod(
        idTransporte: json["idTransporte"],
        empresaTransporte: json["empresaTransporte"],
        ruc: json["ruc"],
        codFotocheck: json["codFotocheck"],
      );

  Map<String, dynamic> toJson() => {
        "idTransporte": idTransporte,
        "empresaTransporte": empresaTransporte,
        "ruc": ruc,
        "codFotocheck": codFotocheck,
      };
}
