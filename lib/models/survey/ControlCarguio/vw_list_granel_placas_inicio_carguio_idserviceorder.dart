// To parse this JSON data, do
//
//     final vwListGranelPlacasInicioCarguioIdserviceorder = vwListGranelPlacasInicioCarguioIdserviceorderFromJson(jsonString);

import 'dart:convert';

List<VwListGranelPlacasInicioCarguioIdserviceorder>
    vwListGranelPlacasInicioCarguioIdserviceorderFromJson(String str) =>
        List<VwListGranelPlacasInicioCarguioIdserviceorder>.from(json
            .decode(str)
            .map((x) =>
                VwListGranelPlacasInicioCarguioIdserviceorder.fromJson(x)));

String vwListGranelPlacasInicioCarguioIdserviceorderToJson(
        List<VwListGranelPlacasInicioCarguioIdserviceorder> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class VwListGranelPlacasInicioCarguioIdserviceorder {
  String? placa;
  int? idCarguio;
  int? idServiceOrder;

  VwListGranelPlacasInicioCarguioIdserviceorder({
    this.placa,
    this.idCarguio,
    this.idServiceOrder,
  });

  factory VwListGranelPlacasInicioCarguioIdserviceorder.fromJson(
          Map<String, dynamic> json) =>
      VwListGranelPlacasInicioCarguioIdserviceorder(
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
