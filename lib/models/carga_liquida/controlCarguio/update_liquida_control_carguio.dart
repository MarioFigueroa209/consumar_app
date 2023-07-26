// To parse this JSON data, do
//
//     final updateLiquidaControlCarguio = updateLiquidaControlCarguioFromJson(jsonString);

import 'dart:convert';

UpdateLiquidaControlCarguio updateLiquidaControlCarguioFromJson(String str) =>
    UpdateLiquidaControlCarguio.fromJson(json.decode(str));

String updateLiquidaControlCarguioToJson(UpdateLiquidaControlCarguio data) =>
    json.encode(data.toJson());

class UpdateLiquidaControlCarguio {
  int? idCarguio;
  DateTime? terminoCarguio;

  UpdateLiquidaControlCarguio({
    this.idCarguio,
    this.terminoCarguio,
  });

  factory UpdateLiquidaControlCarguio.fromJson(Map<String, dynamic> json) =>
      UpdateLiquidaControlCarguio(
        idCarguio: json["idCarguio"],
        terminoCarguio: DateTime.parse(json["terminoCarguio"]),
      );

  Map<String, dynamic> toJson() => {
        "idCarguio": idCarguio,
        "terminoCarguio": terminoCarguio!.toIso8601String(),
      };
}
