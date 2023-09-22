// To parse this JSON data, do
//
//     final vwTicketLiquidaPrecintosCarguio = vwTicketLiquidaPrecintosCarguioFromJson(jsonString);

import 'dart:convert';

List<VwTicketLiquidaPrecintosCarguio> vwTicketLiquidaPrecintosCarguioFromJson(
        String str) =>
    List<VwTicketLiquidaPrecintosCarguio>.from(json
        .decode(str)
        .map((x) => VwTicketLiquidaPrecintosCarguio.fromJson(x)));

String vwTicketLiquidaPrecintosCarguioToJson(
        List<VwTicketLiquidaPrecintosCarguio> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class VwTicketLiquidaPrecintosCarguio {
  int? idPrecinto;
  int? idCarguio;
  String? codigoPrecinto;
  String? tipoPrecinto;
  int? idServiceOrder;

  VwTicketLiquidaPrecintosCarguio({
    this.idPrecinto,
    this.idCarguio,
    this.codigoPrecinto,
    this.tipoPrecinto,
    this.idServiceOrder,
  });

  factory VwTicketLiquidaPrecintosCarguio.fromJson(Map<String, dynamic> json) =>
      VwTicketLiquidaPrecintosCarguio(
        idPrecinto: json["idPrecinto"],
        idCarguio: json["idCarguio"],
        codigoPrecinto: json["codigoPrecinto"],
        tipoPrecinto: json["tipoPrecinto"],
        idServiceOrder: json["idServiceOrder"],
      );

  Map<String, dynamic> toJson() => {
        "idPrecinto": idPrecinto,
        "idCarguio": idCarguio,
        "codigoPrecinto": codigoPrecinto,
        "tipoPrecinto": tipoPrecinto,
        "idServiceOrder": idServiceOrder,
      };
}
