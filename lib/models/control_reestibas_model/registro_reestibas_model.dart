// To parse this JSON data, do
//
//     final registroReestibasModel = registroReestibasModelFromJson(jsonString);

import 'dart:convert';

RegistroReestibasModel registroReestibasModelFromJson(String str) =>
    RegistroReestibasModel.fromJson(json.decode(str));

String registroReestibasModelToJson(RegistroReestibasModel data) =>
    json.encode(data.toJson());

class RegistroReestibasModel {
  RegistroReestibasModel({
    this.idRegistroReestibas,
    this.marca,
    this.modelo,
    this.cantidad,
    this.pesoBruto,
    this.unidad,
    this.nivelInicial,
    this.bodegaInicial,
    this.comentarios,
  });

  int? idRegistroReestibas;
  String? marca;
  String? modelo;
  int? cantidad;
  double? pesoBruto;
  String? unidad;
  String? nivelInicial;
  String? bodegaInicial;
  String? comentarios;

  factory RegistroReestibasModel.fromJson(Map<String, dynamic> json) =>
      RegistroReestibasModel(
        idRegistroReestibas: json["idRegistroReestibas"],
        marca: json["marca"],
        modelo: json["modelo"],
        cantidad: json["cantidad"],
        pesoBruto: json["pesoBruto"].toDouble(),
        unidad: json["unidad"],
        nivelInicial: json["nivelInicial"],
        bodegaInicial: json["bodegaInicial"],
        comentarios: json["comentarios"],
      );

  Map<String, dynamic> toJson() => {
        "idRegistroReestibas": idRegistroReestibas,
        "marca": marca,
        "modelo": modelo,
        "cantidad": cantidad,
        "pesoBruto": pesoBruto,
        "unidad": unidad,
        "nivelInicial": nivelInicial,
        "bodegaInicial": bodegaInicial,
        "comentarios": comentarios,
      };
}
