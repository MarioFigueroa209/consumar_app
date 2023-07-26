// To parse this JSON data, do
//
//     final sqliteUlaje = sqliteUlajeFromJson(jsonString);

import 'dart:convert';

SqliteUlaje sqliteUlajeFromJson(String str) =>
    SqliteUlaje.fromJson(json.decode(str));

String sqliteUlajeToJson(SqliteUlaje data) => json.encode(data.toJson());

class SqliteUlaje {
  SqliteUlaje({
    this.idUlaje,
    this.jornada,
    this.fecha,
    this.tanque,
    this.peso,
    this.temperatura,
    this.descripcionDano,
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
  String? descripcionDano;
  String? descripcionComentarios;
  int? idServiceOrder;
  int? idUsuario;

  factory SqliteUlaje.fromJson(Map<String, dynamic> json) => SqliteUlaje(
        idUlaje: json["idUlaje"],
        jornada: json["jornada"],
        fecha: DateTime.parse(json["fecha"]),
        tanque: json["tanque"],
        peso: json["peso"],
        temperatura: json["temperatura"],
        cantidadDano: json["cantidadDano"],
        descripcionDano: json["descripcionDano"],
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
        "descripcionDano": descripcionDano,
        "descripcionComentarios": descripcionComentarios,
        "idServiceOrder": idServiceOrder,
        "idUsuario": idUsuario,
      };
}
