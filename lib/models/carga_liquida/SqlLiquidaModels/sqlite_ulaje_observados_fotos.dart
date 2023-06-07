// To parse this JSON data, do
//
//     final sqliteUlajeObservadosFotos = sqliteUlajeObservadosFotosFromJson(jsonString);

import 'dart:convert';

SqliteUlajeObservadosFotos sqliteUlajeObservadosFotosFromJson(String str) =>
    SqliteUlajeObservadosFotos.fromJson(json.decode(str));

String sqliteUlajeObservadosFotosToJson(SqliteUlajeObservadosFotos data) =>
    json.encode(data.toJson());

class SqliteUlajeObservadosFotos {
  SqliteUlajeObservadosFotos({
    this.ulajeNombreFoto,
    this.ulajeUrlFoto,
    this.idUlaje,
  });

  String? ulajeNombreFoto;
  String? ulajeUrlFoto;
  int? idUlaje;

  factory SqliteUlajeObservadosFotos.fromJson(Map<String, dynamic> json) =>
      SqliteUlajeObservadosFotos(
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
