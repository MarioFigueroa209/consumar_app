import 'package:flutter/material.dart';

import '../../../utils/constants.dart';
import 'etiquetado_qrCode_page.dart';

class EtiquetadoPage extends StatefulWidget {
  const EtiquetadoPage(
      {super.key,
      required this.jornada,
      required this.idUsuario,
      required this.idServiceOrder});
  final int jornada;
  final int idUsuario;
  final int idServiceOrder;

  @override
  State<EtiquetadoPage> createState() => _EtiquetadoPageState();
}

class ListPackingList {
  ListPackingList({this.cod, this.descripcion, this.etiquetada});

  int? cod;
  String? descripcion;
  String? etiquetada;
}

class _EtiquetadoPageState extends State<EtiquetadoPage>
    with SingleTickerProviderStateMixin {
  List<ListPackingList> listPackingList = <ListPackingList>[
    ListPackingList(
      cod: 1,
      descripcion: "descrip 1",
    ),
    ListPackingList(
      cod: 2,
      descripcion: "descrip 2",
    ),
  ];

  late TabController _tabController;

  Future<List<ListPackingList>>? futureListPackingList;

  final codigoController = TextEditingController();

  final descripcionController = TextEditingController();

  final ordenVentaController = TextEditingController();

  final cantidadController = TextEditingController();

  final altoController = TextEditingController();

  final anchoController = TextEditingController();

  final largoController = TextEditingController();

  final pesoController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text("ETIQUETADO"),
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
                      'BUSQUEDA',
                    ),
                  ),
                  Tab(
                    icon: Icon(
                      Icons.checklist,
                    ),
                    child: Text('PACKING LIST'),
                  ),
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
                            suffixIcon: IconButton(
                                icon: const Icon(Icons.search),
                                onPressed: () {
                                  //  getTransporteByCod();
                                }),
                            labelText: 'Codigo ',
                            labelStyle: TextStyle(
                              color: kColorAzul,
                              fontSize: 20.0,
                            ),
                            hintText: 'Ingrese Codigo'),
                        onChanged: (value) {
                          // getTransporteByCod();
                        },
                        controller: codigoController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, Ingrese codigo de transporte';
                          }
                          return null;
                        },
                        //enabled: enableConductorController,
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
                                  //  getTransporteByCod();
                                }),
                            labelText: 'Descripcion',
                            labelStyle: TextStyle(
                              color: kColorAzul,
                              fontSize: 20.0,
                            ),
                            hintText: 'Ingrese descripcion'),
                        onChanged: (value) {
                          // getTransporteByCod();
                        },
                        controller: descripcionController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, Ingrese descripcion';
                          }
                          return null;
                        },
                        //enabled: enableConductorController,
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
                                  // getTransporteByCod();
                                }),
                            labelText: 'Orden de Venta',
                            labelStyle: TextStyle(
                              color: kColorAzul,
                              fontSize: 20.0,
                            ),
                            hintText: 'Ingrese orden de venta'),
                        onChanged: (value) {
                          //getTransporteByCod();
                        },
                        controller: ordenVentaController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, Ingrese orden de venta';
                          }
                          return null;
                        },
                        //enabled: enableConductorController,
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
                                  //   getTransporteByCod();
                                }),
                            labelText: 'Cantidad',
                            labelStyle: TextStyle(
                              color: kColorAzul,
                              fontSize: 20.0,
                            ),
                            hintText: 'Ingrese cantidad'),
                        onChanged: (value) {
                          // getTransporteByCod();
                        },
                        controller: cantidadController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, Ingrese cantidad';
                          }
                          return null;
                        },
                        //enabled: enableConductorController,
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
                                  //   getTransporteByCod();
                                }),
                            labelText: 'Alto',
                            labelStyle: TextStyle(
                              color: kColorAzul,
                              fontSize: 20.0,
                            ),
                            hintText: 'Ingrese alto'),
                        onChanged: (value) {
                          // getTransporteByCod();
                        },
                        controller: altoController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, Ingrese alto';
                          }
                          return null;
                        },
                        //enabled: enableConductorController,
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
                                  //   getTransporteByCod();
                                }),
                            labelText: 'Ancho',
                            labelStyle: TextStyle(
                              color: kColorAzul,
                              fontSize: 20.0,
                            ),
                            hintText: 'Ingrese ancho'),
                        onChanged: (value) {
                          // getTransporteByCod();
                        },
                        controller: anchoController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, Ingrese Ancho';
                          }
                          return null;
                        },
                        //enabled: enableConductorController,
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
                                  //   getTransporteByCod();
                                }),
                            labelText: 'Largo',
                            labelStyle: TextStyle(
                              color: kColorAzul,
                              fontSize: 20.0,
                            ),
                            hintText: 'Ingrese Largo'),
                        onChanged: (value) {
                          // getTransporteByCod();
                        },
                        controller: largoController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, Ingrese Largo';
                          }
                          return null;
                        },
                        //enabled: enableConductorController,
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
                                  //   getTransporteByCod();
                                }),
                            labelText: 'Peso',
                            labelStyle: TextStyle(
                              color: kColorAzul,
                              fontSize: 20.0,
                            ),
                            hintText: 'Ingrese Peso'),
                        onChanged: (value) {
                          // getTransporteByCod();
                        },
                        controller: pesoController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, Ingrese Peso';
                          }
                          return null;
                        },
                        //enabled: enableConductorController,
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 33, vertical: 20),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      dividerThickness: 3,
                      border: TableBorder.symmetric(
                          inside: BorderSide(
                              width: 1, color: Colors.grey.shade200)),
                      decoration: BoxDecoration(
                        border: Border.all(color: kColorAzul),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      headingTextStyle: TextStyle(
                          fontWeight: FontWeight.bold, color: kColorAzul),
                      columns: const <DataColumn>[
                        DataColumn(
                          label: Text("COD"),
                        ),
                        DataColumn(
                          label: Text("DESCRIP."),
                        ),
                        DataColumn(
                          label: Text("ETIQUET."),
                        ),
                      ],
                      rows: listPackingList
                          .map(((e) => DataRow(
                                onLongPress: () {
                                  /*  Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ReinspeccionEquipoLiquida(
                                                        idInspeccionEquipo: e
                                                            .idInspeccionEquipo!,
                                                      ))); */
                                },
                                cells: <DataCell>[
                                  DataCell(Text(e.cod.toString())),
                                  DataCell(Text(e.descripcion.toString(),
                                      textAlign: TextAlign.center)),
                                  DataCell(IconButton(
                                    icon: const Icon(Icons.qr_code),
                                    onPressed: (() {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  EtiquetadoQrPage()));
                                    }),
                                  )),
                                  /*  DataCell(IconButton(
                                            icon: const Icon(Icons.delete),
                                            onPressed: (() {
                                              /*   inspeccionEquipoService
                                                  .delecteLogicInspeccionEquipo(
                                                      e.idInspeccionEquipo!); */
                                             / dialogoEliminar(context, e);
                                            }),
                                          )), */
                                ],
                              )))
                          .toList(),
                    ),
                  ),
                ),
              )
            ],
          ),
          floatingActionButton: _tabController.index == 1
              ? FloatingActionButton(
                  onPressed: () {
                    setState(() {
                      // obtenerInspeccionEquiposByIdServiceOrder();
                    });
                  },
                  backgroundColor: kColorCeleste,
                  child: Icon(
                    Icons.refresh,
                    color: kColorAzul,
                  ),
                )
              : null,
        ));
  }
}
