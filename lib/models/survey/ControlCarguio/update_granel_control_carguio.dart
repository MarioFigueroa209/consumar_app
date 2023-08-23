// To parse this JSON data, do
//
//     final updateGranelControlCarguio = updateGranelControlCarguioFromJson(jsonString);

import 'dart:convert';

UpdateGranelControlCarguio updateGranelControlCarguioFromJson(String str) =>
    UpdateGranelControlCarguio.fromJson(json.decode(str));

String updateGranelControlCarguioToJson(UpdateGranelControlCarguio data) =>
    json.encode(data.toJson());

class UpdateGranelControlCarguio {
  int? idCarguio;
  DateTime? terminoCarguio;

  UpdateGranelControlCarguio({
    this.idCarguio,
    this.terminoCarguio,
  });

  factory UpdateGranelControlCarguio.fromJson(Map<String, dynamic> json) =>
      UpdateGranelControlCarguio(
        idCarguio: json["idCarguio"],
        terminoCarguio: DateTime.parse(json["terminoCarguio"]),
      );

  Map<String, dynamic> toJson() => {
        "idCarguio": idCarguio,
        "terminoCarguio": terminoCarguio!.toIso8601String(),
      };
}
