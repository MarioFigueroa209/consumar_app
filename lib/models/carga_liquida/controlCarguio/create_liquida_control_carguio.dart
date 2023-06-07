// To parse this JSON data, do
//
//     final createLiquidaControlCarguio = createLiquidaControlCarguioFromJson(jsonString);

import 'dart:convert';

CreateLiquidaControlCarguio createLiquidaControlCarguioFromJson(String str) =>
    CreateLiquidaControlCarguio.fromJson(json.decode(str));

String createLiquidaControlCarguioToJson(CreateLiquidaControlCarguio data) =>
    json.encode(data.toJson());

class CreateLiquidaControlCarguio {
  CreateLiquidaControlCarguio({
    this.spCreateLiquidaControlCarguio,
    this.spCreateLiquidaFotosCarguio,
  });

  SpCreateLiquidaControlCarguio? spCreateLiquidaControlCarguio;
  List<SpCreateLiquidaFotosCarguio>? spCreateLiquidaFotosCarguio;

  factory CreateLiquidaControlCarguio.fromJson(Map<String, dynamic> json) =>
      CreateLiquidaControlCarguio(
        spCreateLiquidaControlCarguio: SpCreateLiquidaControlCarguio.fromJson(
            json["spCreateLiquidaControlCarguio"]),
        spCreateLiquidaFotosCarguio: List<SpCreateLiquidaFotosCarguio>.from(
            json["spCreateLiquidaFotosCarguio"]
                .map((x) => SpCreateLiquidaFotosCarguio.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "spCreateLiquidaControlCarguio":
            spCreateLiquidaControlCarguio!.toJson(),
        "spCreateLiquidaFotosCarguio": List<dynamic>.from(
            spCreateLiquidaFotosCarguio!.map((x) => x.toJson())),
      };
}

class SpCreateLiquidaControlCarguio {
  SpCreateLiquidaControlCarguio({
    this.jornada,
    this.fecha,
    this.barredura,
    this.tanque,
    this.nTicket,
    this.placa,
    this.cisterna,
    this.deliveryOrder,
    this.dam,
    this.inicioCarguio,
    this.terminoCarguio,
    this.idTransporte,
    this.idConductor,
    this.idServiceOrder,
    this.idUsuario,
  });

  int? jornada;
  DateTime? fecha;
  bool? barredura;
  String? tanque;
  String? nTicket;
  String? placa;
  String? cisterna;
  String? deliveryOrder;
  String? dam;
  DateTime? inicioCarguio;
  DateTime? terminoCarguio;
  int? idTransporte;
  int? idConductor;
  int? idServiceOrder;
  int? idUsuario;

  factory SpCreateLiquidaControlCarguio.fromJson(Map<String, dynamic> json) =>
      SpCreateLiquidaControlCarguio(
        jornada: json["jornada"],
        fecha: DateTime.parse(json["fecha"]),
        barredura: json["barredura"],
        tanque: json["tanque"],
        nTicket: json["nTicket"],
        placa: json["placa"],
        cisterna: json["cisterna"],
        deliveryOrder: json["deliveryOrder"],
        dam: json["dam"],
        inicioCarguio: DateTime.parse(json["inicioCarguio"]),
        terminoCarguio: DateTime.parse(json["terminoCarguio"]),
        idTransporte: json["idTransporte"],
        idConductor: json["idConductor"],
        idServiceOrder: json["idServiceOrder"],
        idUsuario: json["idUsuario"],
      );

  Map<String, dynamic> toJson() => {
        "jornada": jornada,
        "fecha": fecha!.toIso8601String(),
        "barredura": barredura,
        "tanque": tanque,
        "nTicket": nTicket,
        "placa": placa,
        "cisterna": cisterna,
        "deliveryOrder": deliveryOrder,
        "dam": dam,
        "inicioCarguio": inicioCarguio!.toIso8601String(),
        "terminoCarguio": terminoCarguio!.toIso8601String(),
        "idTransporte": idTransporte,
        "idConductor": idConductor,
        "idServiceOrder": idServiceOrder,
        "idUsuario": idUsuario,
      };
}

class SpCreateLiquidaFotosCarguio {
  SpCreateLiquidaFotosCarguio({
    this.nombreFoto,
    this.urlFoto,
    this.idCarguio,
  });

  String? nombreFoto;
  String? urlFoto;
  int? idCarguio;

  factory SpCreateLiquidaFotosCarguio.fromJson(Map<String, dynamic> json) =>
      SpCreateLiquidaFotosCarguio(
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
