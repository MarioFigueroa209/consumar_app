// To parse this JSON data, do
//
//     final vwTicketLiquidaDescargaCisterna = vwTicketLiquidaDescargaCisternaFromJson(jsonString);

import 'dart:convert';

List<VwTicketLiquidaDescargaCisterna> vwTicketLiquidaDescargaCisternaFromJson(
        String str) =>
    List<VwTicketLiquidaDescargaCisterna>.from(json
        .decode(str)
        .map((x) => VwTicketLiquidaDescargaCisterna.fromJson(x)));

String vwTicketLiquidaDescargaCisternaToJson(
        List<VwTicketLiquidaDescargaCisterna> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class VwTicketLiquidaDescargaCisterna {
  int? idCarguio;
  String? puerto;
  String? nombreNave;
  int? jornada;
  String? consignatario;
  String? nombreConductor;
  String? brevete;
  String? empresaTransporte;
  String? placaCisterna;
  String? placaTracto;
  String? numeroViaje;
  String? dam;
  String? vwTicketLiquidaDescargaCisternaDo;
  DateTime? fechaDescarga;
  DateTime? fechaInicioCarguio;
  DateTime? fechaTerminoCarguio;
  int? idServiceOrder;

  VwTicketLiquidaDescargaCisterna({
    this.idCarguio,
    this.puerto,
    this.nombreNave,
    this.jornada,
    this.consignatario,
    this.nombreConductor,
    this.brevete,
    this.empresaTransporte,
    this.placaCisterna,
    this.placaTracto,
    this.numeroViaje,
    this.dam,
    this.vwTicketLiquidaDescargaCisternaDo,
    this.fechaDescarga,
    this.fechaInicioCarguio,
    this.fechaTerminoCarguio,
    this.idServiceOrder,
  });

  factory VwTicketLiquidaDescargaCisterna.fromJson(Map<String, dynamic> json) =>
      VwTicketLiquidaDescargaCisterna(
        idCarguio: json["idCarguio"],
        puerto: json["puerto"],
        nombreNave: json["nombreNave"],
        jornada: json["jornada"],
        consignatario: json["consignatario"],
        nombreConductor: json["nombreConductor"],
        brevete: json["brevete"],
        empresaTransporte: json["empresaTransporte"],
        placaCisterna: json["placaCisterna"],
        placaTracto: json["placaTracto"],
        numeroViaje: json["numeroViaje"],
        dam: json["dam"],
        vwTicketLiquidaDescargaCisternaDo: json["do"],
        fechaDescarga: DateTime.parse(json["fechaDescarga"]),
        fechaInicioCarguio: DateTime.parse(json["fechaInicioCarguio"]),
        fechaTerminoCarguio: DateTime.parse(json["fechaTerminoCarguio"]),
        idServiceOrder: json["idServiceOrder"],
      );

  Map<String, dynamic> toJson() => {
        "idCarguio": idCarguio,
        "puerto": puerto,
        "nombreNave": nombreNave,
        "jornada": jornada,
        "consignatario": consignatario,
        "nombreConductor": nombreConductor,
        "brevete": brevete,
        "empresaTransporte": empresaTransporte,
        "placaCisterna": placaCisterna,
        "placaTracto": placaTracto,
        "numeroViaje": numeroViaje,
        "dam": dam,
        "do": vwTicketLiquidaDescargaCisternaDo,
        "fechaDescarga": fechaDescarga!.toIso8601String(),
        "fechaInicioCarguio": fechaInicioCarguio!.toIso8601String(),
        "fechaTerminoCarguio": fechaTerminoCarguio!.toIso8601String(),
        "idServiceOrder": idServiceOrder,
      };
}
