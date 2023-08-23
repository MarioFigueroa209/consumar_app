import 'dart:io';
import 'package:consumar_app/models/survey/ControlCarguio/vw_granel_placas_inicio_carguio.dart';
import 'package:consumar_app/utils/qr_scanner/barcode_scanner_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import '../../../models/carga_liquida/controlCarguio/vw_granel_liquida_cod_conductores.dart';
import '../../../models/file_upload_result.dart';
import '../../../models/survey/ControlCarguio/create_control_carguio.dart';
import '../../../models/survey/ControlCarguio/update_granel_control_carguio.dart';
import '../../../models/survey/ControlCarguio/vw_count_granel_dam_by_idServiceOrder.dart';
import '../../../models/survey/ControlCarguio/vw_granel_consulta_transporte_by_cod.dart';
import '../../../models/survey/ControlCarguio/vw_granel_do_dam_by_idserviceorder.dart';
import '../../../models/survey/ControlCarguio/vw_granel_lista_bodegas.dart';
import '../../../models/survey/ControlCarguio/vw_list_granel_placas_inicio_carguio_idserviceorder.dart';
import '../../../services/carga_liquida/control_carguio_liquida_service.dart';
import '../../../services/file_upload_result.dart';
import '../../../services/survey/control_carguio_service.dart';
import '../../../utils/constants.dart';

class ControlCarguio extends StatefulWidget {
  const ControlCarguio(
      {Key? key,
      required this.jornada,
      required this.idUsuario,
      required this.idServiceOrder})
      : super(key: key);
  final int jornada;
  final int idUsuario;
  final int idServiceOrder;

  @override
  State<ControlCarguio> createState() => _ControlCarguioState();
}

class ListFotoCarguio {
  ListFotoCarguio({this.id, this.fotoCarguio, this.urlFoto});

  int? id;
  File? fotoCarguio;
  String? urlFoto;
}

class ListFotoTerminoCarguio {
  ListFotoTerminoCarguio({this.id, this.fotoCarguio, this.urlFoto});

  int? id;
  File? fotoCarguio;
  String? urlFoto;
}

