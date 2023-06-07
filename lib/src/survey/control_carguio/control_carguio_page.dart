import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import '../../../models/file_upload_result.dart';
import '../../../models/survey/ControlCarguio/create_control_carguio.dart';
import '../../../models/survey/ControlCarguio/vw_granel_consulta_transporte_by_cod.dart';
import '../../../models/survey/ControlCarguio/vw_granel_lista_bodegas.dart';
import '../../../models/vw_get_user_data_by_cod_user.dart';
import '../../../services/file_upload_result.dart';
import '../../../services/survey/control_carguio_service.dart';
import '../../../services/usuario_service.dart';
import '../../../utils/constants.dart';
import '../../scanner_screen.dart';

class ControlCarguio extends StatefulWidget {
  const ControlCarguio(
      {Key? key,
      required this.jornada,
      required this.idUsuario,
      required this.idServiceOrder})
      : super(key: key);
  final int jornada;
  final int idUsuario;
  final int idServiceOrder;

  @override
  State<ControlCarguio> createState() => _ControlCarguioState();
}

class ListFotoCarguio {
  ListFotoCarguio({this.id, this.fotoCarguio, this.urlFoto});

  int? id;
  File? fotoCarguio;
  String? urlFoto;
}

class _ControlCarguioState extends State<ControlCarguio> {
  bool enableBodegaDropdown = true;
  String _valueBodegaDropdown = 'Seleccione la Bodega';
  List<VwGranelListaBodegas> vwGranelListaBodegas = <VwGranelListaBodegas>[];
  TextEditingController transporteController = TextEditingController();
  bool valueBarredura = false;

  final _viajesRealizadosController = TextEditingController();
  final _viajesTotalesController = TextEditingController();
  final _saldoController = TextEditingController();

  final placaController = TextEditingController();
  final deliveryOrderController = TextEditingController();
  final tovaController = TextEditingController();

  final damController = TextEditingController();

  final nTicketController = TextEditingController();

  final codigoTransporteController = TextEditingController();

  final nombreTransporteController = TextEditingController();

  final codigoConductorController = TextEditingController();

  final nombreConductorController = TextEditingController();

  ControlCarguioService controlCarguioService = ControlCarguioService();

  late int idConductor;
  late int idTransporte;

  bool enableQrUsuario = true;

  DateTime dateInicio = DateTime.now();
  DateTime dateTermino = DateTime.now();

  VwgetUserDataByCodUser vwgetUserDataByCodUser = VwgetUserDataByCodUser();

  VwGranelConsultaTransporteByCod vwGranelConsultaTransporteByCod =
      VwGranelConsultaTransporteByCod();

  getUserConductorDataByCodUser() async {
    UsuarioService usuarioService = UsuarioService();

    vwgetUserDataByCodUser = await usuarioService
        .getUserDataByCodUser(codigoConductorController.text);

    nombreConductorController.text =
        "${vwgetUserDataByCodUser.nombres!} ${vwgetUserDataByCodUser.apellidos!}";
    idConductor = vwgetUserDataByCodUser.idUsuario!;
    // print(idConductor);
  }

  List<ListFotoCarguio> listFotoCarguio = [];

  File? imageCarguio;

  Future pickCarguioFoto(ImageSource source) async {
    try {
      final imageCarguio = await ImagePicker().pickImage(source: source);

      if (imageCarguio == null) return;

      final imageTemporary = File(imageCarguio.path);

      setState(() => this.imageCarguio = imageTemporary);
    } on PlatformException catch (e) {
      // print('Failed to pick image: $e');
      e.message;
    }
  }

  getTransporteByCod() async {
    vwGranelConsultaTransporteByCod = await controlCarguioService
        .getGranelConsultaTransporteByCod(codigoTransporteController.text);

    nombreTransporteController.text =
        vwGranelConsultaTransporteByCod.empresaTransporte!;
    idTransporte = vwGranelConsultaTransporteByCod.idTransporte!;
  }

  Future<List<SpCreateGranelFotosCarguio>> parseFotosCarguio() async {
    FileUploadService fileUploadService = FileUploadService();

    List<SpCreateGranelFotosCarguio> spCreateGranelFotosCarguio = [];
    FileUploadResult fileUploadResult = FileUploadResult();
    for (int count = 0; count < listFotoCarguio.length; count++) {
      SpCreateGranelFotosCarguio aux = SpCreateGranelFotosCarguio();
      aux.urlFoto = listFotoCarguio[count].urlFoto;
      spCreateGranelFotosCarguio.add(aux);
      File file = File(aux.urlFoto!);
      fileUploadResult = await fileUploadService.uploadFile(file);
      spCreateGranelFotosCarguio[count].urlFoto = fileUploadResult.urlPhoto;
      spCreateGranelFotosCarguio[count].nombreFoto = fileUploadResult.fileName;
    }
    return spCreateGranelFotosCarguio;
  }

