import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../models/file_upload_result.dart';
import '../../../models/survey/MonitoreoProducto/create_monitoreo_producto.dart';
import '../../../models/survey/sqlLiteModels/monitoreo_producto_sql_lite_model.dart';
import '../../../models/survey/sqlLiteModels/mp_bodega_foto.dart';
import '../../../models/survey/sqlLiteModels/mp_observado_foto.dart';
import '../../../services/file_upload_result.dart';
import '../../../services/survey/monitoreo_producto_service.dart';
import '../../../utils/check_internet_connection.dart';
import '../../../utils/connection_status_cubit.dart';
import '../../../utils/constants.dart';
import '../../../utils/lists.dart';
import '../../../utils/survey/sqlLiteDB/db_monitoreo_producto.dart';

class MonitoreoProducto extends StatefulWidget {
  const MonitoreoProducto(
      {Key? key,
      required this.idUsuario,
      required this.idServiceOrder,
      required this.jornada})
      : super(key: key);
  final int jornada;
  final int idUsuario;
  final int idServiceOrder;

  @override
  State<MonitoreoProducto> createState() => _MonitoreoProductoState();
}

class ListFotoBodega {
  ListFotoBodega({
    this.id,
    this.fotoBodega,
  });

  int? id;
  File? fotoBodega;
}

class ListFotoBodegaDano {
  ListFotoBodegaDano({
    this.id,
    this.fotoBodegaDano,
  });

  int? id;
  File? fotoBodegaDano;
}

late TabController _tabController;

