// To parse this JSON data, do
//
//     final createMonitoreoProducto = createMonitoreoProductoFromJson(jsonString);

import 'dart:convert';

CreateMonitoreoProducto? createMonitoreoProductoFromJson(String str) =>
    CreateMonitoreoProducto.fromJson(json.decode(str));

String createMonitoreoProductoToJson(CreateMonitoreoProducto? data) =>
    json.encode(data!.toJson());

class CreateMonitoreoProducto {
  CreateMonitoreoProducto({
    this.spGranelCreateMonitoreoProducto,
    this.spGranelCreateMpBodegaFotos,
    this.spGranelCreateMpObservadoFotos,
  });

  List<SpGranelCreateMonitoreoProducto?>? spGranelCreateMonitoreoProducto;
  List<SpGranelCreateMpBodegaFoto?>? spGranelCreateMpBodegaFotos;
  List<SpGranelCreateMpObservadoFoto?>? spGranelCreateMpObservadoFotos;

  factory CreateMonitoreoProducto.fromJson(Map<String, dynamic> json) =>
      CreateMonitoreoProducto(
        spGranelCreateMonitoreoProducto:
            json["spGranelCreateMonitoreoProducto"] == null
                ? []
                : List<SpGranelCreateMonitoreoProducto?>.from(
                    json["spGranelCreateMonitoreoProducto"]!.map(
                        (x) => SpGranelCreateMonitoreoProducto.fromJson(x))),
        spGranelCreateMpBodegaFotos: json["spGranelCreateMPBodegaFotos"] == null
            ? []
            : List<SpGranelCreateMpBodegaFoto?>.from(
                json["spGranelCreateMPBodegaFotos"]!
                    .map((x) => SpGranelCreateMpBodegaFoto.fromJson(x))),
        spGranelCreateMpObservadoFotos:
            json["spGranelCreateMPObservadoFotos"] == null
                ? []
                : List<SpGranelCreateMpObservadoFoto?>.from(
                    json["spGranelCreateMPObservadoFotos"]!
                        .map((x) => SpGranelCreateMpObservadoFoto.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "spGranelCreateMonitoreoProducto":
            spGranelCreateMonitoreoProducto == null
                ? []
                : List<dynamic>.from(
                    spGranelCreateMonitoreoProducto!.map((x) => x!.toJson())),
        "spGranelCreateMPBodegaFotos": spGranelCreateMpBodegaFotos == null
            ? []
            : List<dynamic>.from(
                spGranelCreateMpBodegaFotos!.map((x) => x!.toJson())),
        "spGranelCreateMPObservadoFotos": spGranelCreateMpObservadoFotos == null
            ? []
            : List<dynamic>.from(
                spGranelCreateMpObservadoFotos!.map((x) => x!.toJson())),
      };
}

class SpGranelCreateMonitoreoProducto {
  SpGranelCreateMonitoreoProducto({
    this.idMonitoreoProducto,
    this.jornada,
    this.fecha,
    this.inspeccionFito,
    this.bodega,
    this.humedad,
    this.tempEstProa,
    this.tempEstPopa,
    this.tempCentro,
    this.tempBaborProa,
    this.tempBaborPopa,
    this.cantidadDanos,
    this.descripcion,
    this.idServiceOrder,
    this.idUsuarios,
  });

  int? idMonitoreoProducto;
  int? jornada;
  DateTime? fecha;
  String? inspeccionFito;
  String? bodega;
  double? humedad;
  double? tempEstProa;
  double? tempEstPopa;
  double? tempCentro;
  double? tempBaborProa;
  double? tempBaborPopa;
  double? cantidadDanos;
  String? descripcion;
  int? idServiceOrder;
  int? idUsuarios;

  factory SpGranelCreateMonitoreoProducto.fromJson(Map<String, dynamic> json) =>
      SpGranelCreateMonitoreoProducto(
        idMonitoreoProducto: json["idMonitoreoProducto"],
        jornada: json["jornada"],
        fecha: DateTime.parse(json["fecha"]),
        inspeccionFito: json["inspeccionFito"],
        bodega: json["bodega"],
        humedad: json["humedad"].toDouble(),
        tempEstProa: json["tempEstProa"].toDouble(),
        tempEstPopa: json["tempEstPopa"].toDouble(),
        tempCentro: json["tempCentro"].toDouble(),
        tempBaborProa: json["tempBaborProa"].toDouble(),
        tempBaborPopa: json["tempBaborPopa"].toDouble(),
        cantidadDanos: json["cantidadDanos"].toDouble(),
        descripcion: json["descripcion"],
        idServiceOrder: json["idServiceOrder"],
        idUsuarios: json["idUsuarios"],
      );

  Map<String, dynamic> toJson() => {
        "idMonitoreoProducto": idMonitoreoProducto,
        "jornada": jornada,
        "fecha": fecha?.toIso8601String(),
        "inspeccionFito": inspeccionFito,
        "bodega": bodega,
        "humedad": humedad,
        "tempEstProa": tempEstProa,
        "tempEstPopa": tempEstPopa,
        "tempCentro": tempCentro,
        "tempBaborProa": tempBaborProa,
        "tempBaborPopa": tempBaborPopa,
        "cantidadDanos": cantidadDanos,
        "descripcion": descripcion,
        "idServiceOrder": idServiceOrder,
        "idUsuarios": idUsuarios,
      };
}

class SpGranelCreateMpBodegaFoto {
  SpGranelCreateMpBodegaFoto({
    this.mpNombreFoto,
    this.mpUrlFoto,
    this.idMonitoreoProducto,
  });

  String? mpNombreFoto;
  String? mpUrlFoto;
  int? idMonitoreoProducto;

  factory SpGranelCreateMpBodegaFoto.fromJson(Map<String, dynamic> json) =>
      SpGranelCreateMpBodegaFoto(
        mpNombreFoto: json["mpNombreFoto"],
        mpUrlFoto: json["mpUrlFoto"],
        idMonitoreoProducto: json["idMonitoreoProducto"],
      );

  Map<String, dynamic> toJson() => {
        "mpNombreFoto": mpNombreFoto,
        "mpUrlFoto": mpUrlFoto,
        "idMonitoreoProducto": idMonitoreoProducto,
      };
}

class SpGranelCreateMpObservadoFoto {
  SpGranelCreateMpObservadoFoto({
    this.mpNombreFoto,
    this.mpUrlFoto,
    this.idMonitoreoProducto,
  });

  String? mpNombreFoto;
  String? mpUrlFoto;
  int? idMonitoreoProducto;

  factory SpGranelCreateMpObservadoFoto.fromJson(Map<String, dynamic> json) =>
      SpGranelCreateMpObservadoFoto(
        mpNombreFoto: json["mpNombreFoto"],
        mpUrlFoto: json["mpUrlFoto"],
        idMonitoreoProducto: json["idMonitoreoProducto"],
      );

  Map<String, dynamic> toJson() => {
        "mpNombreFoto": mpNombreFoto,
        "mpUrlFoto": mpUrlFoto,
        "idMonitoreoProducto": idMonitoreoProducto,
      };
}
