import 'dart:convert';

List<SpCreatePrinterAppList> spCreatePrinterAppListFromJson(String str) =>
    List<SpCreatePrinterAppList>.from(
        json.decode(str).map((x) => SpCreatePrinterAppList.fromJson(x)));

String spCreatePrinterAppListToJson(List<SpCreatePrinterAppList> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SpCreatePrinterAppList {
  SpCreatePrinterAppList({
    this.jornada,
    this.fecha,
    this.estado,
    this.idVehicle,
    this.idServiceOrder,
    this.idUsuarios,
  });

  int? jornada;
  DateTime? fecha;
  String? estado;
  int? idVehicle;
  int? idServiceOrder;
  int? idUsuarios;

  factory SpCreatePrinterAppList.fromJson(Map<String, dynamic> json) =>
      SpCreatePrinterAppList(
        jornada: json["jornada"],
        fecha: DateTime.parse(json["fecha"]),
        estado: json["estado"],
        idVehicle: json["idVehicle"],
        idServiceOrder: json["idServiceOrder"],
        idUsuarios: json["idUsuarios"],
      );

  Map<String, dynamic> toJson() => {
        "jornada": jornada,
        "fecha": fecha!.toIso8601String(),
        "estado": estado,
        "idVehicle": idVehicle,
        "idServiceOrder": idServiceOrder,
        "idUsuarios": idUsuarios,
      };
}
