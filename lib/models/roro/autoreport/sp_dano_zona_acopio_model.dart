// To parse this JSON data, do
//
//     final spDanoZonaAcopioModel = spDanoZonaAcopioModelFromJson(jsonString);

import 'dart:convert';

List<SpDanoZonaAcopioModel> spDanoZonaAcopioModelFromJson(String str) =>
    List<SpDanoZonaAcopioModel>.from(
        json.decode(str).map((x) => SpDanoZonaAcopioModel.fromJson(x)));

String spDanoZonaAcopioModelToJson(List<SpDanoZonaAcopioModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SpDanoZonaAcopioModel {
  SpDanoZonaAcopioModel({
    this.descripcion,
    this.fotoDao,
    this.idAutoreport,
  });

  String? descripcion;
  String? fotoDao;
  int? idAutoreport;

  factory SpDanoZonaAcopioModel.fromJson(Map<String, dynamic> json) =>
      SpDanoZonaAcopioModel(
        descripcion: json["descripcion"],
        fotoDao: json["fotoDaño"],
        idAutoreport: json["idAutoreport"],
      );

  Map<String, dynamic> toJson() => {
        "descripcion": descripcion,
        "fotoDaño": fotoDao,
        "idAutoreport": idAutoreport,
      };
}
