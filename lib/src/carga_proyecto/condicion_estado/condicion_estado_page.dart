import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../../utils/constants.dart';
import '../../scanner_screen.dart';

class CondicionEstadoPage extends StatefulWidget {
  const CondicionEstadoPage(
      {super.key,
      required this.jornada,
      required this.idUsuario,
      required this.idServiceOrder});
  final int jornada;
  final int idUsuario;
  final int idServiceOrder;

  @override
  State<CondicionEstadoPage> createState() => _CondicionEstadoPageState();
}

class ListInspeccionFotos {
  ListInspeccionFotos({this.id, this.fotoParalizacion, this.urlFoto});

  int? id;
  File? fotoParalizacion;
  String? urlFoto;
}

class _CondicionEstadoPageState extends State<CondicionEstadoPage> {
  File? imageInspeccionFoto;

  List<ListInspeccionFotos> listInspeccionFoto = [];

  List<ListInspeccionFotos> vwInspeccionFotos = <ListInspeccionFotos>[
    ListInspeccionFotos(
      urlFoto: 'https://picsum.photos/250?image=9',
    ),
  ];

  final TextEditingController qrCodigoController = TextEditingController();

  final TextEditingController qrLecturaController = TextEditingController();

  final TextEditingController fechaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    fechaController.value =
        TextEditingValue(text: DateFormat('dd-MM-yyyy').format(DateTime.now()));

    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text("CONDICION DE ESTADO"),
            bottom: TabBar(
                indicatorColor: kColorCeleste,
                labelColor: kColorCeleste,
                /* controller: _tabController, */
                unselectedLabelColor: Colors.white,
                tabs: const [
                  Tab(
                    icon: Icon(
                      Icons.app_registration,
                    ),
                    child: Text(
                      'INSPECCION',
                    ),
                  ),
                  Tab(
                    icon: Icon(
                      Icons.checklist,
                    ),
                    child: Text('FOTOS'),
                  ),
                ]),
          ),
          body: TabBarView(
            children: [
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(children: [
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

                                qrCodigoController.text = result;
                              }),
                          suffixIcon: IconButton(
                              icon: const Icon(Icons.search),
                              onPressed: () {
                                // getUserConductorDataByCodUser();
                              }),
                          labelText: 'Qr',
                          labelStyle: TextStyle(
                            color: kColorAzul,
                            fontSize: 20.0,
                          ),
                          hintText: 'Ingrese el cod Qr'),
                      onChanged: (value) {
                        // getUserConductorDataByCodUser();
                      },
                      controller: qrCodigoController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, ingrese el Qr';
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
                        labelText: 'Lectura',
                      ),
                      enabled: false,
                      //hintText: 'Ingrese el numero de ID del Job'),
                      controller: qrLecturaController,
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
                    Container(
                      height: 40,
                      color: kColorAzul,
                      child: const Center(
                        child: Text("INSPECCION FOTOGRAFICA",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                      ),
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
                            "Ingrese Fotos de inspeccion",
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
                                child: imageInspeccionFoto != null
                                    ? Image.file(imageInspeccionFoto!,
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
                                            "Inserte Foto Inspeccion",
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
                          listInspeccionFoto.add(ListInspeccionFotos(
                              fotoParalizacion: imageInspeccionFoto!,
                              urlFoto: imageInspeccionFoto!.path));
                        });
                      },
                      child: Text(
                        "AGREGAR FOTO",
                        style: TextStyle(
                          fontSize: 20,
                          color: kColorBlanco,
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
                            itemCount: listInspeccionFoto.length,
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
                                  child: listInspeccionFoto[i]
                                              .fotoParalizacion !=
                                          null
                                      ? Image.file(
                                          listInspeccionFoto[i]
                                              .fotoParalizacion!,
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
                    Container(
                      height: 40,
                      color: kColorAzul,
                      child: const Center(
                        child: Text("UBICACION DEL BULTO",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          labelText: 'Ubicación',
                          labelStyle: TextStyle(
                            color: kColorAzul,
                            fontSize: 20.0,
                          ),
                          hintText: 'Ingrese la Ubicación'),
                      controller: qrCodigoController,
                      /* validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, ingrese el Qr';
                        }
                        return null;
                      }, */
                    ),
                    const SizedBox(height: 20),
                    MaterialButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      minWidth: double.infinity,
                      height: 50.0,
                      color: kColorCeleste2,
                      onPressed: () {
                        setState(() {
                          /*  listFotosLiquidaParalizaciones.add(
                              ListFotosLiquidaParalizaciones(
                                  fotoParalizacion: imageInicioParalizacion!,
                                  urlFoto: imageInicioParalizacion!.path)); */
                        });
                      },
                      child: Text(
                        "AGREGAR COORDENADAS",
                        style: TextStyle(
                          fontSize: 20,
                          color: kColorBlanco,
                          fontWeight: FontWeight.bold, /* letterSpacing: 1.5 */
                        ),
                      ),
                    ),
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
                        "REGISTRAR CONDICION DE ESTADO",
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
                scrollDirection: Axis.vertical,
                child: Column(children: [
                  Table(
                      border: TableBorder.all(color: Colors.blueGrey),
                      children: [
                        for (var i = 0; i < vwInspeccionFotos.length; i++)
                          TableRow(children: [
                            Column(children: [
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Image.network(
                                    vwInspeccionFotos[i].urlFoto!,
                                    height: 150,
                                    width: 150,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.close),
                                color: Colors.red,
                              )
                            ]),
                          ])
                      ])
                ]),
              ),
            ],
          ),
        ));
  }

  Future pickInspeccionFoto(ImageSource source) async {
    try {
      final imageInicioParalizacion =
          await ImagePicker().pickImage(source: source);

      if (imageInicioParalizacion == null) return;

      final imageTemporary = File(imageInicioParalizacion.path);

      setState(() => this.imageInspeccionFoto = imageTemporary);
    } on PlatformException catch (e) {
      e.message;
    }
  }
}
