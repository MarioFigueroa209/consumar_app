import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import '../../../models/carga_liquida/paralizaciones/create_liquida_paralizaciones.dart';
import '../../../models/carga_liquida/paralizaciones/sp_liquida_update_paralizaciones_by_id.dart';
import '../../../models/carga_liquida/paralizaciones/vw_liquida_get_paralizaciones.dart';
import '../../../models/carga_liquida/paralizaciones/vw_liquida_get_paralizaciones_by_id.dart';
import '../../../models/file_upload_result.dart';
import '../../../services/carga_liquida/paralizaciones_liquida_service.dart';
import '../../../services/file_upload_result.dart';
import '../../../utils/constants.dart';
import '../../../utils/lists.dart';

class LiquidaParalizaciones extends StatefulWidget {
  const LiquidaParalizaciones(
      {super.key,
      required this.jornada,
      required this.idUsuario,
      required this.idServiceOrder});
  final int jornada;
  final int idUsuario;
  final int idServiceOrder;

  @override
  State<LiquidaParalizaciones> createState() => _LiquidaParalizacionesState();
}

class ListFotosLiquidaParalizaciones {
  ListFotosLiquidaParalizaciones(
      {this.id, this.fotoParalizacion, this.urlFoto, this.estado});

  int? id;
  File? fotoParalizacion;
  String? urlFoto;
  String? estado;
}

class _LiquidaParalizacionesState extends State<LiquidaParalizaciones> {
  ParalizacionesLiquidaService paralizacionesLiquidaService =
      ParalizacionesLiquidaService();

  FileUploadService fileUploadService = FileUploadService();

  DateTime dateInicio = DateTime.now();
  DateTime dateTermino = DateTime.now();

  final TextEditingController responsableController = TextEditingController();
  final TextEditingController detalleController = TextEditingController();

  List<VwLiquidaGetParalizaciones> vwLiquidaGetParalizaciones =
      <VwLiquidaGetParalizaciones>[];

  List<ListFotosLiquidaParalizaciones> listFotosLiquidaParalizaciones = [];

  final TextEditingController detalleConsultaController =
      TextEditingController();
  final TextEditingController responsableConsultaController =
      TextEditingController();
  final TextEditingController tanqueConsultaController =
      TextEditingController();

  String _valueDetalleDropdown = 'Seleccione el Detalle';
  String _valueResponsableDropdown = 'Seleccione el Responsable';

  late int idParalizacion;

  String _valueInicioParalizacionDropdown = 'Seleccione Inicio de Paralizacion';

  String _valueTanqueDropdown = 'Seleccione el Tanque';

  File? imageInicioParalizacion;
  File? imageTerminoParalizacion;

  Future<List<SpCreateLiquidaFotosParalizacione>>
      getInicioFotosParalizaciones() async {
    List<SpCreateLiquidaFotosParalizacione> spFotosParalizaciones = [];
    FileUploadResult fileUploadResult = FileUploadResult();
    for (int count = 0;
        count < listFotosLiquidaParalizaciones.length;
        count++) {
      SpCreateLiquidaFotosParalizacione aux =
          SpCreateLiquidaFotosParalizacione();
      aux.estado = "inicio";
      aux.urlFoto = listFotosLiquidaParalizaciones[count].urlFoto;
      spFotosParalizaciones.add(aux);
      File file = File(aux.urlFoto!);
      fileUploadResult = await fileUploadService.uploadFile(file);
      spFotosParalizaciones[count].urlFoto = fileUploadResult.urlPhoto;
      spFotosParalizaciones[count].nombreFoto = fileUploadResult.fileName;
    }
    return spFotosParalizaciones;
  }

  Future<List<SpCreateLiquidaFotosParalizacione>>
      getTerminoFotosParalizaciones() async {
    List<SpCreateLiquidaFotosParalizacione> spFotosParalizaciones = [];
    FileUploadResult fileUploadResult = FileUploadResult();
    for (int count = 0;
        count < listFotosLiquidaParalizaciones.length;
        count++) {
      SpCreateLiquidaFotosParalizacione aux =
          SpCreateLiquidaFotosParalizacione();
      aux.estado = "termino";
      aux.urlFoto = listFotosLiquidaParalizaciones[count].urlFoto;
      aux.idParalizacion = idParalizacion;
      spFotosParalizaciones.add(aux);
      File file = File(aux.urlFoto!);
      fileUploadResult = await fileUploadService.uploadFile(file);
      spFotosParalizaciones[count].urlFoto = fileUploadResult.urlPhoto;
      spFotosParalizaciones[count].nombreFoto = fileUploadResult.fileName;
    }
    return spFotosParalizaciones;
  }

