// To parse this JSON data, do
//
//     final spCreateUpdateReestibasFirmanteSegunMov = spCreateUpdateReestibasFirmanteSegunMovFromJson(jsonString);

import 'dart:convert';

SpCreateUpdateReestibasFirmanteSegunMov
    spCreateUpdateReestibasFirmanteSegunMovFromJson(String str) =>
        SpCreateUpdateReestibasFirmanteSegunMov.fromJson(json.decode(str));

String spCreateUpdateReestibasFirmanteSegunMovToJson(
        SpCreateUpdateReestibasFirmanteSegunMov data) =>
    json.encode(data.toJson());

class SpCreateUpdateReestibasFirmanteSegunMov {
  SpCreateUpdateReestibasFirmanteSegunMov({
    this.spCreateReestibasFirmanteBySegMov,
    this.spUpdateIdFirmanteSegundoMovimientoByServiceOrderAndIdSegMov,
  });

  SpCreateReestibasFirmanteBySegMov? spCreateReestibasFirmanteBySegMov;
  List<SpUpdateIdFirmanteSegundoMovimientoByServiceOrderAndIdSegMov>?
      spUpdateIdFirmanteSegundoMovimientoByServiceOrderAndIdSegMov;

  factory SpCreateUpdateReestibasFirmanteSegunMov.fromJson(
          Map<String, dynamic> json) =>
      SpCreateUpdateReestibasFirmanteSegunMov(
        spCreateReestibasFirmanteBySegMov:
            SpCreateReestibasFirmanteBySegMov.fromJson(
                json["spCreateReestibasFirmante"]),
        spUpdateIdFirmanteSegundoMovimientoByServiceOrderAndIdSegMov: List<
                SpUpdateIdFirmanteSegundoMovimientoByServiceOrderAndIdSegMov>.from(
            json["spUpdateIdFirmanteSegundoMovimientoByServiceOrderAndIdSegMov"]
                .map((x) =>
                    SpUpdateIdFirmanteSegundoMovimientoByServiceOrderAndIdSegMov
                        .fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "spCreateReestibasFirmante":
            spCreateReestibasFirmanteBySegMov!.toJson(),
        "spUpdateIdFirmanteSegundoMovimientoByServiceOrderAndIdSegMov":
            List<dynamic>.from(
                spUpdateIdFirmanteSegundoMovimientoByServiceOrderAndIdSegMov!
                    .map((x) => x.toJson())),
      };
}

class SpCreateReestibasFirmanteBySegMov {
  SpCreateReestibasFirmanteBySegMov({
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

  factory SpCreateReestibasFirmanteBySegMov.fromJson(
          Map<String, dynamic> json) =>
      SpCreateReestibasFirmanteBySegMov(
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

class SpUpdateIdFirmanteSegundoMovimientoByServiceOrderAndIdSegMov {
  SpUpdateIdFirmanteSegundoMovimientoByServiceOrderAndIdSegMov({
    this.idRoroReestibasFirmantes,
    this.idReestibasSegundoMov,
    this.idServiceOrder,
  });

  int? idRoroReestibasFirmantes;
  int? idReestibasSegundoMov;
  int? idServiceOrder;

  factory SpUpdateIdFirmanteSegundoMovimientoByServiceOrderAndIdSegMov.fromJson(
          Map<String, dynamic> json) =>
      SpUpdateIdFirmanteSegundoMovimientoByServiceOrderAndIdSegMov(
        idRoroReestibasFirmantes: json["idRoroReestibasFirmantes"],
        idReestibasSegundoMov: json["idReestibasSegundoMov"],
        idServiceOrder: json["idServiceOrder"],
      );

  Map<String, dynamic> toJson() => {
        "idRoroReestibasFirmantes": idRoroReestibasFirmantes,
        "idReestibasSegundoMov": idReestibasSegundoMov,
        "idServiceOrder": idServiceOrder,
      };
}
