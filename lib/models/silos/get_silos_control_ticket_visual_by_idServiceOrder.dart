// To parse this JSON data, do
//
//     final getSilosControlTicketVisualByIdServiceOrder = getSilosControlTicketVisualByIdServiceOrderFromJson(jsonString);

import 'dart:convert';

List<GetSilosControlTicketVisualByIdServiceOrder>
    getSilosControlTicketVisualByIdServiceOrderFromJson(String str) =>
        List<GetSilosControlTicketVisualByIdServiceOrder>.from(json
            .decode(str)
            .map((x) =>
                GetSilosControlTicketVisualByIdServiceOrder.fromJson(x)));

String getSilosControlTicketVisualByIdServiceOrderToJson(
        List<GetSilosControlTicketVisualByIdServiceOrder> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetSilosControlTicketVisualByIdServiceOrder {
  int? idTransporteContrTicket;
  int? idTransporteContrVisual;
  String? placa;
  String? ticketApm;
  String? bl;
  String? empresaTransporte;
  int? idServiceOrder;

  GetSilosControlTicketVisualByIdServiceOrder({
    this.idTransporteContrTicket,
    this.idTransporteContrVisual,
    this.placa,
    this.ticketApm,
    this.bl,
    this.empresaTransporte,
    this.idServiceOrder,
  });

  factory GetSilosControlTicketVisualByIdServiceOrder.fromJson(
          Map<String, dynamic> json) =>
      GetSilosControlTicketVisualByIdServiceOrder(
        idTransporteContrTicket: json["idTransporteContrTicket"],
        idTransporteContrVisual: json["idTransporteContrVisual"],
        placa: json["placa"],
        ticketApm: json["ticketApm"],
        bl: json["bl"],
        empresaTransporte: json["empresaTransporte"],
        idServiceOrder: json["idServiceOrder"],
      );

  Map<String, dynamic> toJson() => {
        "idTransporteContrTicket": idTransporteContrTicket,
        "idTransporteContrVisual": idTransporteContrVisual,
        "placa": placa,
        "ticketApm": ticketApm,
        "bl": bl,
        "empresaTransporte": empresaTransporte,
        "idServiceOrder": idServiceOrder,
      };
}
