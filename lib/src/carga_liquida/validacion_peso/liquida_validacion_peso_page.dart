import 'package:flutter/material.dart';

import '../../../models/carga_liquida/recepcionAlmacen/vw_lectura_by_qrCarguio_liquida.dart';
import '../../../models/carga_liquida/validacionPeso/sp_create_liquida_validacion_peso.dart';
import '../../../models/carga_liquida/validacionPeso/vw_lista_liquida_pesos_historicos.dart';
import '../../../services/carga_liquida/liquida_recepcion_almacen_service.dart';
import '../../../services/carga_liquida/liquida_validacion_pesos_service.dart';
import '../../../utils/constants.dart';
import '../../../utils/lists.dart';
import '../../scanner_screen.dart';

class LiquidaValidacionPeso extends StatefulWidget {
  const LiquidaValidacionPeso(
      {super.key,
      required this.jornada,
      required this.idUsuario,
      required this.idServiceOrder});
  final int jornada;
  final int idUsuario;
  final int idServiceOrder;

  @override
  State<LiquidaValidacionPeso> createState() => _LiquidaValidacionPesoState();
}

class _LiquidaValidacionPesoState extends State<LiquidaValidacionPeso> {
  LiquidaRegistroAlmacenService liquidaRegistroAlmacenService =
      LiquidaRegistroAlmacenService();

  LiquidaValidacionPesosService liquidaValidacionPesosService =
      LiquidaValidacionPesosService();

  VwLecturaByQrCarguioLiquida vwLecturaByQrCarguio =
      VwLecturaByQrCarguioLiquida();

  Future<List<VwListaLiquidaPesosHistoricos>>? futureVwListaPesosHistoricos;

  String _valueDestinoDropdown = 'Seleccione el Destino';
  String _valueFacturaDropdown = 'Seleccione la Factura';

  final placaController = TextEditingController();
  final productoController = TextEditingController();
  final cisternaController = TextEditingController();
  final transporteController = TextEditingController();
  final codPrecintadoController = TextEditingController();

  final nTicketController = TextEditingController();
  final pesoBrutoController = TextEditingController();
  final taraCamionController = TextEditingController();
  final pesoNetoController = TextEditingController();

  late int idCarguio;
  late int idPrecinto;

  getLecturaByQrCarguio() async {
    VwLecturaByQrCarguioLiquida vwLecturaByQrCarguio =
        VwLecturaByQrCarguioLiquida();

    vwLecturaByQrCarguio = await liquidaRegistroAlmacenService
        .getLecturaByQrCarguio(codPrecintadoController.text);

    idCarguio = vwLecturaByQrCarguio.idCarguio!;
    idPrecinto = vwLecturaByQrCarguio.idPrecintado!;
    placaController.text = vwLecturaByQrCarguio.placa!;
    cisternaController.text = vwLecturaByQrCarguio.cisterna!;
    transporteController.text = vwLecturaByQrCarguio.empresaTransporte!;
  }

  obtenerPesosHistorico() {
    futureVwListaPesosHistoricos =
        liquidaValidacionPesosService.getPesosHistoricosProducto("ACEITE");
  }

