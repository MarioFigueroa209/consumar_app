// To parse this JSON data, do
//
//     final vwGetDamageReportItemModel = vwGetDamageReportItemModelFromJson(jsonString);

import 'dart:convert';

VwGetDamageReportItemModel vwGetDamageReportItemModelFromJson(String str) =>
    VwGetDamageReportItemModel.fromJson(json.decode(str));

String vwGetDamageReportItemModelToJson(VwGetDamageReportItemModel data) =>
    json.encode(data.toJson());

class VwGetDamageReportItemModel {
  VwGetDamageReportItemModel({
    this.idDamageReport,
    this.fecha,
    this.fotoChasis,
    this.idVehivle,
    this.codDr,
    this.nave,
    this.puerto,
    this.numeroViaje,
    this.lineaNaviera,
    this.damageFound,
    this.damageOcurred,
    this.operation,
    this.posicionEstibador,
    this.puertoAterrizaje,
    this.puertoDestino,
    this.marca,
    this.modelo,
    this.chasis,
    this.nombreResponsableNave,
    this.firmaResponsable,
    this.aprobadoCoordinador,
    this.aprobadoApmtc,
    this.aprobadoResponsableNave,
    this.agenciaMaritica,
    this.consigntario,
    this.billOfLeading,
    this.idUsuario,
    this.idApmtc,
    this.idConductor,
    this.nombreUsuarioCoordinador,
    this.nombreUsuarioApmtc,
    this.nombreConductor,
    this.lugarAccidente,
    this.fechaHoraAccidente,
  });

  int? idDamageReport;
  DateTime? fecha;
  String? fotoChasis;
  int? idVehivle;
  String? codDr;
  String? nave;
  String? puerto;
  String? numeroViaje;
  String? lineaNaviera;
  String? damageFound;
  String? damageOcurred;
  String? operation;
  String? posicionEstibador;
  String? puertoAterrizaje;
  String? puertoDestino;
  String? marca;
  String? modelo;
  String? chasis;
  String? nombreResponsableNave;
  String? firmaResponsable;
  String? aprobadoCoordinador;
  String? aprobadoApmtc;
  String? aprobadoResponsableNave;
  String? agenciaMaritica;
  String? consigntario;
  String? billOfLeading;
  int? idUsuario;
  int? idApmtc;
  int? idConductor;
  String? nombreUsuarioCoordinador;
  String? nombreUsuarioApmtc;
  String? nombreConductor;
  String? lugarAccidente;
  DateTime? fechaHoraAccidente;

  factory VwGetDamageReportItemModel.fromJson(Map<String, dynamic> json) =>
      VwGetDamageReportItemModel(
        idDamageReport: json["idDamageReport"],
        fecha: DateTime.parse(json["fecha"]),
        fotoChasis: json["fotoChasis"],
        idVehivle: json["idVehivle"],
        codDr: json["codDr"],
        nave: json["nave"],
        puerto: json["puerto"],
        numeroViaje: json["numeroViaje"],
        lineaNaviera: json["lineaNaviera"],
        damageFound: json["damageFound"],
        damageOcurred: json["damageOcurred"],
        operation: json["operation"],
        posicionEstibador: json["posicionEstibador"],
        puertoAterrizaje: json["puertoAterrizaje"],
        puertoDestino: json["puertoDestino"],
        marca: json["marca"],
        modelo: json["modelo"],
        chasis: json["chasis"],
        nombreResponsableNave: json["nombreResponsableNave"],
        firmaResponsable: json["firmaResponsable"],
        aprobadoCoordinador: json["aprobadoCoordinador"],
        aprobadoApmtc: json["aprobadoApmtc"],
        aprobadoResponsableNave: json["aprobadoResponsableNave"],
        agenciaMaritica: json["agenciaMaritica"],
        consigntario: json["consigntario"],
        billOfLeading: json["billOfLeading"],
        idUsuario: json["idUsuario"],
        idApmtc: json["idApmtc"],
        idConductor: json["idConductor"],
        nombreUsuarioCoordinador: json["nombreUsuarioCoordinador"],
        nombreUsuarioApmtc: json["nombreUsuarioApmtc"],
        nombreConductor: json["nombreConductor"],
        lugarAccidente: json["lugarAccidente"],
        fechaHoraAccidente: DateTime.parse(json["fechaHoraAccidente"]),
      );

  Map<String, dynamic> toJson() => {
        "idDamageReport": idDamageReport,
        "fecha": fecha!.toIso8601String(),
        "fotoChasis": fotoChasis,
        "idVehivle": idVehivle,
        "codDr": codDr,
        "nave": nave,
        "puerto": puerto,
        "numeroViaje": numeroViaje,
        "lineaNaviera": lineaNaviera,
        "damageFound": damageFound,
        "damageOcurred": damageOcurred,
        "operation": operation,
        "posicionEstibador": posicionEstibador,
        "puertoAterrizaje": puertoAterrizaje,
        "puertoDestino": puertoDestino,
        "marca": marca,
        "modelo": modelo,
        "chasis": chasis,
        "nombreResponsableNave": nombreResponsableNave,
        "firmaResponsable": firmaResponsable,
        "aprobadoCoordinador": aprobadoCoordinador,
        "aprobadoApmtc": aprobadoApmtc,
        "aprobadoResponsableNave": aprobadoResponsableNave,
        "agenciaMaritica": agenciaMaritica,
        "consigntario": consigntario,
        "billOfLeading": billOfLeading,
        "idUsuario": idUsuario,
        "idApmtc": idApmtc,
        "idConductor": idConductor,
        "nombreUsuarioCoordinador": nombreUsuarioCoordinador,
        "nombreUsuarioApmtc": nombreUsuarioApmtc,
        "nombreConductor": nombreConductor,
        "lugarAccidente": lugarAccidente,
        "fechaHoraAccidente": fechaHoraAccidente!.toIso8601String(),
      };
}
