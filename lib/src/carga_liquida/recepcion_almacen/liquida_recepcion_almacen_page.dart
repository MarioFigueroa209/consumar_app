import 'package:flutter/material.dart';

import '../../../models/carga_liquida/recepcionAlmacen/create_recepcion_liquida_almacen.dart';
import '../../../models/carga_liquida/recepcionAlmacen/vw_lectura_by_qrCarguio_liquida.dart';
import '../../../models/carga_liquida/recepcionAlmacen/vw_listaPrecinto_liquida_by_idPrecinto.dart';
import '../../../models/carga_liquida/validacionPeso/sp_create_liquida_peso_historico.dart';
import '../../../services/carga_liquida/liquida_recepcion_almacen_service.dart';
import '../../../services/carga_liquida/liquida_validacion_pesos_service.dart';
import '../../../utils/constants.dart';
import '../../scanner_screen.dart';

class LiquidaRecepcionAlmacen extends StatefulWidget {
  const LiquidaRecepcionAlmacen(
      {super.key,
      required this.jornada,
      required this.idUsuario,
      required this.idServiceOrder});
  final int jornada;
  final int idUsuario;
  final int idServiceOrder;

  @override
  State<LiquidaRecepcionAlmacen> createState() =>
      _LiquidaRecepcionAlmacenState();
}

class _LiquidaRecepcionAlmacenState extends State<LiquidaRecepcionAlmacen> {
  LiquidaRegistroAlmacenService liquidaRegistroAlmacenService =
      LiquidaRegistroAlmacenService();

  LiquidaValidacionPesosService liquidaValidacionPesosService =
      LiquidaValidacionPesosService();

  VwLecturaByQrCarguioLiquida vwLecturaByQrCarguio =
      VwLecturaByQrCarguioLiquida();

  List<VwListaPrecintoLiquidaByIdPrecinto> vwListaPrecintoLiquidaByIdPrecinto =
      [];

  late int idCarguio;
  late int idPrecinto;

  final codPrecintadoController = TextEditingController();

  final placaController = TextEditingController();
  final cisternaController = TextEditingController();
  final transporteController = TextEditingController();

  final pesoBrutoController = TextEditingController();
  final taraCamionController = TextEditingController();
  final pesoNetoController = TextEditingController();

  final valvulaIngresoController = TextEditingController();
  final valvulaSalidaController = TextEditingController();
  final toldoController = TextEditingController();

