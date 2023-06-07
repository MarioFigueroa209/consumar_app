import 'dart:convert';

List<CreateSqlLitePrinterApp> createSqlLitePrinterAppFromJson(String str) =>
    List<CreateSqlLitePrinterApp>.from(
        json.decode(str).map((x) => CreateSqlLitePrinterApp.fromJson(x)));

String createSqlLitePrinterAppToJson(List<CreateSqlLitePrinterApp> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CreateSqlLitePrinterApp {
  CreateSqlLitePrinterApp({
    this.idPrEtiquetados,
    this.jornada,
    this.estado,
    this.chasis,
    this.marca,
    this.modelo,
    this.detalle,
    this.idVehicle,
    this.idServiceOrder,
    this.idUsuarios,
  });

  int? idPrEtiquetados;
  int? jornada;
  String? estado;
  String? chasis;
  String? marca;
  String? modelo;
  String? detalle;
  int? idVehicle;
  int? idServiceOrder;
  int? idUsuarios;

  factory CreateSqlLitePrinterApp.fromJson(Map<String, dynamic> json) =>
      CreateSqlLitePrinterApp(
        idPrEtiquetados: json["idPrEtiquetados"],
        jornada: json["jornada"],
        estado: json["estado"],
        chasis: json["chasis"],
        marca: json["marca"],
        modelo: json["modelo"],
        detalle: json["detalle"],
        idVehicle: json["idVehicle"],
        idServiceOrder: json["idOrdenServicio"],
        idUsuarios: json["idUsuario"],
      );

  Map<String, dynamic> toJson() => {
        "idPrEtiquetados": idPrEtiquetados,
        "jornada": jornada,
        "estado": estado,
        "chasis": chasis,
        "marca": marca,
        "modelo": modelo,
        "detalle": detalle,
        "idVehicle": idVehicle,
        "idOrdenServicio": idServiceOrder,
        "idUsuario": idUsuarios,
      };
}
