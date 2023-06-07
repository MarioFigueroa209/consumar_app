// To parse this JSON data, do
//
//     final spParticipantesInspeccionModel = spParticipantesInspeccionModelFromJson(jsonString);

import 'dart:convert';

List<SpParticipantesInspeccionModel> spParticipantesInspeccionModelFromJson(
        String str) =>
    List<SpParticipantesInspeccionModel>.from(json
        .decode(str)
        .map((x) => SpParticipantesInspeccionModel.fromJson(x)));

String spParticipantesInspeccionModelToJson(
        List<SpParticipantesInspeccionModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SpParticipantesInspeccionModel {
  SpParticipantesInspeccionModel({
    this.nombres,
    this.empresa,
    this.fotoFotocheck,
    this.idAutoreport,
  });

  String? nombres;
  String? empresa;
  String? fotoFotocheck;
  int? idAutoreport;

  factory SpParticipantesInspeccionModel.fromJson(Map<String, dynamic> json) =>
      SpParticipantesInspeccionModel(
        nombres: json["nombres"],
        empresa: json["empresa"],
        fotoFotocheck: json["fotoFotocheck"],
        idAutoreport: json["idAutoreport"],
      );

  Map<String, dynamic> toJson() => {
        "nombres": nombres,
        "empresa": empresa,
        "fotoFotocheck": fotoFotocheck,
        "idAutoreport": idAutoreport,
      };
}
