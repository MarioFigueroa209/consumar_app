import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import '../../../models/roro/damage_report/dr_aprobado_masivo_list.dart';
import '../../../models/roro/damage_report/sp_create_damage_report_list_model.dart';
import '../../../models/roro/damage_report/sp_damage_report_create_model.dart';
import '../../../models/roro/damage_report/vw_get_damage_report_item_model.dart';
import '../../../models/roro/damage_report/vw_get_damage_type_by_id_dr_model.dart';
import '../../../models/roro/damage_report/vw_ticket_dr_listado.dart';
import '../../../models/roro/damage_report/damage_report_consulta.dart';
import '../../../models/roro/damage_report/sp_damage_report_create_list.dart';
import '../../../models/roro/damage_report/vw_get_damage_report_list_model.dart';
import '../../../utils/roro/damage_report_models.dart';
import '../../../utils/roro/sqliteBD/db_damage_report.dart';
import '../../api_services.dart';

class DamageReportConsultaService {
  List<DamageReportConsultaApi> parseDamageReportConsulta(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<DamageReportConsultaApi>(
            (json) => DamageReportConsultaApi.fromJson(json))
        .toList();
  }

  Future<List<DamageReportConsultaApi>> getDamageReportConsulta(
      BigInt idServiceOrder) async {
    final response = await http.get(
        Uri.parse('$urlDamageReportConsulta?idServiceOrder=$idServiceOrder'));
    if (response.statusCode == 200) {
      // Si el servidor devuelve una repuesta OK, parseamos el JSON
      return parseDamageReportConsulta(response.body);
    } else {
      //Si esta respuesta no fue OK, lanza un error.
      throw Exception('No se pudo obtener registros');
    }
  }

  Future<int> insertDamageReportData(
      List<DamageReportConsultaApi> value) async {
    DbDamageReportSqlLite dbDamageReportSql = DbDamageReportSqlLite();
    List<DamageReportInsertSqlLite> damageReportInsertSqlLite = [];
    for (int count = 0; count < value.length; count++) {
      DamageReportInsertSqlLite aux = DamageReportInsertSqlLite();
      aux.idServiceOrder = value[count].idServiceOrder;
      aux.idVehiculo = value[count].idVehiculo;
      aux.chasis = value[count].chasis;
      aux.marca = value[count].marca;
      aux.modelo = value[count].modelo;
      aux.lineaNaviera = value[count].lineaNaviera;
      aux.consigntario = value[count].consigntario;
      aux.billOfLeading = value[count].billOfLeading;
      damageReportInsertSqlLite.add(aux);
    }

    dbDamageReportSql.insertDamageReportData(damageReportInsertSqlLite);
    ////print("cantida de registros damage report${damageReportInsertSqlLite.length}");
    return damageReportInsertSqlLite.length;
  }

  Future<BigInt> createDamageReport(
      SpDamageReportCreateModel spDamageReportCreateModel) async {
    Map data = spDamageReportCreateModel.toJson();

    final Response response = await post(
      urlCreateDamageReport,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
    );
    if (response.statusCode == 200) {
      // //print("respuesta Damage Report ${response.body}");
      return BigInt.parse(response.body);
    } else {
      throw Exception('Failed to post Damage Report');
    }
  }

  Future<String> createDamageReportList(
      SpDamageReportCreateList spDamageReportCreateList) async {
    Map data = spDamageReportCreateList.toJson();
    /* //print(data.toString());*/
    final Response response = await post(
      urlCreateDamageReportList,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
    );
    if (response.statusCode == 200) {
      //print("respuesta Damage Report ${response.body}");
      return "se registraron ${response.body.length}";
    } else {
      throw Exception('Failed to post Damage Report');
    }
  }

  List<VwGetDamageReportListModel> parseDamageReportList(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<VwGetDamageReportListModel>(
            (json) => VwGetDamageReportListModel.fromJson(json))
        .toList();
  }

  Future<List<VwGetDamageReportListModel>> getDamageReportList(
      BigInt idServiceOrder) async {
    final response = await http.get(Uri.parse(
        urlDamageReportAllListByIdServiceOrder + idServiceOrder.toString()));
    if (response.statusCode == 200) {
      // Si el servidor devuelve una repuesta OK, parseamos el JSON
      return parseDamageReportList(response.body);
    } else {
      //Si esta respuesta no fue OK, lanza un error.
      throw Exception('No se pudo obtener los registros');
    }
  }

  Future<VwGetDamageReportItemModel> getDamageReportItem(
      BigInt idDamageReport) async {
    var url = Uri.parse(urlGetDamageReportItem + idDamageReport.toString());

    final response = await http.get(url);

    if (response.statusCode == 200) {
      return VwGetDamageReportItemModel.fromJson(jsonDecode(response.body));
    }
    /*else if (response.statusCode == 404) {
      VwGetDamageReportItemModel damageReportModel =
          VwGetDamageReportItemModel();
      damageReportModel.nombres = 'no encontrado';
      return damageReportModel;
    }*/
    else {
      throw Exception('Fallo al cargar');
    }
  }

