// To parse this JSON data, do
//
//     final vwTicketGranelPrecintosCarguio = vwTicketGranelPrecintosCarguioFromJson(jsonString);

import 'dart:convert';

List<VwTicketGranelPrecintosCarguio> vwTicketGranelPrecintosCarguioFromJson(
        String str) =>
    List<VwTicketGranelPrecintosCarguio>.from(json
        .decode(str)
        .map((x) => VwTicketGranelPrecintosCarguio.fromJson(x)));

String vwTicketGranelPrecintosCarguioToJson(
        List<VwTicketGranelPrecintosCarguio> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class VwTicketGranelPrecintosCarguio {
  int? idPrecinto;
  int? idCarguio;
  String? codigoPrecinto;
  String? tipoPrecinto;
  int? idServiceOrder;

  VwTicketGranelPrecintosCarguio({
    this.idPrecinto,
    this.idCarguio,
    this.codigoPrecinto,
    this.tipoPrecinto,
    this.idServiceOrder,
  });

  factory VwTicketGranelPrecintosCarguio.fromJson(Map<String, dynamic> json) =>
      VwTicketGranelPrecintosCarguio(
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
