// To parse this JSON data, do
//
//     final createSilosControlTicket = createSilosControlTicketFromJson(jsonString);

import 'dart:convert';

CreateSilosControlTicket createSilosControlTicketFromJson(String str) =>
    CreateSilosControlTicket.fromJson(json.decode(str));

String createSilosControlTicketToJson(CreateSilosControlTicket data) =>
    json.encode(data.toJson());

class CreateSilosControlTicket {
  String? ticketApm;
  String? nave;
  String? bl;
  String? subBl;
  String? createSilosControlTicketDo;
  String? dam;
  String? importador;
  String? producto;
  String? transportista;
  String? manifiesto;
  String? ubicacionCarga;
  DateTime? fecha;
  int? jornada;
  int? idTransporte;
  int? idUsuarios;
  int? idServiceOrder;

  CreateSilosControlTicket({
    this.ticketApm,
    this.nave,
    this.bl,
    this.subBl,
    this.createSilosControlTicketDo,
    this.dam,
    this.importador,
    this.producto,
    this.transportista,
    this.manifiesto,
    this.ubicacionCarga,
    this.fecha,
    this.jornada,
    this.idTransporte,
    this.idUsuarios,
    this.idServiceOrder,
  });

  factory CreateSilosControlTicket.fromJson(Map<String, dynamic> json) =>
      CreateSilosControlTicket(
        ticketApm: json["ticketApm"],
        nave: json["nave"],
        bl: json["bl"],
        subBl: json["subBl"],
        createSilosControlTicketDo: json["do"],
        dam: json["dam"],
        importador: json["importador"],
        producto: json["producto"],
        transportista: json["transportista"],
        manifiesto: json["manifiesto"],
        ubicacionCarga: json["ubicacionCarga"],
        fecha: DateTime.parse(json["fecha"]),
        jornada: json["jornada"],
        idTransporte: json["idTransporte"],
        idUsuarios: json["idUsuarios"],
        idServiceOrder: json["idServiceOrder"],
      );

  Map<String, dynamic> toJson() => {
        "ticketApm": ticketApm,
        "nave": nave,
        "bl": bl,
        "subBl": subBl,
        "do": createSilosControlTicketDo,
        "dam": dam,
        "importador": importador,
        "producto": producto,
        "transportista": transportista,
        "manifiesto": manifiesto,
        "ubicacionCarga": ubicacionCarga,
        "fecha": fecha!.toIso8601String(),
        "jornada": jornada,
        "idTransporte": idTransporte,
        "idUsuarios": idUsuarios,
        "idServiceOrder": idServiceOrder,
      };
}
