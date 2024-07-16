//import 'package:consumar_app/src/roro/autoreport/autoreport_list_page.dart';
import 'package:consumar_app/models/Travel.dart';
import 'package:consumar_app/models/service-order.dart';
import 'package:consumar_app/models/ship.dart';
import 'package:consumar_app/models/vehicle.dart';
import 'package:consumar_app/src/auth/login_page.dart';
import 'package:consumar_app/src/roro/printer_app/etiquetado_page.dart';
import 'package:consumar_app/src/roro/printer_app/reetiquetado_page.dart';
import 'package:consumar_app/utils/check_internet_connection.dart';
import 'package:consumar_app/utils/connection_status_cubit.dart';
import 'package:consumar_app/utils/roro/sqliteBD/db_printer_app.dart';
//import 'package:consumar_app/src/roro/printer_app/qr_pdf_reetiquetado_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../../../models/operacion-roro.dart';
import '../../../models/roro/printer_app/insert_printer_app_pendientes.dart';
import '../../../services/roro/printer_app/printer_app_service.dart';
import '../../../utils/constants.dart';
//import '../../../utils/roro/sqliteBD/db_printer_app.dart';

class PrinterApp extends StatefulWidget {
  const PrinterApp(
      {Key? key,
      required this.jornada,
      required this.idUsuario,
      required this.idServiceOrder})
      : super(key: key);
  final int jornada;
  final BigInt idUsuario;
  final BigInt idServiceOrder;

  @override
  State<PrinterApp> createState() => _PrinterAppState();
}

late TabController _tabController;

List<InsertPrinterAppPendientes> getPrinterAppPendientes = [];

List<Vehicle> vehicleList = [];

List<OperacionRoro> operacionList = [];
List<OperacionRoro> operacionListFilter = [];

List<OperacionRoro> operacionListEtiquetados = [];
List<OperacionRoro> operacionListFilterEtiquetados = [];

List<Vehicle> vehicleEtiquetadoList = [];

List<Vehicle> allDR = vehicleList;

List<Vehicle> allDREtiqutado = vehicleEtiquetadoList;

List<Ship> shipList = [];

List<ServiceOrder> serviceOrderList = [];

List<Travel> travelList = [];

String idShip = "";

String idTravel = "";

String idS0 = "";

String serviceorder = "";

String manifiesto = "";

