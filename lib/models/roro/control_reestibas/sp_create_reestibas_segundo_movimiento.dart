import 'dart:convert';

SpCreateReestibasSegundoMovimiento spCreateReestibasSegundoMovimientoFromJson(
        String str) =>
    SpCreateReestibasSegundoMovimiento.fromJson(json.decode(str));

String spCreateReestibasSegundoMovimientoToJson(
        SpCreateReestibasSegundoMovimiento data) =>
    json.encode(data.toJson());

class SpCreateReestibasSegundoMovimiento {
  SpCreateReestibasSegundoMovimiento({
    this.jornada,
    this.fecha,
    this.nivelFinal,
    this.bodegaFinal,
    this.cantidadFinal,
    this.comentarios,
    this.idReestibasPrimerMov,
    this.idServiceOrder,
    this.idUsuarios,
  });

  int? jornada;
  DateTime? fecha;
  String? nivelFinal;
  String? bodegaFinal;
  int? cantidadFinal;
  String? comentarios;
  int? idReestibasPrimerMov;
  int? idServiceOrder;
  int? idUsuarios;

  factory SpCreateReestibasSegundoMovimiento.fromJson(
          Map<String, dynamic> json) =>
      SpCreateReestibasSegundoMovimiento(
        jornada: json["jornada"],
        fecha: DateTime.parse(json["fecha"]),
        nivelFinal: json["nivelFinal"],
        bodegaFinal: json["bodegaFinal"],
        cantidadFinal: json["cantidadFinal"],
        comentarios: json["comentarios"],
        idReestibasPrimerMov: json["idReestibasPrimerMov"],
        idServiceOrder: json["idServiceOrder"],
        idUsuarios: json["idUsuarios"],
      );

  Map<String, dynamic> toJson() => {
        "jornada": jornada,
        "fecha": fecha!.toIso8601String(),
        "nivelFinal": nivelFinal,
        "bodegaFinal": bodegaFinal,
        "cantidadFinal": cantidadFinal,
        "comentarios": comentarios,
        "idReestibasPrimerMov": idReestibasPrimerMov,
        "idServiceOrder": idServiceOrder,
        "idUsuarios": idUsuarios,
      };
}
