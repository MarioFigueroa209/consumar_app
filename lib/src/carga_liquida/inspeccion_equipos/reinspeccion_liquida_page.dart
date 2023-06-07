import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:image_picker/image_picker.dart';

import '../../../models/carga_liquida/inspeccionEquipos/create_liquida_inspeccion_equipos.dart';
import '../../../models/carga_liquida/inspeccionEquipos/sp_update_liquida_segunda_inspeccion_equipo.dart';
import '../../../models/carga_liquida/inspeccionEquipos/sp_update_liquida_tercera_inspeccion_equipo.dart';
import '../../../models/carga_liquida/inspeccionEquipos/vw_liquida_inspeccion_equipos_by_id.dart';
import '../../../models/file_upload_result.dart';
import '../../../services/carga_liquida/inspeccion_equipo_liquida_service.dart';
import '../../../services/file_upload_result.dart';
import '../../../utils/constants.dart';
import '../../../utils/lists.dart';

class ReinspeccionEquipoLiquida extends StatefulWidget {
  const ReinspeccionEquipoLiquida(
      {super.key, required this.idInspeccionEquipo});
  final int idInspeccionEquipo;

  @override
  State<ReinspeccionEquipoLiquida> createState() =>
      _ReinspeccionEquipoLiquidaState();
}

class ListFotoEquiposLiquida {
  ListFotoEquiposLiquida({this.id, this.fotoEquipos, this.urlFoto});

  int? id;
  File? fotoEquipos;
  String? urlFoto;
}

class _ReinspeccionEquipoLiquidaState extends State<ReinspeccionEquipoLiquida> {
  FileUploadService fileUploadService = FileUploadService();

  final TextEditingController tanqueController = TextEditingController();
  final TextEditingController codEquipoController = TextEditingController();
  final TextEditingController equipoController = TextEditingController();

  InspeccionEquipoLiquidaService inspeccionEquipoLiquidaService =
      InspeccionEquipoLiquidaService();

  VwLiquidaInspeccionEquiposById vwLiquidaInspeccionEquiposById =
      VwLiquidaInspeccionEquiposById();

  String _valueEstadoDropdown = 'Seleccione el Estado';

  String? segInspec;
  String? terInspec;

  final TextEditingController controllerComentarios = TextEditingController();

  List<ListFotoEquiposLiquida> listFotoEquipos = [];

  File? imageEquipos;

  Future pickBodegaFoto(ImageSource source) async {
    try {
      final imageEquipos = await ImagePicker().pickImage(source: source);

      if (imageEquipos == null) return;

      final imageTemporary = File(imageEquipos.path);

      setState(() => this.imageEquipos = imageTemporary);
    } on PlatformException catch (e) {
      //print('Failed to pick image: $e');
      e.message;
    }
  }

  getInspeccionEquipoById() async {
    vwLiquidaInspeccionEquiposById = await inspeccionEquipoLiquidaService
        .getInspeccionEquiposById(widget.idInspeccionEquipo);

    tanqueController.text = vwLiquidaInspeccionEquiposById.tanque!;
    codEquipoController.text = vwLiquidaInspeccionEquiposById.codEquipo!;
    equipoController.text = vwLiquidaInspeccionEquiposById.nombreEquipo!;
  }

