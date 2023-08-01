import 'dart:io';

import 'package:consumar_app/utils/qr_scanner/barcode_scanner_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import '../../../models/carga_liquida/controlCarguio/create_liquida_control_carguio.dart';
import '../../../models/carga_liquida/controlCarguio/update_liquida_control_carguio.dart';
import '../../../models/carga_liquida/controlCarguio/vw_count_dam_by_idserviceorder.dart';
import '../../../models/carga_liquida/controlCarguio/vw_get_liquida_list_tanque.dart';
import '../../../models/carga_liquida/controlCarguio/vw_granel_liquida_cod_conductores.dart';
import '../../../models/carga_liquida/controlCarguio/vw_liquida_do_dam_by_idserviceorder.dart';
import '../../../models/carga_liquida/controlCarguio/vw_liquida_placas_inicio_carguio.dart';
import '../../../models/carga_liquida/controlCarguio/vw_liquida_transporte_by_placa_idserviceorder.dart';
import '../../../models/carga_liquida/controlCarguio/vw_list_liquida_placas_inicio_carguio_idserviceorder.dart';
import '../../../models/file_upload_result.dart';
import '../../../services/carga_liquida/control_carguio_liquida_service.dart';
import '../../../services/file_upload_result.dart';
import '../../../utils/constants.dart';

class LiquidaControlCarguio extends StatefulWidget {
  const LiquidaControlCarguio(
      {super.key,
      required this.jornada,
      required this.idUsuario,
      required this.idServiceOrder});
  final int jornada;
  final int idUsuario;
  final int idServiceOrder;

  @override
  State<LiquidaControlCarguio> createState() => _LiquidaControlCarguioState();
}

class ListFotoLiquidaCarguio {
  ListFotoLiquidaCarguio({this.id, this.fotoCarguio, this.urlFoto});

  int? id;
  File? fotoCarguio;
  String? urlFoto;
  String? operacionCarguio;
}

class ListFotoTerminoCarguio {
  ListFotoTerminoCarguio({this.id, this.fotoCarguio, this.urlFoto});

  int? id;
  File? fotoCarguio;
  String? urlFoto;
  String? operacionCarguio;
}

class Tanque {
  final String? tanque;

  Tanque({
    this.tanque,
  });
}