class _ControlCarguioState extends State<ControlCarguio>
    with SingleTickerProviderStateMixin {
  bool enableBodegaDropdown = true;
  String _valueBodegaDropdown = 'Seleccione la Bodega';
  String _valuePlacaDropdown = 'Seleccione la Placa';

  List<VwGranelListaBodegas> vwGranelListaBodegas = <VwGranelListaBodegas>[];
  TextEditingController transporteController = TextEditingController();
  bool valueBarredura = false;

  final _viajesRealizadosController = TextEditingController();
  final _viajesTotalesController = TextEditingController();
  final _saldoController = TextEditingController();

  final deliveryOrderController = TextEditingController();
  final tovaController = TextEditingController();

  final damController = TextEditingController();

  final nTicketController = TextEditingController();

  final codigoTransporteController = TextEditingController();

  final nombreTransporteController = TextEditingController();

  final codigoConductorController = TextEditingController();

  final nombreConductorController = TextEditingController();

  ControlCarguioService controlCarguioService = ControlCarguioService();

  final TextEditingController placaTolvaLecturaController =
      TextEditingController();
  final TextEditingController nTicketLecturaController =
      TextEditingController();
  final TextEditingController nombreTransporteLecturaController =
      TextEditingController();

  List<ListFotoCarguio> listFotoCarguio = [];

  List<ListFotoTerminoCarguio> listFotoTerminoCarguio = [];

  File? imageCarguio;

  File? imageTerminoCarguio;

  late int idCarguio;

  late TabController _tabController;

  late int idConductor;
  late int idTransporte;

  bool enableQrUsuario = true;

  DateTime dateInicio = DateTime.now();
  DateTime dateTermino = DateTime.now();

  VwGranelLiquidaCodConductores vwgetUserDataByCodUser =
      VwGranelLiquidaCodConductores();

  List<VwGranelConsultaTransporteByCod> vwGranelConsultaTransporteByCod = [];

  getUserConductorDataByCodUser() async {
    ControlCarguioLiquidaService controlCarguioLiquidaService =
        ControlCarguioLiquidaService();

    vwgetUserDataByCodUser = await controlCarguioLiquidaService
        .getGranelLiquidaCodConductores(codigoConductorController.text);

    nombreConductorController.text =
        "${vwgetUserDataByCodUser.nombreApellidos!}";
    idConductor = vwgetUserDataByCodUser.idConductores!;
  }

  getTransporteByCod() async {
    vwGranelConsultaTransporteByCod =
        await controlCarguioService.getGranelConsultaTransporteByCod(
            widget.idServiceOrder, codigoTransporteController.text);

    nombreTransporteController.text =
        vwGranelConsultaTransporteByCod[0].empresaTransporte!;
    idTransporte = vwGranelConsultaTransporteByCod[0].idTransporte!;
  }

  Future<List<SpCreateGranelFotosCarguio>> parseFotosInicioCarguio() async {
    FileUploadService fileUploadService = FileUploadService();

    List<SpCreateGranelFotosCarguio> spCreateGranelFotosCarguio = [];
    FileUploadResult fileUploadResult = FileUploadResult();
    for (int count = 0; count < listFotoCarguio.length; count++) {
      SpCreateGranelFotosCarguio aux = SpCreateGranelFotosCarguio();
      aux.urlFoto = listFotoCarguio[count].urlFoto;
      aux.operacionCarguio = "inicio";
      spCreateGranelFotosCarguio.add(aux);
      File file = File(aux.urlFoto!);
      fileUploadResult = await fileUploadService.uploadFile(file);
      spCreateGranelFotosCarguio[count].urlFoto = fileUploadResult.urlPhoto;
      spCreateGranelFotosCarguio[count].nombreFoto = fileUploadResult.fileName;
    }
    return spCreateGranelFotosCarguio;
  }

  Future<List<SpCreateGranelFotosCarguio>> parseFotosTerminoCarguio() async {
    FileUploadService fileUploadService = FileUploadService();

    List<SpCreateGranelFotosCarguio> spCreateGranelFotosCarguio = [];
    FileUploadResult fileUploadResult = FileUploadResult();
    for (int count = 0; count < listFotoTerminoCarguio.length; count++) {
      SpCreateGranelFotosCarguio aux = SpCreateGranelFotosCarguio();
      aux.urlFoto = listFotoTerminoCarguio[count].urlFoto;
      aux.operacionCarguio = "termino";
      aux.idCarguio = idCarguio;
      spCreateGranelFotosCarguio.add(aux);
      File file = File(aux.urlFoto!);
      fileUploadResult = await fileUploadService.uploadFile(file);
      spCreateGranelFotosCarguio[count].urlFoto = fileUploadResult.urlPhoto;
      spCreateGranelFotosCarguio[count].nombreFoto = fileUploadResult.fileName;
    }
    return spCreateGranelFotosCarguio;
  }

  createControlCarguio() async {
    late bool inspeccion;
    if (valueBarredura == false) {
      inspeccion = false;
    } else if (valueBarredura == true) {
      inspeccion = true;
    }
    List<SpCreateGranelFotosCarguio> spCreateGranelFotosCarguio = [];

    spCreateGranelFotosCarguio = await parseFotosInicioCarguio();

    controlCarguioService.createControlCarguio(CreateControlCarguio(
        spCreateGranelControlCarguio: SpCreateGranelControlCarguio(
            jornada: widget.jornada,
            barredura: inspeccion,
            bodega: _valueBodegaDropdown,
            fecha: DateTime.now(),
            dam: damController.text,
            nTicket: nTicketController.text,
            idConductor: idConductor,
            deliveryOrder: deliveryOrderController.text,
            idTransporte: idTransporte,
            inicioCarguio: dateInicio,
            terminoCarguio: null,
            placa: codigoTransporteController.text,
            tolva: tovaController.text,
            idUsuario: widget.idUsuario,
            idServiceOrder: widget.idServiceOrder),
        spCreateGranelFotosCarguio: spCreateGranelFotosCarguio));
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("Inicio Carguio Registrado"),
      backgroundColor: Colors.green,
    ));

    setState(() {
      getListPlacasCarguio();
    });
  }

  createFotoCarguio() async {
    List<SpCreateGranelFotosCarguio> spCreateLiquidaFotosCarguio = [];

    spCreateLiquidaFotosCarguio = await parseFotosTerminoCarguio();

    controlCarguioService
        .createGranelFotoTerminoCarguio(spCreateLiquidaFotosCarguio);
  }

  clearFiels() {
    setState(() {
      listFotoCarguio.clear();
      damController.clear();
      valueBarredura = false;
      imageCarguio = null;
      nTicketController.clear();
      codigoTransporteController.clear();
      nombreConductorController.clear();
      nombreTransporteController.clear();
      codigoConductorController.clear();
      deliveryOrderController.clear();
      codigoTransporteController.clear();
      tovaController.clear();
      _viajesRealizadosController.clear();
      _viajesTotalesController.clear();
      _saldoController.clear();
    });
  }

  getBodegas() async {
    List<VwGranelListaBodegas> value = await controlCarguioService
        .getGranelListaBodegas(widget.idServiceOrder);

    setState(() {
      vwGranelListaBodegas = value;
    });
  }

  List<DropdownMenuItem<String>> getGranelListaBodegas(
      List<VwGranelListaBodegas> bodegas) {
    List<DropdownMenuItem<String>> dropDownItems = [];

    for (var element in bodegas) {
      var newDropDown = DropdownMenuItem(
        value: element.bodega.toString(),
        child: Text(
          element.bodega.toString(),
        ),
      );
      dropDownItems.add(newDropDown);
    }
    return dropDownItems;
  }

  updateTerminoCarguio() {
    controlCarguioService.updateTerminoGranelCarguioById(
        UpdateGranelControlCarguio(
            idCarguio: idCarguio, terminoCarguio: dateTermino));

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("Termino Carguio Registrado"),
      backgroundColor: Colors.green,
    ));
  }

  List<DropdownMenuItem<String>> getDropdownPlacasCarguio(
      List<VwListGranelPlacasInicioCarguioIdserviceorder> tanques) {
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

  List<VwListGranelPlacasInicioCarguioIdserviceorder> vwListGranelPlacas =
      <VwListGranelPlacasInicioCarguioIdserviceorder>[];

  getListPlacasCarguio() async {
    List<VwListGranelPlacasInicioCarguioIdserviceorder> value =
        await controlCarguioService
            .getListGranelPlacasInicioCarguioIdserviceorder(
                widget.idServiceOrder);

    setState(() {
      vwListGranelPlacas = value;
    });
  }

  getPlacaDataIncioById(int id) async {
    List<VwGranelPlacasInicioCarguio> vwGranelPlacasInicioCarguioById = [];

    vwGranelPlacasInicioCarguioById = await controlCarguioService
        .getGranelPlacasInicioCarguio(widget.idServiceOrder, id);

    idCarguio = vwGranelPlacasInicioCarguioById[0].idCarguio!;
    /*  placaTolvaLecturaController.text =
        vwGranelPlacasInicioCarguioById[0].placa!; */
    nombreTransporteLecturaController.text =
        vwGranelPlacasInicioCarguioById[0].empresaTransporte!;
    placaTolvaLecturaController.text =
        vwGranelPlacasInicioCarguioById[0].tolva!;
  }

  List<VwGranelDoDamByIdserviceorder> vwGranelDoDamByIdserviceorder = [];

  getVerificacionDoDam(String dodam, String dam) async {
    List<VwGranelDoDamByIdserviceorder> value = await controlCarguioService
        .getGranelDoDamByIdserviceorder(widget.idServiceOrder, dodam, dam);

    setState(() {
      vwGranelDoDamByIdserviceorder = value;
    });

    _viajesTotalesController.text =
        vwGranelDoDamByIdserviceorder[0].totalViajes.toString();

    if (vwGranelDoDamByIdserviceorder.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Do/Dam Encontrada"),
        backgroundColor: Colors.greenAccent,
      ));
    }
    setState(() {
      calcularSaldo();
    });
  }

  List<VwCountGranelDamByIdServiceOrder> vwCountDamByIdserviceorder = [];

  getCountDam(String dam) async {
    List<VwCountGranelDamByIdServiceOrder> value = await controlCarguioService
        .getGranelCountDamByIdServiceOrder(widget.idServiceOrder, dam);

    setState(() {
      vwCountDamByIdserviceorder = value;
    });

    _viajesRealizadosController.text =
        vwCountDamByIdserviceorder[0].conteoDam.toString();

    setState(() {
      calcularSaldo();
    });
  }

  int saldo = 0;

  calcularSaldo() {
    setState(() {
      saldo = vwGranelDoDamByIdserviceorder[0].totalViajes! -
          vwCountDamByIdserviceorder[0].conteoDam!;
      _saldoController.text = saldo.toString();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getListPlacasCarguio();
    getBodegas();
    _tabController = TabController(length: 2, vsync: this);
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
            title: const Text("Control Carguío"),
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
                    Text("Barredura",
                        style: TextStyle(
                            fontSize: 20,
                            color: kColorAzul,
                            fontWeight: FontWeight.w500)),
                    const SizedBox(width: 5),
                    Switch(
                      value: valueBarredura,
                      onChanged: (value) => setState(() {
                        valueBarredura = value;
                      }),
                      activeTrackColor: Colors.lightGreenAccent,
                      activeColor: Colors.green,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                DropdownButtonFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    labelText: 'Bodega',
                    labelStyle: TextStyle(
                      color: kColorAzul,
                      fontSize: 20.0,
                    ),
                  ),
                  icon: const Icon(
                    Icons.arrow_drop_down_circle_outlined,
                  ),
                  items: getGranelListaBodegas(vwGranelListaBodegas),
                  onChanged: (value) => {
                    setState(() {
                      _valueBodegaDropdown = value as String;
                    })
                  },
                  validator: (value) {
                    if (value != _valueBodegaDropdown) {
                      return 'Por favor, elige la Bodega';
                    }
                    return null;
                  },
                  hint: Text(_valueBodegaDropdown),
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
                            icon: const Icon(Icons.closed_caption_off_rounded),
                            onPressed: () async {
                              final result = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const BarcodeScannerWithScanWindow()));
                              codigoTransporteController.text = result;
                            }),
                        suffixIcon: IconButton(
                            icon: const Icon(Icons.search),
                            onPressed: () {
                              getTransporteByCod();
                            }),
                        labelText: 'Placa',
                        labelStyle: TextStyle(
                          color: kColorAzul,
                          fontSize: 20.0,
                        ),
                        hintText: 'Ingrese la Placa'),
                    onChanged: (value) {
                      getTransporteByCod();
                    },
                    controller: codigoTransporteController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, ingrese la Placa';
                      }

                      return null;
                    },
                    enabled: enableQrUsuario),
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
                /*      const SizedBox(height: 20.0),
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
                ), */
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    prefixIcon: Icon(
                      Icons.directions_boat,
                      color: kColorAzul,
                    ),
                    labelText: 'Tolva',
                    labelStyle: TextStyle(
                      color: kColorAzul,
                      fontSize: 20.0,
                    ),
                    hintText: '',
                  ),
                  controller: tovaController,
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
                            onPressed: () async {
                              getVerificacionDoDam(deliveryOrderController.text,
                                  damController.text);
                              getCountDam(damController.text);
                            }),
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
                    },
                    controller: deliveryOrderController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, ingrese el Delivery Order';
                      }
                      return null;
                    },
                    enabled: enableQrUsuario),
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
                            onPressed: () async {
                              getVerificacionDoDam(deliveryOrderController.text,
                                  damController.text);
                              getCountDam(damController.text);
                            }),
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
                    /* validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, ingrese el DAM';
                      }
                      idUsuario = BigInt.parse(value);
                      return null;
                    }, */
                    enabled: enableQrUsuario),
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
                        "Ingrese Fotos del Inicio Carguio",
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
                                    onPressed: (() =>
                                        pickCarguioFoto(ImageSource.gallery)),
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
                                    onPressed: (() =>
                                        pickCarguioFoto(ImageSource.camera)),
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
                      listFotoCarguio.add(ListFotoCarguio(
                          fotoCarguio: imageCarguio!,
                          urlFoto: imageCarguio!.path));
                    });
                  },
                  child: Text(
                    "AGREGAR FOTO INICIO CARGUIO",
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
                        itemCount: listFotoCarguio.length,
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
                              child: listFotoCarguio[i].fotoCarguio != null
                                  ? Image.file(listFotoCarguio[i].fotoCarguio!,
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
                    await createControlCarguio();
                    clearFiels();
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
                    items: getDropdownPlacasCarguio(vwListGranelPlacas),
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
                                  labelText: 'Empresa Transporte',
                                  labelStyle: TextStyle(
                                    color: kColorAzul,
                                    fontSize: 20.0,
                                  ),
                                  hintText: 'Ingrese tipo de importación'),
                              controller: nombreTransporteLecturaController,
                              enabled: false,
                            ),
                            TextFormField(
                              decoration: InputDecoration(
                                  /*border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),*/
                                  border: InputBorder.none,
                                  prefixIcon: Icon(
                                    Icons.width_wide_sharp,
                                    color: kColorAzul,
                                  ),
                                  labelText: 'Tolva',
                                  labelStyle: TextStyle(
                                    color: kColorAzul,
                                    fontSize: 20.0,
                                  ),
                                  hintText: ''),
                              controller: placaTolvaLecturaController,
                              enabled: false,
                            ),

                            //Caja de texto Tipo de importación
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
                    },
                    child: Text(
                      "AGREGAR FOTO TERMINO CARGUIO",
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

  Future pickCarguioFoto(ImageSource source) async {
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
