// To parse this JSON data, do
//
//     final spAutoreportUpdateModel = spAutoreportUpdateModelFromJson(jsonString);

import 'dart:convert';

import 'package:consumar_app/models/roro/autoreport/sp_dano_zona_acopio_model.dart';
import 'package:consumar_app/models/roro/autoreport/sp_participantes_inspeccion_model.dart';

SpAutoreportUpdateModel spAutoreportUpdateModelFromJson(String str) =>
    SpAutoreportUpdateModel.fromJson(json.decode(str));

String spAutoreportUpdateModelToJson(SpAutoreportUpdateModel data) =>
    json.encode(data.toJson());

class SpAutoreportUpdateModel {
  SpUpdateAutoreport? spUpdateAutoreport;
  List<SpDanoZonaAcopioModel>? spDanosZonaAcopio;
  List<SpParticipantesInspeccionModel>? spParicipantesInspeccion;

  SpAutoreportUpdateModel({
    this.spUpdateAutoreport,
    this.spDanosZonaAcopio,
    this.spParicipantesInspeccion,
  });

  factory SpAutoreportUpdateModel.fromJson(Map<String, dynamic> json) =>
      SpAutoreportUpdateModel(
        spUpdateAutoreport:
            SpUpdateAutoreport.fromJson(json["spUpdateAutoreport"]),
        spDanosZonaAcopio: List<SpDanoZonaAcopioModel>.from(
            json["spDanosZonaAcopio"]
                .map((x) => SpDanoZonaAcopioModel.fromJson(x))),
        spParicipantesInspeccion: List<SpParticipantesInspeccionModel>.from(
            json["spParicipantesInspeccion"]
                .map((x) => SpParticipantesInspeccionModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "spUpdateAutoreport": spUpdateAutoreport!.toJson(),
        "spDanosZonaAcopio":
            List<dynamic>.from(spDanosZonaAcopio!.map((x) => x.toJson())),
        "spParicipantesInspeccion": List<dynamic>.from(
            spParicipantesInspeccion!.map((x) => x.toJson())),
      };
}

class SpUpdateAutoreport {
  int? idAutoreport;
  String? zona;
  String? fila;
  bool? daosAcopio;
  bool? participantesInspeccion;
  bool? presenciaSeguro;
  bool? plumillasDelanteras;
  bool? plumillasTraseras;
  bool? antena;
  bool? espejosInteriores;
  bool? espejosLaterales;
  bool? tapaLlanta;
  bool? radio;
  bool? controlRemotoRadio;
  bool? tacografo;
  bool? tacometro;
  bool? encendedor;
  bool? reloj;
  bool? pisosAdicionales;
  bool? copasAro;
  bool? llantaRepuesto;
  bool? herramientas;
  bool? pinRemolque;
  bool? caja;
  bool? cajaEstado;
  bool? maletin;
  bool? maletinEstado;
  bool? bolsaPlastica;
  bool? bolsaPlasticaEstado;
  bool? estuche;
  bool? relays;
  bool? ceniceros;
  bool? gata;
  bool? extintor;
  bool? trianguloSeguridad;
  bool? pantallaTactil;
  bool? catalogos;
  bool? llaves;
  bool? llavesPrecintas;
  int? nLlavesSimples;
  int? nLlavesInteligentes;
  int? nLlavesComando;
  int? nLlavesPin;
  bool? linterna;
  bool? cableCargadorBateria;
  bool? circulina;
  bool? cableCargagorVehiculoElectrico;
  bool? cd;
  bool? usb;
  bool? memoriaSd;
  bool? camaraSeguridad;
  bool? radioComunicador;
  bool? mangueraAire;
  bool? cableCargador;
  bool? llaveRuedas;
  bool? chaleco;
  bool? galonera;
  bool? controlRemotoMaquinaria;
  String? otros;
  String? comentario;

  SpUpdateAutoreport({
    this.idAutoreport,
    this.zona,
    this.fila,
    this.daosAcopio,
    this.participantesInspeccion,
    this.presenciaSeguro,
    this.plumillasDelanteras,
    this.plumillasTraseras,
    this.antena,
    this.espejosInteriores,
    this.espejosLaterales,
    this.tapaLlanta,
    this.radio,
    this.controlRemotoRadio,
    this.tacografo,
    this.tacometro,
    this.encendedor,
    this.reloj,
    this.pisosAdicionales,
    this.copasAro,
    this.llantaRepuesto,
    this.herramientas,
    this.pinRemolque,
    this.caja,
    this.cajaEstado,
    this.maletin,
    this.maletinEstado,
    this.bolsaPlastica,
    this.bolsaPlasticaEstado,
    this.estuche,
    this.relays,
    this.ceniceros,
    this.gata,
    this.extintor,
    this.trianguloSeguridad,
    this.pantallaTactil,
    this.catalogos,
    this.llaves,
    this.llavesPrecintas,
    this.nLlavesSimples,
    this.nLlavesInteligentes,
    this.nLlavesComando,
    this.nLlavesPin,
    this.linterna,
    this.cableCargadorBateria,
    this.circulina,
    this.cableCargagorVehiculoElectrico,
    this.cd,
    this.usb,
    this.memoriaSd,
    this.camaraSeguridad,
    this.radioComunicador,
    this.mangueraAire,
    this.cableCargador,
    this.llaveRuedas,
    this.chaleco,
    this.galonera,
    this.controlRemotoMaquinaria,
    this.otros,
    this.comentario,
  });

  factory SpUpdateAutoreport.fromJson(Map<String, dynamic> json) =>
      SpUpdateAutoreport(
        idAutoreport: json["idAutoreport"],
        zona: json["zona"],
        fila: json["fila"],
        daosAcopio: json["dañosAcopio"],
        participantesInspeccion: json["participantesInspeccion"],
        presenciaSeguro: json["presenciaSeguro"],
        plumillasDelanteras: json["plumillasDelanteras"],
        plumillasTraseras: json["plumillasTraseras"],
        antena: json["antena"],
        espejosInteriores: json["espejosInteriores"],
        espejosLaterales: json["espejosLaterales"],
        tapaLlanta: json["tapaLlanta"],
        radio: json["radio"],
        controlRemotoRadio: json["controlRemotoRadio"],
        tacografo: json["tacografo"],
        tacometro: json["tacometro"],
        encendedor: json["encendedor"],
        reloj: json["reloj"],
        pisosAdicionales: json["pisosAdicionales"],
        copasAro: json["copasAro"],
        llantaRepuesto: json["llantaRepuesto"],
        herramientas: json["herramientas"],
        pinRemolque: json["pinRemolque"],
        caja: json["caja"],
        cajaEstado: json["cajaEstado"],
        maletin: json["maletin"],
        maletinEstado: json["maletinEstado"],
        bolsaPlastica: json["bolsaPlastica"],
        bolsaPlasticaEstado: json["bolsaPlasticaEstado"],
        estuche: json["estuche"],
        relays: json["relays"],
        ceniceros: json["ceniceros"],
        gata: json["gata"],
        extintor: json["extintor"],
        trianguloSeguridad: json["trianguloSeguridad"],
        pantallaTactil: json["pantallaTactil"],
        catalogos: json["catalogos"],
        llaves: json["llaves"],
        llavesPrecintas: json["llavesPrecintas"],
        nLlavesSimples: json["nLlavesSimples"],
        nLlavesInteligentes: json["nLlavesInteligentes"],
        nLlavesComando: json["nLlavesComando"],
        nLlavesPin: json["nLlavesPin"],
        linterna: json["linterna"],
        cableCargadorBateria: json["cableCargadorBateria"],
        circulina: json["circulina"],
        cableCargagorVehiculoElectrico: json["cableCargagorVehiculoElectrico"],
        cd: json["cd"],
        usb: json["usb"],
        memoriaSd: json["memoriaSd"],
        camaraSeguridad: json["camaraSeguridad"],
        radioComunicador: json["radioComunicador"],
        mangueraAire: json["mangueraAire"],
        cableCargador: json["cableCargador"],
        llaveRuedas: json["llaveRuedas"],
        chaleco: json["chaleco"],
        galonera: json["galonera"],
        controlRemotoMaquinaria: json["controlRemotoMaquinaria"],
        otros: json["otros"],
        comentario: json["comentario"],
      );

  Map<String, dynamic> toJson() => {
        "idAutoreport": idAutoreport,
        "zona": zona,
        "fila": fila,
        "dañosAcopio": daosAcopio,
        "participantesInspeccion": participantesInspeccion,
        "presenciaSeguro": presenciaSeguro,
        "plumillasDelanteras": plumillasDelanteras,
        "plumillasTraseras": plumillasTraseras,
        "antena": antena,
        "espejosInteriores": espejosInteriores,
        "espejosLaterales": espejosLaterales,
        "tapaLlanta": tapaLlanta,
        "radio": radio,
        "controlRemotoRadio": controlRemotoRadio,
        "tacografo": tacografo,
        "tacometro": tacometro,
        "encendedor": encendedor,
        "reloj": reloj,
        "pisosAdicionales": pisosAdicionales,
        "copasAro": copasAro,
        "llantaRepuesto": llantaRepuesto,
        "herramientas": herramientas,
        "pinRemolque": pinRemolque,
        "caja": caja,
        "cajaEstado": cajaEstado,
        "maletin": maletin,
        "maletinEstado": maletinEstado,
        "bolsaPlastica": bolsaPlastica,
        "bolsaPlasticaEstado": bolsaPlasticaEstado,
        "estuche": estuche,
        "relays": relays,
        "ceniceros": ceniceros,
        "gata": gata,
        "extintor": extintor,
        "trianguloSeguridad": trianguloSeguridad,
        "pantallaTactil": pantallaTactil,
        "catalogos": catalogos,
        "llaves": llaves,
        "llavesPrecintas": llavesPrecintas,
        "nLlavesSimples": nLlavesSimples,
        "nLlavesInteligentes": nLlavesInteligentes,
        "nLlavesComando": nLlavesComando,
        "nLlavesPin": nLlavesPin,
        "linterna": linterna,
        "cableCargadorBateria": cableCargadorBateria,
        "circulina": circulina,
        "cableCargagorVehiculoElectrico": cableCargagorVehiculoElectrico,
        "cd": cd,
        "usb": usb,
        "memoriaSd": memoriaSd,
        "camaraSeguridad": camaraSeguridad,
        "radioComunicador": radioComunicador,
        "mangueraAire": mangueraAire,
        "cableCargador": cableCargador,
        "llaveRuedas": llaveRuedas,
        "chaleco": chaleco,
        "galonera": galonera,
        "controlRemotoMaquinaria": controlRemotoMaquinaria,
        "otros": otros,
        "comentario": comentario,
      };
}
