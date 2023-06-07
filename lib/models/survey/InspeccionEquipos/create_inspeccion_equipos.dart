import 'dart:convert';

CreateInspeccionEquipos createInspeccionEquiposFromJson(String str) =>
    CreateInspeccionEquipos.fromJson(json.decode(str));

String createInspeccionEquiposToJson(CreateInspeccionEquipos data) =>
    json.encode(data.toJson());

class CreateInspeccionEquipos {
  CreateInspeccionEquipos({
    this.spCreateGranelInspeccionEquipos,
    this.spCreateGranelInspeccionFotos,
  });

  SpCreateGranelInspeccionEquipos? spCreateGranelInspeccionEquipos;
  List<SpCreateGranelInspeccionFoto>? spCreateGranelInspeccionFotos;

  factory CreateInspeccionEquipos.fromJson(Map<String, dynamic> json) =>
      CreateInspeccionEquipos(
        spCreateGranelInspeccionEquipos:
            SpCreateGranelInspeccionEquipos.fromJson(
                json["spCreateGranelInspeccionEquipos"]),
        spCreateGranelInspeccionFotos: List<SpCreateGranelInspeccionFoto>.from(
            json["spCreateGranelInspeccionFotos"]
                .map((x) => SpCreateGranelInspeccionFoto.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "spCreateGranelInspeccionEquipos":
            spCreateGranelInspeccionEquipos!.toJson(),
        "spCreateGranelInspeccionFotos": List<dynamic>.from(
            spCreateGranelInspeccionFotos!.map((x) => x.toJson())),
      };
}

class SpCreateGranelInspeccionEquipos {
  SpCreateGranelInspeccionEquipos({
    this.jornada,
    this.fecha,
    this.bodega,
    this.muelle,
    this.toldo,
    this.primInsp,
    this.comentario,
    this.idEquipo,
    this.idUsuario,
    this.idServiceOrder,
  });

  int? jornada;
  DateTime? fecha;
  String? bodega;
  String? muelle;
  String? toldo;
  String? primInsp;
  String? comentario;
  int? idEquipo;
  int? idUsuario;
  int? idServiceOrder;

  factory SpCreateGranelInspeccionEquipos.fromJson(Map<String, dynamic> json) =>
      SpCreateGranelInspeccionEquipos(
        jornada: json["jornada"],
        fecha: DateTime.parse(json["fecha"]),
        bodega: json["bodega"],
        muelle: json["muelle"],
        toldo: json["toldo"],
        primInsp: json["primInsp"],
        comentario: json["comentario"],
        idEquipo: json["idEquipo"],
        idUsuario: json["idUsuario"],
        idServiceOrder: json["idServiceOrder"],
      );

  Map<String, dynamic> toJson() => {
        "jornada": jornada,
        "fecha": fecha!.toIso8601String(),
        "bodega": bodega,
        "muelle": muelle,
        "toldo": toldo,
        "primInsp": primInsp,
        "comentario": comentario,
        "idEquipo": idEquipo,
        "idUsuario": idUsuario,
        "idServiceOrder": idServiceOrder,
      };
}

class SpCreateGranelInspeccionFoto {
  SpCreateGranelInspeccionFoto({
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

  factory SpCreateGranelInspeccionFoto.fromJson(Map<String, dynamic> json) =>
      SpCreateGranelInspeccionFoto(
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
