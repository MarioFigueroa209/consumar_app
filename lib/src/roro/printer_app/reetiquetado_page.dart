import 'package:barcode_widget/barcode_widget.dart';
import 'package:consumar_app/src/roro/printer_app/print_page.dart';
import 'package:consumar_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:printing/printing.dart';

class ReetiquetadoPage extends StatefulWidget {
  const ReetiquetadoPage({super.key, required this.idPendientes, required this.chassis});

  final int idPendientes;
  final String chassis;
  
  @override
  State<ReetiquetadoPage> createState() => _ReetiquetadoPageState();
}

class _ReetiquetadoPageState extends State<ReetiquetadoPage> {

    final qrController = TextEditingController();
  final chasisController = TextEditingController();
  final marcaController = TextEditingController();
  final modeloController = TextEditingController();
  final detalleController = TextEditingController();

  final codigoQr = imageFromAssetBundle('assets/images/qrlogo.png');

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    chasisController.text = widget.chassis;
    String textoQr = widget.idPendientes.toString();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text(
          "ETIQUETADO",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(children: [
            BarcodeWidget(
              barcode: Barcode.qrCode(),
              data: textoQr,
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                prefixIcon: Icon(
                  Icons.calendar_month,
                  color: kColorAzul,
                ),
                labelText: 'Chasis',
                labelStyle: TextStyle(
                  color: kColorAzul,
                  //fontSize: 20.0,
                ),
              ),
              controller: chasisController,
              style: TextStyle(
                color: kColorAzul,
                fontSize: 20.0,
              ),
              enabled: false,
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
               
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PrintPage(widget.idPendientes)));
                /*     Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => QrRoroPDF(
                            idVehicle:
                                insertPrinterAppPendientes.idVehiculo!))); */
              },
              child: const Text(
                "ETIQUETAR",
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