import 'dart:convert';

List<RampaDescargaModel> rampaDescargaModelFromJson(String str) =>
    List<RampaDescargaModel>.from(
        json.decode(str).map((x) => RampaDescargaModel.fromJson(x)));

String rampaDescargaModelToJson(List<RampaDescargaModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RampaDescargaModel {
  RampaDescargaModel({
    this.idRampaDescarga,
    this.jornada,
    this.fecha,
    this.tipoImportacion,
    this.direccionamiento,
    this.numeroNivel,
    this.horaLectura,
    this.fechaCreacion,
    this.fechaUltimaModificacion,
    this.fechaEliminacion,
    this.usuarioCreacion,
    this.flagDelete,
    this.usuarioEliminacion,
    this.idServiceOrder,
    this.idUsuarios,
    this.idVehicle,
    this.idConductor,
  });

  int? idRampaDescarga;
  int? jornada;
  DateTime? fecha;
  String? tipoImportacion;
  String? direccionamiento;
  int? numeroNivel;
  DateTime? horaLectura;
  DateTime? fechaCreacion;
  DateTime? fechaUltimaModificacion;
  DateTime? fechaEliminacion;
  String? usuarioCreacion;
  String? flagDelete;
  String? usuarioEliminacion;
  int? idServiceOrder;
  int? idUsuarios;
  int? idVehicle;
  int? idConductor;

  factory RampaDescargaModel.fromJson(Map<String, dynamic> json) =>
      RampaDescargaModel(
        idRampaDescarga: json["idRampaDescarga"],
        jornada: json["jornada"],
        fecha: DateTime.parse(json["fecha"]),
        tipoImportacion: json["tipoImportacion"],
        direccionamiento: json["direccionamiento"],
        numeroNivel: json["numeroNivel"],
        horaLectura: DateTime.parse(json["horaLectura"]),
        fechaCreacion: DateTime.parse(json["fechaCreacion"]),
        fechaUltimaModificacion:
            DateTime.parse(json["fechaUltimaModificacion"]),
        fechaEliminacion: DateTime.parse(json["fechaEliminacion"]),
        usuarioCreacion: json["usuarioCreacion"],
        flagDelete: json["flagDelete"],
        usuarioEliminacion: json["usuarioEliminacion"],
        idServiceOrder: json["idServiceOrder"],
        idUsuarios: json["idUsuarios"],
        idVehicle: json["idVehicle"],
        idConductor: json["idConductor"],
      );

  Map<String, dynamic> toJson() => {
        "idRampaDescarga": idRampaDescarga,
        "jornada": jornada,
        "fecha": fecha?.toIso8601String() ?? '',
        "tipoImportacion": tipoImportacion,
        "direccionamiento": direccionamiento,
        "numeroNivel": numeroNivel,
        "horaLectura": horaLectura?.toIso8601String() ?? '',
        "fechaCreacion": fechaCreacion?.toIso8601String() ?? '',
        "fechaUltimaModificacion":
            fechaUltimaModificacion?.toIso8601String() ?? '',
        "fechaEliminacion": fechaEliminacion?.toIso8601String() ?? '',
        "usuarioCreacion": usuarioCreacion ?? '',
        "flagDelete": flagDelete ?? '',
        "usuarioEliminacion": usuarioEliminacion ?? '',
        "idServiceOrder": idServiceOrder ?? '',
        "idUsuarios": idUsuarios ?? '',
        "idVehicle": idVehicle ?? '',
        "idConductor": idConductor ?? '',
      };
}
