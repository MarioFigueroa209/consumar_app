import 'dart:convert';

import '../../sp_damage_type.dart';
import 'sp_damage_report.dart';

SpDamageReportCreateList spDamageReportCreateListFromJson(String str) =>
    SpDamageReportCreateList.fromJson(json.decode(str));

String spDamageReportCreateListToJson(SpDamageReportCreateList data) =>
    json.encode(data.toJson());

class SpDamageReportCreateList {
  SpDamageReportCreateList({
    this.spDamageReport,
    this.spDamageType,
  });

  List<SpDamageReport>? spDamageReport;
  List<SpDamageType>? spDamageType;

  factory SpDamageReportCreateList.fromJson(Map<String, dynamic> json) =>
      SpDamageReportCreateList(
        spDamageReport: List<SpDamageReport>.from(
            json["spDamageReport"].map((x) => SpDamageReport.fromJson(x))),
        spDamageType: List<SpDamageType>.from(
            json["spDamageType"].map((x) => SpDamageType.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "spDamageReport":
            List<dynamic>.from(spDamageReport!.map((x) => x.toJson())),
        "spDamageType":
            List<dynamic>.from(spDamageType!.map((x) => x.toJson())),
      };
}
