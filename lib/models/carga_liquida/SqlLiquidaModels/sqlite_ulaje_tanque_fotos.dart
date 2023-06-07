// To parse this JSON data, do
//
//     final sqliteUlajeTanqueFotos = sqliteUlajeTanqueFotosFromJson(jsonString);

import 'dart:convert';

SqliteUlajeTanqueFotos sqliteUlajeTanqueFotosFromJson(String str) =>
    SqliteUlajeTanqueFotos.fromJson(json.decode(str));

String sqliteUlajeTanqueFotosToJson(SqliteUlajeTanqueFotos data) =>
    json.encode(data.toJson());

class SqliteUlajeTanqueFotos {
  SqliteUlajeTanqueFotos({
    this.tanqueNombreFoto,
    this.tanqueUrlFoto,
    this.idUlaje,
  });

  String? tanqueNombreFoto;
  String? tanqueUrlFoto;
  int? idUlaje;

  factory SqliteUlajeTanqueFotos.fromJson(Map<String, dynamic> json) =>
      SqliteUlajeTanqueFotos(
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
