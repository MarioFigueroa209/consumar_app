// To parse this JSON data, do
//
//     final drAprobadoMasivoList = drAprobadoMasivoListFromJson(jsonString);

import 'dart:convert';

List<DrAprobadoMasivoList> drAprobadoMasivoListFromJson(String str) =>
    List<DrAprobadoMasivoList>.from(
        json.decode(str).map((x) => DrAprobadoMasivoList.fromJson(x)));

String drAprobadoMasivoListToJson(List<DrAprobadoMasivoList> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DrAprobadoMasivoList {
  DrAprobadoMasivoList({
    this.jornada,
    this.fecha,
    this.responsableNave,
    this.codigoResponsableNave,
    this.nombreResponsableNave,
    this.aprobadoCoordinador,
    this.aprobadoSupervisorApm,
    this.aprobadoResponsableNave,
    this.comentariosCoordinador,
    this.motivoRechazoCoordinador,
    this.comentariosSupervisor,
    this.motivoRechazoSupervisor,
    this.comentariosResponsableNave,
    this.motivoRechazoResponsableNave,
    this.idServiceOrder,
    this.idCoordinador,
    this.idSupervisor,
    this.idCodDr,
    this.imgFirmaResponsable,
    this.urlFirmaResponsable,
  });

  int? jornada;
  DateTime? fecha;
  String? responsableNave;
  String? codigoResponsableNave;
  String? nombreResponsableNave;
  String? aprobadoCoordinador;
  String? aprobadoSupervisorApm;
  String? aprobadoResponsableNave;
  String? comentariosCoordinador;
  String? motivoRechazoCoordinador;
  String? comentariosSupervisor;
  String? motivoRechazoSupervisor;
  String? comentariosResponsableNave;
  String? motivoRechazoResponsableNave;
  int? idServiceOrder;
  int? idCoordinador;
  int? idSupervisor;
  int? idCodDr;
  String? imgFirmaResponsable;
  String? urlFirmaResponsable;

  factory DrAprobadoMasivoList.fromJson(Map<String, dynamic> json) =>
      DrAprobadoMasivoList(
        jornada: json["jornada"],
        fecha: DateTime.parse(json["fecha"]),
        responsableNave: json["responsableNave"],
        codigoResponsableNave: json["codigoResponsableNave"],
        nombreResponsableNave: json["nombreResponsableNave"],
        aprobadoCoordinador: json["aprobadoCoordinador"],
        aprobadoSupervisorApm: json["aprobadoSupervisorApm"],
        aprobadoResponsableNave: json["aprobadoResponsableNave"],
        comentariosCoordinador: json["comentariosCoordinador"],
        motivoRechazoCoordinador: json["motivoRechazoCoordinador"],
        comentariosSupervisor: json["comentariosSupervisor"],
        motivoRechazoSupervisor: json["motivoRechazoSupervisor"],
        comentariosResponsableNave: json["comentariosResponsableNave"],
        motivoRechazoResponsableNave: json["motivoRechazoResponsableNave"],
        idServiceOrder: json["idServiceOrder"],
        idCoordinador: json["idCoordinador"],
        idSupervisor: json["idSupervisor"],
        idCodDr: json["idCodDr"],
        imgFirmaResponsable: json["imgFirmaResponsable"],
        urlFirmaResponsable: json["urlFirmaResponsable"],
      );

  Map<String, dynamic> toJson() => {
        "jornada": jornada,
        "fecha": fecha!.toIso8601String(),
        "responsableNave": responsableNave,
        "codigoResponsableNave": codigoResponsableNave,
        "nombreResponsableNave": nombreResponsableNave,
        "aprobadoCoordinador": aprobadoCoordinador,
        "aprobadoSupervisorApm": aprobadoSupervisorApm,
        "aprobadoResponsableNave": aprobadoResponsableNave,
        "comentariosCoordinador": comentariosCoordinador,
        "motivoRechazoCoordinador": motivoRechazoCoordinador,
        "comentariosSupervisor": comentariosSupervisor,
        "motivoRechazoSupervisor": motivoRechazoSupervisor,
        "comentariosResponsableNave": comentariosResponsableNave,
        "motivoRechazoResponsableNave": motivoRechazoResponsableNave,
        "idServiceOrder": idServiceOrder,
        "idCoordinador": idCoordinador,
        "idSupervisor": idSupervisor,
        "idCodDr": idCodDr,
        "imgFirmaResponsable": imgFirmaResponsable,
        "urlFirmaResponsable": urlFirmaResponsable,
      };
}
