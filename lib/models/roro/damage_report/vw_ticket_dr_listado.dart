// To parse this JSON data, do
//
//     final vwTicketDrListado = vwTicketDrListadoFromJson(jsonString);

import 'dart:convert';

List<VwTicketDrListado> vwTicketDrListadoFromJson(String str) =>
    List<VwTicketDrListado>.from(
        json.decode(str).map((x) => VwTicketDrListado.fromJson(x)));

String vwTicketDrListadoToJson(List<VwTicketDrListado> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class VwTicketDrListado {
  VwTicketDrListado({
    this.idVista,
    this.idDamageReportList,
    this.codDr,
    this.nombreNave,
    this.puerto,
    this.bl,
    this.chasis,
    this.cantidadDanos,
    this.aprobadoResponsableNave,
    this.idServiceOrder,
  });

  int? idVista;
  int? idDamageReportList;
  String? codDr;
  String? nombreNave;
  String? puerto;
  String? bl;
  String? chasis;
  int? cantidadDanos;
  String? aprobadoResponsableNave;
  int? idServiceOrder;

  factory VwTicketDrListado.fromJson(Map<String, dynamic> json) =>
      VwTicketDrListado(
        idVista: json["idVista"],
        idDamageReportList: json["idDamageReportList"],
        codDr: json["codDr"],
        nombreNave: json["nombreNave"],
        puerto: json["puerto"],
        bl: json["bl"],
        chasis: json["chasis"],
        cantidadDanos: json["cantidadDanos"],
        aprobadoResponsableNave: json["aprobadoResponsableNave"],
        idServiceOrder: json["idServiceOrder"],
      );

  Map<String, dynamic> toJson() => {
        "idVista": idVista,
        "idDamageReportList": idDamageReportList,
        "codDr": codDr,
        "nombreNave": nombreNave,
        "puerto": puerto,
        "bl": bl,
        "chasis": chasis,
        "cantidadDanos": cantidadDanos,
        "aprobadoResponsableNave": aprobadoResponsableNave,
        "idServiceOrder": idServiceOrder,
      };
}
