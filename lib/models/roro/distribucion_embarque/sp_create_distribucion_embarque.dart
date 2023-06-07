import 'dart:convert';

List<SpCreateDistribucionEmbarque> spCreateDistribucionEmbarqueFromJson(
        String str) =>
    List<SpCreateDistribucionEmbarque>.from(
        json.decode(str).map((x) => SpCreateDistribucionEmbarque.fromJson(x)));

String spCreateDistribucionEmbarqueToJson(
        List<SpCreateDistribucionEmbarque> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SpCreateDistribucionEmbarque {
  SpCreateDistribucionEmbarque({
    this.jornada,
    this.fecha,
    this.nivel,
    this.idServiceOrder,
    this.idUsuarios,
    this.idVehicle,
  });

  int? jornada;
  DateTime? fecha;
  String? nivel;
  int? idServiceOrder;
  int? idUsuarios;
  int? idVehicle;

  factory SpCreateDistribucionEmbarque.fromJson(Map<String, dynamic> json) =>
      SpCreateDistribucionEmbarque(
        jornada: json["jornada"],
        fecha: DateTime.parse(json["fecha"]),
        nivel: json["nivel"],
        idServiceOrder: json["idServiceOrder"],
        idUsuarios: json["idUsuarios"],
        idVehicle: json["idVehicle"],
      );

  Map<String, dynamic> toJson() => {
        "jornada": jornada,
        "fecha": fecha!.toIso8601String(),
        "nivel": nivel,
        "idServiceOrder": idServiceOrder,
        "idUsuarios": idUsuarios,
        "idVehicle": idVehicle,
      };
}
