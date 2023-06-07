// To parse this JSON data, do
//
//     final createLiquidaUlajeList = createLiquidaUlajeListFromJson(jsonString);

import 'dart:convert';

CreateLiquidaUlajeList createLiquidaUlajeListFromJson(String str) =>
    CreateLiquidaUlajeList.fromJson(json.decode(str));

String createLiquidaUlajeListToJson(CreateLiquidaUlajeList data) =>
    json.encode(data.toJson());

class CreateLiquidaUlajeList {
  CreateLiquidaUlajeList({
    this.spCreateLiquidaUlaje,
    this.spCreateLiquidaUlajeObservadosFotos,
    this.spCreateLiquidaUlajeTanquesFotos,
  });

  List<SpCreateLiquidaUlaje>? spCreateLiquidaUlaje;
  List<SpCreateLiquidaUlajeObservadosFoto>? spCreateLiquidaUlajeObservadosFotos;
  List<SpCreateLiquidaUlajeTanquesFoto>? spCreateLiquidaUlajeTanquesFotos;

  factory CreateLiquidaUlajeList.fromJson(Map<String, dynamic> json) =>
      CreateLiquidaUlajeList(
        spCreateLiquidaUlaje: List<SpCreateLiquidaUlaje>.from(
            json["spCreateLiquidaUlaje"]
                .map((x) => SpCreateLiquidaUlaje.fromJson(x))),
        spCreateLiquidaUlajeObservadosFotos:
            List<SpCreateLiquidaUlajeObservadosFoto>.from(
                json["spCreateLiquidaUlajeObservadosFotos"].map(
                    (x) => SpCreateLiquidaUlajeObservadosFoto.fromJson(x))),
        spCreateLiquidaUlajeTanquesFotos:
            List<SpCreateLiquidaUlajeTanquesFoto>.from(
                json["spCreateLiquidaUlajeTanquesFotos"]
                    .map((x) => SpCreateLiquidaUlajeTanquesFoto.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "spCreateLiquidaUlaje":
            List<dynamic>.from(spCreateLiquidaUlaje!.map((x) => x.toJson())),
        "spCreateLiquidaUlajeObservadosFotos": List<dynamic>.from(
            spCreateLiquidaUlajeObservadosFotos!.map((x) => x.toJson())),
        "spCreateLiquidaUlajeTanquesFotos": List<dynamic>.from(
            spCreateLiquidaUlajeTanquesFotos!.map((x) => x.toJson())),
      };
}

class SpCreateLiquidaUlaje {
  SpCreateLiquidaUlaje({
    this.idUlaje,
    this.jornada,
    this.fecha,
    this.tanque,
    this.peso,
    this.temperatura,
    this.cantidadDano,
    this.descripcionComentarios,
    this.idServiceOrder,
    this.idUsuario,
  });

  int? idUlaje;
  int? jornada;
  DateTime? fecha;
  String? tanque;
  double? peso;
  double? temperatura;
  double? cantidadDano;
  String? descripcionComentarios;
  int? idServiceOrder;
  int? idUsuario;

  factory SpCreateLiquidaUlaje.fromJson(Map<String, dynamic> json) =>
      SpCreateLiquidaUlaje(
        idUlaje: json["idUlaje"],
        jornada: json["jornada"],
        fecha: DateTime.parse(json["fecha"]),
        tanque: json["tanque"],
        peso: json["peso"],
        temperatura: json["temperatura"],
        cantidadDano: json["cantidadDano"],
        descripcionComentarios: json["descripcionComentarios"],
        idServiceOrder: json["idServiceOrder"],
        idUsuario: json["idUsuario"],
      );

  Map<String, dynamic> toJson() => {
        "idUlaje": idUlaje,
        "jornada": jornada,
        "fecha": fecha!.toIso8601String(),
        "tanque": tanque,
        "peso": peso,
        "temperatura": temperatura,
        "cantidadDano": cantidadDano,
        "descripcionComentarios": descripcionComentarios,
        "idServiceOrder": idServiceOrder,
        "idUsuario": idUsuario,
      };
}

class SpCreateLiquidaUlajeObservadosFoto {
  SpCreateLiquidaUlajeObservadosFoto({
    this.ulajeNombreFoto,
    this.ulajeUrlFoto,
    this.idUlaje,
  });

  String? ulajeNombreFoto;
  String? ulajeUrlFoto;
  int? idUlaje;

  factory SpCreateLiquidaUlajeObservadosFoto.fromJson(
          Map<String, dynamic> json) =>
      SpCreateLiquidaUlajeObservadosFoto(
        ulajeNombreFoto: json["ulajeNombreFoto"],
        ulajeUrlFoto: json["ulajeUrlFoto"],
        idUlaje: json["idUlaje"],
      );

  Map<String, dynamic> toJson() => {
        "ulajeNombreFoto": ulajeNombreFoto,
        "ulajeUrlFoto": ulajeUrlFoto,
        "idUlaje": idUlaje,
      };
}

class SpCreateLiquidaUlajeTanquesFoto {
  SpCreateLiquidaUlajeTanquesFoto({
    this.tanqueNombreFoto,
    this.tanqueUrlFoto,
    this.idUlaje,
  });

  String? tanqueNombreFoto;
  String? tanqueUrlFoto;
  int? idUlaje;

  factory SpCreateLiquidaUlajeTanquesFoto.fromJson(Map<String, dynamic> json) =>
      SpCreateLiquidaUlajeTanquesFoto(
        tanqueNombreFoto: json["tanqueNombreFoto"],
        tanqueUrlFoto: json["tanqueUrlFoto"],
        idUlaje: json["idUlaje"],
      );

  Map<String, dynamic> toJson() => {
        "tanqueNombreFoto": tanqueNombreFoto,
        "tanqueUrlFoto": tanqueUrlFoto,
        "idUlaje": idUlaje,
      };
}
