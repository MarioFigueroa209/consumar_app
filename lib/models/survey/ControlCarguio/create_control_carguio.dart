// To parse this JSON data, do
//
//     final createControlCarguio = createControlCarguioFromJson(jsonString);

import 'dart:convert';

CreateControlCarguio createControlCarguioFromJson(String str) =>
    CreateControlCarguio.fromJson(json.decode(str));

String createControlCarguioToJson(CreateControlCarguio data) =>
    json.encode(data.toJson());

class CreateControlCarguio {
  CreateControlCarguio({
    this.spCreateGranelControlCarguio,
    this.spCreateGranelFotosCarguio,
  });

  SpCreateGranelControlCarguio? spCreateGranelControlCarguio;
  List<SpCreateGranelFotosCarguio>? spCreateGranelFotosCarguio;

  factory CreateControlCarguio.fromJson(Map<String, dynamic> json) =>
      CreateControlCarguio(
        spCreateGranelControlCarguio: SpCreateGranelControlCarguio.fromJson(
            json["spCreateGranelControlCarguio"]),
        spCreateGranelFotosCarguio: List<SpCreateGranelFotosCarguio>.from(
            json["spCreateGranelFotosCarguio"]
                .map((x) => SpCreateGranelFotosCarguio.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "spCreateGranelControlCarguio": spCreateGranelControlCarguio!.toJson(),
        "spCreateGranelFotosCarguio": List<dynamic>.from(
            spCreateGranelFotosCarguio!.map((x) => x.toJson())),
      };
}

class SpCreateGranelControlCarguio {
  SpCreateGranelControlCarguio({
    this.jornada,
    this.fecha,
    this.barredura,
    this.bodega,
    this.nTicket,
    this.placa,
    this.tolva,
    this.deliveryOrder,
    this.dam,
    this.inicioCarguio,
    this.terminoCarguio,
    this.idUsuario,
    this.idTransporte,
    this.idConductor,
    this.idServiceOrder,
  });

  int? jornada;
  DateTime? fecha;
  bool? barredura;
  String? bodega;
  String? nTicket;
  String? placa;
  String? tolva;
  String? deliveryOrder;
  String? dam;
  DateTime? inicioCarguio;
  DateTime? terminoCarguio;
  int? idUsuario;
  int? idTransporte;
  int? idConductor;
  int? idServiceOrder;

  factory SpCreateGranelControlCarguio.fromJson(Map<String, dynamic> json) =>
      SpCreateGranelControlCarguio(
        jornada: json["jornada"],
        fecha: DateTime.parse(json["fecha"]),
        barredura: json["barredura"],
        bodega: json["bodega"],
        nTicket: json["nTicket"],
        placa: json["placa"],
        tolva: json["tolva"],
        deliveryOrder: json["deliveryOrder"],
        dam: json["dam"],
        inicioCarguio: DateTime.parse(json["inicioCarguio"]),
        terminoCarguio: DateTime.parse(json["terminoCarguio"]),
        idUsuario: json["idUsuario"],
        idTransporte: json["idTransporte"],
        idConductor: json["idConductor"],
        idServiceOrder: json["idServiceOrder"],
      );

  Map<String, dynamic> toJson() => {
        "jornada": jornada,
        "fecha": fecha!.toIso8601String(),
        "barredura": barredura,
        "bodega": bodega,
        "nTicket": nTicket,
        "placa": placa,
        "tolva": tolva,
        "deliveryOrder": deliveryOrder,
        "dam": dam,
        "inicioCarguio": inicioCarguio?.toIso8601String(),
        "terminoCarguio": terminoCarguio?.toIso8601String(),
        "idUsuario": idUsuario,
        "idTransporte": idTransporte,
        "idConductor": idConductor,
        "idServiceOrder": idServiceOrder,
      };
}

class SpCreateGranelFotosCarguio {
  SpCreateGranelFotosCarguio({
    this.nombreFoto,
    this.urlFoto,
    this.idCarguio,
  });

  String? nombreFoto;
  String? urlFoto;
  int? idCarguio;

  factory SpCreateGranelFotosCarguio.fromJson(Map<String, dynamic> json) =>
      SpCreateGranelFotosCarguio(
        nombreFoto: json["nombreFoto"],
        urlFoto: json["urlFoto"],
        idCarguio: json["idCarguio"],
      );

  Map<String, dynamic> toJson() => {
        "nombreFoto": nombreFoto,
        "urlFoto": urlFoto,
        "idCarguio": idCarguio,
      };
}
