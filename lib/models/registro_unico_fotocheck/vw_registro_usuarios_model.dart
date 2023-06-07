// To parse this JSON data, do
//
//     final vwRegistroUsuariosModel = vwRegistroUsuariosModelFromJson(jsonString);

import 'dart:convert';

List<VwRegistroUsuariosModel> vwRegistroUsuariosModelFromJson(String str) =>
    List<VwRegistroUsuariosModel>.from(
        json.decode(str).map((x) => VwRegistroUsuariosModel.fromJson(x)));

String vwRegistroUsuariosModelToJson(List<VwRegistroUsuariosModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class VwRegistroUsuariosModel {
  VwRegistroUsuariosModel({
    this.idVista,
    this.codFotocheck,
    this.usuario,
    this.nombre,
    this.apellido,
    this.firma,
  });

  int? idVista;
  String? codFotocheck;
  String? usuario;
  String? nombre;
  String? apellido;
  String? firma;

  factory VwRegistroUsuariosModel.fromJson(Map<String, dynamic> json) =>
      VwRegistroUsuariosModel(
        idVista: json["idVista"],
        codFotocheck: json["codFotocheck"],
        usuario: json["usuario"],
        nombre: json["nombre"],
        apellido: json["apellido"],
        firma: json["firma"],
      );

  Map<String, dynamic> toJson() => {
        "idVista": idVista,
        "codFotocheck": codFotocheck,
        "usuario": usuario,
        "nombre": nombre,
        "apellido": apellido,
        "firma": firma,
      };
}
