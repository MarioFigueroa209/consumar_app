// To parse this JSON data, do
//
//     final damageReportListSqlLite = damageReportListSqlLiteFromJson(jsonString);

import 'dart:convert';

DamageReportListSqlLite damageReportListSqlLiteFromJson(String str) =>
    DamageReportListSqlLite.fromJson(json.decode(str));

String damageReportListSqlLiteToJson(DamageReportListSqlLite data) =>
    json.encode(data.toJson());

class DamageReportListSqlLite {
  DamageReportListSqlLite({
    this.idDamageReport,
    this.jornada,
    this.fecha,
    this.codDr,
    this.tipoOperacion,
    this.chasis,
    this.marca,
    this.numeroTrabajador,
    this.chassisFoto,
    this.stowagePosition,
    this.damageInformation,
    this.tercerosOperacion,
    this.companyName,
    this.damageFound,
    this.damageOcurred,
    this.operation,
    this.cantidadDanos,
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

  int? idDamageReport;
  int? jornada;
  DateTime? fecha;
  String? codDr;
  String? tipoOperacion;
  String? chasis;
  String? marca;
  int? numeroTrabajador;
  String? chassisFoto;
  String? stowagePosition;
  String? damageInformation;
  String? tercerosOperacion;
  String? companyName;
  String? damageFound;
  String? damageOcurred;
  String? operation;
  int? cantidadDanos;
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

  factory DamageReportListSqlLite.fromJson(Map<String, dynamic> json) =>
      DamageReportListSqlLite(
        idDamageReport: json["idDamageReport"],
        jornada: json["jornada"],
        fecha: DateTime.parse(json["fecha"]),
        codDr: json["codDr"],
        tipoOperacion: json["tipoOperacion"],
        chasis: json["chasis"],
        marca: json["marca"],
        numeroTrabajador: json["numeroTrabajador"],
        chassisFoto: json["chassisFoto"],
        stowagePosition: json["stowagePosition"],
        damageInformation: json["damageInformation"],
        tercerosOperacion: json["tercerosOperacion"],
        companyName: json["companyName"],
        damageFound: json["damageFound"],
        damageOcurred: json["damageOcurred"],
        operation: json["operation"],
        cantidadDanos: json["cantidadDanos"],
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
        "fecha": fecha?.toIso8601String(),
        "codDr": codDr,
        "tipoOperacion": tipoOperacion,
        "chasis": chasis,
        "marca": marca,
        "numeroTrabajador": numeroTrabajador,
        "chassisFoto": chassisFoto,
        "stowagePosition": stowagePosition,
        "damageInformation": damageInformation,
        "tercerosOperacion": tercerosOperacion,
        "companyName": companyName,
        "damageFound": damageFound,
        "damageOcurred": damageOcurred,
        "operation": operation,
        "cantidadDanos": cantidadDanos,
        "fotoVerificacion": fotoVerificacion,
        "lugarAccidente": lugarAccidente,
        "fechaAccidente": fechaAccidente?.toIso8601String(),
        "comentarios": comentarios,
        "codQr": codQr,
        "idServiceOrder": idServiceOrder,
        "idUsuarios": idUsuarios,
        "idApmtc": idApmtc,
        "idConductor": idConductor,
        "idVehicle": idVehicle,
      };
}