  updateInspeccion() {
    if (vwLiquidaInspeccionEquiposById.primeraInspeccion == 'RECHAZADO') {
      if (vwLiquidaInspeccionEquiposById.segundoInspeccion == 'pendiente' &&
          vwLiquidaInspeccionEquiposById.terceraInspeccion == 'pendiente') {
        inspeccionEquipoLiquidaService.updateSegundaInspeccionEquipo(
            SpUpdateLiquidaSegundaInspeccionEquipo(
                segInsp: _valueEstadoDropdown,
                idInspeccionEquipos:
                    vwLiquidaInspeccionEquiposById.idInspeccionEquipo));
        insertImgReinspeccion("2da Inspec.");
        setState(() {
          listFotoEquipos.clear();
          _valueEstadoDropdown = 'Seleccione el Estado';
          imageEquipos = null;
        });
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Registrado con exito"),
          backgroundColor: Colors.greenAccent,
        ));
      } else if (vwLiquidaInspeccionEquiposById.terceraInspeccion ==
              'pendiente' &&
          vwLiquidaInspeccionEquiposById.segundoInspeccion == 'RECHAZADO') {
        inspeccionEquipoLiquidaService.updateTerceraInspeccionEquipo(
            SpUpdateLiquidaTerceraInspeccionEquipo(
                terInsp: _valueEstadoDropdown,
                idInspeccionEquipos: widget.idInspeccionEquipo));
        insertImgReinspeccion("3da Inspec.");
        setState(() {
          listFotoEquipos.clear();
          _valueEstadoDropdown = 'Seleccione el Estado';
          imageEquipos = null;
        });
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Registrado con exito"),
          backgroundColor: Colors.greenAccent,
        ));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("No se puede rechazar una 2da inspeccion aprobada"),
          backgroundColor: Colors.redAccent,
        ));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("No rechazar aprobado"),
        backgroundColor: Colors.redAccent,
      ));
    }
  }

  Future<List<SpCreateLiquidaInspeccionFoto>> parseInspeccionFoto(
      String inspeccion) async {
    List<SpCreateLiquidaInspeccionFoto> spCreateLiquidaInspeccionFoto = [];
    FileUploadResult fileUploadResult = FileUploadResult();
    for (int count = 0; count < listFotoEquipos.length; count++) {
      SpCreateLiquidaInspeccionFoto aux = SpCreateLiquidaInspeccionFoto();
      aux.numInsp = inspeccion;
      aux.estado = _valueEstadoDropdown;
      aux.urlFoto = listFotoEquipos[count].urlFoto;
      aux.idInspeccionEquipos = widget.idInspeccionEquipo;
      spCreateLiquidaInspeccionFoto.add(aux);
      if (aux.urlFoto != null) {
        File file = File(aux.urlFoto!);
        fileUploadResult = await fileUploadService.uploadFile(file);
        spCreateLiquidaInspeccionFoto[count].urlFoto =
            fileUploadResult.urlPhoto;
        spCreateLiquidaInspeccionFoto[count].nombreFoto =
            fileUploadResult.fileName;
      }
    }
    return spCreateLiquidaInspeccionFoto;
  }

  insertImgReinspeccion(String inspeccion) async {
    List<SpCreateLiquidaInspeccionFoto> spCreateLiquidaInspeccionFoto = [];

    spCreateLiquidaInspeccionFoto = await parseInspeccionFoto(inspeccion);

    inspeccionEquipoLiquidaService
        .createLiquidaInspeccionFotoList(spCreateLiquidaInspeccionFoto);
    //print("salio");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getInspeccionEquipoById();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("REINSPECCION EQUIPOS"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(children: [
            TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                prefixIcon: Icon(
                  Icons.calendar_month,
                  color: kColorAzul,
                ),
                labelText: 'BODEGA',
                labelStyle: TextStyle(
                  color: kColorAzul,
                  //fontSize: 20.0,
                ),
              ),
              controller: tanqueController,
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
                prefixIcon: Icon(
                  Icons.calendar_month,
                  color: kColorAzul,
                ),
                labelText: 'COD. EQUIPO',
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
              enabled: false,
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
              enabled: false,
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                labelText: 'Estado',
                labelStyle: TextStyle(
                  color: kColorAzul,
                  fontSize: 20.0,
                ),
              ),
              icon: const Icon(
                Icons.arrow_drop_down_circle_outlined,
              ),
              items: estadoEquipo.map((String a) {
                return DropdownMenuItem<String>(
                  value: a,
                  child: Center(child: Text(a, textAlign: TextAlign.left)),
                );
              }).toList(),
              onChanged: (value) => {
                setState(() {
                  _valueEstadoDropdown = value as String;
                })
              },
              validator: (value) {
                if (value != _valueEstadoDropdown) {
                  return 'Por favor, elige el Estado';
                }
                return null;
              },
              hint: Text(_valueEstadoDropdown),
            ),
            const SizedBox(height: 20),
            Container(
              height: 40,
              color: kColorAzul,
              child: const Center(
                child: Text("REGISTRO FOTOGRAFICO",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white)),
              ),
            ),
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
                    "Ingrese Fotos de las Bodega",
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
                          border: Border.all(width: 1, color: Colors.grey),
                        ),
                        width: 150,
                        height: 150,
                        child: imageEquipos != null
                            ? Image.file(imageEquipos!,
                                width: 150, height: 150, fit: BoxFit.cover)
                            : Column(
                                mainAxisAlignment: MainAxisAlignment.center,
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
                                    "Inserte Foto de la Bodega",
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
                            width: MediaQuery.of(context).size.width * 0.40,
                            child: ElevatedButton(
                                style: TextButton.styleFrom(
                                  backgroundColor: kColorNaranja,
                                  padding: const EdgeInsets.all(10.0),
                                ),
                                onPressed: (() =>
                                    pickBodegaFoto(ImageSource.gallery)),
                                child: const Text(
                                  "Abrir Galería",
                                  style: TextStyle(fontSize: 18),
                                )),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.40,
                            child: ElevatedButton(
                                style: TextButton.styleFrom(
                                  backgroundColor: kColorNaranja,
                                  padding: const EdgeInsets.all(10.0),
                                ),
                                onPressed: (() =>
                                    pickBodegaFoto(ImageSource.camera)),
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
                  listFotoEquipos.add(
                    ListFotoEquiposLiquida(
                        fotoEquipos: imageEquipos!,
                        urlFoto: imageEquipos!.path),
                  );
                  //print(imageEquipos!.path);
                  //print(listFotoEquipos.length);
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
                    itemCount: listFotoEquipos.length,
                    itemBuilder: (_, int i) {
                      return Column(children: [
                        const SizedBox(height: 10),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(width: 1, color: Colors.grey),
                          ),
                          width: 200,
                          height: 200,
                          child: listFotoEquipos[i].fotoEquipos != null
                              ? Image.file(listFotoEquipos[i].fotoEquipos!,
                                  /* width: 150, height: 150, */ fit:
                                      BoxFit.cover)
                              : Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
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
                                      style: TextStyle(color: Colors.grey),
                                      textAlign: TextAlign.center,
                                    )),
                                  ],
                                ),
                        ),
                        const Divider(),
                      ]);
                    })),
            const SizedBox(height: 20),
            /*  Text(
              "Comentarios",
              textAlign: TextAlign.center,
              style: TextStyle(color: kColorAzul),
            ),
            const SizedBox(height: 10),
            TextField(
              //textAlign: TextAlign.justify,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)))),
              controller: controllerComentarios,
              maxLines: 5,
              minLines: 3,
            ), */
            const SizedBox(height: 20),
            MaterialButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              minWidth: double.infinity,
              height: 50.0,
              color: kColorNaranja,
              onPressed: () {
                updateInspeccion();
              },
              child: const Text(
                "Reinspeccionar Equipo",
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
    );
  }
}
