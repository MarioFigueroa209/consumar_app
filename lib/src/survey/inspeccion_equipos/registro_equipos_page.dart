import 'package:flutter/material.dart';

import '../../../models/survey/RegistroEquipos/sp_create_granel_registro_equipos.dart';
import '../../../models/survey/RegistroEquipos/vw_equipos_registrados_granel.dart';
import '../../../services/survey/registro_equipo_service.dart';
import '../../../utils/constants.dart';

class RegistroEquipos extends StatefulWidget {
  const RegistroEquipos({Key? key}) : super(key: key);

  @override
  State<RegistroEquipos> createState() => _RegistroEquiposState();
}

class _RegistroEquiposState extends State<RegistroEquipos>
    with TickerProviderStateMixin {
  late TabController _tabController;

  RegistroEquipoService registroEquipoService = RegistroEquipoService();

  TextEditingController codEquipoController = TextEditingController();

  TextEditingController equipoController = TextEditingController();

  TextEditingController detalleController = TextEditingController();

  TextEditingController puertoController = TextEditingController();

  TextEditingController operacionController = TextEditingController();

  Future<List<VwEquiposRegistradosGranel>>? futureVwEquiposRegistradosGranel;

  obtenerListadoEquipos() {
    futureVwEquiposRegistradosGranel =
        registroEquipoService.getEquiposRegistradosGranel();
  }

  createEquipo() async {
    await registroEquipoService
        .createGranelRegistroEquipos(SpCreateGranelRegistroEquipos(
            codEquipo: codEquipoController.text,
            equipo: equipoController.text,
            detalle: detalleController.text,
            //puerto: puertoController.text,
            operacion: "GRANEL"));
    setState(() {
      obtenerListadoEquipos();
    });
    _tabController.animateTo((_tabController.index = 1));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(_handleTabIndex);
    obtenerListadoEquipos();
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabIndex);
    _tabController.dispose();
    super.dispose();
  }

  void _handleTabIndex() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("REGISTRO EQUIPOS"),
          bottom: TabBar(
              indicatorColor: kColorCeleste,
              labelColor: kColorCeleste,
              unselectedLabelColor: Colors.white,
              controller: _tabController,
              tabs: const [
                Tab(text: 'Registro'),
                Tab(text: 'Lista'),
              ]),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        prefixIcon: Icon(
                          Icons.calendar_month,
                          color: kColorAzul,
                        ),
                        labelText: 'CODIGO',
                        labelStyle: TextStyle(
                          color: kColorAzul,
                          //fontSize: 20.0,
                        ),
                      ),
                      controller: codEquipoController,
                      style: TextStyle(
                        color: kColorAzul,
                        fontSize: 20.0,
                      ),
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
                          Icons.calendar_month,
                          color: kColorAzul,
                        ),
                        labelText: 'EQUIPO',
                        labelStyle: TextStyle(
                          color: kColorAzul,
                          //fontSize: 20.0,
                        ),
                      ),
                      controller: equipoController,
                      style: TextStyle(
                        color: kColorAzul,
                        fontSize: 20.0,
                      ),
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
                          Icons.calendar_month,
                          color: kColorAzul,
                        ),
                        labelText: 'DETALLE',
                        labelStyle: TextStyle(
                          color: kColorAzul,
                          //fontSize: 20.0,
                        ),
                      ),
                      controller: detalleController,
                      style: TextStyle(
                        color: kColorAzul,
                        fontSize: 20.0,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    /*     TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        prefixIcon: Icon(
                          Icons.calendar_month,
                          color: kColorAzul,
                        ),
                        labelText: 'PUERTO',
                        labelStyle: TextStyle(
                          color: kColorAzul,
                          //fontSize: 20.0,
                        ),
                      ),
                      controller: puertoController,
                      style: TextStyle(
                        color: kColorAzul,
                        fontSize: 20.0,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ), */
                    /* TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        prefixIcon: Icon(
                          Icons.calendar_month,
                          color: kColorAzul,
                        ),
                        labelText: 'OPERACION',
                        labelStyle: TextStyle(
                          color: kColorAzul,
                          //fontSize: 20.0,
                        ),
                      ),
                      controller: operacionController,
                      style: TextStyle(
                        color: kColorAzul,
                        fontSize: 20.0,
                      ),
                    ), */

                    MaterialButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      minWidth: double.infinity,
                      height: 50.0,
                      color: kColorNaranja,
                      onPressed: () {
                        createEquipo();
                      },
                      child: const Text(
                        "REGISTRAR EQUIPO",
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.5),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: FutureBuilder<List<VwEquiposRegistradosGranel>>(
                          future: futureVwEquiposRegistradosGranel,
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            }
                            if (snapshot.hasData) {
                              return DataTable(
                                dividerThickness: 3,
                                border: TableBorder.symmetric(
                                    inside: BorderSide(
                                        width: 1, color: Colors.grey.shade200)),
                                decoration: BoxDecoration(
                                  border: Border.all(color: kColorAzul),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                headingTextStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: kColorAzul),
                                columns: const <DataColumn>[
                                  DataColumn(
                                    label: Text("Nº"),
                                  ),
                                  DataColumn(
                                    label: Text("Cod Equipo"),
                                  ),
                                  DataColumn(
                                    label: Text("Equipo"),
                                  ),
                                  DataColumn(
                                    label: Text("Detalle"),
                                  ),
                                  /*  DataColumn(
                                    label: Text("Puerto"),
                                  ), */
                                  DataColumn(
                                    label: Text("Delete"),
                                  ),
                                ],
                                rows: snapshot.data!
                                    .map(((e) => DataRow(
                                          cells: <DataCell>[
                                            DataCell(
                                                Text(e.idVista.toString())),
                                            DataCell(Text(
                                                e.codEquipo.toString(),
                                                textAlign: TextAlign.center)),
                                            DataCell(Text(e.equipo.toString(),
                                                textAlign: TextAlign.center)),
                                            DataCell(Text(e.detalle.toString(),
                                                textAlign: TextAlign.center)),
                                            /*  DataCell(Text(e.puerto.toString(),
                                                textAlign: TextAlign.center)), */
                                            DataCell(IconButton(
                                              icon: const Icon(Icons.delete),
                                              onPressed: (() {
                                                dialogoEliminar(context, e);
                                              }),
                                            )),
                                          ],
                                        )))
                                    .toList(),
                              );
                            } else if (snapshot.hasError) {
                              return Text("${snapshot.error}");
                            } else {
                              return const Text("No se encuentraron registros");
                            }
                          }),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        floatingActionButton: _tabController.index == 1
            ? FloatingActionButton(
                onPressed: () {
                  setState(() {
                    obtenerListadoEquipos();
                  });
                },
                backgroundColor: kColorCeleste,
                child: Icon(
                  Icons.refresh,
                  color: kColorAzul,
                ),
              )
            : null,
      ),
    );
  }

  dialogoEliminar(BuildContext context, VwEquiposRegistradosGranel e) {
    showDialog<void>(
        context: context,
        builder: (context) => AlertDialog(
              insetPadding: const EdgeInsets.all(100),
              actions: [
                const Center(
                  child: SizedBox(
                    width: 180,
                    child: Text(
                      '¿SEGURO QUE DESEA ELIMINAR ESTE REGISTRO?',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      onPressed: () {
                        registroEquipoService
                            .delecteLogicGranelRegistroEquipo(e.idEquipo!);
                        setState(() {
                          obtenerListadoEquipos();
                        });
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "Eliminar",
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "Cancelar",
                        style: TextStyle(color: Colors.blue),
                      ),
                    )
                  ],
                ),
              ],
            ));
  }
}
