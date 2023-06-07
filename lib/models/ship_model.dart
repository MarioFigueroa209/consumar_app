import 'dart:convert';

List<ShipModel> shipModelFromJson(String str) =>
    List<ShipModel>.from(json.decode(str).map((x) => ShipModel.fromJson(x)));

String shipModelToJson(List<ShipModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ShipModel {
  ShipModel({
    this.idShip,
    this.nombreNave,
    this.tipoNave,
    this.fechaCreacion,
    this.fechaUltimaModificacion,
    this.fechaEliminacion,
    this.usuarioCreacion,
    this.flagDelete,
    this.usuarioEliminacion,
  });

  int? idShip;
  String? nombreNave;
  String? tipoNave;
  DateTime? fechaCreacion;
  DateTime? fechaUltimaModificacion;
  DateTime? fechaEliminacion;
  String? usuarioCreacion;
  String? flagDelete;
  String? usuarioEliminacion;

  factory ShipModel.fromJson(Map<String, dynamic> json) => ShipModel(
        idShip: json["idShip"],
        nombreNave: json["nombreNave"] ?? '',
        tipoNave: json["tipoNave"],
        fechaCreacion: DateTime.parse(json["fechaCreacion"]),
        fechaUltimaModificacion:
            DateTime.parse(json["fechaUltimaModificacion"]),
        fechaEliminacion: DateTime.parse(json["fechaEliminacion"]),
        usuarioCreacion: json["usuarioCreacion"],
        flagDelete: json["flagDelete"],
        usuarioEliminacion: json["usuarioEliminacion"],
      );

  Map<String, dynamic> toJson() => {
        "idShip": idShip,
        "nombreNave": nombreNave,
        "tipoNave": tipoNave,
        "fechaCreacion": fechaCreacion.toString(),
        "fechaUltimaModificacion": fechaUltimaModificacion.toString(),
        "fechaEliminacion": fechaEliminacion.toString(),
        "usuarioCreacion": usuarioCreacion,
        "flagDelete": flagDelete,
        "usuarioEliminacion": usuarioEliminacion,
      };
}
