import 'dart:io';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import '../../../models/file_upload_result.dart';
import '../../../models/survey/ControlCarguio/vw_granel_lista_bodegas.dart';
import '../../../models/survey/InspeccionEquipos/create_inspeccion_equipos.dart';
import '../../../models/survey/InspeccionEquipos/vw_inspeccion_equipos_by_id.dart';
import '../../../models/survey/RegistroEquipos/vw_equipos_registrados_granel.dart';
import '../../../services/file_upload_result.dart';
import '../../../services/survey/control_carguio_service.dart';
import '../../../services/survey/inspeccion_equipo_service.dart';
import '../../../services/survey/registro_equipo_service.dart';
import '../../../utils/constants.dart';
import '../../../utils/lists.dart';
import 'imagenes_equipos_page.dart';
import 'reinspeccion_page.dart';

class Inspeccionequipos extends StatefulWidget {
  const Inspeccionequipos(
      {Key? key,
      required this.jornada,
      required this.idUsuario,
      required this.idServiceOrder})
      : super(key: key);
  final int jornada;
  final int idUsuario;
  final int idServiceOrder;

  @override
  State<Inspeccionequipos> createState() => _InspeccionequiposState();
}

class ListFotoEquipos {
  ListFotoEquipos({this.id, this.fotoEquipos, this.urlFoto});

  int? id;
  File? fotoEquipos;
  String? urlFoto;
}

