// To parse this JSON data, do
//
//     final usuarioModel = usuarioModelFromJson(jsonString);

import 'dart:convert';

List<UsuarioModel> usuarioModelFromJson(String str) => List<UsuarioModel>.from(
    json.decode(str).map((x) => UsuarioModel.fromJson(x)));

String usuarioModelToJson(List<UsuarioModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UsuarioModel {
  UsuarioModel({
    this.idUsuarios,
    this.codFotocheck,
    this.tipoUsuario,
    this.nombres,
    this.apellidos,
    this.empresaTransporte,
    this.firma,
    this.fechaRegistro,
    this.fechaCreacion,
    this.fechaUltimaModificacion,
    this.fechaEliminacion,
    this.usuarioCreacion,
    this.flagDelete,
    this.usuarioEliminacion,
  });

  int? idUsuarios;
  String? codFotocheck;
  String? tipoUsuario;
  String? nombres;
  String? apellidos;
  String? empresaTransporte;
  String? firma;
  DateTime? fechaRegistro;
  DateTime? fechaCreacion;
  DateTime? fechaUltimaModificacion;
  DateTime? fechaEliminacion;
  String? usuarioCreacion;
  String? flagDelete;
  String? usuarioEliminacion;

  factory UsuarioModel.fromJson(Map<String, dynamic> json) => UsuarioModel(
        idUsuarios: json["idUsuarios"],
        codFotocheck: json["codFotocheck"],
        tipoUsuario: json["tipoUsuario"],
        nombres: json["nombres"],
        apellidos: json["apellidos"],
        empresaTransporte: json["empresaTransporte"],
        firma: json["firma"],
        fechaRegistro: DateTime.parse(json["fechaRegistro"]),
        fechaCreacion: DateTime.parse(json["fechaCreacion"]),
        fechaUltimaModificacion:
            DateTime.parse(json["fechaUltimaModificacion"]),
        fechaEliminacion: DateTime.parse(json["fechaEliminacion"]),
        usuarioCreacion: json["usuarioCreacion"],
        flagDelete: json["flagDelete"],
        usuarioEliminacion: json["usuarioEliminacion"],
      );

  Map<String, dynamic> toJson() => {
        "idUsuarios": idUsuarios,
        "codFotocheck": codFotocheck,
        "tipoUsuario": tipoUsuario,
        "nombres": nombres,
        "apellidos": apellidos,
        "empresaTransporte": empresaTransporte,
        "firma": firma,
        "fechaRegistro": fechaRegistro?.toIso8601String(),
        "fechaCreacion": fechaCreacion?.toIso8601String(),
        "fechaUltimaModificacion": fechaUltimaModificacion?.toIso8601String(),
        "fechaEliminacion": fechaEliminacion?.toIso8601String(),
        "usuarioCreacion": usuarioCreacion,
        "flagDelete": flagDelete,
        "usuarioEliminacion": usuarioEliminacion,
      };
}
