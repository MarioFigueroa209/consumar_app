import 'dart:convert';

List<VwDetalleAccesorioItemList> vwDetalleAccesorioItemListFromJson(
        String str) =>
    List<VwDetalleAccesorioItemList>.from(
        json.decode(str).map((x) => VwDetalleAccesorioItemList.fromJson(x)));

String vwDetalleAccesorioItemListToJson(
        List<VwDetalleAccesorioItemList> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class VwDetalleAccesorioItemList {
  VwDetalleAccesorioItemList({
    this.idVista,
    this.idDetalleAccesorio,
    this.descripcion,
    this.urlFoto,
    this.fotoDescripcion,
  });

  int? idVista;
  int? idDetalleAccesorio;
  String? descripcion;
  String? urlFoto;
  String? fotoDescripcion;

  factory VwDetalleAccesorioItemList.fromJson(Map<String, dynamic> json) =>
      VwDetalleAccesorioItemList(
        idVista: json["idVista"],
        idDetalleAccesorio: json["idDetalleAccesorio"],
        descripcion: json["descripcion"],
        urlFoto: json["urlFoto"],
        fotoDescripcion: json["fotoDescripcion"],
      );

  Map<String, dynamic> toJson() => {
        "idVista": idVista,
        "idDetalleAccesorio": idDetalleAccesorio,
        "descripcion": descripcion,
        "urlFoto": urlFoto,
        "fotoDescripcion": fotoDescripcion,
      };
}
