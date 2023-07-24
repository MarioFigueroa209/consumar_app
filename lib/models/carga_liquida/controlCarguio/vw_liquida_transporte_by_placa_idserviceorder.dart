// To parse this JSON data, do
//
//     final vwLiquidaTransporteByPlacaIdserviceorder = vwLiquidaTransporteByPlacaIdserviceorderFromJson(jsonString);

import 'dart:convert';

List<VwLiquidaTransporteByPlacaIdserviceorder>
    vwLiquidaTransporteByPlacaIdserviceorderFromJson(String str) =>
        List<VwLiquidaTransporteByPlacaIdserviceorder>.from(json
            .decode(str)
            .map((x) => VwLiquidaTransporteByPlacaIdserviceorder.fromJson(x)));

String vwLiquidaTransporteByPlacaIdserviceorderToJson(
        List<VwLiquidaTransporteByPlacaIdserviceorder> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class VwLiquidaTransporteByPlacaIdserviceorder {
  int? idTransporte;
  String? placa;
  String? empresaTransporte;
  String? ruc;
  int? idServiceOrder;

  VwLiquidaTransporteByPlacaIdserviceorder({
    this.idTransporte,
    this.placa,
    this.empresaTransporte,
    this.ruc,
    this.idServiceOrder,
  });

  factory VwLiquidaTransporteByPlacaIdserviceorder.fromJson(
          Map<String, dynamic> json) =>
      VwLiquidaTransporteByPlacaIdserviceorder(
        idTransporte: json["idTransporte"],
        placa: json["placa"],
        empresaTransporte: json["empresaTransporte"],
        ruc: json["ruc"],
        idServiceOrder: json["idServiceOrder"],
      );

  Map<String, dynamic> toJson() => {
        "idTransporte": idTransporte,
        "placa": placa,
        "empresaTransporte": empresaTransporte,
        "ruc": ruc,
        "idServiceOrder": idServiceOrder,
      };
}
