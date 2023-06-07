// To parse this JSON data, do
//
//     final vwAllServiceOrder = vwAllServiceOrderFromJson(jsonString);

import 'dart:convert';

List<VwAllServiceOrderGranel> vwAllServiceOrderGranelFromJson(String str) =>
    List<VwAllServiceOrderGranel>.from(
        json.decode(str).map((x) => VwAllServiceOrderGranel.fromJson(x)));

String vwAllServiceOrderGranelToJson(List<VwAllServiceOrderGranel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class VwAllServiceOrderGranel {
  VwAllServiceOrderGranel({
    this.idServiceOrder,
    this.serviceOrder,
  });

  int? idServiceOrder;
  String? serviceOrder;

  factory VwAllServiceOrderGranel.fromJson(Map<String, dynamic> json) =>
      VwAllServiceOrderGranel(
        idServiceOrder: json["idServiceOrder"],
        serviceOrder: json["serviceOrder"],
      );

  Map<String, dynamic> toJson() => {
        "idServiceOrder": idServiceOrder,
        "serviceOrder": serviceOrder,
      };
}
