import 'package:flutter/material.dart';

import '../../../models/survey/RecepcionAlmacen/sp_create_recepcion_almacen.dart';
import '../../../services/survey/registro_almacen_service.dart';
import '../../../utils/constants.dart';

class GranelCreateRecepcionAlmacen extends StatefulWidget {
  const GranelCreateRecepcionAlmacen(
      {super.key,
      required this.jornada,
      required this.idUsuario,
      required this.idCarguio,
      required this.idPrecinto,
      required this.idServiceOrder});
  final int jornada;
  final int idUsuario;
  final int idCarguio;
  final int idPrecinto;
  final int idServiceOrder;

  @override
  State<GranelCreateRecepcionAlmacen> createState() =>
      _GranelCreateRecepcionAlmacenState();
}

class _GranelCreateRecepcionAlmacenState
    extends State<GranelCreateRecepcionAlmacen> {
  final pesoBrutoController = TextEditingController();
  final taraCamionController = TextEditingController();
  final pesoNetoController = TextEditingController();

  RegistroAlmacenService registroAlmacenService = RegistroAlmacenService();

  createRegistroAlmacen() {
    registroAlmacenService.createRecepcionAlmacen(SpCreateRecepcionAlmacen(
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
