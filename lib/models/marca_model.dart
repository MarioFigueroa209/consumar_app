import 'dart:convert';

List<MarcaModel> marcaModelFromJson(String str) =>
    List<MarcaModel>.from(json.decode(str).map((x) => MarcaModel.fromJson(x)));

String marcaModelToJson(List<MarcaModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MarcaModel {
  MarcaModel({
    this.marca,
  });

  String? marca;

  factory MarcaModel.fromJson(Map<String, dynamic> json) => MarcaModel(
        marca: json["marca"],
      );

  Map<String, dynamic> toJson() => {
        "marca": marca,
      };
}