  createControlCarguio() async {
    late bool inspeccion;
    if (valueBarredura == false) {
      inspeccion = false;
    } else if (valueBarredura == true) {
      inspeccion = true;
    }
    List<SpCreateGranelFotosCarguio> spCreateGranelFotosCarguio = [];

    spCreateGranelFotosCarguio = await parseFotosCarguio();

    controlCarguioService.createControlCarguio(CreateControlCarguio(
        spCreateGranelControlCarguio: SpCreateGranelControlCarguio(
            jornada: widget.jornada,
            barredura: inspeccion,
            bodega: _valueBodegaDropdown,
            fecha: DateTime.now(),
            dam: damController.text,
            nTicket: nTicketController.text,
            idConductor: idConductor,
            deliveryOrder: deliveryOrderController.text,
            idTransporte: idTransporte,
            inicioCarguio: dateInicio,
            terminoCarguio: dateTermino,
            placa: placaController.text,
            tolva: tovaController.text,
            idUsuario: widget.idUsuario,
            idServiceOrder: widget.idServiceOrder),
        spCreateGranelFotosCarguio: spCreateGranelFotosCarguio));
  }

  clearFiels() {
    setState(() {
      listFotoCarguio.clear();
      damController.clear();
      valueBarredura = false;
      imageCarguio = null;
      nTicketController.clear();
      codigoTransporteController.clear();
      nombreConductorController.clear();
      nombreTransporteController.clear();
      codigoConductorController.clear();
      deliveryOrderController.clear();
      placaController.clear();
      tovaController.clear();
    });
  }

  List<DropdownMenuItem<String>> getGranelListaBodegas(
      List<VwGranelListaBodegas> bodegas) {
    List<DropdownMenuItem<String>> dropDownItems = [];

    for (var element in bodegas) {
      var newDropDown = DropdownMenuItem(
        value: element.bodega.toString(),
        child: Text(
          element.bodega.toString(),
        ),
      );
      dropDownItems.add(newDropDown);
    }
    return dropDownItems;
  }