class _PrinterAppState extends State<PrinterApp>
    with SingleTickerProviderStateMixin {
  final controllerSearchChasis = TextEditingController();

  final controllerSearchChasisEtiquetado = TextEditingController();

  final controllerSearchChasisEtiquetadoBD = TextEditingController();

  PrinterAppService printerAppService = PrinterAppService();

  DbPrinterApp dbPrinterApp = DbPrinterApp();

  ServiceOrder? _selectedS0;
  Ship? _selectedShip; // Variable para almacenar el barco seleccionado
  Travel? _selectedTravel; // Variable para almacenar el barco seleccionado

  bool vsbDropTravel = false;

  //Metodo para obtener la lista en local de los Vehiculos Etiquetados
  obtenerListadoPrinterAppEtiquetado() async {
    vehicleEtiquetadoList =
        await dbPrinterApp.getSqlLitePrinterAppEtiquetados();

    setState(() {
      allDREtiqutado = vehicleEtiquetadoList;
    });
  }

  //Obtener la lista en local de vehiculos sin etiquetar cargado previamente de la BD
  cargarListaBarcos() async {
    List<Ship> value = await printerAppService.getShips();

    setState(() {
      shipList = value;
    });
  }

  //Obtener la lista en local de vehiculos sin etiquetar cargado previamente de la BD
  cargarListaSO() async {
    List<ServiceOrder> value = await printerAppService.getServiceOrder();

    setState(() {
      serviceOrderList = value;
    });
  }

  //Obtener la lista en local de vehiculos sin etiquetar cargado previamente de la BD
  cargarListaViaje() async {
    List<Travel> value = await printerAppService.getTravels(idShip);

    setState(() {
      travelList = value;
    });
    print(travelList.length);
  }

  //Obtener la lista en local de vehiculos sin etiquetar cargado previamente de la BD
  cargarListVehiculos() async {
    List<OperacionRoro> value =
        await printerAppService.getVehiclesOperacion(idTravel, idS0);

    setState(() {
      //
      //operacionList = value;
      operacionList =
          value.where((vehiculo) => vehiculo.labelledDate == null).toList();

      operacionListEtiquetados =
          value.where((vehiculo) => vehiculo.labelledDate != null).toList();


      operacionListFilter = operacionList;
      operacionListFilterEtiquetados = operacionListEtiquetados;
    });
  }

  bool syncing = false;

  cargando() async {
    EasyLoading.show(
        indicator: const CircularProgressIndicator(),
        status: "Cargando",
        maskType: EasyLoadingMaskType.black);

    await cargarListaBarcos();
    await cargarListaSO();
    EasyLoading.dismiss();
  }

  void syncData() async {
    // Mostrar el CircularProgressIndicator mientras se cargan los datos
    setState(() {
      syncing = true;
    });

    // Aquí cargarías los datos de la BD o desde cualquier otro origen de datos
    await cargarListVehiculos();

    // Detener el CircularProgressIndicator y mostrar la tabla con los datos cargados
    setState(() {
      syncing = false;
    });
  }

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(_handleTabIndex);
    // TODO: implement initStatef
    super.initState();
    cargarListaBarcos();
    cargarListaSO();
    obtenerListadoPrinterAppEtiquetado();
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
    List<OperacionRoro> filteredList =
        operacionList.where((element) => element.labelledDate == null).toList();

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          iconTheme: IconThemeData(
              color: Colors
                  .white), // Cambia el color del icono de hamburguesa aquí
          title: const Text(
            "Vehículos",
            style: TextStyle(color: Colors.white),
            textAlign: TextAlign.left,
          ),
          bottom:  TabBar(
              isScrollable: true,
              indicatorColor: Colors.white,
              labelColor: Colors.white,
              unselectedLabelColor: const Color.fromARGB(255, 223, 216, 216),
              controller: _tabController,
              tabs: [
                Tab(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('PENDIENTES'),
                      const SizedBox(
                        width: 10,
                      ),
                      Container(
                        height: 20,
                        decoration: const BoxDecoration(
                          color: Colors.orange,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            filteredList.length.toString(),
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Tab(
                  child: Row(
                    children: [
                      const Text('ETIQUETADOS LOCAL'),
                      const SizedBox(
                        width: 10,
                      ),
                      Container(
                        height: 20,
                        decoration: const BoxDecoration(
                          color: Colors.orange,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            vehicleEtiquetadoList.length.toString(),
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Tab(
                  child: Row(
                    children: [
                      const Text('ETIQUETADOS BD'),
                      const SizedBox(
                        width: 10,
                      ),
                      Container(
                        height: 20,
                        decoration: const BoxDecoration(
                          color: Colors.orange,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            operacionListEtiquetados.length.toString(),
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
      
        ),
        drawer: Drawer(
          backgroundColor: kColorAzul2,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              SizedBox(
                height: 30,
              ),
              ListTile(
                title: Row(
                  children: [
                    Icon(
                      Icons.logout,
                      color: Colors.white, // Cambia el color del icono aquí
                      size: 32,
                    ),
                    SizedBox(width: 10), // Espacio entre el icono y el texto
                    Text(
                      'Cerrar sesión',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                      ),
                    ),
                  ],
                ),
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (c) => const LoginPantalla(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        body: Container(
          color: kColorAzul2,
          child: TabBarView(
            controller: _tabController,
            children: [
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Container(
                    child: Column(children: [
                      if (allDREtiqutado.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.white.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                Text(
                                  "USTED TIENE VEHICULOS PENDIENTES A SINCRONIZAR",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(
                                    height:
                                        10), // Espacio entre las líneas de texto
                                Text(
                                  "ORDEN DE SERVICIO: ${vehicleEtiquetadoList[0].ordenservicio}",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(
                                    height:
                                        5), // Espacio entre las líneas de texto
                                Text(
                                  "MANIFIESTO: ${vehicleEtiquetadoList[0].manifiesto}",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ),
                      Card(
                          child: ListTile(
                        leading: const Icon(Icons.search),
                        title: TextField(
                            controller: controllerSearchChasis,
                            decoration: const InputDecoration(
                                hintText: 'Buscar Placas',
                                border: InputBorder.none),
                            onChanged: ((value) {
                              if (value.length > 4) {
                                searchChassis(value);
                              }
                              //searchChassisEtiquetado(value);
                            })),
                        trailing: IconButton(
                          icon: const Icon(Icons.cancel),
                          onPressed: () {
                            setState(() {
                              controllerSearchChasis.clear();
                              operacionListFilter = operacionList;
                              searchChassis;
                            });
                          },
                        ),
                      )),
                      const SizedBox(height: 20),
                      SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: syncing
                              ? Column(
                                  children: [
                                    Text(
                                      "Cargando Vehiculos",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Center(
                                      child: CircularProgressIndicator(
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                                Colors.white),
                                      ),
                                    ),
                                  ],
                                )
                              : DataTable(
                                  dividerThickness: 3,
                                  border: TableBorder.symmetric(
                                      inside: BorderSide(
                                          width: 1,
                                          color: Colors.grey.shade200)),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.white),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  headingTextStyle: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                  dataRowColor:
                                      MaterialStateProperty.resolveWith(
                                          _getDataRowColor),
                                  columns: const <DataColumn>[
                                    DataColumn(
                                      label: Center(
                                          child: Text(
                                        "Chassis",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(color: Colors.white),
                                      )),
                                    ),
                                    DataColumn(
                                      label: Center(
                                          child: Text(
                                        "Estado",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(color: Colors.white),
                                      )),
                                    ),
                                  ],
                                  rows: operacionListFilter
                                      .map(((e) => DataRow(cells: <DataCell>[
                                            DataCell(
                                              Text(
                                                e.chassis!,
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                            //DataCell(Text(e.estado!)),
                                            DataCell(
                                              e.labelledDate == null
                                                  ? ElevatedButton(
                                                      onPressed: () {
                                                        print(e.vehicleId);
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        EtiquetadoPrinterApp(
                                                                          jornada:
                                                                              widget.jornada,
                                                                          idUsuario:
                                                                              widget.idUsuario,
                                                                          idServiceOrder:
                                                                              idS0,
                                                                          idPendientes:
                                                                              int.parse(e.vehicleId!),
                                                                          chassis:
                                                                              e.chassis!,
                                                                          idTravel:
                                                                              idTravel,
                                                                          ordenservicio:
                                                                              serviceorder,
                                                                          manifiesto:
                                                                              manifiesto,
                                                                        )));

                                                        operacionList
                                                            .removeWhere(
                                                                (vehicle) =>
                                                                    vehicle
                                                                        .id ==
                                                                    e.id);
                                                        setState(() {
                                                          operacionList;
                                                          vehicleEtiquetadoList;
                                                        });
                                                        // Aquí puedes manejar la acción de etiquetar
                                                      },
                                                      style: ButtonStyle(
                                                        backgroundColor:
                                                            MaterialStateProperty
                                                                .all<Color>(
                                                                    kColorCeleste2),
                                                        shape: MaterialStateProperty
                                                            .all<
                                                                OutlinedBorder>(
                                                          RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0), // Define el radio del borde
                                                          ),
                                                        ),
                                                      ),
                                                      child: Text(
                                                        'Etiquetar',
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    )
                                                  : ElevatedButton(
                                                      onPressed: () {
                                                        print(e.id);
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (context) =>
                                                                EtiquetadoPrinterApp(
                                                              jornada: widget
                                                                  .jornada,
                                                              idUsuario: widget
                                                                  .idUsuario,
                                                              idServiceOrder:
                                                                  idS0,
                                                              idPendientes:
                                                                  int.parse(e
                                                                      .vehicleId!),
                                                              chassis:
                                                                  e.chassis!,
                                                              idTravel:
                                                                  idTravel,
                                                              ordenservicio:
                                                                  serviceorder,
                                                              manifiesto:
                                                                  manifiesto,
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                      style: ButtonStyle(
                                                        backgroundColor:
                                                            MaterialStateProperty
                                                                .all<Color>(
                                                                    kColorNaranja),
                                                        shape: MaterialStateProperty
                                                            .all<
                                                                OutlinedBorder>(
                                                          RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0),
                                                          ),
                                                        ),
                                                      ),
                                                      child: Text(
                                                        'Etiquetado',
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ),
                                            )
                                          ])))
                                      .toList(),
                                )),
                    ]),
                  ),
                ),
              ),
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(children: [
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
                              child: Container(
                                padding: const EdgeInsets.all(16),
                                height: 60,
                                color: Colors.red,
                                child: const Row(
                                  children: [
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
                                child: const Row(
                                  children: [
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
                    Card(
                        child: ListTile(
                      leading: const Icon(Icons.search),
                      title: TextField(
                          controller: controllerSearchChasisEtiquetado,
                          decoration: const InputDecoration(
                              hintText: 'Buscar Chasis Etiquetado',
                              border: InputBorder.none),
                          onChanged: ((value) {
                            if (value.length > 3) {
                              searchChassisEtiquetado(value);
                            }
                          })),
                      trailing: IconButton(
                        icon: const Icon(Icons.cancel),
                        onPressed: () {
                          setState(() {
                            controllerSearchChasisEtiquetado.clear();
                            allDREtiqutado = vehicleEtiquetadoList;
                            searchChassisEtiquetado;
                          });
                        },
                      ),
                    )),
                    const SizedBox(height: 20),
                    SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: DataTable(
                          dividerThickness: 3,
                          border: TableBorder.symmetric(
                              inside: BorderSide(
                                  width: 1, color: Colors.grey.shade200)),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          headingTextStyle: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                          dataRowColor: MaterialStateProperty.resolveWith(
                              _getDataRowColor),
                          columns: const <DataColumn>[
                            DataColumn(
                              label: Center(
                                  child: Text(
                                "Chassis",
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.white),
                              )),
                            ),
                            DataColumn(
                              label: Center(
                                  child: Text(
                                "Estado",
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.white),
                              )),
                            ),
                          ],
                          rows: allDREtiqutado
                              .map(((e) => DataRow(cells: <DataCell>[
                                    DataCell(
                                      Text(
                                        e.chassis,
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                    //DataCell(Text(e.estado!)),
                                    DataCell(
                                      ElevatedButton(
                                        onPressed: () {
                                          print(e.id);
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ReetiquetadoPage(
                                                          idPendientes:
                                                              int.parse(e.id),
                                                          chassis: e.chassis)));
                                        },
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all<Color>(
                                                  kColorNaranja),
                                          shape: MaterialStateProperty.all<
                                              OutlinedBorder>(
                                            RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(
                                                  10.0), // Define el radio del borde
                                            ),
                                          ),
                                        ),
                                        child: Text(
                                          'Etiquetado',
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    )
                                  ])))
                              .toList(),
                        )),
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
                                          "ATENCIÓN: ES NECESARIO TENER CONEXIÓN A INTERNET PARA PODER CARGAR DATOS",
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
                                try {
                                  // Convertir la lista de vehículos a una lista de IDs
                                  List<int> idList = vehicleEtiquetadoList
                                      .map<int>(
                                          (vehicle) => int.parse(vehicle.id))
                                      .toList();

                                  // Llamar al servicio para actualizar los vehículos
                                  await printerAppService
                                      .actualizarVehiculos(idList);

                                  // Recargar la lista de vehículos
                                  await cargarListVehiculos();

                                  // Limpiar la tabla de vehículos etiquetados en la base de datos local
                                  await dbPrinterApp
                                      .clearTablePrinterAppEtiquetados();

                                  // Actualizar el estado de la UI
                                  setState(() {
                                    vehicleEtiquetadoList.clear();
                                    idList.clear();
                                  });

                                  // Mostrar un mensaje de éxito
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                          '¡La actualización se realizó correctamente!'),
                                      backgroundColor: Colors.green,
                                    ),
                                  );
                                } catch (error) {
                                  // Mostrar un mensaje de error en caso de fallo
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                          'Error al actualizar los vehículos: $error'),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                }
                              },
                              child: const Text(
                                "SINCRONIZAR CON BD",
                                style: TextStyle(
                                    fontSize: 17,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1.5),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ]),
                ),
              ),
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Container(
                    child: Column(children: [
                      Card(
                          child: ListTile(
                        leading: const Icon(Icons.search),
                        title: TextField(
                            controller: controllerSearchChasisEtiquetadoBD,
                            decoration: const InputDecoration(
                                hintText: 'Buscar Placas',
                                border: InputBorder.none),
                            onChanged: ((value) {
                              if (value.length > 4) {
                                searchChassisEtiquetadosBD(value);
                              }
                              //searchChassisEtiquetado(value);
                            })),
                        trailing: IconButton(
                          icon: const Icon(Icons.cancel),
                          onPressed: () {
                            setState(() {
                              controllerSearchChasisEtiquetadoBD.clear();
                              operacionListFilterEtiquetados =
                                  operacionListEtiquetados;
                              searchChassisEtiquetadosBD;
                            });
                          },
                        ),
                      )),
                      const SizedBox(height: 20),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: DataTable(
                          dividerThickness: 3,
                          border: TableBorder.symmetric(
                            inside: BorderSide(
                              width: 1,
                              color: Colors.grey.shade200,
                            ),
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          headingTextStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          dataRowColor: MaterialStateProperty.resolveWith(
                            _getDataRowColor,
                          ),
                          columns: const <DataColumn>[
                            DataColumn(
                              label: Center(
                                child: Text(
                                  "Chassis",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                            DataColumn(
                              label: Center(
                                child: Text(
                                  "Estado",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                          rows: operacionListFilterEtiquetados
                              .map((e) => DataRow(cells: <DataCell>[
                                    DataCell(
                                      Text(
                                        e.chassis!,
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                    DataCell(
                                      ElevatedButton(
                                        onPressed: () {
                                          print(e.id);
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  ReetiquetadoPage(
                                                idPendientes: int.parse(e.id!),
                                                chassis: e.chassis!,
                                              ),
                                            ),
                                          );
                                        },
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all<Color>(
                                            kColorNaranja,
                                          ),
                                          shape: MaterialStateProperty.all<
                                              OutlinedBorder>(
                                            RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            ),
                                          ),
                                        ),
                                        child: Text(
                                          'Etiquetado',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ]))
                              .toList(),
                        ),
                      ),
                    ]),
                  ),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              onPressed: allDREtiqutado.isEmpty
                  ? () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return StatefulBuilder(
                            builder: (context, setState) {
                              return AlertDialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                title: Text(
                                  "Sincronizar Vehiculos",
                                  textAlign: TextAlign.center,
                                ),
                                content: Container(
                                  width: double.maxFinite,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("Seleccione una opción:"),
                                      SizedBox(height: 10),
                                      DropdownButton<ServiceOrder>(
                                        isExpanded: true,
                                        hint: Text('Seleccione Orden Servicio'),
                                        value: _selectedS0,
                                        items: serviceOrderList
                                            .map((ServiceOrder so) {
                                          return DropdownMenuItem<ServiceOrder>(
                                            value: so,
                                            child: Text(so.serviceNumber!),
                                          );
                                        }).toList(),
                                        onChanged:
                                            (ServiceOrder? newValue) async {
                                          setState(() {
                                            _selectedS0 = newValue;
                                            idS0 = newValue!.id!;
                                            serviceorder =
                                                newValue.serviceNumber!;
                                            print(idS0);
                                          });

                                          setState(() {});
                                        },
                                      ),
                                      SizedBox(height: 10),
                                      DropdownButton<Ship>(
                                        isExpanded: true,
                                        hint: Text('Seleccione Nave'),
                                        value: _selectedShip,
                                        items: shipList.map((Ship ship) {
                                          return DropdownMenuItem<Ship>(
                                            value: ship,
                                            child: Text(ship.name),
                                          );
                                        }).toList(),
                                        onChanged: (Ship? newValue) async {
                                          setState(() {
                                            _selectedShip = newValue;
                                            _selectedTravel = null;
                                            idShip = newValue!.id;
                                            print(idShip);
                                          });
                                          EasyLoading.show(
                                              indicator:
                                                  const CircularProgressIndicator(),
                                              status: "Cargando",
                                              maskType:
                                                  EasyLoadingMaskType.black);
                                          await cargarListaViaje();
                                          EasyLoading.dismiss();
                                          if (idShip != "") {
                                            setState(() {
                                              vsbDropTravel = true;
                                            });
                                          }
                                        },
                                      ),
                                      SizedBox(height: 10),
                                      Visibility(
                                        visible: vsbDropTravel,
                                        child: DropdownButton<Travel>(
                                          isExpanded: true,
                                          hint: Text('Seleccione Viaje'),
                                          value: _selectedTravel,
                                          items:
                                              travelList.map((Travel travel) {
                                            return DropdownMenuItem<Travel>(
                                              value: travel,
                                              child: Text(travel.travelNumber),
                                            );
                                          }).toList(),
                                          onChanged: (Travel? newValue) {
                                            setState(() {
                                              _selectedTravel = newValue;
                                              idTravel = newValue!.id;
                                              manifiesto =
                                                  newValue.travelNumber;
                                            });
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                actions: [
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8.0),
                                      color: (_selectedShip != null &&
                                              _selectedTravel != null &&
                                              _selectedS0 != null &&
                                              idTravel != "")
                                          ? Colors.orange
                                          : Colors.grey,
                                    ),
                                    child: TextButton(
                                      onPressed: (_selectedShip != null &&
                                              _selectedTravel != null &&
                                              _selectedS0 != null &&
                                              idTravel != "")
                                          ? () {
                                              syncData();
                                              setState(() {
                                                _selectedTravel = null;
                                                _selectedShip = null;
                                                _selectedTravel = null;
                                                idShip = "";
                                                vsbDropTravel = false;
                                              });
                                              Navigator.of(context).pop();
                                            }
                                          : null,
                                      style: ButtonStyle(
                                        foregroundColor: MaterialStateProperty
                                            .resolveWith<Color>(
                                          (Set<MaterialState> states) {
                                            if (states.contains(
                                                MaterialState.disabled)) {
                                              return Colors.white;
                                            }
                                            return Colors.white;
                                          },
                                        ),
                                      ),
                                      child: Text(
                                        'Sincronizar',
                                      ),
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8.0),
                                      color: Colors.red[100],
                                    ),
                                    child: TextButton(
                                      onPressed: () {
                                        setState(() {
                                          _selectedTravel = null;
                                          _selectedShip = null;
                                          _selectedTravel = null;
                                          idShip = "";
                                          vsbDropTravel = false;
                                        });
                                        Navigator.of(context).pop();
                                      },
                                      style: ButtonStyle(
                                        foregroundColor:
                                            MaterialStateProperty.all<Color>(
                                                Colors.red[900]!),
                                      ),
                                      child: Text('Cancelar'),
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      );
                    }
                  : null,
              backgroundColor:
                  allDREtiqutado.isEmpty ? Colors.green : Colors.grey,
              child: const Icon(Icons.cloud_sync),
            ),
          ],
        ),
      ),
    );
  }

  Color _getDataRowColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
      MaterialState.selected
    };

    if (states.any(interactiveStates.contains)) {
      return kColorCeleste;
    }
    //return Colors.green; // Use the default value.
    return Colors.transparent;
  }

  void searchChassis(String query) {
    /*final suggestion = vehicleList.where((drList) {
      final listDR = drList.chassis.toLowerCase();
      final input = query.toLowerCase();
      return listDR.contains(input);
    }).toList();*/

    operacionListFilter = operacionList
        .where((element) =>
            element.chassis!.toLowerCase().contains(query.toLowerCase()))
        .toList();

    //setState(() => allDR = suggestion);
    setState(() {
      controllerSearchChasis;
      // controllerSearchChasisEtiquetado;
    });
  }

  void searchChassisEtiquetadosBD(String query) {
    operacionListFilterEtiquetados = operacionListEtiquetados
        .where((element) =>
            element.chassis!.toLowerCase().contains(query.toLowerCase()))
        .toList();

    setState(() {
      controllerSearchChasisEtiquetadoBD;
    });
  }

  void searchChassisEtiquetado(String query) {
    final suggestion = vehicleEtiquetadoList.where((drList) {
      final listDR = drList.chassis.toLowerCase();
      final input = query.toLowerCase();
      return listDR.contains(input);
    }).toList();

    setState(() => allDREtiqutado = suggestion);
  }

}
