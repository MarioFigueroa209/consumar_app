import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../../utils/constants.dart';

class ReporteDanosDrPage extends StatefulWidget {
  const ReporteDanosDrPage(
      {super.key,
      required this.jornada,
      required this.idUsuario,
      required this.idServiceOrder});
  final int jornada;
  final int idUsuario;
  final int idServiceOrder;

  @override
  State<ReporteDanosDrPage> createState() => _ReporteDanosDrPageState();
}

class ListPackingList {
  ListPackingList({this.cod, this.descripcion, this.etiquetada});

  int? cod;
  String? descripcion;
  String? etiquetada;
}

class ListDrFotos {
  ListDrFotos({this.id, this.fotoDr, this.urlFoto});

  int? id;
  File? fotoDr;
  String? urlFoto;
}

class _ReporteDanosDrPageState extends State<ReporteDanosDrPage>
    with SingleTickerProviderStateMixin {
  File? imageDr;

  List<ListDrFotos> listDrFoto = [];

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

  final codigoController = TextEditingController();

  final lecturaQrController = TextEditingController();

  final descripcionController = TextEditingController();

  final TextEditingController fechaController = TextEditingController();

  late TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    fechaController.value = TextEditingValue(
        text: DateFormat('dd-MM-yyyy hh:mm').format(DateTime.now()));

    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text("REPORTE DE DAÑOS"),
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
                            labelText: 'Lectura',
                            labelStyle: TextStyle(
                              color: kColorAzul,
                              fontSize: 20.0,
                            ),
                            hintText: 'Ingrese descripcion'),
                        onChanged: (value) {
                          // getTransporteByCod();
                        },
                        controller: lecturaQrController,
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
                        controller: fechaController,
                        style: TextStyle(
                          color: kColorAzul,
                          fontSize: 20.0,
                        ),
                        enabled: false,
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            labelText: 'Descripción de Daño',
                            labelStyle: TextStyle(
                              color: kColorAzul,
                              fontSize: 20.0,
                            ),
                            hintText: 'Ingrese descripción'),
                        onChanged: (value) {
                          // getTransporteByCod();
                        },
                        controller: descripcionController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, Ingrese cantidad';
                          }
                          return null;
                        },
                        //enabled: enableConductorController,
                      ),
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
                              "Ingrese Fotos de Daño",
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
                                    border: Border.all(
                                        width: 1, color: Colors.grey),
                                  ),
                                  width: 150,
                                  height: 150,
                                  child: imageDr != null
                                      ? Image.file(imageDr!,
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
                                              "Inserte Foto Daño",
                                              style:
                                                  TextStyle(color: Colors.grey),
                                              textAlign: TextAlign.center,
                                            )),
                                          ],
                                        ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.40,
                                      child: ElevatedButton(
                                          style: TextButton.styleFrom(
                                            backgroundColor: kColorNaranja,
                                            padding: const EdgeInsets.all(10.0),
                                          ),
                                          onPressed: (() => pickInspeccionFoto(
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
                                      width: MediaQuery.of(context).size.width *
                                          0.40,
                                      child: ElevatedButton(
                                          style: TextButton.styleFrom(
                                            backgroundColor: kColorNaranja,
                                            padding: const EdgeInsets.all(10.0),
                                          ),
                                          onPressed: (() => pickInspeccionFoto(
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
                        color: kColorCeleste2,
                        onPressed: () {
                          setState(() {
                            listDrFoto.add(ListDrFotos(
                                fotoDr: imageDr!, urlFoto: imageDr!.path));
                          });
                        },
                        child: Text(
                          "AGREGAR FOTO",
                          style: TextStyle(
                            fontSize: 20,
                            color: kColorBlanco,
                            fontWeight:
                                FontWeight.bold, /* letterSpacing: 1.5 */
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
                              itemCount: listDrFoto.length,
                              itemBuilder: (_, int i) {
                                return Column(children: [
                                  const SizedBox(height: 10),
                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 1, color: Colors.grey),
                                    ),
                                    width: 200,
                                    height: 200,
                                    child: listDrFoto[i].fotoDr != null
                                        ? Image.file(listDrFoto[i].fotoDr!,
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
                                                style: TextStyle(
                                                    color: Colors.grey),
                                                textAlign: TextAlign.center,
                                              )),
                                            ],
                                          ),
                                  ),
                                  const Divider(),
                                ]);
                              })),
                      const SizedBox(height: 40),
                      MaterialButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        minWidth: double.infinity,
                        height: 50.0,
                        color: kColorNaranja,
                        onPressed: () async {},
                        child: const Text(
                          "CARGAR",
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
                                    onPressed: (() {}),
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

  Future pickInspeccionFoto(ImageSource source) async {
    try {
      final imageInicioParalizacion =
          await ImagePicker().pickImage(source: source);

      if (imageInicioParalizacion == null) return;

      final imageTemporary = File(imageInicioParalizacion.path);

      setState(() => this.imageDr = imageTemporary);
    } on PlatformException catch (e) {
      e.message;
    }
  }
}
