import 'package:flutter/material.dart';

import '../../../models/carga_liquida/precintados/create_liquida_precintados.dart';
import '../../../models/carga_liquida/precintados/vw_liquida_precinto.dart';
import '../../../services/carga_liquida/precintado_liquida_service.dart';
import '../../../utils/carga_liquida/clases_liquida_precintados.dart';
import '../../../utils/constants.dart';
import 'liquida_precintado_pdf_page.dart';

class LiquidaPrecintado extends StatefulWidget {
  const LiquidaPrecintado(
      {super.key,
      required this.jornada,
      required this.idUsuario,
      required this.idServiceOrder});
  final int jornada;
  final int idUsuario;
  final int idServiceOrder;

  @override
  State<LiquidaPrecintado> createState() => _LiquidaPrecintadoState();
}

class _LiquidaPrecintadoState extends State<LiquidaPrecintado>
    with SingleTickerProviderStateMixin {
  PrecintadoLiquidaService precintadoLiquidaService =
      PrecintadoLiquidaService();

  List<VwLiquidaPrecinto> listLiquidaPrecinto = [];

  late TabController _tabController;

  List<ValvulasIngreso> valvulasIngreso = [];
  List<ValvulasSalida> valvulasSalida = [];

  List<ListaLiquidaPrecintos> listaPrecintos = [];

  late int idCarguio;

  getListaPrecintos() async {
    List<VwLiquidaPrecinto> value = await precintadoLiquidaService
        .getLiquidaPrecintadosByServiceOrder(widget.idServiceOrder);

    setState(() {
      listLiquidaPrecinto = value;
    });

    // debugPrint(listLiquidaPrecinto.length as String?);
  }

  getPrecintosById(int id) async {
    VwLiquidaPrecinto vLiquidaPrecinto = VwLiquidaPrecinto();

    vLiquidaPrecinto =
        await precintadoLiquidaService.getLiquidaPrecintadoById(id);

    idCarguio = vLiquidaPrecinto.idCarguio!;
    cisternaController.text = vLiquidaPrecinto.cisterna!;
    placaController.text = vLiquidaPrecinto.placa!;
    transporteController.text = vLiquidaPrecinto.empresaTransporte!;
  }

  List<SpCreateLiquidaListaPrecinto> parserListaPrecintos() {
    List<SpCreateLiquidaListaPrecinto> createListaPrecinto = [];

    for (int count = 0; count < listaPrecintos.length; count++) {
      SpCreateLiquidaListaPrecinto aux = SpCreateLiquidaListaPrecinto();
      aux.tipoPrecinto = listaPrecintos[count].tipoPrecinto;
      aux.codigoPrecinto = listaPrecintos[count].codigoPrecinto;
      createListaPrecinto.add(aux);
    }
    return createListaPrecinto;
  }

  createPrecintos() {
    List<SpCreateLiquidaListaPrecinto> createListaPrecinto = [];

    createListaPrecinto = parserListaPrecintos();

    precintadoLiquidaService.createLiquidaPrecinto(SpCreateLiquidaPrecintados(
        spCreateLiquidaPrecintos: SpCreateLiquidaPrecintos(
            jornada: widget.jornada,
            fecha: DateTime.now(),
            idCarguio: idCarguio,
            idUsuario: widget.idUsuario,
            idServiceOrder: widget.idServiceOrder),
        spCreateLiquidaListaPrecintos: createListaPrecinto));
  }

  addValvulasIngresoItems(ValvulasIngreso item) {
    int contador = valvulasIngreso.length;
    contador++;
    item.id = contador;
    valvulasIngreso.add(item);
  }

  addValvulasSalidaItems(ValvulasSalida item) {
    int contador = valvulasSalida.length;
    contador++;
    item.id = contador;
    valvulasSalida.add(item);
  }

  final TextEditingController placaController = TextEditingController();
  final TextEditingController cisternaController = TextEditingController();
  final TextEditingController transporteController = TextEditingController();

  final TextEditingController cantidadValvulaIngresoController =
      TextEditingController();
  final TextEditingController nombreValvulaIngresoController =
      TextEditingController();
  final TextEditingController cantidadValvulaSalidaController =
      TextEditingController();
  final TextEditingController nombreValvulaSalidaController =
      TextEditingController();

  final TextEditingController cantidadToldoController = TextEditingController();
  final TextEditingController nombreToldoController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getListaPrecintos();

    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text("PRECINTADO"),
            bottom: TabBar(
                indicatorColor: kColorCeleste,
                labelColor: kColorCeleste,
                unselectedLabelColor: Colors.white,
                controller: _tabController,
                tabs: const [
                  Tab(text: 'Lista Precintos'),
                  Tab(text: 'Precintado'),
                ]),
          ),
          body: TabBarView(
            controller: _tabController,
            children: [
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(children: [
                    SizedBox(
                      height: 700,
                      child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: listLiquidaPrecinto.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onLongPress: () {
                                getPrecintosById(
                                    listLiquidaPrecinto[index].idCarguio!);
                                _tabController
                                    .animateTo((_tabController.index = 1));
                              },
                              child: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                borderOnForeground: true,
                                margin: const EdgeInsets.all(10),
                                color: Colors.white,
                                shadowColor: Colors.grey,
                                elevation: 10,
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: SizedBox(
                                    //height: 240.0,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Row(
                                          children: [
                                            const Icon(Icons.receipt),
                                            const SizedBox(
                                              width: 10.0,
                                            ),
                                            Text(
                                              listLiquidaPrecinto[index]
                                                  .idServiceOrder
                                                  .toString(),
                                              style: tituloCardDamage,
                                            ),
                                          ],
                                        ),
                                        const Divider(),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "N°: ",
                                              style: etiquetasCardDamage,
                                            ),
                                            Text(
                                              listLiquidaPrecinto[index]
                                                  .idVista
                                                  .toString(),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Placa: ",
                                              style: etiquetasCardDamage,
                                            ),
                                            Text(
                                              listLiquidaPrecinto[index]
                                                  .placa
                                                  .toString(),
                                            )
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Cisterna: ",
                                              style: etiquetasCardDamage,
                                            ),
                                            Text(
                                              listLiquidaPrecinto[index]
                                                  .cisterna
                                                  .toString(),
                                            )
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Transporte: ",
                                              style: etiquetasCardDamage,
                                            ),
                                            Text(
                                              listLiquidaPrecinto[index]
                                                  .empresaTransporte
                                                  .toString(),
                                            )
                                          ],
                                        ),
                                        const Divider(),
                                        Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              IconButton(
                                                icon: const Icon(
                                                  Icons.delete,
                                                  color: Colors.grey,
                                                ),
                                                onPressed: () {
                                                  /*    dialogoEliminar(
                                                      context, allDR[index]); */
                                                },
                                              ),
                                            ]),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
                    const SizedBox(height: 20),
                    MaterialButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      minWidth: double.infinity,
                      height: 50.0,
                      color: kColorNaranja,
                      onPressed: () async {},
                      child: const Text(
                        "Lista de Equipos",
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
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          prefixIcon: Icon(
                            Icons.directions_boat,
                            color: kColorAzul,
                          ),
                          labelText: 'Placa',
                          labelStyle: TextStyle(
                            color: kColorAzul,
                            fontSize: 20.0,
                          ),
                          hintText: '',
                        ),
                        controller: placaController,
                        enabled: false,
                      ),
                      const SizedBox(height: 20.0),
                      TextFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          prefixIcon: Icon(
                            Icons.directions_boat,
                            color: kColorAzul,
                          ),
                          labelText: 'Cisterna',
                          labelStyle: TextStyle(
                            color: kColorAzul,
                            fontSize: 20.0,
                          ),
                          hintText: '',
                        ),
                        controller: cisternaController,
                        enabled: false,
                      ),
                      const SizedBox(height: 20.0),
                      TextFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          prefixIcon: Icon(
                            Icons.directions_boat,
                            color: kColorAzul,
                          ),
                          labelText: 'Transporte',
                          labelStyle: TextStyle(
                            color: kColorAzul,
                            fontSize: 20.0,
                          ),
                          hintText: '',
                        ),
                        controller: transporteController,
                        enabled: false,
                      ),
                      const SizedBox(height: 20),
                      Container(
                        height: 40,
                        color: kColorAzul,
                        child: const Center(
                          child: Text("VALVULAS DE INGRESO",
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
                          prefixIcon: Icon(
                            Icons.directions_boat,
                            color: kColorAzul,
                          ),
                          labelText: 'Nº de Precinto Valvulas de Ingreso',
                          labelStyle: TextStyle(
                            color: kColorAzul,
                            fontSize: 20.0,
                          ),
                          hintText: '',
                        ),
                        controller: cantidadValvulaIngresoController,
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
                          labelText: 'Nombre de Valvula de Ingreso',
                          labelStyle: TextStyle(
                            color: kColorAzul,
                            fontSize: 20.0,
                          ),
                          hintText: '',
                        ),
                        controller: nombreValvulaIngresoController,
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
                          if (valvulasIngreso.length <
                              int.parse(
                                  cantidadValvulaIngresoController.text)) {
                            listaPrecintos.add(ListaLiquidaPrecintos(
                                tipoPrecinto: "Valvula de Ingreso",
                                codigoPrecinto:
                                    nombreValvulaIngresoController.text));
                            setState(() {
                              ValvulasIngreso item = ValvulasIngreso();
                              item.valvulasIngreso =
                                  nombreValvulaIngresoController.text;
                              addValvulasIngresoItems(item);
                              nombreValvulaIngresoController.clear();
                            });
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                                  "Solo se puede agregar ${cantidadValvulaIngresoController.text} datos"),
                              backgroundColor: Colors.redAccent,
                            ));
                          }
                        },
                        child: const Text(
                          "Agregar",
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.5),
                        ),
                      ),
                      const SizedBox(height: 20),
                      DataTable(
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
                        dataRowColor: MaterialStateProperty.all(Colors.white),
                        columns: const <DataColumn>[
                          DataColumn(
                            label: Text("Nº"),
                          ),
                          DataColumn(
                            label: Text("Valvulas Ingreso"),
                          ),
                        ],
                        rows: valvulasIngreso
                            .map(((e) => DataRow(
                                  cells: <DataCell>[
                                    DataCell(
                                      Text(e.id.toString()),
                                    ),
                                    DataCell(
                                      Text(e.valvulasIngreso.toString()),
                                    ),
                                  ],
                                )))
                            .toList(),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        height: 40,
                        color: kColorAzul,
                        child: const Center(
                          child: Text("VALVULAS DE SALIDA",
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
                          prefixIcon: Icon(
                            Icons.directions_boat,
                            color: kColorAzul,
                          ),
                          labelText: 'Cantidad',
                          labelStyle: TextStyle(
                            color: kColorAzul,
                            fontSize: 20.0,
                          ),
                          hintText: '',
                        ),
                        controller: cantidadValvulaSalidaController,
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
                          labelText: 'Nombre de Valvula de Salida',
                          labelStyle: TextStyle(
                            color: kColorAzul,
                            fontSize: 20.0,
                          ),
                          hintText: '',
                        ),
                        controller: nombreValvulaSalidaController,
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
                          if (valvulasSalida.length <
                              int.parse(cantidadValvulaSalidaController.text)) {
                            listaPrecintos.add(ListaLiquidaPrecintos(
                                tipoPrecinto: "Valvula de Salida",
                                codigoPrecinto:
                                    nombreValvulaSalidaController.text));
                            setState(() {
                              ValvulasSalida item = ValvulasSalida();
                              item.valvulasSalida =
                                  nombreValvulaSalidaController.text;
                              addValvulasSalidaItems(item);
                              nombreValvulaSalidaController.clear();
                            });
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                                  "Solo se puede agregar ${nombreValvulaSalidaController.text} datos"),
                              backgroundColor: Colors.redAccent,
                            ));
                          }
                        },
                        child: const Text(
                          "Agregar",
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.5),
                        ),
                      ),
                      const SizedBox(height: 20),
                      DataTable(
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
                        /* headingRowColor: MaterialStateColor.resolveWith(
                          (states) {
                            return kColorAzul;
                          },
                        ), */
                        dataRowColor: MaterialStateProperty.all(Colors.white),
                        columns: const <DataColumn>[
                          DataColumn(
                            label: Text("Nº"),
                          ),
                          DataColumn(
                            label: Text("Valvulas Salida"),
                          ),
                        ],
                        rows: valvulasSalida
                            .map(((e) => DataRow(
                                  cells: <DataCell>[
                                    DataCell(
                                      Text(e.id.toString()),
                                    ),
                                    DataCell(
                                      Text(e.valvulasSalida.toString()),
                                    ),
                                  ],
                                )))
                            .toList(),
                      ),
                      const SizedBox(height: 20),
                      MaterialButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        minWidth: double.infinity,
                        height: 50.0,
                        color: kColorNaranja,
                        onPressed: () async {
                          await createPrecintos();
                          placaController.clear();
                          cisternaController.clear();
                          transporteController.clear();
                          setState(() {
                            cantidadValvulaIngresoController.clear();
                            cantidadValvulaSalidaController.clear();
                            cantidadToldoController.clear();
                            valvulasIngreso.clear();
                            valvulasSalida.clear();
                            listaPrecintos.clear();
                          });
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
                      const SizedBox(height: 20),
                      MaterialButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        minWidth: double.infinity,
                        height: 50.0,
                        color: kColorNaranja,
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const LiquidaPrecintadoPdf()));
                        },
                        child: const Text(
                          "Imprimir",
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
            ],
          ),
        ));
  }
}
