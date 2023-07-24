// To parse this JSON data, do
//
//     final vwListLiquidaPlacasInicioCarguioIdserviceorder = vwListLiquidaPlacasInicioCarguioIdserviceorderFromJson(jsonString);

import 'dart:convert';

List<VwListLiquidaPlacasInicioCarguioIdserviceorder>
    vwListLiquidaPlacasInicioCarguioIdserviceorderFromJson(String str) =>
        List<VwListLiquidaPlacasInicioCarguioIdserviceorder>.from(json
            .decode(str)
            .map((x) =>
                VwListLiquidaPlacasInicioCarguioIdserviceorder.fromJson(x)));

String vwListLiquidaPlacasInicioCarguioIdserviceorderToJson(
        List<VwListLiquidaPlacasInicioCarguioIdserviceorder> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class VwListLiquidaPlacasInicioCarguioIdserviceorder {
  String? placa;
  int? idCarguio;
  int? idServiceOrder;

  VwListLiquidaPlacasInicioCarguioIdserviceorder({
    this.placa,
    this.idCarguio,
    this.idServiceOrder,
  });

  factory VwListLiquidaPlacasInicioCarguioIdserviceorder.fromJson(
          Map<String, dynamic> json) =>
      VwListLiquidaPlacasInicioCarguioIdserviceorder(
        placa: json["placa"],
        idCarguio: json["idCarguio"],
        idServiceOrder: json["idServiceOrder"],
      );

  Map<String, dynamic> toJson() => {
        "placa": placa,
        "idCarguio": idCarguio,
        "idServiceOrder": idServiceOrder,
      };
}
