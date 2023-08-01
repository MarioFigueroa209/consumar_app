import 'package:consumar_app/src/carga_proyecto/condicion_estado/condicion_estado_page.dart';
import 'package:consumar_app/src/carga_proyecto/etiquetado/etiquetado_page.dart';
import 'package:consumar_app/src/carga_proyecto/inspeccion_equipos/proyecto_inspeccion_equipo_page.dart';
import 'package:consumar_app/src/carga_proyecto/recepcion_almacen/recepcion_almacen_1_page.dart';
import 'package:consumar_app/src/carga_proyecto/reporte_danos/reporte_danosDr_page.dart';
import 'package:consumar_app/src/carga_proyecto/supervision_carguio/supervision_carguio_page.dart';
import 'package:consumar_app/src/carga_proyecto/supervision_descarga/supervision_descarga_page.dart';
import 'package:consumar_app/src/carga_proyecto/supervision_embarque/supervision_embarque_page.dart';
import 'package:consumar_app/utils/qr_scanner/barcode_scanner_window.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import '../../models/vw_all_service_order.dart';
import '../../models/vw_get_user_data_by_cod_user.dart';
import '../../services/service_order_services.dart';
import '../../services/usuario_service.dart';
import '../../utils/constants.dart';
import '../../utils/jornada_model.dart';

import '../widgets/boton_menu.dart';

class CargaProyectoPage extends StatefulWidget {
  const CargaProyectoPage({super.key});

  @override
  State<CargaProyectoPage> createState() => _CargaProyectoPageState();
}

class _CargaProyectoPageState extends State<CargaProyectoPage> {
  final _formKey = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();

  List<JornadaModel> jornadaList = <JornadaModel>[
    JornadaModel(idJornada: 1, jornada: "07:00 - 15:00"),
    JornadaModel(idJornada: 2, jornada: "15:00 - 23:00"),
    JornadaModel(idJornada: 3, jornada: "23:00 - 07:00"),
  ];

  String _valueJornadaDropdown = 'Seleccione Jornada';

  final TextEditingController idUsuarioController = TextEditingController();

/*   VwShipAndTravelByIdServiceOrderModel vwShipAndTravelByIdServiceOrderModel =
      VwShipAndTravelByIdServiceOrderModel(); */

  final TextEditingController _nombreNaveController = TextEditingController();
  final TextEditingController _viajeController = TextEditingController();
  final TextEditingController _fechaController = TextEditingController();

  final TextEditingController nombreUsuarioController = TextEditingController();
/* 
  List<VwAllServiceOrderLiquida> serviceOrdersList =
      <VwAllServiceOrderLiquida>[]; */

  //String _selectedServiceOrder = 'Seleccione Orden';

  late int idUsuario;
  late int idServiceOrder;

  bool enableServiceOrderDropdown = true;
  bool enableJornadaDropdown = true;

  VwgetUserDataByCodUser vwgetUserDataByCodUser = VwgetUserDataByCodUser();

  List<VwAllServiceOrder> serviceOrdersList = <VwAllServiceOrder>[];

  /*  getNaveAndTravelServiceOrder() async {
    DistribucionEmbarqueService distribucionEmbarqueSerice =
        DistribucionEmbarqueService();

    vwShipAndTravelByIdServiceOrderModel =
        await distribucionEmbarqueSerice.getShipAndTravelByIdOrderService(
            BigInt.parse(idServiceOrder.toString()));

    _nombreNaveController.text =
        vwShipAndTravelByIdServiceOrderModel.nombreNave!;

    _viajeController.text = vwShipAndTravelByIdServiceOrderModel.numeroViaje!;
  } */

  getUserConductorDataByCodUser() async {
    UsuarioService usuarioService = UsuarioService();

    vwgetUserDataByCodUser =
        await usuarioService.getUserDataByCodUser(idUsuarioController.text);

    nombreUsuarioController.text =
        "${vwgetUserDataByCodUser.nombres!} ${vwgetUserDataByCodUser.apellidos!}";
    idUsuario = vwgetUserDataByCodUser.idUsuario!;

    setState(() {
      enableServiceOrderDropdown = false;
      enableJornadaDropdown = false;
    });
    //print(idUsuario);
  }

