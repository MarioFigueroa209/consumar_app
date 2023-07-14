// To parse this JSON data, do
//
//     final createSilosControlVisual = createSilosControlVisualFromJson(jsonString);

import 'dart:convert';

CreateSilosControlVisual createSilosControlVisualFromJson(String str) =>
    CreateSilosControlVisual.fromJson(json.decode(str));

String createSilosControlVisualToJson(CreateSilosControlVisual data) =>
    json.encode(data.toJson());

class CreateSilosControlVisual {
  String? tolva;
  String? puntoDespacho;
  String? descarga;
  String? cadenero;
  DateTime? horaInicio;
  DateTime? horaTerminal;
  DateTime? fecha;
  int? jornada;
  int? idUsuario;
  int? idTransporte;
  int? idServiceOrder;

  CreateSilosControlVisual({
    this.tolva,
    this.puntoDespacho,
    this.descarga,
    this.cadenero,
    this.horaInicio,
    this.horaTerminal,
    this.fecha,
    this.jornada,
    this.idUsuario,
    this.idTransporte,
    this.idServiceOrder,
  });

  factory CreateSilosControlVisual.fromJson(Map<String, dynamic> json) =>
      CreateSilosControlVisual(
        tolva: json["tolva"],
        puntoDespacho: json["puntoDespacho"],
        descarga: json["descarga"],
        cadenero: json["cadenero"],
        horaInicio: DateTime.parse(json["horaInicio"]),
        horaTerminal: DateTime.parse(json["horaTerminal"]),
        fecha: DateTime.parse(json["fecha"]),
        jornada: json["jornada"],
        idUsuario: json["idUsuario"],
        idTransporte: json["idTransporte"],
        idServiceOrder: json["idServiceOrder"],
      );

  Map<String, dynamic> toJson() => {
        "tolva": tolva,
        "puntoDespacho": puntoDespacho,
        "descarga": descarga,
        "cadenero": cadenero,
        "horaInicio": horaInicio!.toIso8601String(),
        "horaTerminal": horaTerminal!.toIso8601String(),
        "fecha": fecha!.toIso8601String(),
        "jornada": jornada,
        "idUsuario": idUsuario,
        "idTransporte": idTransporte,
        "idServiceOrder": idServiceOrder,
      };
}
