// To parse this JSON data, do
//
//     final vwRampaEmbarqueTop20Model = vwRampaEmbarqueTop20ModelFromJson(jsonString);

import 'dart:convert';

List<VwRampaEmbarqueTop20Model> vwRampaEmbarqueTop20ModelFromJson(String str) =>
    List<VwRampaEmbarqueTop20Model>.from(
        json.decode(str).map((x) => VwRampaEmbarqueTop20Model.fromJson(x)));

String vwRampaEmbarqueTop20ModelToJson(List<VwRampaEmbarqueTop20Model> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class VwRampaEmbarqueTop20Model {
  VwRampaEmbarqueTop20Model({
    this.idRampaEmbarque,
    this.chasis,
    this.marca,
    this.conductor,
    this.horaLectura,
  });

  int? idRampaEmbarque;
  String? chasis;
  String? marca;
  String? conductor;
  DateTime? horaLectura;

  factory VwRampaEmbarqueTop20Model.fromJson(Map<String, dynamic> json) =>
      VwRampaEmbarqueTop20Model(
        idRampaEmbarque: json["idRampaEmbarque"],
        chasis: json["chasis"],
        marca: json["marca"],
        conductor: json["conductor"],
        horaLectura: DateTime.parse(json["horaLectura"]),
      );

  Map<String, dynamic> toJson() => {
        "idRampaEmbarque": idRampaEmbarque,
        "chasis": chasis,
        "marca": marca,
        "conductor": conductor,
        "horaLectura": horaLectura?.toIso8601String(),
      };
}
