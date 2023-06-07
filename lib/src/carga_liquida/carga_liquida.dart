import 'package:consumar_app/src/carga_liquida/control_carguio/liquida_control_carguio.dart';
import 'package:consumar_app/src/carga_liquida/inspeccion_equipos/menu_liquida_equipos_page.dart';
import 'package:consumar_app/src/carga_liquida/paralizaciones/liquida_paralizaciones.dart';
import 'package:consumar_app/src/carga_liquida/precintado/liquida_precintado.dart';
import 'package:consumar_app/src/carga_liquida/recepcion_almacen/liquida_recepcion_almacen_page.dart';
import 'package:consumar_app/src/carga_liquida/ulaje/ulaje_page.dart';
import 'package:consumar_app/src/carga_liquida/validacion_peso/liquida_validacion_peso_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../models/vw_all_service_order_liquida.dart';
import '../../models/vw_get_user_data_by_cod_user.dart';
import '../../models/vw_ship_and_travel_by_id_service_order_model.dart';
import '../../services/roro/distribucion_embarque/distribucion_embarque_services.dart';
import '../../services/service_order_services.dart';
import '../../services/usuario_service.dart';
import '../../utils/constants.dart';
import '../../utils/jornada_model.dart';
import '../scanner_screen.dart';
import '../widgets/boton_menu.dart';
import 'descarga_tuberias/liquida_descarga_tuberias_page.dart';

class CargaLiquida extends StatefulWidget {
  const CargaLiquida({Key? key}) : super(key: key);

  @override
  State<CargaLiquida> createState() => _CargaLiquidaState();
}

class _CargaLiquidaState extends State<CargaLiquida> {
  final _formKey = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();

  List<JornadaModel> jornadaList = <JornadaModel>[
    JornadaModel(idJornada: 1, jornada: "07:00 - 15:00"),
    JornadaModel(idJornada: 2, jornada: "15:00 - 23:00"),
    JornadaModel(idJornada: 3, jornada: "23:00 - 07:00"),
  ];

  String _valueJornadaDropdown = 'Seleccione Jornada';

  final TextEditingController idUsuarioController = TextEditingController();

  VwShipAndTravelByIdServiceOrderModel vwShipAndTravelByIdServiceOrderModel =
      VwShipAndTravelByIdServiceOrderModel();

  final TextEditingController _nombreNaveController = TextEditingController();
  final TextEditingController _viajeController = TextEditingController();
  final TextEditingController _fechaController = TextEditingController();

  final TextEditingController nombreUsuarioController = TextEditingController();

  List<VwAllServiceOrderLiquida> serviceOrdersList =
      <VwAllServiceOrderLiquida>[];

  //String _selectedServiceOrder = 'Seleccione Orden';

  late int idUsuario;
  late int idServiceOrder;

  bool enableServiceOrderDropdown = true;
  bool enableJornadaDropdown = true;

  VwgetUserDataByCodUser vwgetUserDataByCodUser = VwgetUserDataByCodUser();

