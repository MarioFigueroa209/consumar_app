// To parse this JSON data, do
//
//     final spCreateUpdateReestibasFirmante = spCreateUpdateReestibasFirmanteFromJson(jsonString);

import 'dart:convert';

SpCreateUpdateReestibasFirmante spCreateUpdateReestibasFirmanteFromJson(
        String str) =>
    SpCreateUpdateReestibasFirmante.fromJson(json.decode(str));

String spCreateUpdateReestibasFirmanteToJson(
        SpCreateUpdateReestibasFirmante data) =>
    json.encode(data.toJson());

class SpCreateUpdateReestibasFirmante {
  SpCreateUpdateReestibasFirmante({
    this.spCreateReestibasFirmante,
    this.spUpdateIdFirmanteSegundoMovimiento,
  });

  SpCreateReestibasFirmante? spCreateReestibasFirmante;
  SpUpdateIdFirmanteSegundoMovimiento? spUpdateIdFirmanteSegundoMovimiento;

  factory SpCreateUpdateReestibasFirmante.fromJson(Map<String, dynamic> json) =>
      SpCreateUpdateReestibasFirmante(
        spCreateReestibasFirmante: SpCreateReestibasFirmante.fromJson(
            json["spCreateReestibasFirmante"]),
        spUpdateIdFirmanteSegundoMovimiento:
            SpUpdateIdFirmanteSegundoMovimiento.fromJson(
                json["spUpdateIdFirmanteSegundoMovimiento"]),
      );

  Map<String, dynamic> toJson() => {
        "spCreateReestibasFirmante": spCreateReestibasFirmante!.toJson(),
        "spUpdateIdFirmanteSegundoMovimiento":
            spUpdateIdFirmanteSegundoMovimiento!.toJson(),
      };
}

class SpCreateReestibasFirmante {
  SpCreateReestibasFirmante({
    this.jornada,
    this.fecha,
    this.responsableNave,
    this.nombresApellidos,
    this.codFotocheck,
    this.cargo,
    this.firmaName,
    this.firmalUrl,
    this.idServiceOrder,
  });

  int? jornada;
  DateTime? fecha;
  String? responsableNave;
  String? nombresApellidos;
  String? codFotocheck;
  String? cargo;
  String? firmaName;
  String? firmalUrl;
  int? idServiceOrder;

  factory SpCreateReestibasFirmante.fromJson(Map<String, dynamic> json) =>
      SpCreateReestibasFirmante(
        jornada: json["jornada"],
        fecha: DateTime.parse(json["fecha"]),
        responsableNave: json["responsableNave"],
        nombresApellidos: json["nombresApellidos"],
        codFotocheck: json["codFotocheck"],
        cargo: json["cargo"],
        firmaName: json["firmaName"],
        firmalUrl: json["firmalUrl"],
        idServiceOrder: json["idServiceOrder"],
      );

  Map<String, dynamic> toJson() => {
        "jornada": jornada,
        "fecha": fecha!.toIso8601String(),
        "responsableNave": responsableNave,
        "nombresApellidos": nombresApellidos,
        "codFotocheck": codFotocheck,
        "cargo": cargo,
        "firmaName": firmaName,
        "firmalUrl": firmalUrl,
        "idServiceOrder": idServiceOrder,
      };
}

class SpUpdateIdFirmanteSegundoMovimiento {
  SpUpdateIdFirmanteSegundoMovimiento({
    this.idRoroReestibasFirmantes,
    this.idServiceOrder,
  });

  int? idRoroReestibasFirmantes;
  int? idServiceOrder;

  factory SpUpdateIdFirmanteSegundoMovimiento.fromJson(
          Map<String, dynamic> json) =>
      SpUpdateIdFirmanteSegundoMovimiento(
        idRoroReestibasFirmantes: json["idRoroReestibasFirmantes"],
        idServiceOrder: json["idServiceOrder"],
      );

  Map<String, dynamic> toJson() => {
        "idRoroReestibasFirmantes": idRoroReestibasFirmantes,
        "idServiceOrder": idServiceOrder,
      };
}
