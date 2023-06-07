// To parse this JSON data, do
//
//     final vwAutoreportData = vwAutoreportDataFromJson(jsonString);

import 'dart:convert';

VwAutoreportData vwAutoreportDataFromJson(String str) =>
    VwAutoreportData.fromJson(json.decode(str));

String vwAutoreportDataToJson(VwAutoreportData data) =>
    json.encode(data.toJson());

class VwAutoreportData {
  int? idAutoreport;
  DateTime? fechaHora;
  String? codAutoreport;
  String? nave;
  String? bl;
  String? chassis;
  String? marca;
  String? codigoDr;
  String? zona;
  String? fila;
  bool? danoAcopio;
  bool? participantesInspeccion;
  bool? presenciaSeguro;
  bool? plumillasDelanteras;
  bool? plumillasTraseras;
  bool? copasAro;
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
  bool? llantaRepuesto;
  bool? herramienta;
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
  bool? llave;
  bool? llavesPrecintas;
  int? nllavesSimples;
  int? nllavesInteligentes;
  int? nllavesComando;
  int? nllavesPin;
  bool? linterna;
  bool? cableCargadorBateria;
  bool? circulina;
  bool? cableCargadorVehiculoElectrico;
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

  VwAutoreportData({
    this.idAutoreport,
    this.fechaHora,
    this.codAutoreport,
    this.nave,
    this.bl,
    this.chassis,
    this.marca,
    this.codigoDr,
    this.zona,
    this.fila,
    this.danoAcopio,
    this.participantesInspeccion,
    this.presenciaSeguro,
    this.plumillasDelanteras,
    this.plumillasTraseras,
    this.copasAro,
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
    this.llantaRepuesto,
    this.herramienta,
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
    this.llave,
    this.llavesPrecintas,
    this.nllavesSimples,
    this.nllavesInteligentes,
    this.nllavesComando,
    this.nllavesPin,
    this.linterna,
    this.cableCargadorBateria,
    this.circulina,
    this.cableCargadorVehiculoElectrico,
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

  factory VwAutoreportData.fromJson(Map<String, dynamic> json) =>
      VwAutoreportData(
        idAutoreport: json["idAutoreport"],
        fechaHora: DateTime.parse(json["fechaHora"]),
        codAutoreport: json["codAutoreport"],
        nave: json["nave"],
        bl: json["bl"],
        chassis: json["chassis"],
        marca: json["marca"],
        codigoDr: json["codigoDr"],
        zona: json["zona"],
        fila: json["fila"],
        danoAcopio: json["danoAcopio"],
        participantesInspeccion: json["participantesInspeccion"],
        presenciaSeguro: json["presenciaSeguro"],
        plumillasDelanteras: json["plumillasDelanteras"],
        plumillasTraseras: json["plumillasTraseras"],
        copasAro: json["copasAro"],
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
        llantaRepuesto: json["llantaRepuesto"],
        herramienta: json["herramienta"],
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
        llave: json["llave"],
        llavesPrecintas: json["llavesPrecintas"],
        nllavesSimples: json["nllavesSimples"],
        nllavesInteligentes: json["nllavesInteligentes"],
        nllavesComando: json["nllavesComando"],
        nllavesPin: json["nllavesPin"],
        linterna: json["linterna"],
        cableCargadorBateria: json["cableCargadorBateria"],
        circulina: json["circulina"],
        cableCargadorVehiculoElectrico: json["cableCargadorVehiculoElectrico"],
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
        "danoAcopio": danoAcopio,
        "participantesInspeccion": participantesInspeccion,
        "presenciaSeguro": presenciaSeguro,
        "plumillasDelanteras": plumillasDelanteras,
        "plumillasTraseras": plumillasTraseras,
        "copasAro": copasAro,
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
        "llantaRepuesto": llantaRepuesto,
        "herramientas": herramienta,
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
        "llaves": llave,
        "llavesPrecintas": llavesPrecintas,
        "nllavesSimples": nllavesSimples,
        "nllavesInteligentes": nllavesInteligentes,
        "nllavesComando": nllavesComando,
        "nllavesPin": nllavesPin,
        "linterna": linterna,
        "cableCargadorBateria": cableCargadorBateria,
        "circulina": circulina,
        "cableCargagorVehiculoElectrico": cableCargadorVehiculoElectrico,
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
