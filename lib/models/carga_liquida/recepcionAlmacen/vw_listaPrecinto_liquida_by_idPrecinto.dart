// To parse this JSON data, do
//
//     final vwListaPrecintoLiquidaByIdPrecinto = vwListaPrecintoLiquidaByIdPrecintoFromJson(jsonString);

import 'dart:convert';

List<VwListaPrecintoLiquidaByIdPrecinto>
    vwListaPrecintoLiquidaByIdPrecintoFromJson(String str) =>
        List<VwListaPrecintoLiquidaByIdPrecinto>.from(json
            .decode(str)
            .map((x) => VwListaPrecintoLiquidaByIdPrecinto.fromJson(x)));

String vwListaPrecintoLiquidaByIdPrecintoToJson(
        List<VwListaPrecintoLiquidaByIdPrecinto> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class VwListaPrecintoLiquidaByIdPrecinto {
  VwListaPrecintoLiquidaByIdPrecinto({
    this.idPrecinto,
    this.codCarguioPrecintado,
    this.codigoPrecinto,
    this.tipoPrecinto,
  });

  int? idPrecinto;
  String? codCarguioPrecintado;
  String? codigoPrecinto;
  String? tipoPrecinto;

  factory VwListaPrecintoLiquidaByIdPrecinto.fromJson(
          Map<String, dynamic> json) =>
      VwListaPrecintoLiquidaByIdPrecinto(
        idPrecinto: json["idPrecinto"],
        codCarguioPrecintado: json["codCarguioPrecintado"],
        codigoPrecinto: json["codigoPrecinto"],
        tipoPrecinto: json["tipoPrecinto"],
      );

  Map<String, dynamic> toJson() => {
        "idPrecinto": idPrecinto,
        "codCarguioPrecintado": codCarguioPrecintado,
        "codigoPrecinto": codigoPrecinto,
        "tipoPrecinto": tipoPrecinto,
      };
}
