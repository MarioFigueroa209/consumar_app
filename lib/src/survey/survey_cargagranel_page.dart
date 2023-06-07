import 'package:consumar_app/src/survey/precintado/precintado.dart';
import 'package:consumar_app/src/survey/validacion_peso/validacion_peso_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../models/survey/vw_ship_and_travel_by_id_service_order_granel.dart';
import '../../models/usuario_model.dart';
import '../../models/vw_all_service_order_granel.dart';
import '../../models/vw_get_user_data_by_cod_user.dart';
import '../../services/roro/distribucion_embarque/distribucion_embarque_services.dart';
import '../../services/service_order_services.dart';
import '../../services/usuario_service.dart';
import '../../utils/constants.dart';
import '../../utils/jornada_model.dart';
import '../../utils/lists.dart';
import '../scanner_screen.dart';
import '../widgets/boton_menu.dart';

import 'Paralizaciones/paralizaciones.dart';
import 'control_carguio/control_carguio_page.dart';
import 'descarga_directa/descarga_directa.dart';
import 'inspeccion_equipos/menu_equipos_page.dart';
import 'monitoreo_producto/monitoreo_producto_page.dart';
import 'recepcion_almacen/recepcion_almacen.dart';

class SurveyCargaGranel extends StatefulWidget {
  const SurveyCargaGranel({Key? key}) : super(key: key);

  @override
  State<SurveyCargaGranel> createState() => _SurveyCargaGranelState();
}

class _SurveyCargaGranelState extends State<SurveyCargaGranel> {
  final _formKey = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();

  List<VwAllServiceOrderGranel> serviceOrdersList = <VwAllServiceOrderGranel>[];

  //String _selectedServiceOrder = 'Seleccione Orden';

  final idUsuarioController = TextEditingController();
  final nombreUsuarioController = TextEditingController();
  final TextEditingController _nombreNaveController = TextEditingController();
  final TextEditingController _viajeController = TextEditingController();
  final _fechaController = TextEditingController();

  VwgetUserDataByCodUser vwgetUserDataByCodUser = VwgetUserDataByCodUser();

  UsuarioModel usuarioModel = UsuarioModel();

  late int idUsuario;
  late int idServiceOrder;

  String _valueJornadaDropdown = 'Seleccione jornada';
  bool enableJornadaDropdown = true;
  bool enableServiceOrderDropdown = true;

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

  getNaveAndTravelServiceOrder() async {
    VwShipAndTravelByIdServiceOrderGranel vwShipAndTravelByIdServiceOrderModel =
        VwShipAndTravelByIdServiceOrderGranel();

    DistribucionEmbarqueService distribucionEmbarqueSerice =
        DistribucionEmbarqueService();

    vwShipAndTravelByIdServiceOrderModel =
        await distribucionEmbarqueSerice.getShipAndTravelByIdOrderServiceGranel(
            BigInt.parse(idServiceOrder.toString()));

    _nombreNaveController.text =
        vwShipAndTravelByIdServiceOrderModel.nombreNave!;

    _viajeController.text = vwShipAndTravelByIdServiceOrderModel.numeroViaje!;
  }

  List<DropdownMenuItem<String>> getServiceOrdersDropDownItems(
      List<VwAllServiceOrderGranel> orders) {
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

    serviceOrdersList = await serviceOrderService.getAllServiceOrdersGranel();
  }

  validationMonitoreoProducto() {
    if (_formKey.currentState!.validate()) {
      if (_formKey2.currentState!.validate()) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MonitoreoProducto(
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

  validationInspeccionEquipos() {
    if (_formKey.currentState!.validate()) {
      if (_formKey2.currentState!.validate()) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MenuRegistroEquipos(
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

  validationControlCarguio() {
    if (_formKey.currentState!.validate()) {
      if (_formKey2.currentState!.validate()) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ControlCarguio(
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

  validationParalizaciones() {
    if (_formKey.currentState!.validate()) {
      if (_formKey2.currentState!.validate()) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Paralizaciones(
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

  validationPrecintado() {
    if (_formKey.currentState!.validate()) {
      if (_formKey2.currentState!.validate()) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Precintado(
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

  validationRecepcionAlmacen() {
    if (_formKey.currentState!.validate()) {
      if (_formKey2.currentState!.validate()) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => RecepcionAlmacen(
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

  validationDescargaDirecta() {
    if (_formKey.currentState!.validate()) {
      if (_formKey2.currentState!.validate()) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DescargaDirecta(
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

  validationValidacionPeso() {
    if (_formKey.currentState!.validate()) {
      if (_formKey2.currentState!.validate()) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ValidacionPeso(
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
        title: const Text("SURVEY CARGA GRANEL"),
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
              ),
            ),
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
                        items: listaJornada.map((String a) {
                          return DropdownMenuItem<String>(
                            value: a,
                            child: Center(
                                child: Text(a, textAlign: TextAlign.left)),
                          );
                        }).toList(),
                        onChanged: (value) => {
                          setState(() {
                            _valueJornadaDropdown = value as String;
                          })
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
                                  title: 'Monitoreo producto',
                                  icon: Icons.content_paste_search,
                                  onTap: () {
                                    validationMonitoreoProducto();
                                    //Insertar un showDialog
                                  }),
                              const SizedBox(width: 20),
                              BotonMenu(
                                  title: 'Inspección de equipos',
                                  icon: Icons.domain_verification,
                                  onTap: () {
                                    validationInspeccionEquipos();
                                  }),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              BotonMenu(
                                  title: 'Control carguío',
                                  icon: Icons.format_list_numbered_sharp,
                                  onTap: () {
                                    validationControlCarguio();
                                  }),
                              const SizedBox(width: 20),
                              BotonMenu(
                                  title: 'Paralizaciones',
                                  icon: Icons.error_outline,
                                  onTap: () {
                                    validationParalizaciones();
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
                                    validationPrecintado();

                                    //validationDamageReport();
                                    //Insertar un showDialog
                                  }),
                              const SizedBox(width: 20),
                              BotonMenu(
                                  title: 'Recepción de almacén',
                                  icon: Icons.warehouse,
                                  onTap: () {
                                    validationRecepcionAlmacen();
                                    //validationDamageReportListado();
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
                                    validationValidacionPeso();
                                  }),
                              const SizedBox(width: 20),
                              BotonMenu(
                                  title: 'Descarga directa',
                                  icon: Icons.download_for_offline,
                                  onTap: () {
                                    validationDescargaDirecta();
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
