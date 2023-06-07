class MonitoreoProductoSqlLiteModel {
  MonitoreoProductoSqlLiteModel({
    this.idMonitoreoProducto,
    this.jornada,
    this.fecha,
    this.inspeccionFito,
    this.bodega,
    this.humedad,
    this.tempEstProa,
    this.tempEstPopa,
    this.tempCentro,
    this.tempBaborProa,
    this.tempBaborPopa,
    this.cantidadDanos,
    this.descripcion,
    this.idServiceOrder,
    this.idUsuarios,
  });

  int? idMonitoreoProducto;
  int? jornada;
  DateTime? fecha;
  String? inspeccionFito;
  String? bodega;
  double? humedad;
  double? tempEstProa;
  double? tempEstPopa;
  double? tempCentro;
  double? tempBaborProa;
  double? tempBaborPopa;
  double? cantidadDanos;
  String? descripcion;
  int? idServiceOrder;
  int? idUsuarios;

  factory MonitoreoProductoSqlLiteModel.fromJson(Map<String, dynamic> json) =>
      MonitoreoProductoSqlLiteModel(
        idMonitoreoProducto: json["id_monitoreo_producto"],
        jornada: json["jornada"],
        fecha: DateTime.parse(json["fecha"]),
        inspeccionFito: json["inspeccion_fito"],
        bodega: json["bodega"],
        humedad: json["humedad"].toDouble(),
        tempEstProa: json["temp_est_proa"].toDouble(),
        tempEstPopa: json["temp_est_popa"].toDouble(),
        tempCentro: json["temp_centro"].toDouble(),
        tempBaborProa: json["temp_babor_proa"].toDouble(),
        tempBaborPopa: json["temp_babor_popa"].toDouble(),
        cantidadDanos: json["cantidad_danos"].toDouble(),
        descripcion: json["descripcion"],
        idServiceOrder: json["idServiceOrder"],
        idUsuarios: json["idUsuarios"],
      );

  Map<String, dynamic> toJson() => {
        "id_monitoreo_producto": idMonitoreoProducto,
        "jornada": jornada,
        "fecha": fecha?.toIso8601String(),
        "inspeccion_fito": inspeccionFito,
        "bodega": bodega,
        "humedad": humedad,
        "temp_est_proa": tempEstProa,
        "temp_est_popa": tempEstPopa,
        "temp_centro": tempCentro,
        "temp_babor_proa": tempBaborProa,
        "temp_babor_popa": tempBaborPopa,
        "cantidad_danos": cantidadDanos,
        "descripcion": descripcion,
        "idServiceOrder": idServiceOrder,
        "idUsuarios": idUsuarios,
      };
}
