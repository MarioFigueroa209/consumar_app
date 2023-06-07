// To parse this JSON data, do
//
//     final validationServiceOrderClosePrinterRampaDr = validationServiceOrderClosePrinterRampaDrFromJson(jsonString);

import 'dart:convert';

List<ValidationServiceOrderClosePrinterRampaDr>
    validationServiceOrderClosePrinterRampaDrFromJson(String str) =>
        List<ValidationServiceOrderClosePrinterRampaDr>.from(json
            .decode(str)
            .map((x) => ValidationServiceOrderClosePrinterRampaDr.fromJson(x)));

String validationServiceOrderClosePrinterRampaDrToJson(
        List<ValidationServiceOrderClosePrinterRampaDr> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ValidationServiceOrderClosePrinterRampaDr {
  int? idserviceOrder;
  String? serviceOrder;
  int? numeroOperaciones;
  int? operacionesDescarga;
  int? operacionesEmbarque;
  int? cantidadDescargaEtiquetado;
  int? cantidadEmbarqueEtiquetado;
  int? rampaDescargada;
  int? distribucionEmbarque;
  int? rampaEmbarcada;
  int? autoreport;
  int? damageReport;
  int? aprobCoordinador;
  int? aprobSupervisor;
  int? aprobResponsableNave;

  ValidationServiceOrderClosePrinterRampaDr({
    this.idserviceOrder,
    this.serviceOrder,
    this.numeroOperaciones,
    this.operacionesDescarga,
    this.operacionesEmbarque,
    this.cantidadDescargaEtiquetado,
    this.cantidadEmbarqueEtiquetado,
    this.rampaDescargada,
    this.distribucionEmbarque,
    this.rampaEmbarcada,
    this.autoreport,
    this.damageReport,
    this.aprobCoordinador,
    this.aprobSupervisor,
    this.aprobResponsableNave,
  });

  factory ValidationServiceOrderClosePrinterRampaDr.fromJson(
          Map<String, dynamic> json) =>
      ValidationServiceOrderClosePrinterRampaDr(
        idserviceOrder: json["idserviceOrder"],
        serviceOrder: json["serviceOrder"],
        numeroOperaciones: json["numeroOperaciones"],
        operacionesDescarga: json["operacionesDescarga"],
        operacionesEmbarque: json["operacionesEmbarque"],
        cantidadDescargaEtiquetado: json["cantidadDescargaEtiquetado"],
        cantidadEmbarqueEtiquetado: json["cantidadEmbarqueEtiquetado"],
        rampaDescargada: json["rampaDescargada"],
        distribucionEmbarque: json["distribucionEmbarque"],
        rampaEmbarcada: json["rampaEmbarcada"],
        autoreport: json["autoreport"],
        damageReport: json["damageReport"],
        aprobCoordinador: json["aprobCoordinador"],
        aprobSupervisor: json["aprobSupervisor"],
        aprobResponsableNave: json["aprobResponsableNave"],
      );

  Map<String, dynamic> toJson() => {
        "idserviceOrder": idserviceOrder,
        "serviceOrder": serviceOrder,
        "numeroOperaciones": numeroOperaciones,
        "operacionesDescarga": operacionesDescarga,
        "operacionesEmbarque": operacionesEmbarque,
        "cantidadDescargaEtiquetado": cantidadDescargaEtiquetado,
        "cantidadEmbarqueEtiquetado": cantidadEmbarqueEtiquetado,
        "rampaDescargada": rampaDescargada,
        "distribucionEmbarque": distribucionEmbarque,
        "rampaEmbarcada": rampaEmbarcada,
        "autoreport": autoreport,
        "damageReport": damageReport,
        "aprobCoordinador": aprobCoordinador,
        "aprobSupervisor": aprobSupervisor,
        "aprobResponsableNave": aprobResponsableNave,
      };
}
