// To parse this JSON data, do
//
//     final spGranelUpdateParalizacionesById = spGranelUpdateParalizacionesByIdFromJson(jsonString);

import 'dart:convert';

SpGranelUpdateParalizacionesById spGranelUpdateParalizacionesByIdFromJson(
        String str) =>
    SpGranelUpdateParalizacionesById.fromJson(json.decode(str));

String spGranelUpdateParalizacionesByIdToJson(
        SpGranelUpdateParalizacionesById data) =>
    json.encode(data.toJson());

class SpGranelUpdateParalizacionesById {
  SpGranelUpdateParalizacionesById({
    this.idParalizacion,
    this.terminoParalizacion,
  });

  int? idParalizacion;
  DateTime? terminoParalizacion;

  factory SpGranelUpdateParalizacionesById.fromJson(
          Map<String, dynamic> json) =>
      SpGranelUpdateParalizacionesById(
        idParalizacion: json["idParalizacion"],
        terminoParalizacion: DateTime.parse(json["terminoParalizacion"]),
      );

  Map<String, dynamic> toJson() => {
        "idParalizacion": idParalizacion,
        "terminoParalizacion": terminoParalizacion!.toIso8601String(),
      };
}
