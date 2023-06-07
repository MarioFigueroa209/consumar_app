// To parse this JSON data, do
//
//     final createLiquidaParalizaciones = createLiquidaParalizacionesFromJson(jsonString);

import 'dart:convert';

CreateLiquidaParalizaciones createLiquidaParalizacionesFromJson(String str) =>
    CreateLiquidaParalizaciones.fromJson(json.decode(str));

String createLiquidaParalizacionesToJson(CreateLiquidaParalizaciones data) =>
    json.encode(data.toJson());

class CreateLiquidaParalizaciones {
  CreateLiquidaParalizaciones({
    this.spCreateLiquidaParalizaciones,
    this.spCreateLiquidaFotosParalizaciones,
  });

  SpCreateLiquidaParalizaciones? spCreateLiquidaParalizaciones;
  List<SpCreateLiquidaFotosParalizacione>? spCreateLiquidaFotosParalizaciones;

  factory CreateLiquidaParalizaciones.fromJson(Map<String, dynamic> json) =>
      CreateLiquidaParalizaciones(
        spCreateLiquidaParalizaciones: SpCreateLiquidaParalizaciones.fromJson(
            json["spCreateLiquidaParalizaciones"]),
        spCreateLiquidaFotosParalizaciones:
            List<SpCreateLiquidaFotosParalizacione>.from(
                json["spCreateLiquidaFotosParalizaciones"]
                    .map((x) => SpCreateLiquidaFotosParalizacione.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "spCreateLiquidaParalizaciones":
            spCreateLiquidaParalizaciones!.toJson(),
        "spCreateLiquidaFotosParalizaciones": List<dynamic>.from(
            spCreateLiquidaFotosParalizaciones!.map((x) => x.toJson())),
      };
}

class SpCreateLiquidaFotosParalizacione {
  SpCreateLiquidaFotosParalizacione({
    this.nombreFoto,
    this.urlFoto,
    this.estado,
    this.idParalizacion,
  });

  String? nombreFoto;
  String? urlFoto;
  String? estado;
  int? idParalizacion;

  factory SpCreateLiquidaFotosParalizacione.fromJson(
          Map<String, dynamic> json) =>
      SpCreateLiquidaFotosParalizacione(
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

class SpCreateLiquidaParalizaciones {
  SpCreateLiquidaParalizaciones({
    this.jornada,
    this.fecha,
    this.detalle,
    this.responsable,
    this.tanque,
    this.inicioParalizacion,
    this.idServiceOrder,
    this.idUsuario,
  });

  int? jornada;
  DateTime? fecha;
  String? detalle;
  String? responsable;
  String? tanque;
  DateTime? inicioParalizacion;
  int? idServiceOrder;
  int? idUsuario;

  factory SpCreateLiquidaParalizaciones.fromJson(Map<String, dynamic> json) =>
      SpCreateLiquidaParalizaciones(
        jornada: json["jornada"],
        fecha: DateTime.parse(json["fecha"]),
        detalle: json["detalle"],
        responsable: json["responsable"],
        tanque: json["tanque"],
        inicioParalizacion: DateTime.parse(json["inicioParalizacion"]),
        idServiceOrder: json["idServiceOrder"],
        idUsuario: json["idUsuario"],
      );

  Map<String, dynamic> toJson() => {
        "jornada": jornada,
        "fecha": fecha!.toIso8601String(),
        "detalle": detalle,
        "responsable": responsable,
        "tanque": tanque,
        "inicioParalizacion": inicioParalizacion!.toIso8601String(),
        "idServiceOrder": idServiceOrder,
        "idUsuario": idUsuario,
      };
}
