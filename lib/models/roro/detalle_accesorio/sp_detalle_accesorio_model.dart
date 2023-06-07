import 'dart:convert';

import 'sp_create_detalle_accesorio.dart';
import 'sp_create_detalle_accesorio_item.dart';

SpDetalleAccesorioModel spDetalleAccesorioModelFromJson(String str) =>
    SpDetalleAccesorioModel.fromJson(json.decode(str));

String spDetalleAccesorioModelToJson(SpDetalleAccesorioModel data) =>
    json.encode(data.toJson());

class SpDetalleAccesorioModel {
  SpDetalleAccesorioModel({
    this.spCreateDetalleAccesorio,
    this.spCreateDetalleAccesorioItem,
  });

  SpCreateDetalleAccesorio? spCreateDetalleAccesorio;
  List<SpCreateDetalleAccesorioItem>? spCreateDetalleAccesorioItem;

  factory SpDetalleAccesorioModel.fromJson(Map<String, dynamic> json) =>
      SpDetalleAccesorioModel(
        spCreateDetalleAccesorio:
            SpCreateDetalleAccesorio.fromJson(json["spCreateDetalleAccesorio"]),
        spCreateDetalleAccesorioItem: List<SpCreateDetalleAccesorioItem>.from(
            json["spCreateDetalleAccesorioItem"]
                .map((x) => SpCreateDetalleAccesorioItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "spCreateDetalleAccesorio": spCreateDetalleAccesorio!.toJson(),
        "spCreateDetalleAccesorioItem": List<dynamic>.from(
            spCreateDetalleAccesorioItem!.map((x) => x.toJson())),
      };
}
