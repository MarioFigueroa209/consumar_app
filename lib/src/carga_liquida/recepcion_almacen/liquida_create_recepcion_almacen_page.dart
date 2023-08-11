import 'package:flutter/material.dart';

import '../../../models/carga_liquida/recepcionAlmacen/create_recepcion_liquida_almacen.dart';
import '../../../services/carga_liquida/liquida_recepcion_almacen_service.dart';
import '../../../utils/constants.dart';

class LiquidaCreateRecepcionAlmacen extends StatefulWidget {
  const LiquidaCreateRecepcionAlmacen(
      {super.key,
      required this.jornada,
      required this.idUsuario,
      required this.idServiceOrder,
      required this.idCarguio,
      required this.idPrecinto});
  final int jornada;
  final int idUsuario;
  final int idCarguio;
  final int idPrecinto;
  final int idServiceOrder;

  @override
  State<LiquidaCreateRecepcionAlmacen> createState() =>
      _LiquidaCreateRecepcionAlmacenState();
}

class _LiquidaCreateRecepcionAlmacenState
    extends State<LiquidaCreateRecepcionAlmacen> {
  final pesoBrutoController = TextEditingController();
  final taraCamionController = TextEditingController();
  final pesoNetoController = TextEditingController();

  LiquidaRegistroAlmacenService liquidaRegistroAlmacenService =
      LiquidaRegistroAlmacenService();

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
      idCarguio: widget.idCarguio,
      idPrecintado: widget.idPrecinto,
    ));
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text("Datos registrados correctamente"),
      backgroundColor: Colors.greenAccent,
    ));
  }

  clearFields() {
    pesoBrutoController.clear();
    taraCamionController.clear();
    pesoNetoController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("REGISTRAR RECEPCION ALMACEN"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(children: [
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
            MaterialButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              minWidth: double.infinity,
              height: 50.0,
              color: kColorNaranja,
              onPressed: () async {
                await createRegistroAlmacen();
                //await createPesoHistorico();
                clearFields();
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
