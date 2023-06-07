// To parse this JSON data, do
//
//     final vwListaPrecintoByIdPrecinto = vwListaPrecintoByIdPrecintoFromJson(jsonString);

import 'dart:convert';

List<VwListaPrecintoByIdPrecinto> vwListaPrecintoByIdPrecintoFromJson(
        String str) =>
    List<VwListaPrecintoByIdPrecinto>.from(
        json.decode(str).map((x) => VwListaPrecintoByIdPrecinto.fromJson(x)));

String vwListaPrecintoByIdPrecintoToJson(
        List<VwListaPrecintoByIdPrecinto> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class VwListaPrecintoByIdPrecinto {
  VwListaPrecintoByIdPrecinto({
    this.idPrecinto,
    this.codCarguioPrecintado,
    this.codigoPrecinto,
    this.tipoPrecinto,
  });

  int? idPrecinto;
  String? codCarguioPrecintado;
  String? codigoPrecinto;
  String? tipoPrecinto;

  factory VwListaPrecintoByIdPrecinto.fromJson(Map<String, dynamic> json) =>
      VwListaPrecintoByIdPrecinto(
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
