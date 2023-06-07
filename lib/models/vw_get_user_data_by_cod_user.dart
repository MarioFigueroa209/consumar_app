import 'dart:convert';

VwgetUserDataByCodUser vwgetUserDataByCodUserFromJson(String str) =>
    VwgetUserDataByCodUser.fromJson(json.decode(str));

String vwgetUserDataByCodUserToJson(VwgetUserDataByCodUser data) =>
    json.encode(data.toJson());

class VwgetUserDataByCodUser {
  VwgetUserDataByCodUser({
    this.idUsuario,
    this.codFotocheck,
    this.nombres,
    this.apellidos,
    this.tipoUsuario,
    this.firmaName,
    this.firmaUrl,
  });

  int? idUsuario;
  String? codFotocheck;
  String? nombres;
  String? apellidos;
  String? tipoUsuario;
  String? firmaName;
  String? firmaUrl;

  factory VwgetUserDataByCodUser.fromJson(Map<String, dynamic> json) =>
      VwgetUserDataByCodUser(
        idUsuario: json["idUsuario"],
        codFotocheck: json["codFotocheck"],
        nombres: json["nombres"],
        apellidos: json["apellidos"],
        tipoUsuario: json["tipoUsuario"],
        firmaName: json["firmaName"],
        firmaUrl: json["firmaUrl"],
      );

  Map<String, dynamic> toJson() => {
        "idUsuario": idUsuario,
        "codFotocheck": codFotocheck,
        "nombres": nombres,
        "apellidos": apellidos,
        "tipoUsuario": tipoUsuario,
        "firmaName": firmaName,
        "firmaUrl": firmaUrl,
      };
}
