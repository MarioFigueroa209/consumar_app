// To parse this JSON data, do
//
//     final spCreateUsuarios = spCreateUsuariosFromJson(jsonString);

import 'dart:convert';

List<SpCreateUsuarios> spCreateUsuariosFromJson(String str) =>
    List<SpCreateUsuarios>.from(
        json.decode(str).map((x) => SpCreateUsuarios.fromJson(x)));

String spCreateUsuariosToJson(List<SpCreateUsuarios> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SpCreateUsuarios {
  String? codFotocheck;
  String? tipoUsuario;
  String? puesto;
  DateTime? fechaRegistro;
  String? nombres;
  String? apellidos;
  String? firmaName;
  String? firmaUrl;

  SpCreateUsuarios({
    this.codFotocheck,
    this.tipoUsuario,
    this.puesto,
    this.fechaRegistro,
    this.nombres,
    this.apellidos,
    this.firmaName,
    this.firmaUrl,
  });

  factory SpCreateUsuarios.fromJson(Map<String, dynamic> json) =>
      SpCreateUsuarios(
        codFotocheck: json["codFotocheck"],
        tipoUsuario: json["tipoUsuario"],
        puesto: json["puesto"],
        fechaRegistro: DateTime.parse(json["fechaRegistro"]),
        nombres: json["nombres"],
        apellidos: json["apellidos"],
        firmaName: json["firmaName"],
        firmaUrl: json["firmaUrl"],
      );

  Map<String, dynamic> toJson() => {
        "codFotocheck": codFotocheck,
        "tipoUsuario": tipoUsuario,
        "puesto": puesto,
        "fechaRegistro": fechaRegistro!.toIso8601String(),
        "nombres": nombres,
        "apellidos": apellidos,
        "firmaName": firmaName,
        "firmaUrl": firmaUrl,
      };
}
