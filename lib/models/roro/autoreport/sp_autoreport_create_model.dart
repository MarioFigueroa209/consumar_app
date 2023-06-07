// To parse this JSON data, do
//
//     final spAutoreportCreate = spAutoreportCreateFromJson(jsonString);

import 'dart:convert';

import 'sp_create_autoreport_model.dart';
import 'sp_dano_zona_acopio_model.dart';
import 'sp_participantes_inspeccion_model.dart';

SpAutoreportCreate spAutoreportCreateFromJson(String str) =>
    SpAutoreportCreate.fromJson(json.decode(str));

String spAutoreportCreateToJson(SpAutoreportCreate data) =>
    json.encode(data.toJson());

class SpAutoreportCreate {
  SpAutoreportCreate({
    this.spAutoreport,
    this.spDanosZonaAcopio,
    this.spParicipantesInspeccion,
  });

  SpCreateAutoreportModel? spAutoreport;
  List<SpDanoZonaAcopioModel>? spDanosZonaAcopio;
  List<SpParticipantesInspeccionModel>? spParicipantesInspeccion;

  factory SpAutoreportCreate.fromJson(Map<String, dynamic> json) =>
      SpAutoreportCreate(
        spAutoreport: SpCreateAutoreportModel.fromJson(json["spAutoreport"]),
        spDanosZonaAcopio: List<SpDanoZonaAcopioModel>.from(
            json["spDanosZonaAcopio"]
                .map((x) => SpDanoZonaAcopioModel.fromJson(x))),
        spParicipantesInspeccion: List<SpParticipantesInspeccionModel>.from(
            json["spParicipantesInspeccion"]
                .map((x) => SpParticipantesInspeccionModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "spAutoreport": spAutoreport?.toJson(),
        "spDanosZonaAcopio":
            List<dynamic>.from(spDanosZonaAcopio!.map((x) => x.toJson())),
        "spParicipantesInspeccion": List<dynamic>.from(
            spParicipantesInspeccion!.map((x) => x.toJson())),
      };
}
