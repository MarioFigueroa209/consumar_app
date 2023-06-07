import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../models/carga_liquida/SqlLiquidaModels/sqlite_ulaje.dart';
import '../../../models/carga_liquida/SqlLiquidaModels/sqlite_ulaje_observados_fotos.dart';
import '../../../models/carga_liquida/SqlLiquidaModels/sqlite_ulaje_tanque_fotos.dart';
import '../../../models/carga_liquida/ulaje/create_liquida_ulaje_list.dart';
import '../../../models/file_upload_result.dart';
import '../../../services/carga_liquida/ulaje_service.dart';
import '../../../services/file_upload_result.dart';
import '../../../utils/carga_liquida/db_ulaje.dart';
import '../../../utils/check_internet_connection.dart';
import '../../../utils/connection_status_cubit.dart';
import '../../../utils/constants.dart';
import '../../../utils/lists.dart';

class UlajePage extends StatefulWidget {
  const UlajePage(
      {super.key,
      required this.jornada,
      required this.idUsuario,
      required this.idServiceOrder});
  final int jornada;
  final int idUsuario;
  final int idServiceOrder;

  @override
  State<UlajePage> createState() => _UlajePageState();
}

class ListFotoTanque {
  ListFotoTanque({this.id, this.fotoTanque, this.urlFoto});

  int? id;
  File? fotoTanque;
  String? urlFoto;
}

class ObservacionDano {
  ObservacionDano({this.id, this.fotoDano, this.urlFoto});

  int? id;
  File? fotoDano;
  int? cantidad;
  String? urlFoto;
}

