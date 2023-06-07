// To parse this JSON data, do
//
//     final spLiquidaUpdateParalizacionesById = spLiquidaUpdateParalizacionesByIdFromJson(jsonString);

import 'dart:convert';

SpLiquidaUpdateParalizacionesById spLiquidaUpdateParalizacionesByIdFromJson(
        String str) =>
    SpLiquidaUpdateParalizacionesById.fromJson(json.decode(str));

String spLiquidaUpdateParalizacionesByIdToJson(
        SpLiquidaUpdateParalizacionesById data) =>
    json.encode(data.toJson());

class SpLiquidaUpdateParalizacionesById {
  SpLiquidaUpdateParalizacionesById({
    this.idParalizacion,
    this.terminoParalizacion,
  });

  int? idParalizacion;
  DateTime? terminoParalizacion;

  factory SpLiquidaUpdateParalizacionesById.fromJson(
          Map<String, dynamic> json) =>
      SpLiquidaUpdateParalizacionesById(
        idParalizacion: json["idParalizacion"],
        terminoParalizacion: DateTime.parse(json["terminoParalizacion"]),
      );

  Map<String, dynamic> toJson() => {
        "idParalizacion": idParalizacion,
        "terminoParalizacion": terminoParalizacion!.toIso8601String(),
      };
}