  createRegistroAlmacen() {
    liquidaRegistroAlmacenService
        .createRecepcionAlmacen(CreateRecepcionLiquidaAlmacen(
      jornada: widget.jornada,
      fecha: DateTime.now(),
      pesoBruto: double.parse(pesoBrutoController.text),
      taraCamion: double.parse(taraCamionController.text),
      pesoNeto: double.parse(pesoNetoController.text),
      idServiceOrder: widget.idServiceOrder,
      idUsuario: widget.idUsuario,
      idCarguio: idCarguio,
      idPrecintado: idPrecinto,
    ));
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text("Datos registrados correctamente"),
      backgroundColor: Colors.greenAccent,
    ));
    clearFields();
  }

  createPesoHistorico() {
    liquidaValidacionPesosService.createPesoHistorico(
        SpCreateLiquidaPesoHistorico(
            pesoBruto: double.parse(pesoBrutoController.text),
            taraCamion: double.parse(taraCamionController.text),
            pesoNeto: double.parse(pesoNetoController.text),
            producto: "ACEITE"));
  }

  getLecturaByQrCarguio() async {
    vwLecturaByQrCarguio = await liquidaRegistroAlmacenService
        .getLecturaByQrCarguio(codPrecintadoController.text);

    idCarguio = vwLecturaByQrCarguio.idCarguio!;
    idPrecinto = vwLecturaByQrCarguio.idPrecintado!;
    placaController.text = vwLecturaByQrCarguio.placa!;
    cisternaController.text = vwLecturaByQrCarguio.cisterna!;
    transporteController.text = vwLecturaByQrCarguio.empresaTransporte!;
  }

  clearFields() {
    codPrecintadoController.clear();
    placaController.clear();
    cisternaController.clear();
    transporteController.clear();

    pesoBrutoController.clear();
    taraCamionController.clear();
    pesoNetoController.clear();

    valvulaIngresoController.clear();
    valvulaSalidaController.clear();
    toldoController.clear();
  }

  getListaPrecintoByIdPrecinto(String codPrecinto, String tipoPrecinto) async {
    List<VwListaPrecintoLiquidaByIdPrecinto> value =
        await liquidaRegistroAlmacenService.getListaPrecintoByIdPrecinto(
            codPrecintadoController.text, codPrecinto, tipoPrecinto);

    setState(() {
      vwListaPrecintoLiquidaByIdPrecinto = value;
    });

    print(vwListaPrecintoLiquidaByIdPrecinto.length);

    if (vwListaPrecintoLiquidaByIdPrecinto.length != 0) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
            "Registros Encontrados ${vwListaPrecintoLiquidaByIdPrecinto[0].codigoPrecinto}"),
        backgroundColor: Colors.greenAccent,
      ));
    } /* else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Registro no encontrado"),
        backgroundColor: Colors.redAccent,
      ));
    } */
  }

  bool enableQrUsuario = true;
  final controllerSearchDR = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("RECEPCION ALMACEN"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
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
                                    builder: (context) =>
                                        const ScannerScreen()));
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
                  enabled: enableQrUsuario),
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
                  child: Text("PESO ALMACEN",
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
                  prefixIcon: Icon(
                    Icons.directions_boat,
                    color: kColorAzul,
                  ),
                  labelText: 'Peso bruto',
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
              const SizedBox(height: 20),
              Container(
                height: 40,
                color: kColorAzul,
                child: const Center(
                  child: Text("LECTURA DE PRECINTOS",
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
                  prefixIcon: Icon(
                    Icons.directions_boat,
                    color: kColorAzul,
                  ),
                  labelText: 'N° de precintos Valvula de ingreso ',
                  labelStyle: TextStyle(
                    color: kColorAzul,
                    fontSize: 20.0,
                  ),
                  hintText: '',
                ),
                enabled: false,
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
                                    builder: (context) =>
                                        const ScannerScreen()));
                            valvulaIngresoController.text = result;
                          }),
                      suffixIcon: IconButton(
                          icon: const Icon(Icons.search),
                          onPressed: () {
                            getListaPrecintoByIdPrecinto(
                                valvulaIngresoController.text,
                                "Valvula de ingreso");
                          }),
                      labelStyle: TextStyle(
                        color: kColorAzul,
                        fontSize: 20.0,
                      ),
                      hintText: 'Ingrese Valvula de ingreso'),
                  onChanged: (value) {
                    getListaPrecintoByIdPrecinto(
                        valvulaIngresoController.text, "Valvula de Ingreso");
                  },
                  controller: valvulaIngresoController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, ingrese valvula de Ingreso';
                    }
                    return null;
                  },
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
                  labelText: 'N° de precintos valvulas de salida',
                  labelStyle: TextStyle(
                    color: kColorAzul,
                    fontSize: 20.0,
                  ),
                  hintText: '',
                ),
                enabled: false,
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
                                    builder: (context) =>
                                        const ScannerScreen()));
                            valvulaSalidaController.text = result;
                          }),
                      suffixIcon: IconButton(
                          icon: const Icon(Icons.search),
                          onPressed: () {
                            getListaPrecintoByIdPrecinto(
                                valvulaSalidaController.text,
                                "Valvula de Salida");
                          }),
                      labelStyle: TextStyle(
                        color: kColorAzul,
                        fontSize: 20.0,
                      ),
                      hintText: 'Ingrese Caja Valvula de salida'),
                  onChanged: (value) {
                    getListaPrecintoByIdPrecinto(
                        valvulaSalidaController.text, "Valvula de Salida");
                  },
                  controller: valvulaSalidaController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, ingrese Valvula de salida';
                    }
                    return null;
                  },
                  enabled: enableQrUsuario),
              const SizedBox(height: 20),
              MaterialButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                minWidth: double.infinity,
                height: 50.0,
                color: kColorNaranja,
                onPressed: () {
                  createRegistroAlmacen();
                  createPesoHistorico();
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
        ),
      ),
    );
  }
}
