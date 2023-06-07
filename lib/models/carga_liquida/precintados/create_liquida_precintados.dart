// To parse this JSON data, do
//
//     final spCreateLiquidaPrecintados = spCreateLiquidaPrecintadosFromJson(jsonString);

import 'dart:convert';

SpCreateLiquidaPrecintados spCreateLiquidaPrecintadosFromJson(String str) =>
    SpCreateLiquidaPrecintados.fromJson(json.decode(str));

String spCreateLiquidaPrecintadosToJson(SpCreateLiquidaPrecintados data) =>
    json.encode(data.toJson());

class SpCreateLiquidaPrecintados {
  SpCreateLiquidaPrecintados({
    this.spCreateLiquidaPrecintos,
    this.spCreateLiquidaListaPrecintos,
  });

  SpCreateLiquidaPrecintos? spCreateLiquidaPrecintos;
  List<SpCreateLiquidaListaPrecinto>? spCreateLiquidaListaPrecintos;

  factory SpCreateLiquidaPrecintados.fromJson(Map<String, dynamic> json) =>
      SpCreateLiquidaPrecintados(
        spCreateLiquidaPrecintos:
            SpCreateLiquidaPrecintos.fromJson(json["spCreateLiquidaPrecintos"]),
        spCreateLiquidaListaPrecintos: List<SpCreateLiquidaListaPrecinto>.from(
            json["spCreateLiquidaListaPrecintos"]
                .map((x) => SpCreateLiquidaListaPrecinto.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "spCreateLiquidaPrecintos": spCreateLiquidaPrecintos!.toJson(),
        "spCreateLiquidaListaPrecintos": List<dynamic>.from(
            spCreateLiquidaListaPrecintos!.map((x) => x.toJson())),
      };
}

class SpCreateLiquidaListaPrecinto {
  SpCreateLiquidaListaPrecinto({
    this.codigoPrecinto,
    this.tipoPrecinto,
    this.idPrecintado,
  });

  String? codigoPrecinto;
  String? tipoPrecinto;
  int? idPrecintado;

  factory SpCreateLiquidaListaPrecinto.fromJson(Map<String, dynamic> json) =>
      SpCreateLiquidaListaPrecinto(
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

class SpCreateLiquidaPrecintos {
  SpCreateLiquidaPrecintos({
    this.jornada,
    this.fecha,
    this.codCarguioPrecintado,
    this.idCarguio,
    this.idServiceOrder,
    this.idUsuario,
  });

  int? jornada;
  DateTime? fecha;
  String? codCarguioPrecintado;
  int? idCarguio;
  int? idServiceOrder;
  int? idUsuario;

  factory SpCreateLiquidaPrecintos.fromJson(Map<String, dynamic> json) =>
      SpCreateLiquidaPrecintos(
        jornada: json["jornada"],
        fecha: DateTime.parse(json["fecha"]),
        codCarguioPrecintado: json["codCarguioPrecintado"],
        idCarguio: json["idCarguio"],
        idServiceOrder: json["idServiceOrder"],
        idUsuario: json["idUsuario"],
      );

  Map<String, dynamic> toJson() => {
        "jornada": jornada,
        "fecha": fecha!.toIso8601String(),
        "codCarguioPrecintado": codCarguioPrecintado,
        "idCarguio": idCarguio,
        "idServiceOrder": idServiceOrder,
        "idUsuario": idUsuario,
      };
}