  createValidacionPeso() {
    liquidaValidacionPesosService.createValidacionPeso(
        SpCreateLiquidaValidacionPeso(
            jornada: widget.jornada,
            fecha: DateTime.now(),
            idPrecintado: idPrecinto,
            nTicket: nTicketController.text,
            taraCamion: double.parse(taraCamionController.text),
            pesoBruto: double.parse(pesoBrutoController.text),
            pesoNeto: double.parse(pesoNetoController.text),
            factura: _valueFacturaDropdown,
            destino: _valueDestinoDropdown,
            idCarguio: idCarguio,
            idServiceOrder: widget.idServiceOrder,
            idUsuario: widget.idUsuario));
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text("Datos registrados correctamente"),
      backgroundColor: Colors.greenAccent,
    ));
    clearFields();
  }

  clearFields() {
    codPrecintadoController.clear();
    placaController.clear();
    cisternaController.clear();
    transporteController.clear();

    pesoBrutoController.clear();
    taraCamionController.clear();
    pesoNetoController.clear();

    nTicketController.clear();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    obtenerPesosHistorico();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('VALIDACION PESO'),
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
                  prefixIcon: IconButton(
                      icon: const Icon(Icons.closed_caption_off_rounded),
                      onPressed: () async {
                        final result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ScannerScreen()));
                        codPrecintadoController.text = result;
                      }),
                  suffixIcon: IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: () {
                        getLecturaByQrCarguio();
                      }),
                  labelText: 'Codigo',
                  labelStyle: TextStyle(
                    color: kColorAzul,
                    fontSize: 20.0,
                  ),
                  hintText: 'Ingrese el Codigo'),
              onChanged: (value) {
                getLecturaByQrCarguio();
              },
              controller: codPrecintadoController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, ingrese el Codigo';
                }
                return null;
              },
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
                labelText: 'Placa',
                labelStyle: TextStyle(
                  color: kColorAzul,
                  fontSize: 20.0,
                ),
                hintText: '',
              ),
              controller: placaController,
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
                labelText: 'Cisterna',
                labelStyle: TextStyle(
                  color: kColorAzul,
                  fontSize: 20.0,
                ),
                hintText: '',
              ),
              controller: cisternaController,
            ),
            const SizedBox(height: 20.0),
            TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                prefixIcon: Icon(
                  Icons.car_repair,
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
            const SizedBox(height: 20.0),
            TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                prefixIcon: Icon(
                  Icons.production_quantity_limits,
                  color: kColorAzul,
                ),
                labelText: 'Producto',
                labelStyle: TextStyle(
                  color: kColorAzul,
                  fontSize: 20.0,
                ),
                hintText: '',
              ),
              controller: productoController,
              enabled: false,
            ),
            const SizedBox(
              height: 20.0,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: FutureBuilder<List<VwListaLiquidaPesosHistoricos>>(
                    future: futureVwListaPesosHistoricos,
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(child: CircularProgressIndicator());
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
                              fontWeight: FontWeight.bold, color: kColorAzul),
                          columns: const <DataColumn>[
                            DataColumn(
                              label: Text("Peso Bruto"),
                            ),
                            DataColumn(
                              label: Text("Tara Camion"),
                            ),
                            DataColumn(
                              label: Text("Peso Neto"),
                            ),
                          ],
                          rows: snapshot.data!
                              .map(((e) => DataRow(
                                    onLongPress: () {},
                                    cells: <DataCell>[
                                      DataCell(Text(e.pesoBruto.toString())),
                                      DataCell(Text(e.taraCamion.toString(),
                                          textAlign: TextAlign.center)),
                                      DataCell(Text(e.pesoNeto.toString(),
                                          textAlign: TextAlign.center)),
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
                labelText: 'Nº Ticket',
                labelStyle: TextStyle(
                  color: kColorAzul,
                  fontSize: 20.0,
                ),
                hintText: '',
              ),
              controller: nTicketController,
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
                labelText: 'Peso Bruto',
                labelStyle: TextStyle(
                  color: kColorAzul,
                  fontSize: 20.0,
                ),
                hintText: '',
              ),
              controller: pesoBrutoController,
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
                labelText: 'Tara camion',
                labelStyle: TextStyle(
                  color: kColorAzul,
                  fontSize: 20.0,
                ),
                hintText: '',
              ),
              controller: taraCamionController,
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
                labelText: 'Peso neto',
                labelStyle: TextStyle(
                  color: kColorAzul,
                  fontSize: 20.0,
                ),
                hintText: '',
              ),
              controller: pesoNetoController,
            ),
            const SizedBox(
              height: 20,
            ),
            DropdownButtonFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                labelText: 'Factura',
                labelStyle: TextStyle(
                  color: kColorAzul,
                  fontSize: 20.0,
                ),
              ),
              icon: const Icon(
                Icons.arrow_drop_down_circle_outlined,
              ),
              items: listaFactura.map((String a) {
                return DropdownMenuItem<String>(
                  value: a,
                  child: Center(child: Text(a, textAlign: TextAlign.left)),
                );
              }).toList(),
              onChanged: (value) => {
                setState(() {
                  _valueFacturaDropdown = value as String;
                })
              },
              validator: (value) {
                if (value != _valueFacturaDropdown) {
                  return 'Por favor, elige la factura';
                }
                return null;
              },
              hint: Text(_valueFacturaDropdown),
            ),
            const SizedBox(height: 20.0),
            DropdownButtonFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                labelText: 'Destino',
                labelStyle: TextStyle(
                  color: kColorAzul,
                  fontSize: 20.0,
                ),
              ),
              icon: const Icon(
                Icons.arrow_drop_down_circle_outlined,
              ),
              items: listaDestino.map((String a) {
                return DropdownMenuItem<String>(
                  value: a,
                  child: Center(child: Text(a, textAlign: TextAlign.left)),
                );
              }).toList(),
              onChanged: (value) => {
                setState(() {
                  _valueDestinoDropdown = value as String;
                })
              },
              validator: (value) {
                if (value != _valueDestinoDropdown) {
                  return 'Por favor, elige el destino';
                }
                return null;
              },
              hint: Text(_valueDestinoDropdown),
            ),
            const SizedBox(height: 20.0),
            MaterialButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              minWidth: double.infinity,
              height: 50.0,
              color: kColorNaranja,
              onPressed: () {
                createValidacionPeso();
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
}
