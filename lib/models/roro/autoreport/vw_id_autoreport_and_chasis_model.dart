// To parse this JSON data, do
//
//     final vwAutoreportList = vwAutoreportListFromJson(jsonString);

import 'dart:convert';

List<VwAutoreportList> vwAutoreportListFromJson(String str) =>
    List<VwAutoreportList>.from(
        json.decode(str).map((x) => VwAutoreportList.fromJson(x)));

String vwAutoreportListToJson(List<VwAutoreportList> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class VwAutoreportList {
  VwAutoreportList({
    this.idVista,
    this.idAutoreport,
    this.chassis,
    this.danoAcopio,
    this.participantesInspecion,
    this.fechaCreacion,
    this.idServiceOrder,
  });

  int? idVista;
  int? idAutoreport;
  String? chassis;
  bool? danoAcopio;
  bool? participantesInspecion;
  DateTime? fechaCreacion;
  int? idServiceOrder;

  factory VwAutoreportList.fromJson(Map<String, dynamic> json) =>
      VwAutoreportList(
        idVista: json["idVista"],
        idAutoreport: json["idAutoreport"],
        chassis: json["chassis"],
        danoAcopio: json["danoAcopio"],
        participantesInspecion: json["participantesInspecion"],
        fechaCreacion: DateTime.parse(json["fechaCreacion"]),
        idServiceOrder: json["idServiceOrder"],
      );

  Map<String, dynamic> toJson() => {
        "idVista": idVista,
        "idAutoreport": idAutoreport,
        "chassis": chassis,
        "danoAcopio": danoAcopio,
        "participantesInspecion": participantesInspecion,
        "fechaCreacion": fechaCreacion!.toIso8601String(),
        "idServiceOrder": idServiceOrder,
      };
}
