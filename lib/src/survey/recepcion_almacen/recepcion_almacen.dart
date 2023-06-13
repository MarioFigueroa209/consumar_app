import 'package:flutter/material.dart';
import '../../../models/survey/RecepcionAlmacen/sp_create_recepcion_almacen.dart';
import '../../../models/survey/RecepcionAlmacen/vw_lectura_by_qr_carguio.dart';
import '../../../models/survey/RecepcionAlmacen/vw_lista_precinto_by_id_precinto.dart';
import '../../../models/survey/ValidacionPesos/sp_create_peso_historico.dart';
import '../../../services/survey/registro_almacen_service.dart';
import '../../../services/survey/validacion_pesos_service.dart';
import '../../../utils/constants.dart';
import '../../scanner_screen.dart';

class RecepcionAlmacen extends StatefulWidget {
  const RecepcionAlmacen(
      {Key? key,
      required this.jornada,
      required this.idUsuario,
      required this.idServiceOrder})
      : super(key: key);
  final int jornada;
  final int idUsuario;
  final int idServiceOrder;

  @override
  State<RecepcionAlmacen> createState() => _RecepcionAlmacenState();
}

class _RecepcionAlmacenState extends State<RecepcionAlmacen> {
  RegistroAlmacenService registroAlmacenService = RegistroAlmacenService();

  ValidacionPesosService validacionPesosService = ValidacionPesosService();

  VwLecturaByQrCarguio vwLecturaByQrCarguio = VwLecturaByQrCarguio();

  List<VwListaPrecintoByIdPrecinto> vwListaPrecintoByIdPrecinto = [];

  late int idCarguio;
  late int idPrecinto;

  final codPrecintadoController = TextEditingController();

  final placaController = TextEditingController();
  final tolvaController = TextEditingController();
  final transporteController = TextEditingController();

  final pesoBrutoController = TextEditingController();
  final taraCamionController = TextEditingController();
  final pesoNetoController = TextEditingController();

  final compuertaTolvaController = TextEditingController();
  final cajaComandoController = TextEditingController();
  final toldoController = TextEditingController();

  final codigoCompuertaTolvaController = TextEditingController();
  final codigoCajaComandoController = TextEditingController();
  final codigoToldoController = TextEditingController();

  createRegistroAlmacen() {
    registroAlmacenService.createRecepcionAlmacen(SpCreateRecepcionAlmacen(
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
  }

  createPesoHistorico() {
    validacionPesosService.createPesoHistorico(SpCreatePesoHistorico(
        pesoBruto: double.parse(pesoBrutoController.text),
        taraCamion: double.parse(taraCamionController.text),
        pesoNeto: double.parse(pesoNetoController.text),
        producto: "MAIZ"));
  }

  getLecturaByQrCarguio() async {
    vwLecturaByQrCarguio = await registroAlmacenService
        .getLecturaByQrCarguio(codPrecintadoController.text);

    idCarguio = vwLecturaByQrCarguio.idCarguio!;
    idPrecinto = vwLecturaByQrCarguio.idPrecintado!;
    placaController.text = vwLecturaByQrCarguio.placa!;
    tolvaController.text = vwLecturaByQrCarguio.tolva!;
    transporteController.text = vwLecturaByQrCarguio.empresaTransporte!;
  }

  getListaPrecintoByIdPrecinto(String codPrecinto, String tipoPrecinto) async {
    List<VwListaPrecintoByIdPrecinto> value =
        await registroAlmacenService.getListaPrecintoByIdPrecinto(
            codPrecintadoController.text, codPrecinto, tipoPrecinto);

    setState(() {
      vwListaPrecintoByIdPrecinto = value;
    });

    //debugPrint(vwListaPrecintoByIdPrecinto.length as String?);

    if (vwListaPrecintoByIdPrecinto.isNotEmpty) {
      //if (context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
            "Registros Encontrados ${vwListaPrecintoByIdPrecinto[0].codigoPrecinto}"),
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
                  labelText: 'Tolva',
                  labelStyle: TextStyle(
                    color: kColorAzul,
                    fontSize: 20.0,
                  ),
                  hintText: '',
                ),
                controller: tolvaController,
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
                  labelText: 'Compuerta de tolva',
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
                            compuertaTolvaController.text = result;
                          }),
                      suffixIcon: IconButton(
                          icon: const Icon(Icons.search),
                          onPressed: () {
                            getListaPrecintoByIdPrecinto(
                                compuertaTolvaController.text,
                                "COMPUERTA TOLVA");
                          }),
                      labelStyle: TextStyle(
                        color: kColorAzul,
                        fontSize: 20.0,
                      ),
                      hintText: 'Ingrese compuerta de tolva'),
                  onChanged: (value) {
                    getListaPrecintoByIdPrecinto(
                        compuertaTolvaController.text, "COMPUERTA TOLVA");
                  },
                  controller: compuertaTolvaController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, ingrese compuerta de tolva';
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
                  labelText: 'Caja de comando hidraulica',
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
                            cajaComandoController.text = result;
                          }),
                      suffixIcon: IconButton(
                          icon: const Icon(Icons.search),
                          onPressed: () {
                            getListaPrecintoByIdPrecinto(
                                cajaComandoController.text,
                                "CAJA DE COMANDO HIDRAULICA");
                          }),
                      labelStyle: TextStyle(
                        color: kColorAzul,
                        fontSize: 20.0,
                      ),
                      hintText: 'Ingrese Caja de comando hidraulica'),
                  onChanged: (value) {
                    getListaPrecintoByIdPrecinto(cajaComandoController.text,
                        "CAJA DE COMANDO HIDRAULICA");
                  },
                  controller: cajaComandoController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, ingrese Caja de comando hidraulica';
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
                  labelText: 'Toldo',
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
                            toldoController.text = result;
                          }),
                      suffixIcon: IconButton(
                          icon: const Icon(Icons.search),
                          onPressed: () {
                            getListaPrecintoByIdPrecinto(
                                toldoController.text, "TOLDO");
                          }),
                      labelStyle: TextStyle(
                        color: kColorAzul,
                        fontSize: 20.0,
                      ),
                      hintText: 'Ingrese Toldo'),
                  onChanged: (value) {
                    getListaPrecintoByIdPrecinto(toldoController.text, "TOLDO");
                  },
                  controller: toldoController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, ingrese Toldo';
                    }
                    return null;
                  },
                  enabled: enableQrUsuario),
              const SizedBox(height: 20.0),
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
