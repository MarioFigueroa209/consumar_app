import 'dart:convert';
import 'dart:io';

SpDamageReportModel spDamageReportModelFromJson(String str) =>
    SpDamageReportModel.fromJson(json.decode(str));

String spDamageReportModelToJson(SpDamageReportModel data) =>
    json.encode(data.toJson());

class SpDamageReportModel {
  SpDamageReportModel({
    this.jornada,
    this.fecha,
    this.codDr,
    this.numeroTrabajador,
    this.chassisFoto,
    this.stowagePosition,
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

  int? jornada;
  DateTime? fecha;
  String? codDr;
  int? numeroTrabajador;
  String? chassisFoto;
  String? stowagePosition;
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

  factory SpDamageReportModel.fromJson(Map<String, dynamic> json) =>
      SpDamageReportModel(
        jornada: json["jornada"],
        fecha: DateTime.parse(json["fecha"]),
        codDr: json["codDr"],
        numeroTrabajador: json["numeroTrabajador"],
        chassisFoto: json["chassisFoto"],
        stowagePosition: json["stowagePosition"],
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
        "jornada": jornada,
        "fecha": fecha?.toIso8601String(),
        "codDr": codDr,
        "numeroTrabajador": numeroTrabajador,
        "chassisFoto": chassisFoto,
        "stowagePosition": stowagePosition,
        "damageFound": damageFound,
        "damageOcurred": damageOcurred,
        "operation": operation,
        "cantidadDaños": cantidadDaos,
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

DamageItem damageItemFromJson(String str) =>
    DamageItem.fromJson(json.decode(str));

String damageItemToJson(DamageItem data) => json.encode(data.toJson());

class DamageItem {
  DamageItem({
    //this.idDamageTypeRegister,
    this.codigoDao,
    this.daoRegistrado,
    this.cantidadDsMissing,
    this.descripcionFaltantes,
    this.parteVehiculo,
    this.zonaVehiculo,
    this.fotoDao,
    this.fotoViewDao,
    this.idDamageReport,
  });

  // int? idDamageTypeRegister;
  String? codigoDao;
  String? daoRegistrado;
  int? cantidadDsMissing;
  String? descripcionFaltantes;
  String? parteVehiculo;
  String? zonaVehiculo;
  String? fotoDao;
  File? fotoViewDao;
  int? idDamageReport;

  factory DamageItem.fromJson(Map<String, dynamic> json) => DamageItem(
        // idDamageTypeRegister: json["idDamageTypeRegister"],
        codigoDao: json["codigoDaño"],
        daoRegistrado: json["dañoRegistrado"],
        cantidadDsMissing: json["cantidadDsMissing"],
        descripcionFaltantes: json["descripcionFaltantes"],
        parteVehiculo: json["parteVehiculo"],
        zonaVehiculo: json["zonaVehiculo"],
        fotoDao: json["fotoDaño"],
        idDamageReport: json["idDamageReport"],
      );

  Map<String, dynamic> toJson() => {
        // "idDamageTypeRegister": idDamageTypeRegister,
        "codigoDaño": codigoDao,
        "dañoRegistrado": daoRegistrado,
        "cantidadDsMissing": cantidadDsMissing,
        "descripcionFaltantes": descripcionFaltantes,
        "parteVehiculo": parteVehiculo,
        "zonaVehiculo": zonaVehiculo,
        "fotoDaño": fotoDao,
        "idDamageReport": idDamageReport,
      };
}

class DamageTypeItems {
  DamageTypeItems({
    this.id,
    this.codigoDao,
    this.daoRegistrado,
    this.descripcionFaltantes,
    this.parteVehiculo,
    this.zonaVehiculo,
    this.fotoDao,
  });

  int? id;
  String? codigoDao;
  String? daoRegistrado;
  String? descripcionFaltantes;
  String? parteVehiculo;
  String? zonaVehiculo;
  File? fotoDao;
}

List<DamageReportInsertSqlLite> damageReportInsertSqlLiteFromJson(String str) =>
    List<DamageReportInsertSqlLite>.from(
        json.decode(str).map((x) => DamageReportInsertSqlLite.fromJson(x)));

String damageReportInsertSqlLiteToJson(List<DamageReportInsertSqlLite> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DamageReportInsertSqlLite {
  int? idServiceOrder;
  int? idVehiculo;
  String? chasis;
  String? marca;
  String? modelo;
  String? lineaNaviera;
  String? consigntario;
  String? billOfLeading;

  DamageReportInsertSqlLite({
    this.idServiceOrder,
    this.idVehiculo,
    this.chasis,
    this.marca,
    this.modelo,
    this.lineaNaviera,
    this.consigntario,
    this.billOfLeading,
  });

  factory DamageReportInsertSqlLite.fromJson(Map<String, dynamic> json) =>
      DamageReportInsertSqlLite(
        idServiceOrder: json["idServiceOrder"],
        idVehiculo: json["idVehiculo"],
        chasis: json["chasis"],
        marca: json["marca"],
        modelo: json["modelo"],
        lineaNaviera: json["lineaNaviera"],
        consigntario: json["consigntario"],
        billOfLeading: json["billOfLeading"],
      );

  Map<String, dynamic> toJson() => {
        "idServiceOrder": idServiceOrder,
        "idVehiculo": idVehiculo,
        "chasis": chasis,
        "marca": marca,
        "modelo": modelo,
        "lineaNaviera": lineaNaviera,
        "consigntario": consigntario,
        "billOfLeading": billOfLeading,
      };
}
