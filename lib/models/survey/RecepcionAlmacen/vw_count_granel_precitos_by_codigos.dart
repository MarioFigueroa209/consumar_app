// To parse this JSON data, do
//
//     final vwCountGranelPrecitosByCodigos = vwCountGranelPrecitosByCodigosFromJson(jsonString);

import 'dart:convert';

VwCountGranelPrecitosByCodigos vwCountGranelPrecitosByCodigosFromJson(
        String str) =>
    VwCountGranelPrecitosByCodigos.fromJson(json.decode(str));

String vwCountGranelPrecitosByCodigosToJson(
        VwCountGranelPrecitosByCodigos data) =>
    json.encode(data.toJson());

class VwCountGranelPrecitosByCodigos {
  String? codCarguiPrecinto;
  int? cantidadCompuertaTolva;
  int? cantidadCajaHidraulica;
  int? cantidadMantaCorrediza;

  VwCountGranelPrecitosByCodigos({
    this.codCarguiPrecinto,
    this.cantidadCompuertaTolva,
    this.cantidadCajaHidraulica,
    this.cantidadMantaCorrediza,
  });

  factory VwCountGranelPrecitosByCodigos.fromJson(Map<String, dynamic> json) =>
      VwCountGranelPrecitosByCodigos(
        codCarguiPrecinto: json["codCarguiPrecinto"],
        cantidadCompuertaTolva: json["cantidadCompuertaTolva"],
        cantidadCajaHidraulica: json["cantidadCajaHidraulica"],
        cantidadMantaCorrediza: json["cantidadMantaCorrediza"],
      );

  Map<String, dynamic> toJson() => {
        "codCarguiPrecinto": codCarguiPrecinto,
        "cantidadCompuertaTolva": cantidadCompuertaTolva,
        "cantidadCajaHidraulica": cantidadCajaHidraulica,
        "cantidadMantaCorrediza": cantidadMantaCorrediza,
      };
}