  List<DropdownMenuItem<String>> getServiceOrdersDropDownItems(
      List<VwAllServiceOrder> orders) {
    List<DropdownMenuItem<String>> dropDownItems = [];

    for (var element in orders) {
      var newDropDown = DropdownMenuItem(
        value: element.idServiceOrder.toString(),
        child: Text(
          element.serviceOrder.toString(),
        ),
      );
      dropDownItems.add(newDropDown);
    }
    return dropDownItems;
  }

  List<DropdownMenuItem<String>> getJornadaDropDownItems(
      List<JornadaModel> jornadas) {
    List<DropdownMenuItem<String>> dropDownItems = [];

    for (var element in jornadas) {
      var newDropDown = DropdownMenuItem(
        value: element.idJornada.toString(),
        child: Text(
          element.jornada.toString(),
        ),
      );
      dropDownItems.add(newDropDown);
    }
    return dropDownItems;
  }

  getOrdenesServicio() async {
    ServiceOrderService serviceOrderService = ServiceOrderService();

    serviceOrdersList = await serviceOrderService.getAllServiceOrders();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getOrdenesServicio();
  }

  @override
  Widget build(BuildContext context) {
    _fechaController.value =
        TextEditingValue(text: DateFormat('dd-MM-yyyy').format(DateTime.now()));
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("CARGA PROYECTO"),
      ),
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(children: [
            Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          prefixIcon: IconButton(
                              icon: const Icon(Icons.qr_code),
                              onPressed: () async {
                                final result = await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const BarcodeScannerWithScanWindow()));
                                idUsuarioController.text = result;
                              }),
                          suffixIcon: IconButton(
                              icon: const Icon(Icons.search),
                              onPressed: () {
                                getUserConductorDataByCodUser();
                              }),
                          labelText: 'Id.Job',
                          labelStyle: TextStyle(
                            color: kColorAzul,
                            fontSize: 20.0,
                          ),
                          hintText: 'Ingrese el numero de ID Job'),
                      onChanged: (value) {
                        getUserConductorDataByCodUser();
                      },
                      controller: idUsuarioController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, ingrese el Id Job';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        prefixIcon: Icon(
                          Icons.account_box,
                          color: kColorAzul,
                        ),
                        labelText: 'Nombre usuario',
                      ),
                      enabled: false,
                      //hintText: 'Ingrese el numero de ID del Job'),
                      controller: nombreUsuarioController,
                    ),
                    const SizedBox(height: 20),
                  ],
                )),
            Form(
                key: _formKey2,
                child: Column(
                  children: [
                    IgnorePointer(
                      ignoring: enableServiceOrderDropdown,
                      child: DropdownButtonHideUnderline(
                        child: DropdownButtonFormField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            labelText: 'Orden de servicio',
                            hintText: 'Selecione Orden de servicio',
                            labelStyle: TextStyle(
                              color: kColorAzul,
                              fontSize: 20.0,
                            ),
                          ),
                          icon: const Icon(
                            Icons.arrow_drop_down_circle_outlined,
                          ),
                          /*PENDIENTE A CAMBIO*/
                          items:
                              getServiceOrdersDropDownItems(serviceOrdersList),
                          onChanged: (value) {
                            /* idServiceOrder = int.parse(value.toString());
                            getNaveAndTravelServiceOrder();

                            setState(() {
                              //_selectedServiceOrder = value.toString();
                            }); */
                          },
                          validator: (value) {
                            if (value == null) {
                              return 'Por favor, elige order de servicio';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              prefixIcon: Icon(
                                Icons.directions_boat,
                                color: kColorAzul,
                              ),
                              labelText: 'Nave',
                              labelStyle: TextStyle(
                                color: kColorAzul,
                                fontSize: 20.0,
                              ),
                              hintText: '',
                            ),
                            controller: _nombreNaveController,
                            enabled: false,
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
                                Icons.airplane_ticket_outlined,
                                color: kColorAzul,
                              ),
                              labelText: 'Viaje',
                              labelStyle: TextStyle(
                                color: kColorAzul,
                                fontSize: 20.0,
                              ),
                            ),
                            controller: _viajeController,
                            enabled: false,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    IgnorePointer(
                      ignoring: enableJornadaDropdown,
                      child: DropdownButtonFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          labelText: 'Jornada',
                          labelStyle: TextStyle(
                            color: kColorAzul,
                            fontSize: 20.0,
                          ),
                        ),
                        icon: const Icon(
                          Icons.arrow_drop_down_circle_outlined,
                        ),
                        items: getJornadaDropDownItems(jornadaList),
                        onChanged: (value) => {
                          setState(() {
                            _valueJornadaDropdown = value.toString();
                          }),
                          //print("La Jornada es: $_valueJornadaDropdown")
                        },
                        validator: (value) {
                          if (value != _valueJornadaDropdown) {
                            return 'Por favor, elige jornada';
                          }
                          return null;
                        },
                        hint: Text(_valueJornadaDropdown),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        prefixIcon: Icon(
                          Icons.calendar_month,
                          color: kColorAzul,
                        ),
                        labelText: 'Fecha',
                        labelStyle: TextStyle(
                          color: kColorAzul,
                          //fontSize: 20.0,
                        ),
                      ),
                      controller: _fechaController,
                      style: TextStyle(
                        color: kColorAzul,
                        fontSize: 20.0,
                      ),
                      enabled: false,
                    ),
                    const Text(
                      "OPERACION",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              BotonMenu(
                                  title: 'ETIQUETADO',
                                  icon: Icons.content_paste_search,
                                  onTap: () {
                                    // validationUlaje();
                                    //Insertar un showDialog
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                EtiquetadoPage(
                                                  idServiceOrder: 1,
                                                  idUsuario: 1,
                                                  jornada: 1,
                                                )));
                                  }),
                              const SizedBox(width: 20),
                              BotonMenu(
                                  title: 'CONDICIÓN DE ESTADO',
                                  icon: Icons.domain_verification,
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                CondicionEstadoPage(
                                                  idServiceOrder: 1,
                                                  idUsuario: 1,
                                                  jornada: 1,
                                                )));
                                    //  validationInspeccionEquiposLiquida();
                                  }),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              BotonMenu(
                                  title: 'SUPERVISIÓN CARGUIO',
                                  icon: Icons.format_list_numbered_sharp,
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                SupervisionCarguioPage(
                                                  idServiceOrder: 1,
                                                  idUsuario: 1,
                                                  jornada: 1,
                                                )));
                                    // validationLiquidaControlCarguio();
                                  }),
                              const SizedBox(width: 20),
                              BotonMenu(
                                  title: 'RECEPCION ALMACEN',
                                  icon: Icons.error_outline,
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                RecepcionAlmacen1(
                                                  idServiceOrder: 1,
                                                  idUsuario: 1,
                                                  jornada: 1,
                                                )));
                                    //  validationLiquidaParalizaciones();
                                    //validationDamageReport();
                                    //Insertar un showDialog
                                  }),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              BotonMenu(
                                  title: 'SUPERVISIÓN DESCARGA',
                                  icon: Icons.verified_user,
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                SupervisionDescargaPage(
                                                  idServiceOrder: 1,
                                                  idUsuario: 1,
                                                  jornada: 1,
                                                )));
                                    //  validationLiquidaPrecintos();
                                    //validationDamageReport();
                                    //Insertar un showDialog
                                  }),
                              const SizedBox(width: 20),
                              BotonMenu(
                                  title: 'SUPERVISIÓN EMBARQUE',
                                  icon: Icons.warehouse,
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                SupervisionEmbarquePage(
                                                  idServiceOrder: 1,
                                                  idUsuario: 1,
                                                  jornada: 1,
                                                )));
                                    //   validationLiquidaRecepcionAlmacen();
                                  }),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              BotonMenu(
                                  title: 'REPORTE DE DAÑOS',
                                  icon: Icons.balance,
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ReporteDanosDrPage(
                                                  idServiceOrder: 1,
                                                  idUsuario: 1,
                                                  jornada: 1,
                                                )));
                                    //  validationLiquidaValidacionPeso();
                                  }),
                              const SizedBox(width: 20),
                              BotonMenu(
                                  title: 'INSPECCION DE EQUIPOS',
                                  icon: Icons.download_for_offline,
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ProyectoInspeccionEquipos(
                                                  idServiceOrder: 1,
                                                  idUsuario: 1,
                                                  jornada: 1,
                                                )));
                                    //  validationLiquidaDescargaTuberias();
                                  }),
                            ],
                          ),
                        ]),
                  ],
                ))
          ]),
        ),
      ),
    );
  }
}
