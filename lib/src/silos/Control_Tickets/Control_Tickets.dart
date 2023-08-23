import 'package:flutter/material.dart';
import '../../../models/silos/create_silos_control_ticket.dart';
import '../../../models/survey/ControlCarguio/vw_granel_consulta_transporte_by_cod.dart';
import '../../../services/silos/silos_service.dart';
import '../../../services/survey/control_carguio_service.dart';
import '../../../utils/constants.dart';

class ControlTickets extends StatefulWidget {
  const ControlTickets(
      {Key? key,
      required this.jornada,
      required this.idUsuario,
      required this.idServiceOrder})
      : super(key: key);
  final int jornada;
  final int idUsuario;
  final int idServiceOrder;

  @override
  State<ControlTickets> createState() => _ControlTicketsState();
}

class _ControlTicketsState extends State<ControlTickets> {
  ControlCarguioService controlCarguioService = ControlCarguioService();

  SilosService silosService = SilosService();

  VwGranelConsultaTransporteByCod vwGranelConsultaTransporteByCod =
      VwGranelConsultaTransporteByCod();

  final ticketApmController = TextEditingController();
  final naveController = TextEditingController();
  final blController = TextEditingController();
  final subBlController = TextEditingController();
  final doController = TextEditingController();
  final damController = TextEditingController();
  final importadorController = TextEditingController();
  final productorController = TextEditingController();
  final transportistaController = TextEditingController();
  final manifiestoController = TextEditingController();
  final ubicacionCargaController = TextEditingController();
  final codigoTransporteController = TextEditingController();
  final nombreTransporteController = TextEditingController();
  final codPlacaController = TextEditingController();

  late int idConductor;
  late int idTransporte;

  createControlTicket() async {
    await silosService.createSilosControlTicket(CreateSilosControlTicket(
        ticketApm: ticketApmController.text,
        nave: naveController.text,
        bl: blController.text,
        subBl: subBlController.text,
        createSilosControlTicketDo: doController.text,
        dam: damController.text,
        importador: importadorController.text,
        producto: productorController.text,
        transportista: transportistaController.text,
        manifiesto: manifiestoController.text,
        ubicacionCarga: ubicacionCargaController.text,
        fecha: DateTime.now(),
        jornada: widget.jornada,
        idUsuarios: widget.idUsuario,
        idServiceOrder: widget.idServiceOrder,
        idTransporte: idTransporte));
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text("Datos Registrados con exito"),
      backgroundColor: Colors.green,
    ));
    clearTxt();
  }

  clearTxt() {
    ticketApmController.clear();
    naveController.clear();
    blController.clear();
    subBlController.clear();
    doController.clear();
    damController.clear();
    importadorController.clear();
    productorController.clear();
    transportistaController.clear();
    manifiestoController.clear();
    ubicacionCargaController.clear();
    codigoTransporteController.clear();
    nombreTransporteController.clear();
    codPlacaController.clear();
  }

  /* getTransporteByCod() async {
    vwGranelConsultaTransporteByCod = await controlCarguioService
        .getGranelConsultaTransporteByCod(codigoTransporteController.text);

    codPlacaController.text = vwGranelConsultaTransporteByCod.codFotocheck!;

    nombreTransporteController.text =
        vwGranelConsultaTransporteByCod.empresaTransporte!;
    idTransporte = vwGranelConsultaTransporteByCod.idTransporte!;
  } */

  final idUsuarioController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('CONTROL DE TICKETS'),
        ),
        body: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        suffixIcon: IconButton(
                            icon: const Icon(Icons.camera_alt_outlined),
                            onPressed: () {}),
                        labelText: 'TicketAPM',
                        labelStyle: TextStyle(
                          color: kColorAzul,
                          fontSize: 20.0,
                        ),
                        hintText: 'Ingrese el TicketAPM'),
                    controller: ticketApmController,
                    /* validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, ingrese el TicketAPM';
                      }
                      return null;
                    }, */
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        suffixIcon: IconButton(
                            icon: const Icon(Icons.search),
                            onPressed: () {
                              //getTransporteByCod();
                            }),
                        labelText: 'Codigo Vehiculo',
                        labelStyle: TextStyle(
                          color: kColorAzul,
                          fontSize: 20.0,
                        ),
                        hintText: 'Ingrese el numero de Codigo del Vehiculo'),
                    onChanged: (value) {
                      //getTransporteByCod();
                    },
                    controller: codigoTransporteController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, ingrese el Codigo del Vehiculo';
                      }
                      return null;
                    },
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
                            labelText: 'Transporte',
                            labelStyle: TextStyle(
                              color: kColorAzul,
                              fontSize: 20.0,
                            ),
                            hintText: '',
                          ),
                          enabled: false,
                          controller: nombreTransporteController,
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
                            labelText: 'Placa',
                            labelStyle: TextStyle(
                              color: kColorAzul,
                              fontSize: 20.0,
                            ),
                          ),
                          enabled: false,
                          controller: codPlacaController,
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
                      labelText: 'Nave',
                      labelStyle: TextStyle(
                        color: kColorAzul,
                        fontSize: 20.0,
                      ),
                      hintText: '',
                    ),
                    enabled: true,
                    controller: naveController,
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
                            labelText: 'BL',
                            labelStyle: TextStyle(
                              color: kColorAzul,
                              fontSize: 20.0,
                            ),
                            hintText: '',
                          ),
                          enabled: true,
                          controller: blController,
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
                            labelText: 'SUB BL',
                            labelStyle: TextStyle(
                              color: kColorAzul,
                              fontSize: 20.0,
                            ),
                          ),
                          enabled: true,
                          controller: subBlController,
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
                      labelText: 'DO',
                      labelStyle: TextStyle(
                        color: kColorAzul,
                        fontSize: 20.0,
                      ),
                      hintText: '',
                    ),
                    enabled: true,
                    controller: doController,
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      labelText: 'DAM',
                      labelStyle: TextStyle(
                        color: kColorAzul,
                        fontSize: 20.0,
                      ),
                      hintText: '',
                    ),
                    enabled: true,
                    controller: damController,
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      labelText: 'Importador',
                      labelStyle: TextStyle(
                        color: kColorAzul,
                        fontSize: 20.0,
                      ),
                      hintText: '',
                    ),
                    enabled: true,
                    controller: importadorController,
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      labelText: 'Producto',
                      labelStyle: TextStyle(
                        color: kColorAzul,
                        fontSize: 20.0,
                      ),
                      hintText: '',
                    ),
                    enabled: true,
                    controller: productorController,
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      labelText: 'Transportista',
                      labelStyle: TextStyle(
                        color: kColorAzul,
                        fontSize: 20.0,
                      ),
                      hintText: '',
                    ),
                    enabled: true,
                    controller: transportistaController,
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      labelText: 'Manifiesto',
                      labelStyle: TextStyle(
                        color: kColorAzul,
                        fontSize: 20.0,
                      ),
                      hintText: '',
                    ),
                    enabled: true,
                    controller: manifiestoController,
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      labelText: 'Ubicación de la carga',
                      labelStyle: TextStyle(
                        color: kColorAzul,
                        fontSize: 20.0,
                      ),
                      hintText: '',
                    ),
                    enabled: true,
                    controller: ubicacionCargaController,
                  ),
                  const SizedBox(height: 20),
                  MaterialButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    minWidth: double.infinity,
                    height: 50.0,
                    color: kColorNaranja,
                    onPressed: () {
                      createControlTicket();
                    },
                    child: const Text(
                      "REGISTRAR TICKET",
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.5),
                    ),
                  ),
                ],
              )),
        ));
  }
}
