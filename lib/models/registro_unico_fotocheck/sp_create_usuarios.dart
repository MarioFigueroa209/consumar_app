// To parse this JSON data, do
//
//     final spCreateUsuarios = spCreateUsuariosFromJson(jsonString);

import 'dart:convert';

SpCreateUsuarios spCreateUsuariosFromJson(String str) =>
    SpCreateUsuarios.fromJson(json.decode(str));

String spCreateUsuariosToJson(SpCreateUsuarios data) =>
    json.encode(data.toJson());

class SpCreateUsuarios {
  SpCreateUsuarios({
    this.codFotocheck,
    this.tipoUsuario,
    this.fechaRegistro,
    this.nombres,
    this.apellidos,
    this.firmaName,
    this.firmaUrl,
  });

  String? codFotocheck;
  String? tipoUsuario;
  DateTime? fechaRegistro;
  String? nombres;
  String? apellidos;
  String? firmaName;
  String? firmaUrl;

  factory SpCreateUsuarios.fromJson(Map<String, dynamic> json) =>
      SpCreateUsuarios(
        codFotocheck: json["codFotocheck"],
        tipoUsuario: json["tipoUsuario"],
        fechaRegistro: DateTime.parse(json["fechaRegistro"]),
        nombres: json["nombres"],
        apellidos: json["apellidos"],
        firmaName: json["firmaName"],
        firmaUrl: json["firmaUrl"],
      );

  Map<String, dynamic> toJson() => {
        "codFotocheck": codFotocheck,
        "tipoUsuario": tipoUsuario,
        "fechaRegistro": fechaRegistro!.toIso8601String(),
        "nombres": nombres,
        "apellidos": apellidos,
        "firmaName": firmaName,
        "firmaUrl": firmaUrl,
      };
}