  getNaveAndTravelServiceOrder() async {
    DistribucionEmbarqueService distribucionEmbarqueSerice =
        DistribucionEmbarqueService();

    vwShipAndTravelByIdServiceOrderModel =
        await distribucionEmbarqueSerice.getShipAndTravelByIdOrderService(
            BigInt.parse(idServiceOrder.toString()));

    _nombreNaveController.text =
        vwShipAndTravelByIdServiceOrderModel.nombreNave!;

    _viajeController.text = vwShipAndTravelByIdServiceOrderModel.numeroViaje!;
  }

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
      List<VwAllServiceOrderLiquida> orders) {
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

    serviceOrdersList = await serviceOrderService.getAllServiceOrdersLiquida();
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
        title: const Text("CARGA LIQUIDA"),
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
                                            const ScannerScreen()));

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
                          items:
                              getServiceOrdersDropDownItems(serviceOrdersList),
                          onChanged: (value) {
                            idServiceOrder = int.parse(value.toString());
                            getNaveAndTravelServiceOrder();

                            setState(() {
                              //_selectedServiceOrder = value.toString();
                            });
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
                                  title: 'ULAJE',
                                  icon: Icons.content_paste_search,
                                  onTap: () {
                                    validationUlaje();
                                    //Insertar un showDialog
                                  }),
                              const SizedBox(width: 20),
                              BotonMenu(
                                  title: 'Inspeccion Equipos',
                                  icon: Icons.domain_verification,
                                  onTap: () {
                                    validationInspeccionEquiposLiquida();
                                  }),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              BotonMenu(
                                  title: 'Control Carguio',
                                  icon: Icons.format_list_numbered_sharp,
                                  onTap: () {
                                    validationLiquidaControlCarguio();
                                  }),
                              const SizedBox(width: 20),
                              BotonMenu(
                                  title: 'Paralizaciones',
                                  icon: Icons.error_outline,
                                  onTap: () {
                                    validationLiquidaParalizaciones();
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
                                  title: 'Precintado',
                                  icon: Icons.verified_user,
                                  onTap: () {
                                    validationLiquidaPrecintos();
                                    //validationDamageReport();
                                    //Insertar un showDialog
                                  }),
                              const SizedBox(width: 20),
                              BotonMenu(
                                  title: 'Recepción de almacén',
                                  icon: Icons.warehouse,
                                  onTap: () {
                                    validationLiquidaRecepcionAlmacen();
                                  }),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              BotonMenu(
                                  title: 'Validacion de Peso',
                                  icon: Icons.balance,
                                  onTap: () {
                                    validationLiquidaValidacionPeso();
                                  }),
                              const SizedBox(width: 20),
                              BotonMenu(
                                  title: 'Descarga Tuberias',
                                  icon: Icons.download_for_offline,
                                  onTap: () {
                                    validationLiquidaDescargaTuberias();
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

  validationUlaje() {
    if (_formKey.currentState!.validate()) {
      if (_formKey2.currentState!.validate()) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => UlajePage(
                      idServiceOrder: idServiceOrder,
                      idUsuario: idUsuario,
                      jornada: int.parse(_valueJornadaDropdown),
                    )));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Por ingresar orden de Servicio y Jornada"),
          backgroundColor: Colors.redAccent,
        ));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Por ingresar Codigo de Trabajador"),
        backgroundColor: Colors.redAccent,
      ));
    }
  }

  validationInspeccionEquiposLiquida() {
    if (_formKey.currentState!.validate()) {
      if (_formKey2.currentState!.validate()) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MenuLiquidaEquipos(
                      idServiceOrder: idServiceOrder,
                      idUsuario: idUsuario,
                      jornada: int.parse(_valueJornadaDropdown),
                    )));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Por ingresar orden de Servicio y Jornada"),
          backgroundColor: Colors.redAccent,
        ));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Por ingresar Codigo de Trabajador"),
        backgroundColor: Colors.redAccent,
      ));
    }
  }

  validationLiquidaControlCarguio() {
    if (_formKey.currentState!.validate()) {
      if (_formKey2.currentState!.validate()) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => LiquidaControlCarguio(
                      idServiceOrder: idServiceOrder,
                      idUsuario: idUsuario,
                      jornada: int.parse(_valueJornadaDropdown),
                    )));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Por ingresar orden de Servicio y Jornada"),
          backgroundColor: Colors.redAccent,
        ));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Por ingresar Codigo de Trabajador"),
        backgroundColor: Colors.redAccent,
      ));
    }
  }

  validationLiquidaParalizaciones() {
    if (_formKey.currentState!.validate()) {
      if (_formKey2.currentState!.validate()) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => LiquidaParalizaciones(
                      idServiceOrder: idServiceOrder,
                      idUsuario: idUsuario,
                      jornada: int.parse(_valueJornadaDropdown),
                    )));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Por ingresar orden de Servicio y Jornada"),
          backgroundColor: Colors.redAccent,
        ));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Por ingresar Codigo de Trabajador"),
        backgroundColor: Colors.redAccent,
      ));
    }
  }

  validationLiquidaPrecintos() {
    if (_formKey.currentState!.validate()) {
      if (_formKey2.currentState!.validate()) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => LiquidaPrecintado(
                      idServiceOrder: idServiceOrder,
                      idUsuario: idUsuario,
                      jornada: int.parse(_valueJornadaDropdown),
                    )));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Por ingresar orden de Servicio y Jornada"),
          backgroundColor: Colors.redAccent,
        ));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Por ingresar Codigo de Trabajador"),
        backgroundColor: Colors.redAccent,
      ));
    }
  }

  validationLiquidaRecepcionAlmacen() {
    if (_formKey.currentState!.validate()) {
      if (_formKey2.currentState!.validate()) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => LiquidaRecepcionAlmacen(
                      idServiceOrder: idServiceOrder,
                      idUsuario: idUsuario,
                      jornada: int.parse(_valueJornadaDropdown),
                    )));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Por ingresar orden de Servicio y Jornada"),
          backgroundColor: Colors.redAccent,
        ));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Por ingresar Codigo de Trabajador"),
        backgroundColor: Colors.redAccent,
      ));
    }
  }

  validationLiquidaValidacionPeso() {
    if (_formKey.currentState!.validate()) {
      if (_formKey2.currentState!.validate()) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => LiquidaValidacionPeso(
                      idServiceOrder: idServiceOrder,
                      idUsuario: idUsuario,
                      jornada: int.parse(_valueJornadaDropdown),
                    )));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Por ingresar orden de Servicio y Jornada"),
          backgroundColor: Colors.redAccent,
        ));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Por ingresar Codigo de Trabajador"),
        backgroundColor: Colors.redAccent,
      ));
    }
  }

  validationLiquidaDescargaTuberias() {
    if (_formKey.currentState!.validate()) {
      if (_formKey2.currentState!.validate()) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => LiquidaDescargaTuberias(
                      idServiceOrder: idServiceOrder,
                      idUsuario: idUsuario,
                      jornada: int.parse(_valueJornadaDropdown),
                    )));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Por ingresar orden de Servicio y Jornada"),
          backgroundColor: Colors.redAccent,
        ));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Por ingresar Codigo de Trabajador"),
        backgroundColor: Colors.redAccent,
      ));
    }
  }
}
