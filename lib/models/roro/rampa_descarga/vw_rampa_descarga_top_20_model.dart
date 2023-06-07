import 'dart:convert';

List<VwRampaDescargaTop20Model> vwRampaDescargaTop20ModelFromJson(String str) =>
    List<VwRampaDescargaTop20Model>.from(
        json.decode(str).map((x) => VwRampaDescargaTop20Model.fromJson(x)));

String vwRampaDescargaTop20ModelToJson(List<VwRampaDescargaTop20Model> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class VwRampaDescargaTop20Model {
  VwRampaDescargaTop20Model({
    this.idRampaDescarga,
    this.chasis,
    this.marca,
    this.conductor,
    this.horaLectura,
  });

  int? idRampaDescarga;
  String? chasis;
  String? marca;
  String? conductor;
  DateTime? horaLectura;

  factory VwRampaDescargaTop20Model.fromJson(Map<String, dynamic> json) =>
      VwRampaDescargaTop20Model(
        idRampaDescarga: json["idRampaDescarga"],
        chasis: json["chasis"],
        marca: json["marca"],
        conductor: json["conductor"],
        horaLectura: DateTime.parse(json["horaLectura"]),
      );

  Map<String, dynamic> toJson() => {
        "idRampaDescarga": idRampaDescarga,
        "chasis": chasis,
        "marca": marca,
        "conductor": conductor,
        "horaLectura": horaLectura?.toIso8601String(),
      };
}