  getBodegas() async {
    List<VwGranelListaBodegas> value =
        await controlCarguioService.getGranelListaBodegas();

    setState(() {
      vwGranelListaBodegas = value;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getBodegas();
  }

  @override
  Widget build(BuildContext context) {
    final hours1 = dateInicio.hour.toString().padLeft(2, '0');
    final minutes1 = dateInicio.minute.toString().padLeft(2, '0');
    final hours2 = dateTermino.hour.toString().padLeft(2, '0');
    final minutes2 = dateTermino.minute.toString().padLeft(2, '0');

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Control Carguío"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(children: [
            Row(
              children: [
                Text("Barredura",
                    style: TextStyle(
                        fontSize: 20,
                        color: kColorAzul,
                        fontWeight: FontWeight.w500)),
                const SizedBox(width: 5),
                Switch(
                  value: valueBarredura,
                  onChanged: (value) => setState(() {
                    valueBarredura = value;
                  }),
                  activeTrackColor: Colors.lightGreenAccent,
                  activeColor: Colors.green,
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            DropdownButtonFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                labelText: 'Bodega',
                labelStyle: TextStyle(
                  color: kColorAzul,
                  fontSize: 20.0,
                ),
              ),
              icon: const Icon(
                Icons.arrow_drop_down_circle_outlined,
              ),
              items: getGranelListaBodegas(vwGranelListaBodegas),
              onChanged: (value) => {
                setState(() {
                  _valueBodegaDropdown = value as String;
                })
              },
              validator: (value) {
                if (value != _valueBodegaDropdown) {
                  return 'Por favor, elige la Bodega';
                }
                return null;
              },
              hint: Text(_valueBodegaDropdown),
            ),
            const SizedBox(height: 20),
            TextFormField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  labelText: 'N° Ticket',
                  labelStyle: TextStyle(
                    color: kColorAzul,
                    fontSize: 20.0,
                  ),
                  hintText: 'Ingrese el N° Ticket'),
              onChanged: (value) {},
              controller: nTicketController,
              /* validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingrese la Placa';
                  }
                  idUsuario = BigInt.parse(value);
                    return null;
                }, */
              //enabled: enableQrUsuario
            ),
            const SizedBox(height: 20),
            Container(
              height: 40,
              color: kColorAzul,
              child: const Center(
                child: Text("TRANSPORTE",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white)),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    prefixIcon: IconButton(
                        icon: const Icon(Icons.closed_caption_off_rounded),
                        onPressed: () async {
                          final result = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const ScannerScreen()));
                          placaController.text = result;
                        }),
                    labelText: 'Placa',
                    labelStyle: TextStyle(
                      color: kColorAzul,
                      fontSize: 20.0,
                    ),
                    hintText: 'Ingrese la Placa'),
                onChanged: (value) {},
                controller: placaController,
                /* validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingrese la Placa';
                  }
                  idUsuario = BigInt.parse(value);
                  return null;
                }, */
                enabled: enableQrUsuario),
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
                labelText: 'Tolva',
                labelStyle: TextStyle(
                  color: kColorAzul,
                  fontSize: 20.0,
                ),
                hintText: '',
              ),
              controller: tovaController,
            ),
            const SizedBox(height: 20.0),
            TextFormField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  prefixIcon: IconButton(
                      icon: const Icon(Icons.code),
                      onPressed: () async {
                        final result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ScannerScreen()));
                        codigoTransporteController.text = result;
                      }),
                  suffixIcon: IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: () {
                        getTransporteByCod();
                      }),
                  labelText: 'Codigo Transporte',
                  labelStyle: TextStyle(
                    color: kColorAzul,
                    fontSize: 20.0,
                  ),
                  hintText: 'Ingrese Codigo de Transporte'),
              onChanged: (value) {
                getTransporteByCod();
              },
              controller: codigoTransporteController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, Ingrese codigo de transporte';
                }
                return null;
              },
              //enabled: enableConductorController,
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
                    Icons.badge,
                    color: kColorAzul,
                  ),
                  labelText: 'Nombre Transporte',
                  labelStyle: TextStyle(
                    color: kColorAzul,
                    fontSize: 20.0,
                  ),
                  hintText: ''),
              controller: nombreTransporteController,
              enabled: false,
            ),
            const SizedBox(height: 20.0),
            TextFormField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  prefixIcon: IconButton(
                      icon: const Icon(Icons.code),
                      onPressed: () async {
                        final result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ScannerScreen()));
                        codigoConductorController.text = result;
                      }),
                  suffixIcon: IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: () {
                        getUserConductorDataByCodUser();
                      }),
                  labelText: 'Codigo conductor',
                  labelStyle: TextStyle(
                    color: kColorAzul,
                    fontSize: 20.0,
                  ),
                  hintText: 'Ingrese codigo de conductor'),
              onChanged: (value) {
                getUserConductorDataByCodUser();
              },
              controller: codigoConductorController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, Ingrese codigo de conductor';
                }
                return null;
              },
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
                    Icons.badge,
                    color: kColorAzul,
                  ),
                  labelText: 'Nombre conductor',
                  labelStyle: TextStyle(
                    color: kColorAzul,
                    fontSize: 20.0,
                  ),
                  hintText: ''),
              controller: nombreConductorController,
              /* validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, Ingrese datos de conductor';
                }
                return null;
              }, */
              enabled: false,
            ),
            const SizedBox(height: 20.0),
            TextFormField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    prefixIcon: IconButton(
                        icon: Icon(
                          Icons.delivery_dining,
                          color: kColorAzul,
                        ),
                        onPressed: () async {}),
                    /*   suffixIcon: IconButton(
                        icon: const Icon(Icons.search), onPressed: () {}), */
                    labelText: 'Delivery Order',
                    labelStyle: TextStyle(
                      color: kColorAzul,
                      fontSize: 20.0,
                    ),
                    hintText: 'Ingrese el Delivery Order'),
                onChanged: (value) {},
                controller: deliveryOrderController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingrese el Delivery Order';
                  }
                  return null;
                },
                enabled: enableQrUsuario),
            const SizedBox(height: 20.0),
            TextFormField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    prefixIcon: IconButton(
                        icon: Icon(
                          Icons.delivery_dining,
                          color: kColorAzul,
                        ),
                        onPressed: () async {}),
                    /* suffixIcon: IconButton(
                        icon: const Icon(Icons.search), onPressed: () {}), */
                    labelText: 'DAM',
                    labelStyle: TextStyle(
                      color: kColorAzul,
                      fontSize: 20.0,
                    ),
                    hintText: 'Ingrese el DAM'),
                onChanged: (value) {},
                controller: damController,
                /* validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingrese el DAM';
                  }
                  idUsuario = BigInt.parse(value);
                  return null;
                }, */
                enabled: enableQrUsuario),
            const SizedBox(height: 20.0),
            Container(
              height: 40,
              color: kColorAzul,
              child: const Center(
                child: Text("VIAJES",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white)),
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
                        Icons.mode_of_travel,
                        color: kColorAzul,
                      ),
                      labelText: 'Viajes Totales',
                      labelStyle: TextStyle(
                        color: kColorAzul,
                        fontSize: 20.0,
                      ),
                      hintText: '',
                    ),
                    controller: _viajesTotalesController,
                    enabled: false,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      prefixIcon: Icon(
                        Icons.balance,
                        color: kColorAzul,
                      ),
                      labelText: 'Saldo',
                      labelStyle: TextStyle(
                        color: kColorAzul,
                        fontSize: 20.0,
                      ),
                      hintText: '',
                    ),
                    controller: _saldoController,
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
                  Icons.mode_of_travel,
                  color: kColorAzul,
                ),
                labelText: 'Viajes Realizados',
                labelStyle: TextStyle(
                  color: kColorAzul,
                  fontSize: 20.0,
                ),
                hintText: '',
              ),
              controller: _viajesRealizadosController,
              enabled: false,
            ),
            const SizedBox(height: 20),
            Container(
              height: 40,
              color: kColorAzul,
              child: const Center(
                child: Text("HORA DE CARGUIO",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white)),
              ),
            ),
            const SizedBox(height: 20),
            Row(children: [
              Expanded(
                  flex: 3,
                  child: Text(
                    "INICIO CARGUIO:",
                    style: TextStyle(
                        fontSize: 20,
                        color: kColorAzul,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5),
                  )),
              Expanded(
                flex: 2,
                child: TextFormField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      prefixIcon: Icon(
                        Icons.calendar_month,
                        color: kColorAzul,
                      ),
                      labelText: /* ${dateTime.day}/${dateTime.month}/${dateTime.year} */
                          '$hours1:$minutes1',
                      labelStyle: TextStyle(
                        color: kColorAzul,
                        fontSize: 20.0,
                      ),
                      enabled: false),
                ),
              ),
            ]),
            const SizedBox(height: 20.0),
            MaterialButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                minWidth: double.infinity,
                height: 50.0,
                color: kColorCeleste,
                onPressed: pickDateTime1,
                child: Text(
                  "Hora - Inicio Carguio",
                  style: TextStyle(
                    fontSize: 20,
                    color: kColorAzul,
                    fontWeight: FontWeight.bold, /* letterSpacing: 1.5 */
                  ),
                )),
            const SizedBox(height: 20.0),
            Row(children: [
              Expanded(
                  flex: 3,
                  child: Text(
                    "TERMINO CARGUIO:",
                    style: TextStyle(
                        fontSize: 20,
                        color: kColorAzul,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5),
                  )),
              Expanded(
                flex: 2,
                child: TextFormField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      prefixIcon: Icon(
                        Icons.calendar_month,
                        color: kColorAzul,
                      ),
                      labelText: /* '${dateTime2.day}/${dateTime2.month}/${dateTime2.year}' */
                          '$hours2:$minutes2',
                      labelStyle: TextStyle(
                        color: kColorAzul,
                        fontSize: 20.0,
                      ),
                      enabled: false),
                ),
              ),
            ]),
            const SizedBox(height: 20.0),
            MaterialButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                minWidth: double.infinity,
                height: 50.0,
                color: kColorCeleste,
                onPressed: pickDateTime2,
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
                    "Ingrese Fotos del Carguio",
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
                        child: imageCarguio != null
                            ? Image.file(imageCarguio!,
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
                                    pickCarguioFoto(ImageSource.gallery)),
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
                                    pickCarguioFoto(ImageSource.camera)),
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
                  listFotoCarguio.add(ListFotoCarguio(
                      fotoCarguio: imageCarguio!, urlFoto: imageCarguio!.path));
                });
              },
              child: Text(
                "AGREGAR FOTO CARGUIO",
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
                    itemCount: listFotoCarguio.length,
                    itemBuilder: (_, int i) {
                      return Column(children: [
                        const SizedBox(height: 10),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(width: 1, color: Colors.grey),
                          ),
                          width: 200,
                          height: 200,
                          child: listFotoCarguio[i].fotoCarguio != null
                              ? Image.file(listFotoCarguio[i].fotoCarguio!,
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
            const SizedBox(height: 20.0),
            MaterialButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              minWidth: double.infinity,
              height: 50.0,
              color: kColorNaranja,
              onPressed: () async {
                await createControlCarguio();
                clearFiels();
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
          ]),
        ),
      ),
    );
  }

  Future pickDateTime1() async {
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
  Future pickDateTime2() async {
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
