class MpObservadoFoto {
  MpObservadoFoto({
    this.mpUrlFoto,
    this.idMonitoreoProducto,
  });

  String? mpUrlFoto;
  int? idMonitoreoProducto;

  factory MpObservadoFoto.fromJson(Map<String, dynamic> json) =>
      MpObservadoFoto(
        mpUrlFoto: json["mp_url_foto"],
        idMonitoreoProducto: json["id_monitoreo_producto"],
      );

  Map<String, dynamic> toJson() => {
        "mp_url_foto": mpUrlFoto,
        "id_monitoreo_producto": idMonitoreoProducto,
      };
}
