// To parse this JSON data, do
//
//     final createGranelParalizaciones = createGranelParalizacionesFromJson(jsonString);

import 'dart:convert';

CreateGranelParalizaciones createGranelParalizacionesFromJson(String str) =>
    CreateGranelParalizaciones.fromJson(json.decode(str));

String createGranelParalizacionesToJson(CreateGranelParalizaciones data) =>
    json.encode(data.toJson());

class CreateGranelParalizaciones {
  CreateGranelParalizaciones({
    this.spCreateGranelParalizaciones,
    this.spCreateGranelFotosParalizaciones,
  });

  SpCreateGranelParalizaciones? spCreateGranelParalizaciones;
  List<SpCreateGranelFotosParalizaciones>? spCreateGranelFotosParalizaciones;

  factory CreateGranelParalizaciones.fromJson(Map<String, dynamic> json) =>
      CreateGranelParalizaciones(
        spCreateGranelParalizaciones: SpCreateGranelParalizaciones.fromJson(
            json["spCreateGranelParalizaciones"]),
        spCreateGranelFotosParalizaciones:
            List<SpCreateGranelFotosParalizaciones>.from(
                json["spCreateGranelFotosParalizaciones"]
                    .map((x) => SpCreateGranelFotosParalizaciones.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "spCreateGranelParalizaciones": spCreateGranelParalizaciones!.toJson(),
        "spCreateGranelFotosParalizaciones": List<dynamic>.from(
            spCreateGranelFotosParalizaciones!.map((x) => x.toJson())),
      };
}

class SpCreateGranelFotosParalizaciones {
  SpCreateGranelFotosParalizaciones({
    this.nombreFoto,
    this.urlFoto,
    this.estado,
    this.idParalizacion,
  });

  String? nombreFoto;
  String? urlFoto;
  String? estado;
  int? idParalizacion;

  factory SpCreateGranelFotosParalizaciones.fromJson(
          Map<String, dynamic> json) =>
      SpCreateGranelFotosParalizaciones(
        nombreFoto: json["nombreFoto"],
        urlFoto: json["urlFoto"],
        estado: json["estado"],
        idParalizacion: json["idParalizacion"],
      );

  Map<String, dynamic> toJson() => {
        "nombreFoto": nombreFoto,
        "urlFoto": urlFoto,
        "estado": estado,
        "idParalizacion": idParalizacion,
      };
}

class SpCreateGranelParalizaciones {
  SpCreateGranelParalizaciones({
    this.jornada,
    this.fecha,
    this.detalle,
    this.responsable,
    this.bodega,
    this.inicioParalizacion,
    this.idServiceOrder,
    this.idUsuario,
  });

  int? jornada;
  DateTime? fecha;
  String? detalle;
  String? responsable;
  String? bodega;
  DateTime? inicioParalizacion;

  int? idServiceOrder;
  int? idUsuario;

  factory SpCreateGranelParalizaciones.fromJson(Map<String, dynamic> json) =>
      SpCreateGranelParalizaciones(
        jornada: json["jornada"],
        fecha: DateTime.parse(json["fecha"]),
        detalle: json["detalle"],
        responsable: json["responsable"],
        bodega: json["bodega"],
        inicioParalizacion: DateTime.parse(json["inicioParalizacion"]),
        idServiceOrder: json["idServiceOrder"],
        idUsuario: json["idUsuario"],
      );

  Map<String, dynamic> toJson() => {
        "jornada": jornada,
        "fecha": fecha?.toIso8601String(),
        "detalle": detalle,
        "responsable": responsable,
        "bodega": bodega,
        "inicioParalizacion": inicioParalizacion?.toIso8601String(),
        "idServiceOrder": idServiceOrder,
        "idUsuario": idUsuario,
      };
}
