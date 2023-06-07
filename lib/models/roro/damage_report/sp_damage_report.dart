// To parse this JSON data, do
//
//     final spDamageReport = spDamageReportFromJson(jsonString);

import 'dart:convert';

SpDamageReport spDamageReportFromJson(String str) =>
    SpDamageReport.fromJson(json.decode(str));

String spDamageReportToJson(SpDamageReport data) => json.encode(data.toJson());

class SpDamageReport {
  int? idDamageReport;
  int? jornada;
  DateTime? fecha;
  String? codDr;
  String? tipoOperacion;
  int? numeroTrabajador;
  String? chassisFoto;
  String? stowagePosition;
  String? damageInformation;
  String? tercerosOperacion;
  String? companyName;
  String? damageFound;
  String? damageOcurred;
  String? operation;
  int? cantidadDaos;
  String? fotoVerificacion;
  String? lugarAccidente;
  DateTime? fechaAccidente;
  String? comentarios;
  String? codQr;
  int? idServiceOrder;
  int? idUsuarios;
  int? idApmtc;
  int? idConductor;
  int? idVehicle;

  SpDamageReport({
    this.idDamageReport,
    this.jornada,
    this.fecha,
    this.codDr,
    this.tipoOperacion,
    this.numeroTrabajador,
    this.chassisFoto,
    this.stowagePosition,
    this.damageInformation,
    this.tercerosOperacion,
    this.companyName,
    this.damageFound,
    this.damageOcurred,
    this.operation,
    this.cantidadDaos,
    this.fotoVerificacion,
    this.lugarAccidente,
    this.fechaAccidente,
    this.comentarios,
    this.codQr,
    this.idServiceOrder,
    this.idUsuarios,
    this.idApmtc,
    this.idConductor,
    this.idVehicle,
  });

  factory SpDamageReport.fromJson(Map<String, dynamic> json) => SpDamageReport(
        idDamageReport: json["idDamageReport"],
        jornada: json["jornada"],
        fecha: DateTime.parse(json["fecha"]),
        codDr: json["codDr"],
        tipoOperacion: json["tipoOperacion"],
        numeroTrabajador: json["numeroTrabajador"],
        chassisFoto: json["chassisFoto"],
        stowagePosition: json["stowagePosition"],
        damageInformation: json["damageInformation"],
        tercerosOperacion: json["tercerosOperacion"],
        companyName: json["companyName"],
        damageFound: json["damageFound"],
        damageOcurred: json["damageOcurred"],
        operation: json["operation"],
        cantidadDaos: json["cantidadDaños"],
        fotoVerificacion: json["fotoVerificacion"],
        lugarAccidente: json["lugarAccidente"],
        fechaAccidente: DateTime.parse(json["fechaAccidente"]),
        comentarios: json["comentarios"],
        codQr: json["codQr"],
        idServiceOrder: json["idServiceOrder"],
        idUsuarios: json["idUsuarios"],
        idApmtc: json["idApmtc"],
        idConductor: json["idConductor"],
        idVehicle: json["idVehicle"],
      );

  Map<String, dynamic> toJson() => {
        "idDamageReport": idDamageReport,
        "jornada": jornada,
        "fecha": fecha!.toIso8601String(),
        "codDr": codDr,
        "tipoOperacion": tipoOperacion,
        "numeroTrabajador": numeroTrabajador,
        "chassisFoto": chassisFoto,
        "stowagePosition": stowagePosition,
        "damageInformation": damageInformation,
        "tercerosOperacion": tercerosOperacion,
        "companyName": companyName,
        "damageFound": damageFound,
        "damageOcurred": damageOcurred,
        "operation": operation,
        "cantidadDaños": cantidadDaos,
        "fotoVerificacion": fotoVerificacion,
        "lugarAccidente": lugarAccidente,
        "fechaAccidente": fechaAccidente!.toIso8601String(),
        "comentarios": comentarios,
        "codQr": codQr,
        "idServiceOrder": idServiceOrder,
        "idUsuarios": idUsuarios,
        "idApmtc": idApmtc,
        "idConductor": idConductor,
        "idVehicle": idVehicle,
      };
}
