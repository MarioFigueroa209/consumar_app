// To parse this JSON data, do
//
//     final vwRampaEmbarqueVehicleDataModel = vwRampaEmbarqueVehicleDataModelFromJson(jsonString);

import 'dart:convert';

VwRampaEmbarqueVehicleDataModel vwRampaEmbarqueVehicleDataModelFromJson(String str) => VwRampaEmbarqueVehicleDataModel.fromJson(json.decode(str));

String vwRampaEmbarqueVehicleDataModelToJson(VwRampaEmbarqueVehicleDataModel data) => json.encode(data.toJson());

class VwRampaEmbarqueVehicleDataModel {
    int? idServiceOrder;
    int? idVehiculo;
    int? idTravel;
    int? idNaveEmbarque;
    int? idBl;
    String? tipoMercaderia;
    String? chasis;
    String? marca;
    String? modelo;
    String? codDr;
    String? consigntario;
    String? billOfLeading;
    String? eliminadoDamageReport;
    String? naveEmbarque;
    String? puertoDestino;
    String? nivelDistribucionEmbarque;

    VwRampaEmbarqueVehicleDataModel({
        this.idServiceOrder,
        this.idVehiculo,
        this.idTravel,
        this.idNaveEmbarque,
        this.idBl,
        this.tipoMercaderia,
        this.chasis,
        this.marca,
        this.modelo,
        this.codDr,
        this.consigntario,
        this.billOfLeading,
        this.eliminadoDamageReport,
        this.naveEmbarque,
        this.puertoDestino,
        this.nivelDistribucionEmbarque,
    });

    factory VwRampaEmbarqueVehicleDataModel.fromJson(Map<String, dynamic> json) => VwRampaEmbarqueVehicleDataModel(
        idServiceOrder: json["idServiceOrder"],
        idVehiculo: json["idVehiculo"],
        idTravel: json["idTravel"],
        idNaveEmbarque: json["idNaveEmbarque"],
        idBl: json["idBl"],
        tipoMercaderia: json["tipoMercaderia"],
        chasis: json["chasis"],
        marca: json["marca"],
        modelo: json["modelo"],
        codDr: json["codDr"],
        consigntario: json["consigntario"],
        billOfLeading: json["billOfLeading"],
        eliminadoDamageReport: json["eliminadoDamageReport"],
        naveEmbarque: json["naveEmbarque"],
        puertoDestino: json["puertoDestino"],
        nivelDistribucionEmbarque: json["nivelDistribucionEmbarque"],
    );

    Map<String, dynamic> toJson() => {
        "idServiceOrder": idServiceOrder,
        "idVehiculo": idVehiculo,
        "idTravel": idTravel,
        "idNaveEmbarque": idNaveEmbarque,
        "idBl": idBl,
        "tipoMercaderia": tipoMercaderia,
        "chasis": chasis,
        "marca": marca,
        "modelo": modelo,
        "codDr": codDr,
        "consigntario": consigntario,
        "billOfLeading": billOfLeading,
        "eliminadoDamageReport": eliminadoDamageReport,
        "naveEmbarque": naveEmbarque,
        "puertoDestino": puertoDestino,
        "nivelDistribucionEmbarque": nivelDistribucionEmbarque,
    };
}
