class SpCreateDetalleAccesorio {
  SpCreateDetalleAccesorio({
    this.pdfUrl,
    this.idServiceOrder,
    this.idVehicle,
    this.idUsuarios,
  });

  String? pdfUrl;
  int? idServiceOrder;
  int? idVehicle;
  int? idUsuarios;

  factory SpCreateDetalleAccesorio.fromJson(Map<String, dynamic> json) =>
      SpCreateDetalleAccesorio(
        pdfUrl: json["pdfUrl"],
        idServiceOrder: json["idServiceOrder"],
        idVehicle: json["idVehicle"],
        idUsuarios: json["idUsuarios"],
      );

  Map<String, dynamic> toJson() => {
        "pdfUrl": pdfUrl,
        "idServiceOrder": idServiceOrder,
        "idVehicle": idVehicle,
        "idUsuarios": idUsuarios,
      };
}
