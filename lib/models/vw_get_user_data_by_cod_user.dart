// To parse this JSON data, do
//
//     final vwgetUserDataByCodUser = vwgetUserDataByCodUserFromJson(jsonString);

import 'dart:convert';

VwgetUserDataByCodUser vwgetUserDataByCodUserFromJson(String str) =>
    VwgetUserDataByCodUser.fromJson(json.decode(str));

String vwgetUserDataByCodUserToJson(VwgetUserDataByCodUser data) =>
    json.encode(data.toJson());

class VwgetUserDataByCodUser {
  int? idUsuario;
  String? codFotocheck;
  String? puesto;
  String? nombres;
  String? apellidos;
  String? tipoUsuario;
  String? firmaName;
  String? firmaUrl;

  VwgetUserDataByCodUser({
    this.idUsuario,
    this.codFotocheck,
    this.puesto,
    this.nombres,
    this.apellidos,
    this.tipoUsuario,
    this.firmaName,
    this.firmaUrl,
  });

  factory VwgetUserDataByCodUser.fromJson(Map<String, dynamic> json) =>
      VwgetUserDataByCodUser(
        idUsuario: json["idUsuario"],
        codFotocheck: json["codFotocheck"],
        puesto: json["puesto"],
        nombres: json["nombres"],
        apellidos: json["apellidos"],
        tipoUsuario: json["tipoUsuario"],
        firmaName: json["firmaName"],
        firmaUrl: json["firmaUrl"],
      );

  Map<String, dynamic> toJson() => {
        "idUsuario": idUsuario,
        "codFotocheck": codFotocheck,
        "puesto": puesto,
        "nombres": nombres,
        "apellidos": apellidos,
        "tipoUsuario": tipoUsuario,
        "firmaName": firmaName,
        "firmaUrl": firmaUrl,
      };
}
