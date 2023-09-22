// To parse this JSON data, do
//
//     final vwTicketGranelDescargaBodega = vwTicketGranelDescargaBodegaFromJson(jsonString);

import 'dart:convert';

List<VwTicketGranelDescargaBodega> vwTicketGranelDescargaBodegaFromJson(
        String str) =>
    List<VwTicketGranelDescargaBodega>.from(
        json.decode(str).map((x) => VwTicketGranelDescargaBodega.fromJson(x)));

String vwTicketGranelDescargaBodegaToJson(
        List<VwTicketGranelDescargaBodega> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class VwTicketGranelDescargaBodega {
  int? idCarguio;
  String? puerto;
  String? nombreNave;
  int? jornada;
  String? consignatario;
  String? nombreConductor;
  String? brevete;
  String? empresaTransporte;
  String? placaTolva;
  String? placaTracto;
  String? numeroViaje;
  String? dam;
  String? vwTicketGranelDescargaBodegaDo;
  DateTime? fechaDescarga;
  DateTime? fechaInicioCarguio;
  DateTime? fechaTerminoCarguio;
  int? idServiceOrder;

  VwTicketGranelDescargaBodega({
    this.idCarguio,
    this.puerto,
    this.nombreNave,
    this.jornada,
    this.consignatario,
    this.nombreConductor,
    this.brevete,
    this.empresaTransporte,
    this.placaTolva,
    this.placaTracto,
    this.numeroViaje,
    this.dam,
    this.vwTicketGranelDescargaBodegaDo,
    this.fechaDescarga,
    this.fechaInicioCarguio,
    this.fechaTerminoCarguio,
    this.idServiceOrder,
  });

  factory VwTicketGranelDescargaBodega.fromJson(Map<String, dynamic> json) =>
      VwTicketGranelDescargaBodega(
        idCarguio: json["idCarguio"],
        puerto: json["puerto"],
        nombreNave: json["nombreNave"],
        jornada: json["jornada"],
        consignatario: json["consignatario"],
        nombreConductor: json["nombreConductor"],
        brevete: json["brevete"],
        empresaTransporte: json["empresaTransporte"],
        placaTolva: json["placaTolva"],
        placaTracto: json["placaTracto"],
        numeroViaje: json["numeroViaje"],
        dam: json["dam"],
        vwTicketGranelDescargaBodegaDo: json["do"],
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
        "placaTolva": placaTolva,
        "placaTracto": placaTracto,
        "numeroViaje": numeroViaje,
        "dam": dam,
        "do": vwTicketGranelDescargaBodegaDo,
        "fechaDescarga": fechaDescarga!.toIso8601String(),
        "fechaInicioCarguio": fechaInicioCarguio!.toIso8601String(),
        "fechaTerminoCarguio": fechaTerminoCarguio!.toIso8601String(),
        "idServiceOrder": idServiceOrder,
      };
}
