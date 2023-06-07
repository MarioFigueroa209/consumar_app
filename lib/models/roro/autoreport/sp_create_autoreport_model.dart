// To parse this JSON data, do
//
//     final spCreateAutoreportModel = spCreateAutoreportModelFromJson(jsonString);

import 'dart:convert';

SpCreateAutoreportModel spCreateAutoreportModelFromJson(String str) =>
    SpCreateAutoreportModel.fromJson(json.decode(str));

String spCreateAutoreportModelToJson(SpCreateAutoreportModel data) =>
    json.encode(data.toJson());

class SpCreateAutoreportModel {
  int? jornada;
  DateTime? fecha;
  String? zona;
  String? fila;
  String? codigoDr;
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
  int? idServiceOrder;
  int? idUsuarios;
  int? idBl;
  int? idShip;
  int? idVehicle;
  int? idTravel;
  String? codAutoreport;

  SpCreateAutoreportModel({
    this.jornada,
    this.fecha,
    this.zona,
    this.fila,
    this.codigoDr,
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
    this.idServiceOrder,
    this.idUsuarios,
    this.idBl,
    this.idShip,
    this.idVehicle,
    this.idTravel,
    this.codAutoreport,
  });

  factory SpCreateAutoreportModel.fromJson(Map<String, dynamic> json) =>
      SpCreateAutoreportModel(
        jornada: json["jornada"],
        fecha: DateTime.parse(json["fecha"]),
        zona: json["zona"],
        fila: json["fila"],
        codigoDr: json["codigoDr"],
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
        idServiceOrder: json["idServiceOrder"],
        idUsuarios: json["idUsuarios"],
        idBl: json["idBl"],
        idShip: json["idShip"],
        idVehicle: json["idVehicle"],
        idTravel: json["idTravel"],
        codAutoreport: json["codAutoreport"],
      );

  Map<String, dynamic> toJson() => {
        "jornada": jornada,
        "fecha": fecha!.toIso8601String(),
        "zona": zona,
        "fila": fila,
        "codigoDr": codigoDr,
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
        "idServiceOrder": idServiceOrder,
        "idUsuarios": idUsuarios,
        "idBl": idBl,
        "idShip": idShip,
        "idVehicle": idVehicle,
        "idTravel": idTravel,
        "codAutoreport": codAutoreport,
      };
}