  SpCreateLiquidaParalizaciones parseParalizacion() {
    SpCreateLiquidaParalizaciones spCreateLiquidaFotosParalizacione =
        SpCreateLiquidaParalizaciones();
    spCreateLiquidaFotosParalizacione.jornada = widget.jornada;
    spCreateLiquidaFotosParalizacione.fecha = DateTime.now();
    if (_valueDetalleDropdown != 'Seleccione el Detalle') {
      spCreateLiquidaFotosParalizacione.detalle = _valueDetalleDropdown;
    } else {
      spCreateLiquidaFotosParalizacione.detalle = detalleController.text;
    }
    if (_valueResponsableDropdown != 'Seleccione el Responsable') {
      spCreateLiquidaFotosParalizacione.responsable = _valueResponsableDropdown;
    } else {
      spCreateLiquidaFotosParalizacione.responsable =
          responsableController.text;
    }
    spCreateLiquidaFotosParalizacione.tanque = _valueTanqueDropdown;
    spCreateLiquidaFotosParalizacione.inicioParalizacion = dateInicio;
    spCreateLiquidaFotosParalizacione.idServiceOrder = widget.idServiceOrder;
    spCreateLiquidaFotosParalizacione.idUsuario = widget.idUsuario;

    return spCreateLiquidaFotosParalizacione;
  }

  createParalizacion() async {
    CreateLiquidaParalizaciones createLiquidaParalizaciones =
        CreateLiquidaParalizaciones();

    SpCreateLiquidaParalizaciones spFotosParalizacione =
        SpCreateLiquidaParalizaciones();

    List<SpCreateLiquidaFotosParalizacione> spFotosParalizacionesList = [];

    spFotosParalizacione = parseParalizacion();

    spFotosParalizacionesList = await getInicioFotosParalizaciones();

    createLiquidaParalizaciones.spCreateLiquidaParalizaciones =
        spFotosParalizacione;

    createLiquidaParalizaciones.spCreateLiquidaFotosParalizaciones =
        spFotosParalizacionesList;

    await paralizacionesLiquidaService
        .createLiquidaParalizaciones(createLiquidaParalizaciones);

    setState(() {
      getParalizaciones();
    });
  }

  createFotoParalizaciones() async {
    List<SpCreateLiquidaFotosParalizacione> spFotosParalizacionesList = [];

    spFotosParalizacionesList = await getTerminoFotosParalizaciones();

    paralizacionesLiquidaService
        .createLiquidaFotoParalizaciones(spFotosParalizacionesList);
  }

  updateTerminoParalizaciones() {
    paralizacionesLiquidaService.updateParalizacionesById(
        SpLiquidaUpdateParalizacionesById(
            idParalizacion: idParalizacion, terminoParalizacion: dateTermino));
  }

  Future pickInicioFoto(ImageSource source) async {
    try {
      final imageInicioParalizacion =
          await ImagePicker().pickImage(source: source);

      if (imageInicioParalizacion == null) return;

      final imageTemporary = File(imageInicioParalizacion.path);

      setState(() => this.imageInicioParalizacion = imageTemporary);
    } on PlatformException catch (e) {
      e.message;
    }
  }

  Future pickTerminoFoto(ImageSource source) async {
    try {
      final imageTerminoParalizacion =
          await ImagePicker().pickImage(source: source);

      if (imageTerminoParalizacion == null) return;

      final imageTemporary = File(imageTerminoParalizacion.path);

      setState(() => this.imageTerminoParalizacion = imageTemporary);
    } on PlatformException catch (e) {
      e.message;
    }
  }

  List<DropdownMenuItem<String>> getDropdownParalizaciones(
      List<VwLiquidaGetParalizaciones> tanques) {
    List<DropdownMenuItem<String>> dropDownItems = [];

    for (var element in tanques) {
      var newDropDown = DropdownMenuItem(
        value: element.idParalizaciones.toString(),
        child: Text(
          element.inicioParalizaciones.toString(),
        ),
      );
      dropDownItems.add(newDropDown);
    }
    return dropDownItems;
  }

  getParalizaciones() async {
    List<VwLiquidaGetParalizaciones> value = await paralizacionesLiquidaService
        .getLiquidaParalizaciones(widget.idServiceOrder);

    setState(() {
      vwLiquidaGetParalizaciones = value;
    });
  }

