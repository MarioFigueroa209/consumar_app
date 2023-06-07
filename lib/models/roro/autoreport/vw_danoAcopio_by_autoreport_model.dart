// To parse this JSON data, do
//
//     final vwDanoAcopioByAutoreportModel = vwDanoAcopioByAutoreportModelFromJson(jsonString);

import 'dart:convert';

List<VwDanoAcopioByAutoreportModel> vwDanoAcopioByAutoreportModelFromJson(
        String str) =>
    List<VwDanoAcopioByAutoreportModel>.from(
        json.decode(str).map((x) => VwDanoAcopioByAutoreportModel.fromJson(x)));

String vwDanoAcopioByAutoreportModelToJson(
        List<VwDanoAcopioByAutoreportModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class VwDanoAcopioByAutoreportModel {
  int? idVista;
  int? idDanoAcopio;
  int? idAutoreport;
  String? danoZonaAcopio;

  VwDanoAcopioByAutoreportModel({
    this.idVista,
    this.idDanoAcopio,
    this.idAutoreport,
    this.danoZonaAcopio,
  });

  factory VwDanoAcopioByAutoreportModel.fromJson(Map<String, dynamic> json) =>
      VwDanoAcopioByAutoreportModel(
        idVista: json["idVista"],
        idDanoAcopio: json["idDanoAcopio"],
        idAutoreport: json["idAutoreport"],
        danoZonaAcopio: json["danoZonaAcopio"],
      );

  Map<String, dynamic> toJson() => {
        "idVista": idVista,
        "idDanoAcopio": idDanoAcopio,
        "idAutoreport": idAutoreport,
        "danoZonaAcopio": danoZonaAcopio,
      };
}