class _UlajePageState extends State<UlajePage>
    with SingleTickerProviderStateMixin {
  DbUlaje dbLiteUlaje = DbUlaje();

  FileUploadService fileUploadService = FileUploadService();

  bool valueMarcaderia = false;
  bool visibleMercaderia = false;

  String _valueTanqueDropdown = 'Seleccione Tanque';

  late TabController _tabController;

  final pesoController = TextEditingController();

  final temperaturaController = TextEditingController();

  final cantAproxDanoController = TextEditingController();

  final comentariosController = TextEditingController();

  Future<List<SqliteUlaje>>? futureListSqliteUlaje;

  List<ListFotoTanque> listFotoTanque = [];

  List<ObservacionDano> observacionDanoList = [];

  List<SqliteUlajeObservadosFotos> listSqliteUlajeObservadosFotos = [];

  List<SqliteUlajeTanqueFotos> liteSqliteUlajeTanqueFotos = [];

  List<SqliteUlaje> liteSqliteUlaje = [];

  File? imageTanque;

  File? imageDano;

  createUlajeSqlLite() async {
    double? cantidadDanos;

    if (cantAproxDanoController.text.isEmpty) {
      cantidadDanos = null;
    } else {
      cantidadDanos = double.parse(cantAproxDanoController.text);
    }

    await dbLiteUlaje.insertUlajeSqlLite(
        SqliteUlaje(
            jornada: widget.jornada,
            fecha: DateTime.now(),
            tanque: _valueTanqueDropdown,
            peso: double.parse(pesoController.text),
            temperatura: double.parse(temperaturaController.text),
            cantidadDano: cantidadDanos,
            descripcionComentarios: comentariosController.text,
            idServiceOrder: widget.idServiceOrder,
            idUsuario: widget.idUsuario),
        listSqliteUlajeObservadosFotos,
        liteSqliteUlajeTanqueFotos);
    setState(() {
      listFutureTableUlajeSqLite();
      _valueTanqueDropdown = 'Seleccione Tanque';
      pesoController.clear();
      imageDano = null;
      imageTanque = null;
      temperaturaController.clear();
      cantAproxDanoController.clear();
      comentariosController.clear();
      listSqliteUlajeObservadosFotos.clear();
      liteSqliteUlajeTanqueFotos.clear();
      listFotoTanque.clear();
      observacionDanoList.clear();
    });
    _tabController.animateTo((_tabController.index = 1));
  }

  obtenerUlajeList() async {
    liteSqliteUlaje = await dbLiteUlaje.getUlajeListSqlLite();

    print("lista a enviar de ulaje ${liteSqliteUlaje.length}");
  }

  obtenerListTanquesFoto() async {
    liteSqliteUlajeTanqueFotos = await dbLiteUlaje.getListTanquesFotos();

    print("lista a enviar de tanque foto ${liteSqliteUlajeTanqueFotos.length}");
  }

  obtenerObservadosFoto() async {
    listSqliteUlajeObservadosFotos = await dbLiteUlaje.getListObservadosFotos();

    print(
        "lista a enviar de ObservadoFoto ${listSqliteUlajeObservadosFotos.length}");
  }

  listFutureTableUlajeSqLite() {
    futureListSqliteUlaje = dbLiteUlaje.getUlajeListSqlLite();
  }

  List<SpCreateLiquidaUlaje> parseLiquidaUlaje() {
    List<SpCreateLiquidaUlaje> spCreateLiquidaUlajeList = [];
    for (int count = 0; count < liteSqliteUlaje.length; count++) {
      SpCreateLiquidaUlaje spCreateLiquidaUlajeModel = SpCreateLiquidaUlaje();
      spCreateLiquidaUlajeModel.idUlaje = liteSqliteUlaje[count].idUlaje;
      spCreateLiquidaUlajeModel.jornada = liteSqliteUlaje[count].jornada;
      spCreateLiquidaUlajeModel.fecha = liteSqliteUlaje[count].fecha;
      spCreateLiquidaUlajeModel.tanque = liteSqliteUlaje[count].tanque;
      spCreateLiquidaUlajeModel.peso = liteSqliteUlaje[count].peso;
      spCreateLiquidaUlajeModel.temperatura =
          liteSqliteUlaje[count].temperatura;
      spCreateLiquidaUlajeModel.cantidadDano =
          liteSqliteUlaje[count].cantidadDano;
      spCreateLiquidaUlajeModel.descripcionComentarios =
          liteSqliteUlaje[count].descripcionComentarios;
      spCreateLiquidaUlajeModel.idServiceOrder =
          liteSqliteUlaje[count].idServiceOrder;
      spCreateLiquidaUlajeModel.idUsuario = liteSqliteUlaje[count].idUsuario;
      spCreateLiquidaUlajeList.add(spCreateLiquidaUlajeModel);
    }
    return spCreateLiquidaUlajeList;
  }

  Future<List<SpCreateLiquidaUlajeTanquesFoto>> parserTanqueFoto() async {
    List<SpCreateLiquidaUlajeTanquesFoto> spCreateLiquidaUlajeTanquesFoto = [];
    FileUploadResult fileUploadResult = FileUploadResult();
    for (int count = 0; count < liteSqliteUlajeTanqueFotos.length; count++) {
      SpCreateLiquidaUlajeTanquesFoto aux = SpCreateLiquidaUlajeTanquesFoto();
      aux.idUlaje = liteSqliteUlajeTanqueFotos[count].idUlaje;
      aux.tanqueUrlFoto = liteSqliteUlajeTanqueFotos[count].tanqueUrlFoto;
      spCreateLiquidaUlajeTanquesFoto.add(aux);
      File file = File(aux.tanqueUrlFoto!);
      fileUploadResult = await fileUploadService.uploadFile(file);
      spCreateLiquidaUlajeTanquesFoto[count].tanqueUrlFoto =
          fileUploadResult.urlPhoto;
      spCreateLiquidaUlajeTanquesFoto[count].tanqueNombreFoto =
          fileUploadResult.fileName;
    }
    return spCreateLiquidaUlajeTanquesFoto;
  }

  Future<List<SpCreateLiquidaUlajeObservadosFoto>> parserObservadoFoto() async {
    List<SpCreateLiquidaUlajeObservadosFoto>
        spCreateLiquidaUlajeObservadosFoto = [];
    FileUploadResult fileUploadResult = FileUploadResult();
    for (int count = 0;
        count < listSqliteUlajeObservadosFotos.length;
        count++) {
      SpCreateLiquidaUlajeObservadosFoto aux =
          SpCreateLiquidaUlajeObservadosFoto();
      aux.idUlaje = listSqliteUlajeObservadosFotos[count].idUlaje;
      aux.ulajeUrlFoto = listSqliteUlajeObservadosFotos[count].ulajeUrlFoto;
      spCreateLiquidaUlajeObservadosFoto.add(aux);
      File file = File(aux.ulajeUrlFoto!);
      fileUploadResult = await fileUploadService.uploadFile(file);
      spCreateLiquidaUlajeObservadosFoto[count].ulajeUrlFoto =
          fileUploadResult.urlPhoto;
      spCreateLiquidaUlajeObservadosFoto[count].ulajeNombreFoto =
          fileUploadResult.fileName;
    }
    return spCreateLiquidaUlajeObservadosFoto;
  }

  cargarListaCompletaUlaje() async {
    UlajeService ulajeService = UlajeService();

    List<SpCreateLiquidaUlaje> createLiquidaUlaje = <SpCreateLiquidaUlaje>[];
    createLiquidaUlaje = parseLiquidaUlaje();

    List<SpCreateLiquidaUlajeTanquesFoto> spLiquidaUlajeTanquesFoto =
        <SpCreateLiquidaUlajeTanquesFoto>[];
    spLiquidaUlajeTanquesFoto = await parserTanqueFoto();

    List<SpCreateLiquidaUlajeObservadosFoto> spLiquidaUlajeObservadosFoto =
        <SpCreateLiquidaUlajeObservadosFoto>[];
    spLiquidaUlajeObservadosFoto = await parserObservadoFoto();

    CreateLiquidaUlajeList createLiquidaUlajeList = CreateLiquidaUlajeList();

    createLiquidaUlajeList.spCreateLiquidaUlaje = createLiquidaUlaje;
    createLiquidaUlajeList.spCreateLiquidaUlajeObservadosFotos =
        spLiquidaUlajeObservadosFoto;
    createLiquidaUlajeList.spCreateLiquidaUlajeTanquesFotos =
        spLiquidaUlajeTanquesFoto;

    ulajeService.createLiquidaUlajeList(createLiquidaUlajeList);
  }

  @override
  void initState() {
    // TODO: implement initState
    _tabController = TabController(length: 2, vsync: this);
    listFutureTableUlajeSqLite();
    obtenerObservadosFoto();
    obtenerListTanquesFoto();
    obtenerUlajeList();
    super.initState();
  }

  @override
  void dispose() {
    /*   _tabController.removeListener(_handleTabIndex); */
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Ulaje"),
          bottom: TabBar(
              indicatorColor: kColorCeleste,
              labelColor: kColorCeleste,
              unselectedLabelColor: Colors.white,
              controller: _tabController,
              tabs: const [
                Tab(
                  icon: Icon(
                    Icons.app_registration,
                  ),
                  child: Text(
                    'REGISTRO',
                  ),
                ),
                Tab(
                  icon: Icon(
                    Icons.checklist,
                  ),
                  child: Text('LISTADO'),
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
                  DropdownButtonFormField(
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
                    items: listaTanque.map((String a) {
                      return DropdownMenuItem<String>(
                        value: a,
                        child:
                            Center(child: Text(a, textAlign: TextAlign.left)),
                      );
                    }).toList(),
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
                  const SizedBox(height: 20),
                  TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      prefixIcon: Icon(
                        Icons.directions_boat,
                        color: kColorAzul,
                      ),
                      labelText: 'Peso',
                      labelStyle: TextStyle(
                        color: kColorAzul,
                        fontSize: 20.0,
                      ),
                      hintText: '',
                    ),
                    controller: pesoController,
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      prefixIcon: Icon(
                        Icons.directions_boat,
                        color: kColorAzul,
                      ),
                      labelText: 'Temperatura',
                      labelStyle: TextStyle(
                        color: kColorAzul,
                        fontSize: 20.0,
                      ),
                      hintText: '',
                    ),
                    controller: temperaturaController,
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
                          "Ingrese Fotos de los tanques",
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
                              child: imageTanque != null
                                  ? Image.file(imageTanque!,
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
                                          "Inserte Foto del tanque",
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
                                      onPressed: (() =>
                                          pickTanqueFoto(ImageSource.gallery)),
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
                                      onPressed: (() =>
                                          pickTanqueFoto(ImageSource.camera)),
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
                  const SizedBox(
                    height: 20,
                  ),
                  MaterialButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    minWidth: double.infinity,
                    height: 50.0,
                    color: kColorCeleste,
                    onPressed: () {
                      setState(() {
                        listFotoTanque.add(ListFotoTanque(
                            fotoTanque: imageTanque!,
                            urlFoto: imageTanque!.path));
                        liteSqliteUlajeTanqueFotos.add(SqliteUlajeTanqueFotos(
                            tanqueUrlFoto: imageTanque!.path));
                      });
                    },
                    child: Text(
                      "AGREGAR",
                      style: TextStyle(
                          fontSize: 20,
                          color: kColorAzul,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.5),
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
                          itemCount: listFotoTanque.length,
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
                                child: listFotoTanque[i].fotoTanque != null
                                    ? Image.file(listFotoTanque[i].fotoTanque!,
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
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    color: Colors.grey,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: const [
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              "Mercaderia Observada",
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Switch(
                              value: valueMarcaderia,
                              onChanged: (value) => setState(
                                () {
                                  valueMarcaderia = value;
                                  visibleMercaderia = value;
                                },
                              ),
                              activeTrackColor: Colors.lightGreenAccent,
                              activeColor: Colors.green,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                      visible: visibleMercaderia,
                      child: Column(children: [
                        const SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                labelText: 'Observacion',
                                labelStyle: TextStyle(
                                  color: kColorAzul,
                                  fontSize: 18.0,
                                ),
                                hintText: 'Cantidad Aproximada de daño'),
                            controller: cantAproxDanoController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Por favor, ingrese cantidad';
                              }
                              return null;
                            },
                            enabled: true),
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
                                "Ingrese Fotos de los daños",
                                style: TextStyle(
                                    fontSize: 15,
                                    color: kColorAzul,
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 1, color: Colors.grey),
                                    ),
                                    width: 150,
                                    height: 150,
                                    child: imageDano != null
                                        ? Image.file(imageDano!,
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
                                                "Inserte Foto de los daños",
                                                style: TextStyle(
                                                    color: Colors.grey),
                                                textAlign: TextAlign.center,
                                              )),
                                            ],
                                          ),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.40,
                                        child: ElevatedButton(
                                            style: TextButton.styleFrom(
                                              backgroundColor: kColorNaranja,
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                            ),
                                            onPressed: (() =>
                                                pickObservacionDano(
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
                                            MediaQuery.of(context).size.width *
                                                0.40,
                                        child: ElevatedButton(
                                            style: TextButton.styleFrom(
                                              backgroundColor: kColorNaranja,
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                            ),
                                            onPressed: (() =>
                                                pickObservacionDano(
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
                        const SizedBox(
                          height: 20,
                        ),
                        MaterialButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          minWidth: double.infinity,
                          height: 50.0,
                          color: kColorCeleste,
                          onPressed: () {
                            setState(() {
                              observacionDanoList.add(ObservacionDano(
                                  fotoDano: imageDano!,
                                  urlFoto: imageDano!.path));
                              listSqliteUlajeObservadosFotos.add(
                                  SqliteUlajeObservadosFotos(
                                      ulajeUrlFoto: imageDano!.path));
                            });
                          },
                          child: Text(
                            "AGREGAR",
                            style: TextStyle(
                                fontSize: 20,
                                color: kColorAzul,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.5),
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
                                itemCount: observacionDanoList.length,
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
                                      child: observacionDanoList[i].fotoDano !=
                                              null
                                          ? Image.file(
                                              observacionDanoList[i].fotoDano!,
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
                      ])),
                  const SizedBox(height: 20),
                  Text(
                    "Comentarios",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: kColorAzul),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    //textAlign: TextAlign.justify,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10)))),
                    controller: comentariosController,
                    maxLines: 5,
                    minLines: 3,
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
                      createUlajeSqlLite();
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
                ],
              ),
            )),
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    BlocProvider(
                      create: (context) => ConnectionStatusCubit(),
                      child:
                          BlocBuilder<ConnectionStatusCubit, ConnectionStatus>(
                        builder: (context, status) {
                          return Visibility(
                              visible: status != ConnectionStatus.online,
                              child: Container(
                                padding: const EdgeInsets.all(16),
                                height: 60,
                                color: Colors.red,
                                child: Row(
                                  children: const [
                                    Icon(Icons.wifi_off),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Text("SIN CONEXIÓN A INTERNET")
                                  ],
                                ),
                              ));
                        },
                      ),
                    ),
                    BlocProvider(
                      create: (context) => ConnectionStatusCubit(),
                      child:
                          BlocBuilder<ConnectionStatusCubit, ConnectionStatus>(
                        builder: (context, status) {
                          return Visibility(
                              visible: status == ConnectionStatus.online,
                              child: Container(
                                padding: const EdgeInsets.all(16),
                                height: 60,
                                color: Colors.green,
                                child: Row(
                                  children: const [
                                    Icon(Icons.cell_wifi),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Text("CON CONEXIÓN A INTERNET")
                                  ],
                                ),
                              ));
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: FutureBuilder<List<SqliteUlaje>>(
                          future: futureListSqliteUlaje,
                          builder: (context, snapshot) {
                            /* if (!snapshot.hasData) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            } */
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
                                    label: Text("Tanque"),
                                  ),
                                  DataColumn(
                                    label: Text("Peso "),
                                  ),
                                  DataColumn(
                                    label: Text("Temperatura"),
                                  ),
                                  DataColumn(
                                    label: Text("Delete"),
                                  ),
                                ],
                                rows: snapshot.data!
                                    .map(((e) => DataRow(
                                          onLongPress: () {},
                                          cells: <DataCell>[
                                            DataCell(Text(e.tanque.toString())),
                                            DataCell(Text(e.peso.toString(),
                                                textAlign: TextAlign.center)),
                                            DataCell(Text(
                                                e.temperatura.toString(),
                                                textAlign: TextAlign.center)),
                                            DataCell(
                                              IconButton(
                                                icon: const Icon(
                                                  Icons.delete,
                                                  color: Colors.grey,
                                                ),
                                                onPressed: () {
                                                  dialogoEliminar(context, e);
                                                  setState(() {});
                                                },
                                              ),
                                            ),
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
                    BlocProvider(
                      create: (context) => ConnectionStatusCubit(),
                      child:
                          BlocBuilder<ConnectionStatusCubit, ConnectionStatus>(
                        builder: (context, status) {
                          return Visibility(
                              visible: status != ConnectionStatus.online,
                              child: Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black),
                                      color: Colors.white,
                                    ),
                                    padding: const EdgeInsets.all(16),
                                    child: Column(
                                      children: [
                                        Icon(
                                          Icons.warning,
                                          color: Colors.red.shade900,
                                          size: 50,
                                        ),
                                        Text(
                                          "ATENCIÓN: ES NECESARIO TENER CONEXIÓN A INTERNET PARA PODER CARGAR LOS REGISTROS",
                                          style: TextStyle(
                                              color: Colors.red.shade900,
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.bold),
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                ],
                              ));
                        },
                      ),
                    ),
                    BlocProvider(
                      create: (context) => ConnectionStatusCubit(),
                      child:
                          BlocBuilder<ConnectionStatusCubit, ConnectionStatus>(
                        builder: (context, status) {
                          return Visibility(
                              visible: status == ConnectionStatus.online,
                              child: MaterialButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                minWidth: double.infinity,
                                height: 50.0,
                                color: kColorNaranja,
                                onPressed: () async {
                                  await obtenerUlajeList();
                                  await obtenerListTanquesFoto();
                                  await obtenerObservadosFoto();
                                  cargarListaCompletaUlaje();
                                  await dbLiteUlaje.clearTables();
                                  setState(() {
                                    listFutureTableUlajeSqLite();
                                    listSqliteUlajeObservadosFotos.clear();
                                    liteSqliteUlajeTanqueFotos.clear();
                                    liteSqliteUlaje.clear();
                                  });
                                },
                                child: const Text(
                                  "CARGAR LISTA",
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1.5),
                                ),
                              ));
                        },
                      ),
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
                    listFutureTableUlajeSqLite();
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

  dialogoEliminar(BuildContext context, SqliteUlaje itemSqlUlaje) {
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
                        dbLiteUlaje.deleteUlajeByIdUlaje(itemSqlUlaje.idUlaje!);
                        dbLiteUlaje
                            .deleteTanquesFotosByIDUlaje(itemSqlUlaje.idUlaje!);
                        dbLiteUlaje.deleteObservadosFotosByIdUlaje(
                            itemSqlUlaje.idUlaje!);
                        setState(() {
                          listFutureTableUlajeSqLite();
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

  Future pickTanqueFoto(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);

      if (image == null) return;

      final imageTemporary = File(image.path);

      setState(() => this.imageTanque = imageTemporary);
    } on PlatformException catch (e) {
      // print('Failed to pick image: $e');
      e.message;
    }
  }

  Future pickObservacionDano(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);

      if (image == null) return;

      final imageTemporary = File(image.path);

      setState(() => this.imageDano = imageTemporary);
    } on PlatformException catch (e) {
      // print('Failed to pick image: $e');
      e.message;
    }
  }
}
