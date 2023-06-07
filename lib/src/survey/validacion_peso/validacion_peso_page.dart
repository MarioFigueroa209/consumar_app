import 'package:flutter/material.dart';

import '../../../models/survey/RecepcionAlmacen/vw_lectura_by_qr_carguio.dart';
import '../../../models/survey/ValidacionPesos/sp_create_validacion_peso.dart';
import '../../../models/survey/ValidacionPesos/vw_lista_pesos_historicos.dart';
import '../../../services/survey/registro_almacen_service.dart';
import '../../../services/survey/validacion_pesos_service.dart';
import '../../../utils/constants.dart';
import '../../../utils/lists.dart';
import '../../scanner_screen.dart';

class ValidacionPeso extends StatefulWidget {
  const ValidacionPeso(
      {Key? key,
      required this.jornada,
      required this.idUsuario,
      required this.idServiceOrder})
      : super(key: key);
  final int jornada;
  final int idUsuario;
  final int idServiceOrder;

  @override
  State<ValidacionPeso> createState() => _ValidacionPesoState();
}

class _ValidacionPesoState extends State<ValidacionPeso> {
  RegistroAlmacenService registroAlmacenService = RegistroAlmacenService();
  ValidacionPesosService validacionPesosService = ValidacionPesosService();
  VwLecturaByQrCarguio vwLecturaByQrCarguio = VwLecturaByQrCarguio();

  Future<List<VwListaPesosHistoricos>>? futureVwListaPesosHistoricos;

  String _valueDestinoDropdown = 'Seleccione el Destino';
  String _valueFacturaDropdown = 'Seleccione la Factura';

  final placaController = TextEditingController();
  final productoController = TextEditingController();
  final tolvaController = TextEditingController();
  final transporteController = TextEditingController();
  final codPrecintadoController = TextEditingController();

  final nTicketController = TextEditingController();
  final pesoBrutoController = TextEditingController();
  final taraCamionController = TextEditingController();
  final pesoNetoController = TextEditingController();

  late int idCarguio;
  late int idPrecinto;

  getLecturaByQrCarguio() async {
    VwLecturaByQrCarguio vwLecturaByQrCarguio = VwLecturaByQrCarguio();

    vwLecturaByQrCarguio = await registroAlmacenService
        .getLecturaByQrCarguio(codPrecintadoController.text);

    idCarguio = vwLecturaByQrCarguio.idCarguio!;
    idPrecinto = vwLecturaByQrCarguio.idPrecintado!;
    placaController.text = vwLecturaByQrCarguio.placa!;
    tolvaController.text = vwLecturaByQrCarguio.tolva!;
    transporteController.text = vwLecturaByQrCarguio.empresaTransporte!;
  }

  obtenerPesosHistorico() {
    futureVwListaPesosHistoricos =
        validacionPesosService.getPesosHistoricosProducto("MAIZ");
  }

  createValidacionPeso() {
    validacionPesosService.createValidacionPeso(SpCreateValidacionPeso(
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
        title: const Text('VALIDACION PESO'),
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
                labelText: 'Tolva',
                labelStyle: TextStyle(
                  color: kColorAzul,
                  fontSize: 20.0,
                ),
                hintText: '',
              ),
              controller: tolvaController,
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
                child: FutureBuilder<List<VwListaPesosHistoricos>>(
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
