import 'package:barcode_widget/barcode_widget.dart';
import 'package:consumar_app/src/roro/printer_app/print_page.dart';
import 'package:flutter/material.dart';
import 'package:printing/printing.dart';

import '../../../models/roro/printer_app/create_sql_lite_printer_app.dart';
import '../../../models/roro/printer_app/insert_printer_app_pendientes.dart';
import '../../../utils/constants.dart';
import '../../../utils/roro/sqliteBD/db_printer_app.dart';
import 'printer_app_page.dart';
//import 'qr_pdf_page.dart';

class EtiquetadoPrinterApp extends StatefulWidget {
  const EtiquetadoPrinterApp(
      {Key? key,
      required this.jornada,
      required this.idUsuario,
      required this.idServiceOrder,
      required this.idPendientes})
      : super(key: key);

  final int jornada;
  final BigInt idUsuario;
  final BigInt idServiceOrder;
  final int idPendientes;

  @override
  State<EtiquetadoPrinterApp> createState() => _EtiquetadoPrinterAppState();
}

class _EtiquetadoPrinterAppState extends State<EtiquetadoPrinterApp> {
  final qrController = TextEditingController();
  final chasisController = TextEditingController();
  final marcaController = TextEditingController();
  final modeloController = TextEditingController();
  final detalleController = TextEditingController();

  final codigoQr = imageFromAssetBundle('assets/images/qrlogo.png');

  String textoQr = "QR ID VEHICLE";

  DbPrinterApp dbPrinterApp = DbPrinterApp();
  InsertPrinterAppPendientes insertPrinterAppPendientes =
      InsertPrinterAppPendientes();

  getPendienteByID() async {
    insertPrinterAppPendientes =
        await dbPrinterApp.getPrinterAppPendientesById(widget.idPendientes);
    // //print(insertPrinterAppPendientes.idPrinterAppPendientes);
    // //print(insertPrinterAppPendientes.estado);
    qrController.text = insertPrinterAppPendientes.idVehiculo.toString();
    setState(() {
      textoQr = qrController.text;
    });
    chasisController.text = insertPrinterAppPendientes.chasis!;
    marcaController.text = insertPrinterAppPendientes.marca!;
    modeloController.text = insertPrinterAppPendientes.modelo!;
    detalleController.text = insertPrinterAppPendientes.detalle!;
  }

  //Metodo para etiquetar los vehiculos

  createPrinterAppEtiquetado() {
    dbPrinterApp.createPrinterAppEtiquetado(CreateSqlLitePrinterApp(
        jornada: widget.jornada,
        idServiceOrder: int.parse(widget.idServiceOrder.toString()),
        idUsuarios: int.parse(widget.idUsuario.toString()),
        idVehicle: int.parse(qrController.text),
        chasis: chasisController.text,
        detalle: detalleController.text,
        estado: "etiquetado",
        marca: marcaController.text,
        modelo: modeloController.text));
    insertPrinterAppPendientes.estado = "etiquetado";
    dbPrinterApp.update(insertPrinterAppPendientes);
    //se setea nuevamente para obtener lista actualizada
  }

  @override
  void initState() {
    super.initState();
    getPendienteByID();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("ETIQUETADO"),
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
                  Icons.qr_code,
                  color: kColorAzul,
                ),
                labelText: 'QR',
                labelStyle: TextStyle(
                  color: kColorAzul,
                  //fontSize: 20.0,
                ),
              ),
              controller: qrController,
              onChanged: (value) {
                textoQr = value;
                setState(() {});
              },
              style: TextStyle(
                color: kColorAzul,
                fontSize: 20.0,
              ),
              enabled: false,
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
            TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                prefixIcon: Icon(
                  Icons.calendar_month,
                  color: kColorAzul,
                ),
                labelText: 'Marca',
                labelStyle: TextStyle(
                  color: kColorAzul,
                  //fontSize: 20.0,
                ),
              ),
              controller: marcaController,
              style: TextStyle(
                color: kColorAzul,
                fontSize: 20.0,
              ),
              enabled: false,
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
                labelText: 'Modelo',
                labelStyle: TextStyle(
                  color: kColorAzul,
                  //fontSize: 20.0,
                ),
              ),
              controller: modeloController,
              style: TextStyle(
                color: kColorAzul,
                fontSize: 20.0,
              ),
              enabled: false,
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
                labelText: 'Detalle',
                labelStyle: TextStyle(
                  color: kColorAzul,
                  //fontSize: 20.0,
                ),
              ),
              controller: detalleController,
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
                createPrinterAppEtiquetado();
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            PrintPage(int.parse(qrController.text))));
                /*     Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => QrRoroPDF(
                              idVehicle: BigInt.parse(qrController.text),
                            ))); */

                setState(() {
                  getPrinterAppPendientes;
                });
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