class _InspeccionequiposState extends State<Inspeccionequipos>
    with SingleTickerProviderStateMixin {
  ControlCarguioService controlCarguioService = ControlCarguioService();

  RegistroEquipoService registroEquipoService = RegistroEquipoService();

  InspeccionEquipoService inspeccionEquipoService = InspeccionEquipoService();

  FileUploadService fileUploadService = FileUploadService();

  final TextEditingController equipoController = TextEditingController();

  late TabController _tabController;

  String _valueBodegaDropdown = 'Seleccione la Bodega';

  String _valueEquipoDropdown = 'Seleccione el Equipo';

  String _valueEstadoDropdown = 'Seleccione el Estado';

  bool valueMuelle = false;

  bool valueToldo = false;

  late int idEquipo;

  final TextEditingController comentariosController = TextEditingController();

  Future<List<VwInspeccionEquiposById>>?
      futureVwInspeccionEquiposByIdServiceOrder;

  obtenerInspeccionEquiposByIdServiceOrder() {
    futureVwInspeccionEquiposByIdServiceOrder = inspeccionEquipoService
        .getInspeccionEquiposByIdServiceOrder(widget.idServiceOrder);
  }

  List<VwEquiposRegistradosGranel> vwEquiposRegistradosGranelList = [];

  List<VwGranelListaBodegas> vwGranelListaBodegas = <VwGranelListaBodegas>[];

  List<DropdownMenuItem<String>> getEquipoDropDownItems(
      List<VwEquiposRegistradosGranel> equipos) {
    List<DropdownMenuItem<String>> dropDownItems = [];
    for (var element in equipos) {
      var newDropDown = DropdownMenuItem(
        value: element.codEquipo.toString(),
        child: Text(
          element.codEquipo.toString(),
        ),
      );
      dropDownItems.add(newDropDown);
    }

    return dropDownItems;
  }

  List<String> equiposList = [];

  getListEquipos() async {
    vwEquiposRegistradosGranelList =
        await registroEquipoService.getEquiposRegistradosGranel();

    print(vwEquiposRegistradosGranelList);

    /* setState(() {
      pepe = vwEquiposRegistradosGranelList.map((e) => e as String).toList();
    }); */

    /*  final map = Map<String, dynamic>();
    vwEquiposRegistradosGranelList = (map['codEquipo'] as List)
        .map((item) => item as VwEquiposRegistradosGranel)
        .toList(); */
  }

  getEquipoByCod() async {
    List<VwEquiposRegistradosGranel> vwEquiposRegistradosGranel =
        await registroEquipoService
            .getEquipoRegistradoByCod(_valueEquipoDropdown);

    equipoController.text = vwEquiposRegistradosGranel[0].equipo!;
    idEquipo = vwEquiposRegistradosGranel[0].idEquipo!;
    // print(idEquipo);
  }

  Future<List<SpCreateGranelInspeccionFoto>> parseInspeccionFoto() async {
    List<SpCreateGranelInspeccionFoto> spCreateGranelInspeccionFoto = [];
    FileUploadResult fileUploadResult = FileUploadResult();
    for (int count = 0; count < listFotoEquipos.length; count++) {
      SpCreateGranelInspeccionFoto aux = SpCreateGranelInspeccionFoto();
      aux.numInsp = "1er Inspec.";
      aux.estado = _valueEstadoDropdown;
      aux.urlFoto = listFotoEquipos[count].urlFoto;
      spCreateGranelInspeccionFoto.add(aux);
      File file = File(aux.urlFoto!);
      fileUploadResult = await fileUploadService.uploadFile(file);
      spCreateGranelInspeccionFoto[count].urlFoto = fileUploadResult.urlPhoto;
      spCreateGranelInspeccionFoto[count].nombreFoto =
          fileUploadResult.fileName;
    }
    return spCreateGranelInspeccionFoto;
  }

  createInspeccionEquipo() async {
    List<SpCreateGranelInspeccionFoto> spCreateGranelInspeccionFoto = [];

    spCreateGranelInspeccionFoto = await parseInspeccionFoto();

    String muelle;
    String toldo;

    if (valueMuelle == true) {
      muelle = "APTO";
    } else {
      muelle = "NO APTO";
    }

    if (valueToldo == true) {
      toldo = "SI";
    } else {
      toldo = "NO";
    }

    await inspeccionEquipoService.createInspeccionEquipos(
        CreateInspeccionEquipos(
            spCreateGranelInspeccionEquipos: SpCreateGranelInspeccionEquipos(
                bodega: _valueBodegaDropdown,
                jornada: widget.jornada,
                primInsp: _valueEstadoDropdown,
                muelle: muelle,
                toldo: toldo,
                comentario: comentariosController.text,
                fecha: DateTime.now(),
                idEquipo: idEquipo,
                idServiceOrder: widget.idServiceOrder,
                idUsuario: widget.idUsuario),
            spCreateGranelInspeccionFotos: spCreateGranelInspeccionFoto));
    setState(() {
      obtenerInspeccionEquiposByIdServiceOrder();
    });

    setState(() {
      imageEquipos = null;
      listFotoEquipos.clear();
      _valueBodegaDropdown = 'Seleccione la Bodega';
      _valueEquipoDropdown = 'Seleccione el Equipo';
      _valueEstadoDropdown = 'Seleccione el Estado';
      equipoController.clear();
      comentariosController.clear();
    });
    _tabController.animateTo((_tabController.index = 1));
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
    List<VwGranelListaBodegas> value = await controlCarguioService
        .getGranelListaBodegas(widget.idServiceOrder);

    setState(() {
      vwGranelListaBodegas = value;
    });
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
  void initState() {
    // TODO: implement initState
    super.initState();
    getBodegas();
    getListEquipos();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(_handleTabIndex);

    obtenerInspeccionEquiposByIdServiceOrder();
  }

  List<ListFotoEquipos> listFotoEquipos = [];

  File? imageEquipos;

  Future pickBodegaFoto(ImageSource source) async {
    try {
      final imageEquipos = await ImagePicker().pickImage(source: source);

      if (imageEquipos == null) return;

      final imageTemporary = File(imageEquipos.path);

      setState(() => this.imageEquipos = imageTemporary);
    } on PlatformException catch (e) {
      // print('Failed to pick image: $e');
      e.message;
    }
  }

  @override
  Widget build(BuildContext context) {
    equiposList =
        vwEquiposRegistradosGranelList.map((city) => city.codEquipo!).toList();

    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text("INSPECCIÓN DE EQUIPOS"),
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
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text("Muelle",
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: kColorAzul,
                                        fontWeight: FontWeight.w500)),
                                const SizedBox(width: 2),
                                Switch(
                                  value: valueMuelle,
                                  onChanged: (value) => setState(() {
                                    valueMuelle = value;
                                  }),
                                  activeTrackColor: Colors.lightGreenAccent,
                                  activeColor: Colors.green,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text("Toldo (Instalado)",
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: kColorAzul,
                                        fontWeight: FontWeight.w500)),
                                const SizedBox(width: 2),
                                Switch(
                                  value: valueToldo,
                                  onChanged: (value) => setState(() {
                                    valueToldo = value;
                                  }),
                                  activeTrackColor: Colors.lightGreenAccent,
                                  activeColor: Colors.green,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
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
                      DropdownSearch<String>(
                        items: equiposList,
                        popupProps: const PopupProps.menu(
                          showSearchBox: true,
                          title: Text('Busque el Codigo del Equipo'),
                        ),
                        dropdownDecoratorProps: DropDownDecoratorProps(
                          dropdownSearchDecoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            labelText: "Lista Codigo Equipo",
                            labelStyle: TextStyle(
                              color: kColorAzul,
                              fontSize: 20.0,
                            ),
                            hintText: "Seleccione Equipo",
                            filled: true,
                          ),
                        ),
                        onChanged: (value) => {
                          setState(() {
                            _valueEquipoDropdown = value as String;
                            // codEquipo = _valueEquipoDropdown;
                          }),
                          getEquipoByCod(),
                        },
                      ),
                      /*   DropdownSearch<String>(
                        mode: Mode.MENU,
                        showSelectedItems: true,
                        items: [
                          "Brazil",
                          "Italia (Disabled)",
                          "Tunisia",
                          'Canada'
                        ],
                        dropdownSearchDecoration: InputDecoration(
                          labelText: "Menu mode",
                          hintText: "country in menu mode",
                        ),
                        popupItemDisabled: isItemDisabled,
                        onChanged: itemSelectionChanged,
                        //selectedItem: "",
                        showSearchBox: true,
                        searchFieldProps: TextFieldProps(
                          cursorColor: Colors.blue,
                        ),
                      ), */
                      /*     DropdownButtonFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          labelText: 'Lista Codigo Equipo',
                          hintText: 'Seleccione Equipo',
                          labelStyle: TextStyle(
                            color: kColorAzul,
                            fontSize: 20.0,
                          ),
                        ),
                        icon: const Icon(
                          Icons.arrow_drop_down_circle_outlined,
                        ),
                        items: getEquipoDropDownItems(
                            vwEquiposRegistradosGranelList),
                        onChanged: (value) {
                          setState(() {
                            _valueEquipoDropdown = value.toString();
                          });
                          getEquipoByCod();
                        },
                        validator: (value) {
                          if (value == null) {
                            return 'Por favor, elige order de equipo';
                          }
                          return null;
                        },
                      ), */
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
                            child: Center(
                                child: Text(a, textAlign: TextAlign.left)),
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
                                    border: Border.all(
                                        width: 1, color: Colors.grey),
                                  ),
                                  width: 150,
                                  height: 150,
                                  child: imageEquipos != null
                                      ? Image.file(imageEquipos!,
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
                                          onPressed: (() => pickBodegaFoto(
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
                            listFotoEquipos.add(ListFotoEquipos(
                                fotoEquipos: imageEquipos!,
                                urlFoto: imageEquipos!.path));
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
                                      border: Border.all(
                                          width: 1, color: Colors.grey),
                                    ),
                                    width: 200,
                                    height: 200,
                                    child: listFotoEquipos[i].fotoEquipos !=
                                            null
                                        ? Image.file(
                                            listFotoEquipos[i].fotoEquipos!,
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
                          createInspeccionEquipo();
                        },
                        child: const Text(
                          "Registrar Equipos",
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
                padding: const EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: FutureBuilder<List<VwInspeccionEquiposById>>(
                        future: futureVwInspeccionEquiposByIdServiceOrder,
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
                                  label: Text("Bodega"),
                                ),
                                DataColumn(
                                  label: Text("Cod. Equipo"),
                                ),
                                DataColumn(
                                  label: Text("Nombre Equipo"),
                                ),
                                DataColumn(
                                  label: Text("Comentario"),
                                ),
                                DataColumn(
                                  label: Text("1.INSP"),
                                ),
                                DataColumn(
                                  label: Text("2.INSP"),
                                ),
                                DataColumn(
                                  label: Text("3.INSP"),
                                ),
                                DataColumn(
                                  label: Text("Fotografias"),
                                ),
                                DataColumn(
                                  label: Text("Delete"),
                                ),
                              ],
                              rows: snapshot.data!
                                  .map(((e) => DataRow(
                                        onLongPress: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ReinspeccionEquipo(
                                                        idInspeccionEquipo: e
                                                            .idInspeccionEquipo!,
                                                      )));
                                        },
                                        cells: <DataCell>[
                                          DataCell(Text(e.idVista.toString())),
                                          DataCell(Text(e.bodega.toString(),
                                              textAlign: TextAlign.center)),
                                          DataCell(Text(e.codEquipo.toString(),
                                              textAlign: TextAlign.center)),
                                          DataCell(Text(
                                              e.nombreEquipo.toString(),
                                              textAlign: TextAlign.center)),
                                          DataCell(Text(e.comentario.toString(),
                                              textAlign: TextAlign.center)),
                                          DataCell(e.primeraInspeccion ==
                                                  "APROBADO"
                                              ? const Icon(
                                                  Icons.check_outlined,
                                                  color: Colors.green,
                                                )
                                              : e.primeraInspeccion ==
                                                      "RECHAZADO"
                                                  ? const Icon(
                                                      Icons.close,
                                                      color: Colors.red,
                                                    )
                                                  : const Icon(
                                                      Icons.warning,
                                                      color: Color.fromARGB(
                                                          174, 197, 197, 10),
                                                    )),
                                          DataCell(e.segundoInspeccion ==
                                                  "APROBADO"
                                              ? const Icon(
                                                  Icons.check_outlined,
                                                  color: Colors.green,
                                                )
                                              : e.segundoInspeccion ==
                                                      "RECHAZADO"
                                                  ? const Icon(
                                                      Icons.close,
                                                      color: Colors.red,
                                                    )
                                                  : const Icon(
                                                      Icons.warning,
                                                      color: Color.fromARGB(
                                                          174, 197, 197, 10),
                                                    )),
                                          DataCell(e.terceraInspeccion ==
                                                  "APROBADO"
                                              ? const Icon(
                                                  Icons.check_outlined,
                                                  color: Colors.green,
                                                )
                                              : e.terceraInspeccion ==
                                                      "RECHAZADO"
                                                  ? const Icon(
                                                      Icons.close,
                                                      color: Colors.red,
                                                    )
                                                  : const Icon(
                                                      Icons.warning,
                                                      color: Color.fromARGB(
                                                          174, 197, 197, 10),
                                                    )),
                                          DataCell(IconButton(
                                            icon: const Icon(Icons.image),
                                            onPressed: (() {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          ImagenesEquipos(
                                                            idInspeccionEquipo:
                                                                e.idInspeccionEquipo!,
                                                          )));
                                            }),
                                          )),
                                          DataCell(IconButton(
                                            icon: const Icon(Icons.delete),
                                            onPressed: (() {
                                              /*   inspeccionEquipoService
                                                  .delecteLogicInspeccionEquipo(
                                                      e.idInspeccionEquipo!); */
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
                ),
              )
            ],
          ),
          floatingActionButton: _tabController.index == 1
              ? FloatingActionButton(
                  onPressed: () {
                    setState(() {
                      obtenerInspeccionEquiposByIdServiceOrder();
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

  dialogoEliminar(BuildContext context, VwInspeccionEquiposById e) {
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
                        inspeccionEquipoService.delecteLogicInspeccionEquipo(
                            e.idInspeccionEquipo!);
                        setState(() {
                          obtenerInspeccionEquiposByIdServiceOrder();
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
