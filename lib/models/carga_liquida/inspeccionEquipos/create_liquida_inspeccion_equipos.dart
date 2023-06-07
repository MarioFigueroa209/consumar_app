// To parse this JSON data, do
//
//     final createLiquidaInspeccionEquipos = createLiquidaInspeccionEquiposFromJson(jsonString);

import 'dart:convert';

CreateLiquidaInspeccionEquipos createLiquidaInspeccionEquiposFromJson(
        String str) =>
    CreateLiquidaInspeccionEquipos.fromJson(json.decode(str));

String createLiquidaInspeccionEquiposToJson(
        CreateLiquidaInspeccionEquipos data) =>
    json.encode(data.toJson());

class CreateLiquidaInspeccionEquipos {
  CreateLiquidaInspeccionEquipos({
    this.spCreateLiquidaInspeccionEquipos,
    this.spCreateLiquidaInspeccionFotos,
  });

  SpCreateLiquidaInspeccionEquipos? spCreateLiquidaInspeccionEquipos;
  List<SpCreateLiquidaInspeccionFoto>? spCreateLiquidaInspeccionFotos;

  factory CreateLiquidaInspeccionEquipos.fromJson(Map<String, dynamic> json) =>
      CreateLiquidaInspeccionEquipos(
        spCreateLiquidaInspeccionEquipos:
            SpCreateLiquidaInspeccionEquipos.fromJson(
                json["spCreateLiquidaInspeccionEquipos"]),
        spCreateLiquidaInspeccionFotos:
            List<SpCreateLiquidaInspeccionFoto>.from(
                json["spCreateLiquidaInspeccionFotos"]
                    .map((x) => SpCreateLiquidaInspeccionFoto.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "spCreateLiquidaInspeccionEquipos":
            spCreateLiquidaInspeccionEquipos!.toJson(),
        "spCreateLiquidaInspeccionFotos": List<dynamic>.from(
            spCreateLiquidaInspeccionFotos!.map((x) => x.toJson())),
      };
}

class SpCreateLiquidaInspeccionEquipos {
  SpCreateLiquidaInspeccionEquipos({
    this.jornada,
    this.fecha,
    this.tanque,
    this.primInsp,
    this.comentario,
    this.idEquipo,
    this.idUsuario,
    this.idServiceOrder,
  });

  int? jornada;
  DateTime? fecha;
  String? tanque;
  String? primInsp;
  String? comentario;
  int? idEquipo;
  int? idUsuario;
  int? idServiceOrder;

  factory SpCreateLiquidaInspeccionEquipos.fromJson(
          Map<String, dynamic> json) =>
      SpCreateLiquidaInspeccionEquipos(
        jornada: json["jornada"],
        fecha: DateTime.parse(json["fecha"]),
        tanque: json["tanque"],
        primInsp: json["primInsp"],
        comentario: json["comentario"],
        idEquipo: json["idEquipo"],
        idUsuario: json["idUsuario"],
        idServiceOrder: json["idServiceOrder"],
      );

  Map<String, dynamic> toJson() => {
        "jornada": jornada,
        "fecha": fecha?.toIso8601String(),
        "tanque": tanque,
        "primInsp": primInsp,
        "comentario": comentario,
        "idEquipo": idEquipo,
        "idUsuario": idUsuario,
        "idServiceOrder": idServiceOrder,
      };
}

class SpCreateLiquidaInspeccionFoto {
  SpCreateLiquidaInspeccionFoto({
    this.nombreFoto,
    this.urlFoto,
    this.numInsp,
    this.estado,
    this.idInspeccionEquipos,
  });

  String? nombreFoto;
  String? urlFoto;
  String? numInsp;
  String? estado;
  int? idInspeccionEquipos;

  factory SpCreateLiquidaInspeccionFoto.fromJson(Map<String, dynamic> json) =>
      SpCreateLiquidaInspeccionFoto(
        nombreFoto: json["nombreFoto"],
        urlFoto: json["urlFoto"],
        numInsp: json["numInsp"],
        estado: json["estado"],
        idInspeccionEquipos: json["idInspeccionEquipos"],
      );

  Map<String, dynamic> toJson() => {
        "nombreFoto": nombreFoto,
        "urlFoto": urlFoto,
        "numInsp": numInsp,
        "estado": estado,
        "idInspeccionEquipos": idInspeccionEquipos,
      };
}
