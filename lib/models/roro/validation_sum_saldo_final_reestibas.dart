// To parse this JSON data, do
//
//     final validationSumSaldoFinalReestibas = validationSumSaldoFinalReestibasFromJson(jsonString);

import 'dart:convert';

List<ValidationSumSaldoFinalReestibas> validationSumSaldoFinalReestibasFromJson(
        String str) =>
    List<ValidationSumSaldoFinalReestibas>.from(json
        .decode(str)
        .map((x) => ValidationSumSaldoFinalReestibas.fromJson(x)));

String validationSumSaldoFinalReestibasToJson(
        List<ValidationSumSaldoFinalReestibas> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ValidationSumSaldoFinalReestibas {
  int? idServiceOrder;
  int? sumaSaldos;
  int? sumaSaldoMuelle;
  int? sumaSaldoAbordo;

  ValidationSumSaldoFinalReestibas({
    this.idServiceOrder,
    this.sumaSaldos,
    this.sumaSaldoMuelle,
    this.sumaSaldoAbordo,
  });

  factory ValidationSumSaldoFinalReestibas.fromJson(
          Map<String, dynamic> json) =>
      ValidationSumSaldoFinalReestibas(
        idServiceOrder: json["idServiceOrder"],
        sumaSaldos: json["sumaSaldos"],
        sumaSaldoMuelle: json["sumaSaldoMuelle"],
        sumaSaldoAbordo: json["sumaSaldoAbordo"],
      );

  Map<String, dynamic> toJson() => {
        "idServiceOrder": idServiceOrder,
        "sumaSaldos": sumaSaldos,
        "sumaSaldoMuelle": sumaSaldoMuelle,
        "sumaSaldoAbordo": sumaSaldoAbordo,
      };
}