  getParalizacionById(int id) async {
    VwLiquidaGetParalizacionesById vwLiquidaGetParalizacionesById =
        VwLiquidaGetParalizacionesById();

    vwLiquidaGetParalizacionesById =
        await paralizacionesLiquidaService.getParalizacionesById(id);

    idParalizacion = vwLiquidaGetParalizacionesById.idParalizaciones!;
    tanqueConsultaController.text = vwLiquidaGetParalizacionesById.tanque!;
    detalleConsultaController.text = vwLiquidaGetParalizacionesById.detalle!;
    responsableConsultaController.text =
        vwLiquidaGetParalizacionesById.responsable!;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getParalizaciones();
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
          title: const Text("Paralizaciones"),
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
                    'Inicio Paralización',
                  ),
                ),
                Tab(
                  icon: Icon(
                    Icons.checklist,
                  ),
                  child: Text('Termino Paralización'),
                ),
              ]),
        ),
        body: TabBarView(
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
                        labelText: 'Detalle',
                        labelStyle: TextStyle(
                          color: kColorAzul,
                          fontSize: 20.0,
                        ),
                      ),
                      icon: const Icon(
                        Icons.arrow_drop_down_circle_outlined,
                      ),
                      items: listaDetalle.map((String a) {
                        return DropdownMenuItem<String>(
                          value: a,
                          child:
                              Center(child: Text(a, textAlign: TextAlign.left)),
                        );
                      }).toList(),
                      onChanged: (value) => {
                        setState(() {
                          _valueDetalleDropdown = value as String;
                        })
                      },
                      validator: (value) {
                        if (value != _valueDetalleDropdown) {
                          return 'Por favor, elige el Detalle';
                        }
                        return null;
                      },
                      hint: Text(_valueDetalleDropdown),
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
                        labelText: 'Otro Detalle',
                        labelStyle: TextStyle(
                          color: kColorAzul,
                          fontSize: 20.0,
                        ),
                        hintText: 'ingrese detalle',
                      ),
                      controller: detalleController,
                    ),
                    const SizedBox(height: 20),
                    DropdownButtonFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        labelText: 'Responsable',
                        labelStyle: TextStyle(
                          color: kColorAzul,
                          fontSize: 20.0,
                        ),
                      ),
                      icon: const Icon(
                        Icons.arrow_drop_down_circle_outlined,
                      ),
                      items: listaResponsable.map((String a) {
                        return DropdownMenuItem<String>(
                          value: a,
                          child:
                              Center(child: Text(a, textAlign: TextAlign.left)),
                        );
                      }).toList(),
                      onChanged: (value) => {
                        setState(() {
                          _valueResponsableDropdown = value as String;
                        })
                      },
                      validator: (value) {
                        if (value != _valueResponsableDropdown) {
                          return 'Por favor, elige el Detalle';
                        }
                        return null;
                      },
                      hint: Text(_valueResponsableDropdown),
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
                        labelText: 'Otro Responsable',
                        labelStyle: TextStyle(
                          color: kColorAzul,
                          fontSize: 20.0,
                        ),
                        hintText: 'ingrese responsable',
                      ),
                      controller: responsableController,
                    ),
                    const SizedBox(height: 20.0),
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
                          return 'Por favor, elige el Tanque';
                        }
                        return null;
                      },
                      hint: Text(_valueTanqueDropdown),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      height: 40,
                      color: kColorAzul,
                      child: const Center(
                        child: Text("INICIO DE PARALIZACION",
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
                            labelText: 'Inicio de Carguio',
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
                            labelText: '$hours1:$minutes1',
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
                        onPressed: pickDateTimeInicio,
                        child: Text(
                          "Hora - Inicio Carguio",
                          style: TextStyle(
                            fontSize: 20,
                            color: kColorAzul,
                            fontWeight:
                                FontWeight.bold, /* letterSpacing: 1.5 */
                          ),
                        )),
                    const SizedBox(height: 20.0),
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
                            "Ingrese Fotos del Inicio de Paralizacion",
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
                                child: imageInicioParalizacion != null
                                    ? Image.file(imageInicioParalizacion!,
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
                                            "Inserte Foto Inicio Paralizacion",
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
                                        onPressed: (() => pickInicioFoto(
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
                                        onPressed: (() =>
                                            pickInicioFoto(ImageSource.camera)),
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
                          listFotosLiquidaParalizaciones.add(
                              ListFotosLiquidaParalizaciones(
                                  fotoParalizacion: imageInicioParalizacion!,
                                  urlFoto: imageInicioParalizacion!.path));
                        });
                      },
                      child: Text(
                        "AGREGAR FOTO PARALIZACION",
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
                            itemCount: listFotosLiquidaParalizaciones.length,
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
                                  child: listFotosLiquidaParalizaciones[i]
                                              .fotoParalizacion !=
                                          null
                                      ? Image.file(
                                          listFotosLiquidaParalizaciones[i]
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
                    MaterialButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      minWidth: double.infinity,
                      height: 50.0,
                      color: kColorNaranja,
                      onPressed: () async {
                        await createParalizacion();
                        setState(() {
                          imageInicioParalizacion = null;
                          listFotosLiquidaParalizaciones.clear();
                          responsableController.clear();
                          detalleController.clear();
                        });
                      },
                      child: const Text(
                        "REGISTRAR INICIO",
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
                child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  DropdownButtonFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      labelText: 'Inicio de Paralizacion',
                      labelStyle: TextStyle(
                        color: kColorAzul,
                        fontSize: 20.0,
                      ),
                    ),
                    icon: const Icon(
                      Icons.arrow_drop_down_circle_outlined,
                    ),
                    items:
                        getDropdownParalizaciones(vwLiquidaGetParalizaciones),
                    onChanged: (value) => {
                      setState(() {
                        _valueInicioParalizacionDropdown = value as String;
                      }),
                      getParalizacionById(int.parse(value.toString()))
                    },
                    /* validator: (value) {
                        if (value != _valueDetalleDropdown) {
                          return 'Por favor, elija Inicio de Paralizacion';
                        }
                        return null;
                      }, */
                    hint: Text(_valueInicioParalizacionDropdown),
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
                                    Icons.numbers,
                                    color: kColorAzul,
                                  ),
                                  labelText: 'Detalle',
                                  labelStyle: TextStyle(
                                    color: kColorAzul,
                                    fontSize: 20.0,
                                  ),
                                  hintText: ''),
                              controller: detalleConsultaController,
                              enabled: false,
                            ),

                            //Caja de texto Responsable
                            TextFormField(
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  prefixIcon: Icon(
                                    Icons.branding_watermark,
                                    color: kColorAzul,
                                  ),
                                  labelText: 'Responsable',
                                  labelStyle: TextStyle(
                                    color: kColorAzul,
                                    fontSize: 20.0,
                                  ),
                                  hintText: ''),
                              controller: responsableConsultaController,
                              enabled: false,
                            ),

                            //Caja de texto Tipo de importación
                            TextFormField(
                              decoration: InputDecoration(
                                  /*border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),*/
                                  border: InputBorder.none,
                                  prefixIcon: Icon(
                                    Icons.type_specimen,
                                    color: kColorAzul,
                                  ),
                                  labelText: 'Tanque',
                                  labelStyle: TextStyle(
                                    color: kColorAzul,
                                    fontSize: 20.0,
                                  ),
                                  hintText: 'Ingrese tipo de importación'),
                              controller: tanqueConsultaController,
                              enabled: false,
                            ),
                          ],
                        ),
                      )),
                  const SizedBox(height: 20),
                  Container(
                    height: 40,
                    color: kColorAzul,
                    child: const Center(
                      child: Text("TERMINO DE PARALIZACION",
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
                      onPressed: pickDateTimeTermino,
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
                          "Ingrese Fotos del Termino de Paralizacion",
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
                              child: imageTerminoParalizacion != null
                                  ? Image.file(imageTerminoParalizacion!,
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
                                          "Inserte Foto Termino Paralizacion",
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
                                          pickTerminoFoto(ImageSource.gallery)),
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
                                          pickTerminoFoto(ImageSource.camera)),
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
                        listFotosLiquidaParalizaciones.add(
                            ListFotosLiquidaParalizaciones(
                                fotoParalizacion: imageTerminoParalizacion!,
                                urlFoto: imageTerminoParalizacion!.path));
                      });
                    },
                    child: Text(
                      "AGREGAR FOTO PARALIZACION",
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
                          itemCount: listFotosLiquidaParalizaciones.length,
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
                                child: listFotosLiquidaParalizaciones[i]
                                            .fotoParalizacion !=
                                        null
                                    ? Image.file(
                                        listFotosLiquidaParalizaciones[i]
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
                  MaterialButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    minWidth: double.infinity,
                    height: 50.0,
                    color: kColorNaranja,
                    onPressed: () async {
                      updateTerminoParalizaciones();
                      await createFotoParalizaciones();
                      setState(() {
                        imageTerminoParalizacion = null;
                        listFotosLiquidaParalizaciones.clear();
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
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }

  Future pickDateTimeInicio() async {
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
  Future pickDateTimeTermino() async {
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
