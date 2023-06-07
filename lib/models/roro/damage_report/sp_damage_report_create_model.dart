import 'dart:convert';

import '../../sp_damage_type.dart';
import 'sp_damage_report.dart';

SpDamageReportCreateModel spDamageReportCreateModelFromJson(String str) =>
    SpDamageReportCreateModel.fromJson(json.decode(str));

String spDamageReportCreateModelToJson(SpDamageReportCreateModel data) =>
    json.encode(data.toJson());

class SpDamageReportCreateModel {
  SpDamageReportCreateModel({
    this.spDamageReport,
    this.spDamageType,
  });

  SpDamageReport? spDamageReport;
  List<SpDamageType>? spDamageType;

  factory SpDamageReportCreateModel.fromJson(Map<String, dynamic> json) =>
      SpDamageReportCreateModel(
        spDamageReport: SpDamageReport.fromJson(json["spDamageReport"]),
        spDamageType: List<SpDamageType>.from(
            json["spDamageType"].map((x) => SpDamageType.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "spDamageReport": spDamageReport?.toJson(),
        "spDamageType":
            List<dynamic>.from(spDamageType!.map((x) => x.toJson())),
      };
}
