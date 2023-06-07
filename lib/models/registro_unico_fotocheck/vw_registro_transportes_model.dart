import 'dart:convert';

List<VwRegistroTransportesModel> vwRegistroTransportesModelFromJson(
        String str) =>
    List<VwRegistroTransportesModel>.from(
        json.decode(str).map((x) => VwRegistroTransportesModel.fromJson(x)));

String vwRegistroTransportesModelToJson(
        List<VwRegistroTransportesModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class VwRegistroTransportesModel {
  VwRegistroTransportesModel({
    this.idVista,
    this.empresaTransporte,
    this.ruc,
    this.codFotocheck,
  });

  int? idVista;
  String? empresaTransporte;
  String? ruc;
  String? codFotocheck;

  factory VwRegistroTransportesModel.fromJson(Map<String, dynamic> json) =>
      VwRegistroTransportesModel(
        idVista: json["idVista"],
        empresaTransporte: json["empresaTransporte"],
        ruc: json["ruc"],
        codFotocheck: json["codFotocheck"],
      );

  Map<String, dynamic> toJson() => {
        "idVista": idVista,
        "empresaTransporte": empresaTransporte,
        "ruc": ruc,
        "codFotocheck": codFotocheck,
      };
}
