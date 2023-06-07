class SpDamageType {
  SpDamageType({
    this.codigoDano,
    this.danoRegistrado,
    this.descripcionFaltantes,
    this.parteVehiculo,
    this.zonaVehiculo,
    this.fotoDano,
    this.idDamageReport,
  });

  String? codigoDano;
  String? danoRegistrado;
  String? descripcionFaltantes;
  String? parteVehiculo;
  String? zonaVehiculo;
  String? fotoDano;
  int? idDamageReport;

  factory SpDamageType.fromJson(Map<String, dynamic> json) => SpDamageType(
        codigoDano: json["codigoDano"],
        danoRegistrado: json["danoRegistrado"],
        descripcionFaltantes: json["descripcionFaltantes"],
        parteVehiculo: json["parteVehiculo"],
        zonaVehiculo: json["zonaVehiculo"],
        fotoDano: json["fotoDano"],
        idDamageReport: json["idDamageReport"],
      );

  Map<String, dynamic> toJson() => {
        "codigoDano": codigoDano,
        "danoRegistrado": danoRegistrado,
        "descripcionFaltantes": descripcionFaltantes,
        "parteVehiculo": parteVehiculo,
        "zonaVehiculo": zonaVehiculo,
        "fotoDano": fotoDano,
        "idDamageReport": idDamageReport,
      };
}
