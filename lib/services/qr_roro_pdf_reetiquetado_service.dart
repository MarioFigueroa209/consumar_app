import 'dart:typed_data';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class QrRoroPdfReetiquetadoService {
  final doc = pw.Document();

  var pdf = pw.Document;
  late Future<Uint8List> archivoPdf;

  Future<Uint8List> createPdf(int idVehicle) async {
    //final apmLogo = await imageFromAssetBundle('assets/images/apmlogo.jpg');
    // final consumarLogo =        await imageFromAssetBundle('assets/images/logotipoconsumar.jpg');
    //final codigoQr = await imageFromAssetBundle('assets/images/qrlogo.png');

    doc.addPage(pw.Page(
        pageFormat: const PdfPageFormat(
            1.2 * PdfPageFormat.inch, double.infinity,
            marginAll: 0.4 * PdfPageFormat.cm),
        build: (pw.Context context) {
          return pw.Container(
              child: pw.Column(children: [
            pw.Text("REETIQUETADO",
                style:
                    pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(height: 20),
            pw.BarcodeWidget(
              barcode: pw.Barcode.qrCode(),
              data: idVehicle.toString(),
              height: 60.0,
              width: 60.0,
            ),
          ]));
        }));

    /*   await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => doc.save()); */

    /// print the document using the iOS or Android print service:
    return doc.save();
    /*final file = File('AutoreportPdf.pdf');
    await file.writeAsBytes(await doc.save());*/
  }
}
