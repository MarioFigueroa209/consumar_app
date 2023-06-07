// To parse this JSON data, do
//
//     final spCreatePrecintados = spCreatePrecintadosFromJson(jsonString);

import 'dart:convert';

SpCreatePrecintados spCreatePrecintadosFromJson(String str) =>
    SpCreatePrecintados.fromJson(json.decode(str));

String spCreatePrecintadosToJson(SpCreatePrecintados data) =>
    json.encode(data.toJson());

class SpCreatePrecintados {
  SpCreatePrecintados({
    this.spCreateGranelPrecintos,
    this.spCreateGranelListaPrecintos,
  });

  SpCreateGranelPrecintos? spCreateGranelPrecintos;
  List<SpCreateGranelListaPrecinto>? spCreateGranelListaPrecintos;

  factory SpCreatePrecintados.fromJson(Map<String, dynamic> json) =>
      SpCreatePrecintados(
        spCreateGranelPrecintos:
            SpCreateGranelPrecintos.fromJson(json["spCreateGranelPrecintos"]),
        spCreateGranelListaPrecintos: List<SpCreateGranelListaPrecinto>.from(
            json["spCreateGranelListaPrecintos"]
                .map((x) => SpCreateGranelListaPrecinto.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "spCreateGranelPrecintos": spCreateGranelPrecintos!.toJson(),
        "spCreateGranelListaPrecintos": List<dynamic>.from(
            spCreateGranelListaPrecintos!.map((x) => x.toJson())),
      };
}

class SpCreateGranelListaPrecinto {
  SpCreateGranelListaPrecinto({
    this.codigoPrecinto,
    this.tipoPrecinto,
    this.idPrecintado,
  });

  String? codigoPrecinto;
  String? tipoPrecinto;
  int? idPrecintado;

  factory SpCreateGranelListaPrecinto.fromJson(Map<String, dynamic> json) =>
      SpCreateGranelListaPrecinto(
        codigoPrecinto: json["codigoPrecinto"],
        tipoPrecinto: json["tipoPrecinto"],
        idPrecintado: json["idPrecintado"],
      );

  Map<String, dynamic> toJson() => {
        "codigoPrecinto": codigoPrecinto,
        "tipoPrecinto": tipoPrecinto,
        "idPrecintado": idPrecintado,
      };
}

class SpCreateGranelPrecintos {
  SpCreateGranelPrecintos({
    this.jornada,
    this.fecha,
    this.idCarguio,
    this.idServiceOrder,
    this.idUsuario,
  });

  int? jornada;
  DateTime? fecha;
  int? idCarguio;
  int? idServiceOrder;
  int? idUsuario;

  factory SpCreateGranelPrecintos.fromJson(Map<String, dynamic> json) =>
      SpCreateGranelPrecintos(
        jornada: json["jornada"],
        fecha: DateTime.parse(json["fecha"]),
        idCarguio: json["idCarguio"],
        idServiceOrder: json["idServiceOrder"],
        idUsuario: json["idUsuario"],
      );

  Map<String, dynamic> toJson() => {
        "jornada": jornada,
        "fecha": fecha!.toIso8601String(),
        "idCarguio": idCarguio,
        "idServiceOrder": idServiceOrder,
        "idUsuario": idUsuario,
      };
}
