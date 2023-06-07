// To parse this JSON data, do
//
//     final vwParticipantesByAutoreportModel = vwParticipantesByAutoreportModelFromJson(jsonString);

import 'dart:convert';

List<VwParticipantesByAutoreportModel> vwParticipantesByAutoreportModelFromJson(
        String str) =>
    List<VwParticipantesByAutoreportModel>.from(json
        .decode(str)
        .map((x) => VwParticipantesByAutoreportModel.fromJson(x)));

String vwParticipantesByAutoreportModelToJson(
        List<VwParticipantesByAutoreportModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class VwParticipantesByAutoreportModel {
  int? idVista;
  int? idParticipantesInspeccion;
  int? idAutoreport;
  String? nombreParticipante;
  String? empresa;

  VwParticipantesByAutoreportModel({
    this.idVista,
    this.idParticipantesInspeccion,
    this.idAutoreport,
    this.nombreParticipante,
    this.empresa,
  });

  factory VwParticipantesByAutoreportModel.fromJson(
          Map<String, dynamic> json) =>
      VwParticipantesByAutoreportModel(
        idVista: json["idVista"],
        idParticipantesInspeccion: json["idParticipantesInspeccion"],
        idAutoreport: json["idAutoreport"],
        nombreParticipante: json["nombreParticipante"],
        empresa: json["empresa"],
      );

  Map<String, dynamic> toJson() => {
        "idVista": idVista,
        "idParticipantesInspeccion": idParticipantesInspeccion,
        "idAutoreport": idAutoreport,
        "nombreParticipante": nombreParticipante,
        "empresa": empresa,
      };
}
