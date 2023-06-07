class SpCreateDetalleAccesorioItem {
  SpCreateDetalleAccesorioItem({
    this.descripcion,
    this.fotoDescripcion,
    this.urlFotoDescripcion,
    this.idDetalleAccesorio,
  });

  String? descripcion;
  String? fotoDescripcion;
  String? urlFotoDescripcion;
  int? idDetalleAccesorio;

  factory SpCreateDetalleAccesorioItem.fromJson(Map<String, dynamic> json) =>
      SpCreateDetalleAccesorioItem(
        descripcion: json["descripcion"],
        fotoDescripcion: json["fotoDescripcion"],
        urlFotoDescripcion: json["urlFotoDescripcion"],
        idDetalleAccesorio: json["idDetalleAccesorio"],
      );

  Map<String, dynamic> toJson() => {
        "descripcion": descripcion,
        "fotoDescripcion": fotoDescripcion,
        "urlFotoDescripcion": urlFotoDescripcion,
        "idDetalleAccesorio": idDetalleAccesorio,
      };
}