  List<VwGetDamageTypeByIdDrModel> parseDamageItemByIdDR(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<VwGetDamageTypeByIdDrModel>(
            (json) => VwGetDamageTypeByIdDrModel.fromJson(json))
        .toList();
  }

  Future<List<VwGetDamageTypeByIdDrModel>> getDamageItemListByIdDR(
      BigInt idDamageReport) async {
    final response = await http.get(
        Uri.parse("$urlGetDamageTypeByIdDR?IdDamageReport=$idDamageReport"));
    if (response.statusCode == 200) {
      // Si el servidor devuelve una repuesta OK, parseamos el JSON
      return parseDamageItemByIdDR(response.body);
    } else {
      //Si esta respuesta no fue OK, lanza un error.
      throw Exception('No se pudo obtener los registros');
    }
  }

  Future<SpCreateDamageReportListModel> insertDamageReportList(
      SpCreateDamageReportListModel spCreateDamageReportListModel) async {
    Map data = spCreateDamageReportListModel.toJson();

    final Response response = await post(
      urlInsertDamageReport,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
    );
    if (response.statusCode == 200) {
      //print("respuesta Damage Report ${response.body}");
      return spCreateDamageReportListModel;
    } else {
      throw Exception('Failed to post Damage Report');
    }
  }

  Future<void> delecteLogicDamageReport(BigInt id) async {
    http.Response res =
        await http.put(Uri.parse(urlDeleteLogicDamageReport + id.toString()));

    if (res.statusCode == 200) {
      // //print(" Actualizado");
    } else {
      throw "Fallo al actualizar";
    }
  }

  Future<void> delecteLogicDamageReportList(BigInt id) async {
    http.Response res = await http
        .put(Uri.parse(urlDeleteLogicDamageReportList + id.toString()));

    if (res.statusCode == 200) {
      // //print(" Actualizado");
    } else {
      throw "Fallo al actualizar";
    }
  }

  List<VwTicketDrListado> parseVwTicketDrListado(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<VwTicketDrListado>((json) => VwTicketDrListado.fromJson(json))
        .toList();
  }

  Future<List<VwTicketDrListado>> getVwTicketDrListado(
      BigInt idServiceOrder) async {
    final response = await http
        .get(Uri.parse(urlGetVwTicketDRListado + idServiceOrder.toString()));
    if (response.statusCode == 200) {
      // Si el servidor devuelve una repuesta OK, parseamos el JSON
      return parseVwTicketDrListado(response.body);
    } else {
      //Si esta respuesta no fue OK, lanza un error.
      throw Exception('No se pudo obtener los registros');
    }
  }

  Future<List<DrAprobadoMasivoList>> createAprobadoMasivoList(
    int jornada,
    int idServiceOrder,
    String? responsableNave,
    String? codigoCapitan,
    String? nombreCapitan,
    String? imgFirmaResponsable,
    String? urlFirmaResponsable,
    String? aprobadoCoordinador,
    String? aprobadoApmtc,
    String? aprobadoCapitan,
    int? idCoordinador,
    int? idSupervisor,
    List<VwGetDamageReportListModel> value,
  ) async {
    List<DrAprobadoMasivoList> aprobadoMasivoList = [];
    for (int count = 0; count < value.length; count++) {
      DrAprobadoMasivoList aux = DrAprobadoMasivoList();
      aux.jornada = jornada;
      aux.fecha = DateTime.now();
      aux.codigoResponsableNave = codigoCapitan;
      aux.nombreResponsableNave = nombreCapitan;

      aux.responsableNave = aux.aprobadoCoordinador = aprobadoCoordinador;
      aux.aprobadoSupervisorApm = aprobadoApmtc;
      aux.aprobadoResponsableNave = aprobadoCapitan;

      aux.responsableNave = responsableNave;

      aux.comentariosCoordinador = null;
      aux.motivoRechazoCoordinador = null;

      aux.comentariosSupervisor = null;
      aux.motivoRechazoSupervisor = null;

      aux.comentariosResponsableNave = null;
      aux.motivoRechazoResponsableNave = null;

      aux.idServiceOrder = idServiceOrder;
      aux.idCoordinador = idCoordinador;
      aux.idSupervisor = idSupervisor;
      aux.idCodDr = value[count].idDamageReport;
      aux.imgFirmaResponsable = imgFirmaResponsable;
      aux.urlFirmaResponsable = urlFirmaResponsable;

      aprobadoMasivoList.add(aux);
    }

    final Response response = await post(
      urlCreateAprobadoMasivoDRList,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(aprobadoMasivoList),
    );
    if (response.statusCode == 200) {
      return aprobadoMasivoList;
    } else {
      throw Exception('Failed to post data');
    }
  }
}