class _LiquidaControlCarguioState extends State<LiquidaControlCarguio>
    with SingleTickerProviderStateMixin {
  File? imageCarguio;

  File? imageTerminoCarguio;

  String stringList = "";

  List<String> listaTanqueAdd = [];

  late List<String?> cityNames;

  List<ListFotoLiquidaCarguio> listFotoLiquidaCarguio = [];

  List<ListFotoTerminoCarguio> listFotoTerminoCarguio = [];

  String _valueTanqueDropdown = 'Seleccione el Tanque';

  String _valuePlacaDropdown = 'Seleccione la Placa';

  bool valueSoplado = false;

  late int idCarguio;
  late int idConductor;
  late int idTransporte;

  int saldo = 0;

  ControlCarguioLiquidaService controlCarguioLiquidaService =
      ControlCarguioLiquidaService();

  final nTicketController = TextEditingController();

  final tanquesText = TextEditingController();

  final placaController = TextEditingController();
  final deliveryOrderController = TextEditingController();
  final cisternaController = TextEditingController();

  final _viajesRealizadosController = TextEditingController();
  final _viajesTotalesController = TextEditingController();
  final _saldoController = TextEditingController();

  final damController = TextEditingController();

  final codigoTransporteController = TextEditingController();

  final nombreTransporteController = TextEditingController();

  final cisternaLecturaController = TextEditingController();

  final transporteLecturaController = TextEditingController();

  final codigoConductorController = TextEditingController();

  final nombreConductorController = TextEditingController();

  VwGranelLiquidaCodConductores vwgetUserDataByCodUser =
      VwGranelLiquidaCodConductores();

  List<VwLiquidaTransporteByPlacaIdserviceorder>
      vwLiquidaTransporteByPlacaIdserviceorder = [];

  getUserConductorDataByCodUser() async {
    vwgetUserDataByCodUser = await controlCarguioLiquidaService
        .getGranelLiquidaCodConductores(codigoConductorController.text);

    nombreConductorController.text =
        "${vwgetUserDataByCodUser.nombreApellidos!}";
    idConductor = vwgetUserDataByCodUser.idConductores!;
  }

  getTransporteByCod() async {
    vwLiquidaTransporteByPlacaIdserviceorder =
        await controlCarguioLiquidaService.getLiquidaTransporteByPlacas(
            widget.idServiceOrder, codigoTransporteController.text);

    nombreTransporteController.text =
        vwLiquidaTransporteByPlacaIdserviceorder[0].empresaTransporte!;
    idTransporte = vwLiquidaTransporteByPlacaIdserviceorder[0].idTransporte!;
  }

  Future<List<SpCreateLiquidaFotosCarguio>> parseFotosInicioCarguio() async {
    FileUploadService fileUploadService = FileUploadService();

    List<SpCreateLiquidaFotosCarguio> spCreateLiquidaFotosCarguio = [];
    FileUploadResult fileUploadResult = FileUploadResult();
    for (int count = 0; count < listFotoLiquidaCarguio.length; count++) {
      SpCreateLiquidaFotosCarguio aux = SpCreateLiquidaFotosCarguio();
      aux.urlFoto = listFotoLiquidaCarguio[count].urlFoto;
      aux.operacionCarguio = "inicio";
      spCreateLiquidaFotosCarguio.add(aux);
      File file = File(aux.urlFoto!);
      fileUploadResult = await fileUploadService.uploadFile(file);
      spCreateLiquidaFotosCarguio[count].urlFoto = fileUploadResult.urlPhoto;
      spCreateLiquidaFotosCarguio[count].nombreFoto = fileUploadResult.fileName;
    }
    return spCreateLiquidaFotosCarguio;
  }

  Future<List<SpCreateLiquidaFotosCarguio>> parseFotosTerminoCarguio() async {
    FileUploadService fileUploadService = FileUploadService();

    List<SpCreateLiquidaFotosCarguio> spCreateLiquidaFotosCarguio = [];
    FileUploadResult fileUploadResult = FileUploadResult();
    for (int count = 0; count < listFotoTerminoCarguio.length; count++) {
      SpCreateLiquidaFotosCarguio aux = SpCreateLiquidaFotosCarguio();
      aux.urlFoto = listFotoTerminoCarguio[count].urlFoto;
      aux.operacionCarguio = "termino";
      aux.idCarguio = idCarguio;
      spCreateLiquidaFotosCarguio.add(aux);
      File file = File(aux.urlFoto!);
      fileUploadResult = await fileUploadService.uploadFile(file);
      spCreateLiquidaFotosCarguio[count].urlFoto = fileUploadResult.urlPhoto;
      spCreateLiquidaFotosCarguio[count].nombreFoto = fileUploadResult.fileName;
    }
    return spCreateLiquidaFotosCarguio;
  }

  createLiquidaControlCarguio() async {
    /* late bool inspeccion;
    if (valueSoplado == false) {
      inspeccion = false;
    } else if (valueSoplado == true) {
      inspeccion = true;
    } */
    List<SpCreateLiquidaFotosCarguio> spCreateLiquidaFotosCarguio = [];

    spCreateLiquidaFotosCarguio = await parseFotosInicioCarguio();

    await controlCarguioLiquidaService.createLiquidaControlCarguio(
        CreateLiquidaControlCarguio(
            spCreateLiquidaControlCarguio: SpCreateLiquidaControlCarguio(
                jornada: widget.jornada,
                soplado: valueSoplado,
                tanque: stringList,
                fecha: DateTime.now(),
                dam: damController.text,
                nTicket: nTicketController.text,
                idConductor: idConductor,
                deliveryOrder: deliveryOrderController.text,
                idTransporte: idTransporte,
                inicioCarguio: dateInicio,
                terminoCarguio: null,
                placa: placaController.text,
                cisterna: cisternaController.text,
                idUsuario: widget.idUsuario,
                idServiceOrder: widget.idServiceOrder),
            spCreateLiquidaFotosCarguio: spCreateLiquidaFotosCarguio));

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("Inicio Carguio Registrado"),
      backgroundColor: Colors.green,
    ));

    setState(() {
      getListPlacasCarguio();
    });
  }

  createFotoCarguio() async {
    List<SpCreateLiquidaFotosCarguio> spCreateLiquidaFotosCarguio = [];

    spCreateLiquidaFotosCarguio = await parseFotosTerminoCarguio();

    controlCarguioLiquidaService
        .createLiquidaFotoTerminoCarguio(spCreateLiquidaFotosCarguio);
  }

  clearFiels() {
    setState(() {
      listFotoLiquidaCarguio.clear();
      damController.clear();
      imageCarguio = null;
      valueSoplado = false;
      nTicketController.clear();
      codigoTransporteController.clear();
      nombreConductorController.clear();
      nombreTransporteController.clear();
      codigoConductorController.clear();
      deliveryOrderController.clear();
      placaController.clear();
      cisternaController.clear();
    });
  }

  DateTime dateInicio = DateTime.now();
  DateTime dateTermino = DateTime.now();

  late TabController _tabController;

  List<VwGetLiquidaListTanque> vwGetLiquidaListTanque =
      <VwGetLiquidaListTanque>[];

  getTanques() async {
    List<VwGetLiquidaListTanque> value =
        await controlCarguioLiquidaService.getListTanque();

    setState(() {
      vwGetLiquidaListTanque = value;
    });
  }

  updateTerminoCarguio() {
    controlCarguioLiquidaService.updateTerminoCarguioById(
        UpdateLiquidaControlCarguio(
            idCarguio: idCarguio, terminoCarguio: dateTermino));

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("Termino Carguio Registrado"),
      backgroundColor: Colors.green,
    ));
  }

  List<DropdownMenuItem<String>> getDropdownPlacasCarguio(
      List<VwListLiquidaPlacasInicioCarguioIdserviceorder> tanques) {
    List<DropdownMenuItem<String>> dropDownItems = [];

    for (var element in tanques) {
      var newDropDown = DropdownMenuItem(
        value: element.idCarguio.toString(),
        child: Text(
          element.placa.toString(),
        ),
      );
      dropDownItems.add(newDropDown);
    }
    return dropDownItems;
  }

  List<VwListLiquidaPlacasInicioCarguioIdserviceorder> vwListLiquidaPlacas =
      <VwListLiquidaPlacasInicioCarguioIdserviceorder>[];

  getListPlacasCarguio() async {
    List<VwListLiquidaPlacasInicioCarguioIdserviceorder> value =
        await controlCarguioLiquidaService
            .getListLiquidaPlacasInicioCarguioIdserviceorder(
                widget.idServiceOrder);

    setState(() {
      vwListLiquidaPlacas = value;
    });
  }

  getPlacaDataIncioById(int id) async {
    List<VwLiquidaPlacasInicioCarguio> vwLiquidaPlacasInicioCarguioById = [];

    vwLiquidaPlacasInicioCarguioById = await controlCarguioLiquidaService
        .getLiquidaPlacasInicioCarguio(widget.idServiceOrder, id);

    idCarguio = vwLiquidaPlacasInicioCarguioById[0].idCarguio!;
    placaController.text = vwLiquidaPlacasInicioCarguioById[0].placa!;
    transporteLecturaController.text =
        vwLiquidaPlacasInicioCarguioById[0].empresaTransporte!;
    cisternaLecturaController.text =
        vwLiquidaPlacasInicioCarguioById[0].cisterna!;
  }

  List<VwLiquidaDoDamByIdserviceorder> vwLiquidaDoDamByIdserviceorder = [];

  getVerificacionDoDam(String dodam, String dam) async {
    List<VwLiquidaDoDamByIdserviceorder> value =
        await controlCarguioLiquidaService.getLiquidaDoDamByIdserviceorder(
            widget.idServiceOrder, dodam, dam);

    setState(() {
      vwLiquidaDoDamByIdserviceorder = value;
    });

    _viajesTotalesController.text =
        vwLiquidaDoDamByIdserviceorder[0].totalViajes.toString();

    if (vwLiquidaDoDamByIdserviceorder.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Do/Dam Encontrada"),
        backgroundColor: Colors.greenAccent,
      ));
    }
    setState(() {
      calcularSaldo();
    });
  }

  List<VwCountDamByIdserviceorder> vwCountDamByIdserviceorder = [];

  getCountDam(String dam) async {
    List<VwCountDamByIdserviceorder> value = await controlCarguioLiquidaService
        .getLiquidaCountDamByIdServiceOrder(widget.idServiceOrder, dam);

    setState(() {
      vwCountDamByIdserviceorder = value;
    });

    _viajesRealizadosController.text =
        vwCountDamByIdserviceorder[0].conteoDam.toString();

    setState(() {
      calcularSaldo();
    });
    //debugPrint(vwListaPrecintoLiquidaByIdPrecinto.length as String?);

    /* if (vwCountDamByIdserviceorder.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Dam Encontrada"),
        backgroundColor: Colors.greenAccent,
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Registro no encontrado"),
        backgroundColor: Colors.redAccent,
      ));
    }  */
  }

  calcularSaldo() {
    setState(() {
      saldo = vwLiquidaDoDamByIdserviceorder[0].totalViajes! -
          vwCountDamByIdserviceorder[0].conteoDam!;
      _saldoController.text = saldo.toString();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    getTanques();
    getListPlacasCarguio();
  }

  @override
  Widget build(BuildContext context) {
    final hours1 = dateInicio.hour.toString().padLeft(2, '0');
    final minutes1 = dateInicio.minute.toString().padLeft(2, '0');
    final hours2 = dateTermino.hour.toString().padLeft(2, '0');
    final minutes2 = dateTermino.minute.toString().padLeft(2, '0');

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
            centerTitle: true,
            title: const Text("Liquida Control Carguío"),
            bottom: TabBar(
                indicatorColor: kColorCeleste,
                labelColor: kColorCeleste,
                controller: _tabController,
                unselectedLabelColor: Colors.white,
                tabs: const [
                  Tab(
                    icon: Icon(
                      Icons.app_registration,
                    ),
                    child: Text(
                      'INICIO CARGUIO',
                    ),
                  ),
                  Tab(
                    icon: Icon(
                      Icons.checklist,
                    ),
                    child: Text('TERMINO CARGUIO'),
                  ),
                ])),
        body: TabBarView(controller: _tabController, children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(children: [
                Row(
                  children: [
                    Text("Soplado",
                        style: TextStyle(
                            fontSize: 20,
                            color: kColorAzul,
                            fontWeight: FontWeight.w500)),
                    const SizedBox(width: 5),
                    Switch(
                      value: valueSoplado,
                      onChanged: (value) => setState(() {
                        valueSoplado = value;
                      }),
                      activeTrackColor: Colors.lightGreenAccent,
                      activeColor: Colors.green,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 270,
                        child: DropdownButtonFormField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            labelText: 'Tanque',
                            labelStyle: TextStyle(
                              color: kColorAzul,
                              fontSize: 20.0,
                            ),
                          ),
                          icon: const Icon(
                            Icons.arrow_drop_down_circle_outlined,
                          ),
                          items: getLiquidaListaTanque(vwGetLiquidaListTanque),
                          onChanged: (value) => {
                            setState(() {
                              _valueTanqueDropdown = value as String;
                            })
                          },
                          validator: (value) {
                            if (value != _valueTanqueDropdown) {
                              return 'Por favor, elige el tanque';
                            }
                            return null;
                          },
                          hint: Text(_valueTanqueDropdown),
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            listaTanqueAdd.add(_valueTanqueDropdown);
                            setState(() {
                              stringList = listaTanqueAdd.join(", ");
                              tanquesText.text = stringList;
                            });
                            print(stringList);
                          },
                          icon: Icon(
                            Icons.add_box,
                            color: kColorAzul,
                          ))
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  "LISTA TANQUE AGREGADOS:",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 7),
                Text(
                  stringList,
                  style: TextStyle(fontSize: 15),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      labelText: 'N° Ticket',
                      labelStyle: TextStyle(
                        color: kColorAzul,
                        fontSize: 20.0,
                      ),
                      hintText: 'Ingrese el N° Ticket'),
                  onChanged: (value) {},
                  controller: nTicketController,
                  /* validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, ingrese la Placa';
                      }
                      idUsuario = BigInt.parse(value);
                        return null;
                    }, */
                  //enabled: enableQrUsuario
                ),
                const SizedBox(height: 20),
                Container(
                  height: 40,
                  color: kColorAzul,
                  child: const Center(
                    child: Text("TRANSPORTE",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white)),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      prefixIcon: IconButton(
                          icon: const Icon(Icons.code),
                          onPressed: () async {
                            final result = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    /*builder: (context) =>
                                        const ScannerScreen()));*/
                                    builder: (context) =>
                                        const BarcodeScannerWithScanWindow()));
                            codigoTransporteController.text = result;
                          }),
                      suffixIcon: IconButton(
                          icon: const Icon(Icons.search),
                          onPressed: () {
                            getTransporteByCod();
                          }),
                      labelText: 'Codigo Transporte',
                      labelStyle: TextStyle(
                        color: kColorAzul,
                        fontSize: 20.0,
                      ),
                      hintText: 'Ingrese Codigo de Transporte'),
                  onChanged: (value) {
                    getTransporteByCod();
                  },
                  controller: codigoTransporteController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, Ingrese codigo de transporte';
                    }
                    return null;
                  },
                  //enabled: enableConductorController,
                ),
                /* TextFormField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      prefixIcon: IconButton(
                          icon: const Icon(Icons.closed_caption_off_rounded),
                          onPressed: () async {
                            final result = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const ScannerScreen()));
                            placaController.text = result;
                          }),
                      labelText: 'Placa',
                      labelStyle: TextStyle(
                        color: kColorAzul,
                        fontSize: 20.0,
                      ),
                      hintText: 'Ingrese la Placa'),
                  onChanged: (value) {},
                  controller: placaController,
                  /* validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, ingrese la Placa';
                      }
                      idUsuario = BigInt.parse(value);
                      return null;
                    }, */
                ), */
                const SizedBox(height: 20),
                TextFormField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      prefixIcon: Icon(
                        Icons.badge,
                        color: kColorAzul,
                      ),
                      labelText: 'Nombre Transporte',
                      labelStyle: TextStyle(
                        color: kColorAzul,
                        fontSize: 20.0,
                      ),
                      hintText: ''),
                  controller: nombreTransporteController,
                  enabled: false,
                ),

                /*    const SizedBox(height: 20.0),
                TextFormField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      prefixIcon: IconButton(
                          icon: const Icon(Icons.code),
                          onPressed: () async {
                            final result = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const ScannerScreen()));
                            codigoTransporteController.text = result;
                          }),
                      suffixIcon: IconButton(
                          icon: const Icon(Icons.search),
                          onPressed: () {
                            getTransporteByCod();
                          }),
                      labelText: 'Codigo Transporte',
                      labelStyle: TextStyle(
                        color: kColorAzul,
                        fontSize: 20.0,
                      ),
                      hintText: 'Ingrese Codigo de Transporte'),
                  onChanged: (value) {
                    getTransporteByCod();
                  },
                  controller: codigoTransporteController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, Ingrese codigo de transporte';
                    }
                    return null;
                  },
                  //enabled: enableConductorController,
                ),
                const SizedBox(
                  height: 20,
                ), */
                const SizedBox(height: 20.0),
                TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    prefixIcon: Icon(
                      Icons.directions_boat,
                      color: kColorAzul,
                    ),
                    labelText: 'Cisterna',
                    labelStyle: TextStyle(
                      color: kColorAzul,
                      fontSize: 20.0,
                    ),
                    hintText: '',
                  ),
                  controller: cisternaController,
                ),
                const SizedBox(height: 20.0),
                TextFormField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      prefixIcon: IconButton(
                          icon: const Icon(Icons.code),
                          onPressed: () async {
                            final result = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    /*    builder: (context) =>
                                        const ScannerScreen()));*/
                                    builder: (context) =>
                                        const BarcodeScannerWithScanWindow()));
                            codigoConductorController.text = result;
                          }),
                      suffixIcon: IconButton(
                          icon: const Icon(Icons.search),
                          onPressed: () {
                            getUserConductorDataByCodUser();
                          }),
                      labelText: 'Codigo conductor',
                      labelStyle: TextStyle(
                        color: kColorAzul,
                        fontSize: 20.0,
                      ),
                      hintText: 'Ingrese codigo de conductor'),
                  onChanged: (value) {
                    getUserConductorDataByCodUser();
                  },
                  controller: codigoConductorController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, Ingrese codigo de conductor';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      prefixIcon: Icon(
                        Icons.badge,
                        color: kColorAzul,
                      ),
                      labelText: 'Nombre conductor',
                      labelStyle: TextStyle(
                        color: kColorAzul,
                        fontSize: 20.0,
                      ),
                      hintText: ''),
                  controller: nombreConductorController,
                  /* validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, Ingrese datos de conductor';
                    }
                    return null;
                  }, */
                  enabled: false,
                ),
                const SizedBox(height: 20.0),
                TextFormField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      prefixIcon: IconButton(
                          icon: Icon(
                            Icons.delivery_dining,
                            color: kColorAzul,
                          ),
                          onPressed: () async {}),
                      /*   suffixIcon: IconButton(
                            icon: const Icon(Icons.search), onPressed: () {}), */
                      labelText: 'Delivery Order',
                      labelStyle: TextStyle(
                        color: kColorAzul,
                        fontSize: 20.0,
                      ),
                      hintText: 'Ingrese el Delivery Order'),
                  onChanged: (value) {
                    getVerificacionDoDam(
                        deliveryOrderController.text, damController.text);
                    getCountDam(damController.text);
                    // calcularSaldo();
                  },
                  controller: deliveryOrderController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, ingrese el Delivery Order';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20.0),
                TextFormField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      prefixIcon: IconButton(
                          icon: Icon(
                            Icons.delivery_dining,
                            color: kColorAzul,
                          ),
                          onPressed: () async {}),
                      /* suffixIcon: IconButton(
                            icon: const Icon(Icons.search), onPressed: () {}), */
                      labelText: 'DAM',
                      labelStyle: TextStyle(
                        color: kColorAzul,
                        fontSize: 20.0,
                      ),
                      hintText: 'Ingrese el DAM'),
                  onChanged: (value) {
                    getVerificacionDoDam(
                        deliveryOrderController.text, damController.text);
                    getCountDam(damController.text);
                    calcularSaldo();
                  },
                  controller: damController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, ingrese el DAM';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20.0),
                Container(
                  height: 40,
                  color: kColorAzul,
                  child: const Center(
                    child: Text("VIAJES",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white)),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          prefixIcon: Icon(
                            Icons.mode_of_travel,
                            color: kColorAzul,
                          ),
                          labelText: 'Viajes Totales',
                          labelStyle: TextStyle(
                            color: kColorAzul,
                            fontSize: 20.0,
                          ),
                          hintText: '',
                        ),
                        controller: _viajesTotalesController,
                        enabled: false,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          prefixIcon: Icon(
                            Icons.balance,
                            color: kColorAzul,
                          ),
                          labelText: 'Saldo',
                          labelStyle: TextStyle(
                            color: kColorAzul,
                            fontSize: 20.0,
                          ),
                          hintText: '',
                        ),
                        controller: _saldoController,
                        enabled: false,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    prefixIcon: Icon(
                      Icons.mode_of_travel,
                      color: kColorAzul,
                    ),
                    labelText: 'Viajes Realizados',
                    labelStyle: TextStyle(
                      color: kColorAzul,
                      fontSize: 20.0,
                    ),
                    hintText: '',
                  ),
                  controller: _viajesRealizadosController,
                  enabled: false,
                ),
                const SizedBox(height: 20),
                Container(
                  height: 40,
                  color: kColorAzul,
                  child: const Center(
                    child: Text("HORA DE CARGUIO",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white)),
                  ),
                ),
                const SizedBox(height: 20),
                Row(children: [
                  Expanded(
                      flex: 3,
                      child: Text(
                        "INICIO CARGUIO:",
                        style: TextStyle(
                            fontSize: 20,
                            color: kColorAzul,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.5),
                      )),
                  Expanded(
                    flex: 2,
                    child: TextFormField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          prefixIcon: Icon(
                            Icons.calendar_month,
                            color: kColorAzul,
                          ),
                          labelText: /* ${dateTime.day}/${dateTime.month}/${dateTime.year} */
                              '$hours1:$minutes1',
                          labelStyle: TextStyle(
                            color: kColorAzul,
                            fontSize: 20.0,
                          ),
                          enabled: false),
                    ),
                  ),
                ]),
                const SizedBox(height: 20.0),
                MaterialButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    minWidth: double.infinity,
                    height: 50.0,
                    color: kColorCeleste,
                    onPressed: pickDateTime1,
                    child: Text(
                      "Hora - Inicio Carguio",
                      style: TextStyle(
                        fontSize: 20,
                        color: kColorAzul,
                        fontWeight: FontWeight.bold, /* letterSpacing: 1.5 */
                      ),
                    )),
                const SizedBox(height: 20.0),
                Container(
                  height: 40,
                  color: kColorAzul,
                  child: const Center(
                    child: Text("REGISTRO FOTOGRAFICO",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white)),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    border: Border.all(
                      width: 1,
                      color: Colors.grey,
                    ),
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 15),
                      Text(
                        "Ingrese Fotos del Carguio",
                        style: TextStyle(
                            fontSize: 15,
                            color: kColorAzul,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(width: 1, color: Colors.grey),
                            ),
                            width: 150,
                            height: 150,
                            child: imageCarguio != null
                                ? Image.file(imageCarguio!,
                                    width: 150, height: 150, fit: BoxFit.cover)
                                : Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Transform.scale(
                                        scale: 3,
                                        child: const Icon(
                                          Icons.camera_alt,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      const Center(
                                          child: Text(
                                        "Inserte Foto de la Bodega",
                                        style: TextStyle(color: Colors.grey),
                                        textAlign: TextAlign.center,
                                      )),
                                    ],
                                  ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.40,
                                child: ElevatedButton(
                                    style: TextButton.styleFrom(
                                      backgroundColor: kColorNaranja,
                                      padding: const EdgeInsets.all(10.0),
                                    ),
                                    onPressed: (() => pickCarguioInicioFoto(
                                        ImageSource.gallery)),
                                    child: const Text(
                                      "Abrir Galería",
                                      style: TextStyle(fontSize: 18),
                                    )),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.40,
                                child: ElevatedButton(
                                    style: TextButton.styleFrom(
                                      backgroundColor: kColorNaranja,
                                      padding: const EdgeInsets.all(10.0),
                                    ),
                                    onPressed: (() => pickCarguioInicioFoto(
                                        ImageSource.camera)),
                                    child: const Text(
                                      "Tomar Foto",
                                      style: TextStyle(fontSize: 18),
                                    )),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
                const SizedBox(height: 20.0),
                MaterialButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  minWidth: double.infinity,
                  height: 50.0,
                  color: kColorCeleste,
                  onPressed: () {
                    setState(() {
                      listFotoLiquidaCarguio.add(ListFotoLiquidaCarguio(
                          fotoCarguio: imageCarguio!,
                          urlFoto: imageCarguio!.path));
                    });
                    imageCarguio = null;
                  },
                  child: Text(
                    "AGREGAR FOTO CARGUIO",
                    style: TextStyle(
                      fontSize: 20,
                      color: kColorAzul,
                      fontWeight: FontWeight.bold, /* letterSpacing: 1.5 */
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        color: Colors.white),
                    height: 400,
                    child: ListView.builder(
                        itemCount: listFotoLiquidaCarguio.length,
                        itemBuilder: (_, int i) {
                          return Column(children: [
                            const SizedBox(height: 10),
                            Container(
                              decoration: BoxDecoration(
                                border:
                                    Border.all(width: 1, color: Colors.grey),
                              ),
                              width: 200,
                              height: 200,
                              child: listFotoLiquidaCarguio[i].fotoCarguio !=
                                      null
                                  ? Image.file(
                                      listFotoLiquidaCarguio[i].fotoCarguio!,
                                      /* width: 150, height: 150, */ fit:
                                          BoxFit.cover)
                                  : Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Transform.scale(
                                          scale: 3,
                                          child: const Icon(
                                            Icons.camera_alt,
                                            color: Colors.grey,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        const Center(
                                            child: Text(
                                          "No Image",
                                          style: TextStyle(color: Colors.grey),
                                          textAlign: TextAlign.center,
                                        )),
                                      ],
                                    ),
                            ),
                            const Divider(),
                          ]);
                        })),
                const SizedBox(height: 20.0),
                MaterialButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  minWidth: double.infinity,
                  height: 50.0,
                  color: kColorNaranja,
                  onPressed: () async {
                    if (vwLiquidaDoDamByIdserviceorder.isNotEmpty) {
                      await createLiquidaControlCarguio();
                      clearFiels();
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                            "Los Datos no son correctos, validar antes realizar registros"),
                        backgroundColor: Colors.redAccent,
                      ));
                    }
                  },
                  child: const Text(
                    "Cargar Datos",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5),
                  ),
                ),
              ]),
            ),
          ),
          SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(children: [
                  DropdownButtonFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      labelText: 'Placa',
                      labelStyle: TextStyle(
                        color: kColorAzul,
                        fontSize: 20.0,
                      ),
                    ),
                    icon: const Icon(
                      Icons.arrow_drop_down_circle_outlined,
                    ),
                    items: getDropdownPlacasCarguio(vwListLiquidaPlacas),
                    onChanged: (value) => {
                      setState(() {
                        _valuePlacaDropdown = value as String;
                      }),
                      getPlacaDataIncioById(int.parse(value.toString()))
                    },
                    validator: (value) {
                      if (value != _valuePlacaDropdown) {
                        return 'Por favor, elige la Placa';
                      }
                      return null;
                    },
                    hint: Text(_valuePlacaDropdown),
                  ),
                  const SizedBox(height: 20),
                  Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      color: Colors.white,
                      //shadowColor: Colors.grey,
                      elevation: 10,
                      borderOnForeground: true,
                      //margin: const EdgeInsets.all(10),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            //Caja de texto Responsable
                            TextFormField(
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  prefixIcon: Icon(
                                    Icons.numbers,
                                    color: kColorAzul,
                                  ),
                                  labelText: 'Transporte',
                                  labelStyle: TextStyle(
                                    color: kColorAzul,
                                    fontSize: 20.0,
                                  ),
                                  hintText: ''),
                              controller: transporteLecturaController,
                              enabled: false,
                            ),

                            //Caja de texto Tipo de importación
                            TextFormField(
                              decoration: InputDecoration(
                                /*border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),*/
                                border: InputBorder.none,
                                prefixIcon: Icon(
                                  Icons.directions_car,
                                  color: kColorAzul,
                                ),
                                labelText: 'Cisterna',
                                labelStyle: TextStyle(
                                  color: kColorAzul,
                                  fontSize: 20.0,
                                ), /* hintText: 'Ingrese cisterna' */
                              ),
                              controller: cisternaLecturaController,
                              enabled: false,
                            ),
                          ],
                        ),
                      )),
                  const SizedBox(height: 20),
                  Container(
                    height: 40,
                    color: kColorAzul,
                    child: const Center(
                      child: Text("TERMINO DE CARGUIO",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(children: [
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          prefixIcon: Icon(
                            Icons.timer,
                            color: kColorAzul,
                          ),
                          labelText: 'Termino de Carguio',
                          labelStyle: TextStyle(
                            color: kColorAzul,
                            fontSize: 20.0,
                          ),
                          hintText: '',
                          enabled: false,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          prefixIcon: Icon(
                            Icons.calendar_month,
                            color: kColorAzul,
                          ),
                          labelText: '$hours2:$minutes2',
                          labelStyle: TextStyle(
                            color: kColorAzul,
                            fontSize: 20.0,
                          ),
                        ),
                        enabled: false,
                        //hintText: 'Ingrese el numero de ID del Job'),
                        //controller: TransporteController,
                      ),
                    )
                  ]),
                  const SizedBox(height: 20),
                  MaterialButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      minWidth: double.infinity,
                      height: 50.0,
                      color: kColorCeleste,
                      onPressed: pickDateTime2,
                      child: Text(
                        "Hora - Termino Carguio",
                        style: TextStyle(
                          fontSize: 20,
                          color: kColorAzul,
                          fontWeight: FontWeight.bold, /* letterSpacing: 1.5 */
                        ),
                      )),
                  const SizedBox(height: 20),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      border: Border.all(
                        width: 1,
                        color: Colors.grey,
                      ),
                    ),
                    child: Column(
                      children: [
                        const SizedBox(height: 15),
                        Text(
                          "Ingrese Fotos del Termino de Carguio",
                          style: TextStyle(
                              fontSize: 15,
                              color: kColorAzul,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                border:
                                    Border.all(width: 1, color: Colors.grey),
                              ),
                              width: 150,
                              height: 150,
                              child: imageTerminoCarguio != null
                                  ? Image.file(imageTerminoCarguio!,
                                      width: 150,
                                      height: 150,
                                      fit: BoxFit.cover)
                                  : Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Transform.scale(
                                          scale: 3,
                                          child: const Icon(
                                            Icons.camera_alt,
                                            color: Colors.grey,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        const Center(
                                            child: Text(
                                          "Inserte Foto Termino Carguio",
                                          style: TextStyle(color: Colors.grey),
                                          textAlign: TextAlign.center,
                                        )),
                                      ],
                                    ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.40,
                                  child: ElevatedButton(
                                      style: TextButton.styleFrom(
                                        backgroundColor: kColorNaranja,
                                        padding: const EdgeInsets.all(10.0),
                                      ),
                                      onPressed: (() => pickCarguioTerminoFoto(
                                          ImageSource.gallery)),
                                      child: const Text(
                                        "Abrir Galería",
                                        style: TextStyle(fontSize: 18),
                                      )),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.40,
                                  child: ElevatedButton(
                                      style: TextButton.styleFrom(
                                        backgroundColor: kColorNaranja,
                                        padding: const EdgeInsets.all(10.0),
                                      ),
                                      onPressed: (() => pickCarguioTerminoFoto(
                                          ImageSource.camera)),
                                      child: const Text(
                                        "Tomar Foto",
                                        style: TextStyle(fontSize: 18),
                                      )),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  MaterialButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    minWidth: double.infinity,
                    height: 50.0,
                    color: kColorCeleste,
                    onPressed: () {
                      setState(() {
                        listFotoTerminoCarguio.add(ListFotoTerminoCarguio(
                            fotoCarguio: imageTerminoCarguio!,
                            urlFoto: imageTerminoCarguio!.path));
                      });
                      imageTerminoCarguio = null;
                    },
                    child: Text(
                      "AGREGAR FOTO TERMINO",
                      style: TextStyle(
                        fontSize: 20,
                        color: kColorAzul,
                        fontWeight: FontWeight.bold, /* letterSpacing: 1.5 */
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          color: Colors.white),
                      height: 400,
                      child: ListView.builder(
                          itemCount: listFotoTerminoCarguio.length,
                          itemBuilder: (_, int i) {
                            return Column(children: [
                              const SizedBox(height: 10),
                              Container(
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(width: 1, color: Colors.grey),
                                ),
                                width: 200,
                                height: 200,
                                child: listFotoTerminoCarguio[i].fotoCarguio !=
                                        null
                                    ? Image.file(
                                        listFotoTerminoCarguio[i].fotoCarguio!,
                                        /* width: 150, height: 150, */ fit:
                                            BoxFit.cover)
                                    : Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Transform.scale(
                                            scale: 3,
                                            child: const Icon(
                                              Icons.camera_alt,
                                              color: Colors.grey,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          const Center(
                                              child: Text(
                                            "No Image",
                                            style:
                                                TextStyle(color: Colors.grey),
                                            textAlign: TextAlign.center,
                                          )),
                                        ],
                                      ),
                              ),
                              const Divider(),
                            ]);
                          })),
                  const SizedBox(height: 20),
                  MaterialButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    minWidth: double.infinity,
                    height: 50.0,
                    color: kColorNaranja,
                    onPressed: () async {
                      updateTerminoCarguio();
                      await createFotoCarguio();
                      setState(() {
                        imageTerminoCarguio = null;
                        listFotoTerminoCarguio.clear();
                      });
                    },
                    child: const Text(
                      "REGISTRAR TERMINO",
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.5),
                    ),
                  ),
                ])),
          ),
        ]),
      ),
    );
  }

  List<DropdownMenuItem<String>> getLiquidaListaTanque(
      List<VwGetLiquidaListTanque> bodegas) {
    List<DropdownMenuItem<String>> dropDownItems = [];

    for (var element in bodegas) {
      var newDropDown = DropdownMenuItem(
        value: element.tanque.toString(),
        child: Text(
          element.tanque.toString(),
        ),
      );
      dropDownItems.add(newDropDown);
    }
    return dropDownItems;
  }

  Future pickCarguioTerminoFoto(ImageSource source) async {
    try {
      final imageTerminoCarguio = await ImagePicker().pickImage(source: source);

      if (imageTerminoCarguio == null) return;

      final imageTemporary = File(imageTerminoCarguio.path);

      setState(() => this.imageTerminoCarguio = imageTemporary);
    } on PlatformException catch (e) {
      // print('Failed to pick image: $e');
      e.message;
    }
  }

  Future pickCarguioInicioFoto(ImageSource source) async {
    try {
      final imageCarguio = await ImagePicker().pickImage(source: source);

      if (imageCarguio == null) return;

      final imageTemporary = File(imageCarguio.path);

      setState(() => this.imageCarguio = imageTemporary);
    } on PlatformException catch (e) {
      // print('Failed to pick image: $e');
      e.message;
    }
  }

  Future pickDateTime1() async {
    DateTime? date = DateTime.now();
    //if (date == null) return;
    TimeOfDay? time = await pickTime1();
    if (time == null) return;

    final dateTime1 = DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );
    setState(() => dateInicio = dateTime1);
  }

  Future<TimeOfDay?> pickTime1() => showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: dateInicio.hour, minute: dateInicio.minute));

/*-------------------------------------------- */
  Future pickDateTime2() async {
    DateTime? date = DateTime.now();
    //if (date == null) return;
    TimeOfDay? time = await pickTime2();
    if (time == null) return;

    final dateTime2 = DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );
    setState(() => dateTermino = dateTime2);
  }

  Future<TimeOfDay?> pickTime2() => showTimePicker(
      context: context,
      initialTime:
          TimeOfDay(hour: dateTermino.hour, minute: dateTermino.minute));
}