class _MonitoreoProductoState extends State<MonitoreoProducto>
    with SingleTickerProviderStateMixin {
  DbLiteMonitoreoProducto dbLiteMonitoreoProducto = DbLiteMonitoreoProducto();

  FileUploadService fileUploadService = FileUploadService();

  TextEditingController humedadController = TextEditingController();

  TextEditingController tEstriborProa = TextEditingController();

  TextEditingController tEstriborPopa = TextEditingController();

  TextEditingController tCentro = TextEditingController();

  TextEditingController tBaborProa = TextEditingController();

  TextEditingController tBaborPopa = TextEditingController();

  TextEditingController cantidadDanosController = TextEditingController();

  TextEditingController descripcionController = TextEditingController();

  Future<List<MonitoreoProductoSqlLiteModel>>?
      futureMonitoreoProductoSqlLiteModel;

  //Lista independiente para mostrar imagenes en el front
  List<ListFotoBodega> listFotoBodega = [];

  List<ListFotoBodegaDano> listFotoBodegaDano = [];

  List<MpBodegaFoto> listMpBodegaFoto = [];

  List<MpObservadoFoto> listMpObservadoFoto = [];

  List<MpBodegaFoto> listToUploadMpBodegaFoto = [];

  List<MpObservadoFoto> listToUploadMpObservadoFoto = [];

  List<MonitoreoProductoSqlLiteModel> monitoreoProductoSqlLiteModel = [];

  bool valueInspeccionFito = false;

  bool value2 = false;
  bool isVisible3 = false;

  String _valueBodegaropdown = 'Seleccione Bodega';

  File? imageBodega;
  File? imageBodegaDano;

  Future pickBodegaFoto(ImageSource source) async {
    try {
      final imageBodega = await ImagePicker().pickImage(source: source);

      if (imageBodega == null) return;

      final imageTemporary3 = File(imageBodega.path);

      setState(() => this.imageBodega = imageTemporary3);
    } on PlatformException catch (e) {
      e.message;
      // //print('Failed to pick image: $e');
    }
  }

  Future pickBodegaDanoFoto(ImageSource source) async {
    try {
      final imageBodegaDano = await ImagePicker().pickImage(source: source);

      if (imageBodegaDano == null) return;

      final imageTemporary3 = File(imageBodegaDano.path);

      setState(() => this.imageBodegaDano = imageTemporary3);
    } on PlatformException catch (e) {
      // //print('Failed to pick image: $e');
      e.message;
    }
  }

  createMonitoreoProductoSqlLite() async {
    late String inspeccion;

    double? cantidadDanos;

    if (valueInspeccionFito == false) {
      inspeccion = 'no';
    } else if (valueInspeccionFito == true) {
      inspeccion = 'si';
    }

    if (cantidadDanosController.text.isEmpty) {
      cantidadDanos = null;
    } else {
      cantidadDanos = double.parse(cantidadDanosController.text);
    }

    await dbLiteMonitoreoProducto.insertMonitoreoProducto(
        MonitoreoProductoSqlLiteModel(
            jornada: widget.jornada,
            fecha: DateTime.now(),
            bodega: _valueBodegaropdown,
            inspeccionFito: inspeccion,
            humedad: double.parse(humedadController.text),
            tempEstProa: double.parse(tEstriborProa.text),
            tempEstPopa: double.parse(tEstriborPopa.text),
            tempCentro: double.parse(tCentro.text),
            tempBaborProa: double.parse(tBaborProa.text),
            tempBaborPopa: double.parse(tBaborPopa.text),
            cantidadDanos: cantidadDanos,
            descripcion: descripcionController.text,
            idServiceOrder: widget.idServiceOrder,
            idUsuarios: widget.idUsuario),
        listMpBodegaFoto,
        listMpObservadoFoto);
    setState(() {
      _valueBodegaropdown = 'Seleccione Bodega';
      valueInspeccionFito = false;
      humedadController.clear();
      tEstriborProa.clear();
      tEstriborPopa.clear();
      tCentro.clear();
      tBaborProa.clear();
      tBaborPopa.clear();
      cantidadDanosController.clear();
      descripcionController.clear();
      imageBodega = null;
      imageBodegaDano = null;
      listMpBodegaFoto.clear();
      listMpObservadoFoto.clear();
      listFotoBodega.clear();
      listFotoBodegaDano.clear();
      listTableMonitoreoProductoSqLite();
    });
    _tabController.animateTo((_tabController.index = 1));
  }

  obtenerMonitoreoProductoList() async {
    monitoreoProductoSqlLiteModel =
        await dbLiteMonitoreoProducto.getMonitoreoProductoListSqlLite();

    // //print(        "lista a enviar de monitoreoProducto ${monitoreoProductoSqlLiteModel.length}");
  }

  obtenerMpBodegaFoto() async {
    listToUploadMpBodegaFoto =
        await dbLiteMonitoreoProducto.getListMpBodegaFotoSqlLite();

    // //print("lista a enviar de BodegaFoto ${listToUploadMpBodegaFoto.length}");
  }

  obtenerMpObservadoFoto() async {
    listToUploadMpObservadoFoto =
        await dbLiteMonitoreoProducto.getListMPObservadoFotoSqlLite();

    // //print("lista a enviar de ObservadoFoto ${listToUploadMpBodegaFoto.length}");
  }

  List<SpGranelCreateMonitoreoProducto> parserMonitoreoProducto() {
    List<SpGranelCreateMonitoreoProducto> spMonitoreoProductoList = [];
    for (int count = 0; count < monitoreoProductoSqlLiteModel.length; count++) {
      SpGranelCreateMonitoreoProducto spGranelCreateMonitoreoProducto =
          SpGranelCreateMonitoreoProducto();
      spGranelCreateMonitoreoProducto.idMonitoreoProducto =
          monitoreoProductoSqlLiteModel[count].idMonitoreoProducto;
      spGranelCreateMonitoreoProducto.jornada =
          monitoreoProductoSqlLiteModel[count].jornada;
      spGranelCreateMonitoreoProducto.fecha =
          monitoreoProductoSqlLiteModel[count].fecha;
      spGranelCreateMonitoreoProducto.inspeccionFito =
          monitoreoProductoSqlLiteModel[count].inspeccionFito;
      spGranelCreateMonitoreoProducto.bodega =
          monitoreoProductoSqlLiteModel[count].bodega;
      spGranelCreateMonitoreoProducto.humedad =
          monitoreoProductoSqlLiteModel[count].humedad;
      spGranelCreateMonitoreoProducto.tempEstProa =
          monitoreoProductoSqlLiteModel[count].tempEstProa;
      spGranelCreateMonitoreoProducto.tempEstPopa =
          monitoreoProductoSqlLiteModel[count].tempEstPopa;
      spGranelCreateMonitoreoProducto.tempCentro =
          monitoreoProductoSqlLiteModel[count].tempCentro;
      spGranelCreateMonitoreoProducto.tempBaborProa =
          monitoreoProductoSqlLiteModel[count].tempBaborProa;
      spGranelCreateMonitoreoProducto.tempBaborPopa =
          monitoreoProductoSqlLiteModel[count].tempBaborPopa;
      spGranelCreateMonitoreoProducto.cantidadDanos =
          monitoreoProductoSqlLiteModel[count].cantidadDanos;
      spGranelCreateMonitoreoProducto.descripcion =
          monitoreoProductoSqlLiteModel[count].descripcion;
      spGranelCreateMonitoreoProducto.idServiceOrder =
          monitoreoProductoSqlLiteModel[count].idServiceOrder;
      spGranelCreateMonitoreoProducto.idUsuarios =
          monitoreoProductoSqlLiteModel[count].idUsuarios;
      spMonitoreoProductoList.add(spGranelCreateMonitoreoProducto);
    }
    return spMonitoreoProductoList;
  }

  Future<List<SpGranelCreateMpBodegaFoto>> parserMpBodegaFoto() async {
    List<SpGranelCreateMpBodegaFoto> spGranelCreateMpBodegaFotoList = [];
    FileUploadResult fileUploadResult = FileUploadResult();
    for (int count = 0; count < listToUploadMpBodegaFoto.length; count++) {
      SpGranelCreateMpBodegaFoto aux = SpGranelCreateMpBodegaFoto();
      aux.idMonitoreoProducto =
          listToUploadMpBodegaFoto[count].idMonitoreoProducto;
      aux.mpUrlFoto = listToUploadMpBodegaFoto[count].mpUrlFoto;
      spGranelCreateMpBodegaFotoList.add(aux);
      File file = File(aux.mpUrlFoto!);
      fileUploadResult = await fileUploadService.uploadFile(file);
      spGranelCreateMpBodegaFotoList[count].mpUrlFoto =
          fileUploadResult.urlPhoto;
      spGranelCreateMpBodegaFotoList[count].mpNombreFoto =
          fileUploadResult.fileName;
    }
    return spGranelCreateMpBodegaFotoList;
  }

  Future<List<SpGranelCreateMpObservadoFoto>> parserMpObservadoFoto() async {
    List<SpGranelCreateMpObservadoFoto> spGranelCreateMpObservadoFotoList = [];
    FileUploadResult fileUploadResult = FileUploadResult();
    for (int count = 0; count < listToUploadMpObservadoFoto.length; count++) {
      SpGranelCreateMpObservadoFoto aux = SpGranelCreateMpObservadoFoto();
      aux.idMonitoreoProducto =
          listToUploadMpObservadoFoto[count].idMonitoreoProducto;
      aux.mpUrlFoto = listToUploadMpObservadoFoto[count].mpUrlFoto;
      spGranelCreateMpObservadoFotoList.add(aux);
      File file = File(aux.mpUrlFoto!);
      fileUploadResult = await fileUploadService.uploadFile(file);
      spGranelCreateMpObservadoFotoList[count].mpUrlFoto =
          fileUploadResult.urlPhoto;
      spGranelCreateMpObservadoFotoList[count].mpNombreFoto =
          fileUploadResult.fileName;
    }
    return spGranelCreateMpObservadoFotoList;
  }

  cargarListaCompletaMonitoreoProducto() async {
    MonitoreoProductoService monitoreoProductoService =
        MonitoreoProductoService();

    List<SpGranelCreateMonitoreoProducto> monitoreoProducto =
        <SpGranelCreateMonitoreoProducto>[];
    monitoreoProducto = parserMonitoreoProducto();

    List<SpGranelCreateMpBodegaFoto> mpBodegaFoto =
        <SpGranelCreateMpBodegaFoto>[];
    mpBodegaFoto = await parserMpBodegaFoto();

    List<SpGranelCreateMpObservadoFoto> mpObservadoFoto =
        <SpGranelCreateMpObservadoFoto>[];
    mpObservadoFoto = await parserMpObservadoFoto();

    CreateMonitoreoProducto createMonitoreoProducto = CreateMonitoreoProducto();

    createMonitoreoProducto.spGranelCreateMonitoreoProducto = monitoreoProducto;
    createMonitoreoProducto.spGranelCreateMpBodegaFotos = mpBodegaFoto;
    createMonitoreoProducto.spGranelCreateMpObservadoFotos = mpObservadoFoto;

    monitoreoProductoService.createMonitoreoProducto(createMonitoreoProducto);
  }

  listTableMonitoreoProductoSqLite() {
    futureMonitoreoProductoSqlLiteModel =
        dbLiteMonitoreoProducto.listMonitoreoProductoTableSqlLite();
  }

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(_handleTabIndex);
    listTableMonitoreoProductoSqLite();
    obtenerMonitoreoProductoList();
    obtenerMpBodegaFoto();
    obtenerMpObservadoFoto();
    // TODO: implement initState
    super.initState();
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
          title: const Text("MONITOREO PRODUCTO"),
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
                    Row(
                      children: [
                        Text("Inspeccion Fitosanitaria",
                            style: TextStyle(
                                fontSize: 20,
                                color: kColorAzul,
                                fontWeight: FontWeight.w500)),
                        const SizedBox(width: 5),
                        Switch(
                          value: valueInspeccionFito,
                          onChanged: (value) => setState(() {
                            valueInspeccionFito = value;
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
                        labelText: 'BODEGA',
                        labelStyle: TextStyle(
                          color: kColorAzul,
                          fontSize: 20.0,
                        ),
                      ),
                      icon: const Icon(
                        Icons.arrow_drop_down_circle_outlined,
                      ),
                      items: registroReestibas.map((String a) {
                        return DropdownMenuItem<String>(
                          value: a,
                          child:
                              Center(child: Text(a, textAlign: TextAlign.left)),
                        );
                      }).toList(),
                      onChanged: (value) => {
                        setState(() {
                          _valueBodegaropdown = value.toString();
                        }),
                        //print("La bodega es: $_valueBodegaropdown")
                      },
                      validator: (value) {
                        if (value != _valueBodegaropdown) {
                          return 'Por favor, elige bodega';
                        }
                        return null;
                      },
                      hint: Text(_valueBodegaropdown),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r"[0-9.]")),
                        TextInputFormatter.withFunction((oldValue, newValue) {
                          try {
                            final text = newValue.text;
                            if (text.isNotEmpty) double.parse(text);
                            return newValue;
                          } catch (e) {
                            e.toString();
                          }
                          return oldValue;
                        }),
                      ],
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        prefixIcon: Icon(
                          Icons.directions_boat,
                          color: kColorAzul,
                        ),
                        labelText: 'HUMEDAD',
                        labelStyle: TextStyle(
                          color: kColorAzul,
                          fontSize: 20.0,
                        ),
                        hintText: '',
                      ),
                      controller: humedadController,
                      //enabled: false,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 40,
                      color: kColorAzul,
                      child: const Center(
                        child: Text("TEMPERATURA",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r"[0-9.]")),
                        TextInputFormatter.withFunction((oldValue, newValue) {
                          try {
                            final text = newValue.text;
                            if (text.isNotEmpty) double.parse(text);
                            return newValue;
                          } catch (e) {
                            e.toString();
                          }
                          return oldValue;
                        }),
                      ],
                      decoration: InputDecoration(
                        suffixText: "ºC",
                        suffixStyle: TextStyle(
                          color: kColorAzul,
                          fontSize: 20.0,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        prefixIcon: Icon(
                          Icons.directions_boat,
                          color: kColorAzul,
                        ),
                        labelText: 'T. ESTRIBOR PROA',
                        labelStyle: TextStyle(
                          color: kColorAzul,
                          fontSize: 20.0,
                        ),
                        hintText: '',
                      ),
                      controller: tEstriborProa,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r"[0-9.]")),
                        TextInputFormatter.withFunction((oldValue, newValue) {
                          try {
                            final text = newValue.text;
                            if (text.isNotEmpty) double.parse(text);
                            return newValue;
                          } catch (e) {
                            e.toString();
                          }
                          return oldValue;
                        }),
                      ],
                      decoration: InputDecoration(
                        suffixText: "ºC",
                        suffixStyle: TextStyle(
                          color: kColorAzul,
                          fontSize: 20.0,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        prefixIcon: Icon(
                          Icons.directions_boat,
                          color: kColorAzul,
                        ),
                        labelText: 'T. ESTRIBOR POPA',
                        labelStyle: TextStyle(
                          color: kColorAzul,
                          fontSize: 20.0,
                        ),
                        hintText: '',
                      ),
                      controller: tEstriborPopa,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r"[0-9.]")),
                        TextInputFormatter.withFunction((oldValue, newValue) {
                          try {
                            final text = newValue.text;
                            if (text.isNotEmpty) double.parse(text);
                            return newValue;
                          } catch (e) {
                            e.toString();
                          }
                          return oldValue;
                        }),
                      ],
                      decoration: InputDecoration(
                        suffixText: "ºC",
                        suffixStyle: TextStyle(
                          color: kColorAzul,
                          fontSize: 20.0,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        prefixIcon: Icon(
                          Icons.directions_boat,
                          color: kColorAzul,
                        ),
                        labelText: 'T. CENTRO',
                        labelStyle: TextStyle(
                          color: kColorAzul,
                          fontSize: 20.0,
                        ),
                        hintText: '',
                      ),
                      controller: tCentro,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r"[0-9.]")),
                        TextInputFormatter.withFunction((oldValue, newValue) {
                          try {
                            final text = newValue.text;
                            if (text.isNotEmpty) double.parse(text);
                            return newValue;
                          } catch (e) {
                            e.toString();
                          }
                          return oldValue;
                        }),
                      ],
                      decoration: InputDecoration(
                        suffixText: "ºC",
                        suffixStyle: TextStyle(
                          color: kColorAzul,
                          fontSize: 20.0,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        prefixIcon: Icon(
                          Icons.directions_boat,
                          color: kColorAzul,
                        ),
                        labelText: 'T. BABOR PROA',
                        labelStyle: TextStyle(
                          color: kColorAzul,
                          fontSize: 20.0,
                        ),
                        hintText: '',
                      ),
                      controller: tBaborProa,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r"[0-9.]")),
                        TextInputFormatter.withFunction((oldValue, newValue) {
                          try {
                            final text = newValue.text;
                            if (text.isNotEmpty) double.parse(text);
                            return newValue;
                          } catch (e) {
                            e.toString();
                          }
                          return oldValue;
                        }),
                      ],
                      decoration: InputDecoration(
                        suffixText: "ºC",
                        suffixStyle: TextStyle(
                          color: kColorAzul,
                          fontSize: 20.0,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        prefixIcon: Icon(
                          Icons.directions_boat,
                          color: kColorAzul,
                        ),
                        labelText: 'T. BABOR POPA',
                        labelStyle: TextStyle(
                          color: kColorAzul,
                          fontSize: 20.0,
                        ),
                        hintText: '',
                      ),
                      controller: tBaborPopa,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 40,
                      color: kColorAzul,
                      child: const Center(
                        child: Text("REGISTRO FOTOGRAFICO",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
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
                                  border:
                                      Border.all(width: 1, color: Colors.grey),
                                ),
                                width: 150,
                                height: 150,
                                child: imageBodega != null
                                    ? Image.file(imageBodega!,
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
                                            "Inserte Foto de la Bodega",
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
                                        onPressed: (() => pickBodegaFoto(
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
                          listMpBodegaFoto
                              .add(MpBodegaFoto(mpUrlFoto: imageBodega?.path));
                          listFotoBodega
                              .add(ListFotoBodega(fotoBodega: imageBodega!));
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
                            itemCount: listFotoBodega.length,
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
                                  child: listFotoBodega[i].fotoBodega != null
                                      ? Image.file(
                                          listFotoBodega[i].fotoBodega!,
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
                      height: 40,
                      color: kColorAzul,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: const [
                              SizedBox(
                                width: 20,
                              ),
                              Center(
                                child: Text("MERCADERIA OBSERVADA",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white)),
                              ),
                            ],
                          ),
                          Switch(
                            value: value2,
                            onChanged: (value) => setState(
                              () {
                                value2 = value;
                                isVisible3 = !isVisible3;
                              },
                            ),
                            activeTrackColor: Colors.lightGreenAccent,
                            activeColor: Colors.green,
                          ),
                        ],
                      ),
                    ),
                    Visibility(
                      visible: isVisible3,
                      child: Column(
                        children: [
                          const SizedBox(height: 20),
                          TextFormField(
                            keyboardType: const TextInputType.numberWithOptions(
                                decimal: true),
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r"[0-9.]")),
                              TextInputFormatter.withFunction(
                                  (oldValue, newValue) {
                                try {
                                  final text = newValue.text;
                                  if (text.isNotEmpty) double.parse(text);
                                  return newValue;
                                } catch (e) {
                                  e.toString();
                                }
                                return oldValue;
                              }),
                            ],
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              prefixIcon: Icon(
                                Icons.badge,
                                color: kColorAzul,
                              ),
                              labelText: 'CANTIDAD APROX. DAÑOS',
                              labelStyle: TextStyle(
                                color: kColorAzul,
                                fontSize: 20.0,
                              ),
                              //hintText: 'Ingrese el Nombre del Conductor'
                            ),
                            controller: cantidadDanosController,
                          ),
                          const SizedBox(height: 20),
                          Text(
                            "DESCRIPCION Y/O COMENTARIOS",
                            style: TextStyle(color: kColorAzul, fontSize: 20),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextField(
                            //textAlign: TextAlign.justify,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)))),

                            maxLines: 3,
                            minLines: 1, controller: descripcionController,
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
                                  "Ingrese Fotos de los Daños",
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
                                      child: imageBodegaDano != null
                                          ? Image.file(imageBodegaDano!,
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
                                                  "Inserte Foto del Daño",
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
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.40,
                                          child: ElevatedButton(
                                              style: TextButton.styleFrom(
                                                backgroundColor: kColorNaranja,
                                                padding:
                                                    const EdgeInsets.all(10.0),
                                              ),
                                              onPressed: (() =>
                                                  pickBodegaDanoFoto(
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
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.40,
                                          child: ElevatedButton(
                                              style: TextButton.styleFrom(
                                                backgroundColor: kColorNaranja,
                                                padding:
                                                    const EdgeInsets.all(10.0),
                                              ),
                                              onPressed: (() =>
                                                  pickBodegaDanoFoto(
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
                                listMpObservadoFoto.add(MpObservadoFoto(
                                    mpUrlFoto: imageBodegaDano?.path));
                                listFotoBodegaDano.add(ListFotoBodegaDano(
                                    fotoBodegaDano: imageBodegaDano!));
                              });
                            },
                            child: Text(
                              "AGREGAR DAÑO",
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
                                border: Border.all(
                                    color:
                                        Colors.black), /* color: Colors.white */
                              ),
                              height: 400,
                              child: ListView.builder(
                                  itemCount: listFotoBodegaDano.length,
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
                                        child: listFotoBodegaDano[i]
                                                    .fotoBodegaDano !=
                                                null
                                            ? Image.file(
                                                listFotoBodegaDano[i]
                                                    .fotoBodegaDano!,
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
                      color: kColorNaranja,
                      onPressed: () {
                        createMonitoreoProductoSqlLite();
                        /* setState(() {
                          listFotoBodegaDano.add(ListFotoBodegaDano(
                              fotoBodegaDano: imageBodegaDano!));
                        }); */
                      },
                      child: const Text(
                        "REGISTRAR",
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.5),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
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
                      child: FutureBuilder<List<MonitoreoProductoSqlLiteModel>>(
                          future: futureMonitoreoProductoSqlLiteModel,
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
                                  /* DataColumn(
                                              label: Text("Cod Dr."),
                                            ), */
                                  DataColumn(
                                    label: Text("Bodega"),
                                  ),
                                  DataColumn(
                                    label: Text("Humedad"),
                                  ),
                                  DataColumn(
                                    label: Text("Temperatura 1"),
                                  ),
                                  DataColumn(
                                    label: Text("Temperatura 2"),
                                  ),
                                  DataColumn(
                                    label: Text("Temperatura 3"),
                                  ),
                                  DataColumn(
                                    label: Text("Temperatura 4"),
                                  ),
                                  DataColumn(
                                    label: Text("Temperatura 5"),
                                  ),
                                  DataColumn(
                                    label: Text("Delete"),
                                  ),
                                ],
                                rows: snapshot.data!
                                    .map(((e) => DataRow(
                                          cells: <DataCell>[
                                            DataCell(Text(e.idMonitoreoProducto
                                                .toString())),
                                            /* DataCell(Text(
                                                          e.codDr.toString(),
                                                          textAlign:
                                                              TextAlign.center)), */
                                            DataCell(Text(e.bodega.toString(),
                                                textAlign: TextAlign.center)),
                                            DataCell(Text(e.humedad.toString(),
                                                textAlign: TextAlign.center)),
                                            DataCell(Text(
                                                e.tempEstProa.toString(),
                                                textAlign: TextAlign.center)),
                                            DataCell(Text(
                                                e.tempEstPopa.toString(),
                                                textAlign: TextAlign.center)),
                                            DataCell(Text(
                                                e.tempCentro.toString(),
                                                textAlign: TextAlign.center)),
                                            DataCell(Text(
                                                e.tempBaborProa.toString(),
                                                textAlign: TextAlign.center)),
                                            DataCell(Text(
                                                e.tempBaborPopa.toString(),
                                                textAlign: TextAlign.center)),
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
                                  await obtenerMonitoreoProductoList();
                                  await obtenerMpBodegaFoto();
                                  await obtenerMpObservadoFoto();
                                  /*  imprimirMonitoreo();
                                  imprimirBodega();
                                  imprimirObservado(); */
                                  await cargarListaCompletaMonitoreoProducto();
                                  await dbLiteMonitoreoProducto.clearTables();
                                  setState(() {
                                    listTableMonitoreoProductoSqLite();
                                    listToUploadMpBodegaFoto.clear();
                                    listToUploadMpObservadoFoto.clear();
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
                    listTableMonitoreoProductoSqLite();
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

  dialogoEliminar(BuildContext context,
      MonitoreoProductoSqlLiteModel itemMonitoreoProductoSqlLite) {
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
                        dbLiteMonitoreoProducto.deleteBodegaFotostByIDMonitoreo(
                            itemMonitoreoProductoSqlLite.idMonitoreoProducto!);
                        dbLiteMonitoreoProducto
                            .deleteObservandoFotosByIDMonitoreo(
                                itemMonitoreoProductoSqlLite
                                    .idMonitoreoProducto!);
                        dbLiteMonitoreoProducto.deleteMonitoreoProductotByID(
                            itemMonitoreoProductoSqlLite.idMonitoreoProducto!);
                        setState(() {
                          listTableMonitoreoProductoSqLite();
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
