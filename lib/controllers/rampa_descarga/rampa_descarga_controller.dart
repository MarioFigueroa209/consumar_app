import 'package:flutter/material.dart';

import '../../models/roro/damage_report/vw_get_damage_report_list_model.dart';
import '../../models/roro/rampa_descarga/vw_rampa_descarga_top_20_model.dart';
import '../../models/vw_get_user_data_by_cod_user.dart';
import '../../models/vw_vehicle_data_model.dart';
import '../../services/roro/rampa_descarga/rampa_descarga_services.dart';
import '../../services/usuario_service.dart';
import '../../services/vehicle_service.dart';
import '../../utils/roro/rampa_descaga_list_models.dart';
import '../../utils/roro/rampa_descarga_table_model.dart';

class RampaDescargaController extends ChangeNotifier {
  bool isLoading = false;

  RampaDescargaServices rampaDescargaServices = RampaDescargaServices();
  List<VwRampaDescargaTop20Model>? vwRampaDescargaTop20;
  VwgetUserDataByCodUser vwGetUserDataByCodUser = VwgetUserDataByCodUser();
  List<RampaDescargaList> detalleRampaDescargaList = [];
  List<RampaDescargaTable> rampaDescargaTable = [];
  List<VwVehicleDataModel> vwVehicleDataModelList = [];
  List<VwGetDamageReportListModel> vwGetDamageReportListModel = [];

  Future<void> getRampaDescargaTop20() async {
    vwRampaDescargaTop20 =
        await rampaDescargaServices.getVwRampaDescargaTop20();

    notifyListeners();
  }

  Future<void> getUserConductorDataByCodUser(String codigoConductor) async {
    UsuarioService usuarioService = UsuarioService();

    vwGetUserDataByCodUser =
        await usuarioService.getUserDataByCodUser(codigoConductor);

    notifyListeners();
  }

  addRampaDescargaItem(RampaDescargaList? item) {
    int contador = detalleRampaDescargaList.length;
    contador++;
    item?.id = contador;
    detalleRampaDescargaList.add(item!);
    notifyListeners();
  }

  addRampaDescargaTable(RampaDescargaTable item) {
    int contador = rampaDescargaTable.length;
    contador++;
    item.num = contador;
    rampaDescargaTable.add(item);
    notifyListeners();
  }

  deleteRampaDescargaTable(int id) {
    for (int i = 0; i < rampaDescargaTable.length; i++) {
      if (rampaDescargaTable[i].num == id) {
        rampaDescargaTable.removeAt(i);
      }
    }
    notifyListeners();
  }

  deleteRampaDescargaList(int id) {
    for (int i = 0; i < detalleRampaDescargaList.length; i++) {
      if (detalleRampaDescargaList[i].id == id) {
        detalleRampaDescargaList.removeAt(i);
      }
    }
    notifyListeners();
  }

  agregarListado(
    int? jornada,
    String? tipoImportacion,
    String? direccionamiento,
    int? nivel,
    int? idServiceOrder,
    int? idUsuario,
    int? idVehicle,
    int? idConductor,
  ) {
    RampaDescargaList? item = RampaDescargaList();
    item.jornada = jornada;
    item.tipoImportacion = tipoImportacion;
    item.direccionamiento = direccionamiento;
    item.numeroNivel = nivel;
    item.idServiceOrder = idServiceOrder;
    item.idUsuarios = idUsuario;
    item.idVehicle = idVehicle;
    item.idConductor = idConductor ?? null;
    addRampaDescargaItem(item);
    notifyListeners();
  }

  cargarRampaDescarga() {
    rampaDescargaServices.createRampaDescargaList(detalleRampaDescargaList);
    notifyListeners();
  }

  Future<void> getVehicleDataByIdAndIdServiceOrder(
    BigInt idVehicle,
    BigInt idServiceOrderRampa,
  ) async {
    VehicleService vehicleService = VehicleService();

    vwVehicleDataModelList = await vehicleService
        .getVehicleByIdAndIdServiceOrder(idVehicle, idServiceOrderRampa);

    notifyListeners();
  }

  Future<void> getVehiculoPendientAprob(
    int idVehicle,
    int idServiceOrderRampa,
  ) async {
    VehicleService vehicleService = VehicleService();

    vwGetDamageReportListModel = await vehicleService.getVehiculoPendientAprob(
        idVehicle, idServiceOrderRampa);

    notifyListeners();
  }
}
