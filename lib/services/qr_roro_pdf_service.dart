import 'dart:typed_data';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
//import 'package:printing/printing.dart';

class QrRoroPdfService {
  getQrRoroById(int idVehicle) {}
  final doc = pw.Document();

  var pdf = pw.Document;
  late Future<Uint8List> archivoPdf;

  Future<Uint8List> createPdf(int idVehicle) async {
    //final apmLogo = await imageFromAssetBundle('assets/images/apmlogo.jpg');
    // final consumarLogo =        await imageFromAssetBundle('assets/images/logotipoconsumar.jpg');
    //final codigoQr = await imageFromAssetBundle('assets/images/qrlogo.png');

    doc.addPage(pw.Page(
        // pageFormat: PdfPageFormat.a4,
        pageFormat: PdfPageFormat(
          5 * PdfPageFormat.cm,
          3 * PdfPageFormat.cm,
          /*    marginTop: 0.1 * PdfPageFormat.cm,
          marginBottom: 0.01 * PdfPageFormat.cm, */
          marginLeft: 1.5 * PdfPageFormat.cm,
          marginRight: 1 * PdfPageFormat.cm,
        ),
        build: (pw.Context context) {
          return pw.Container(
              child: pw.Column(children: [
            pw.Text("CSMP",
                style:
                    pw.TextStyle(fontSize: 5, fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(height: 0.2),
            pw.BarcodeWidget(
              barcode: pw.Barcode.qrCode(),
              data: idVehicle.toString(),
              height: 30.0,
              width: 30.0,
            ),
          ]));
        }));

    await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => doc.save());

    /// print the document using the iOS or Android print service:
    return doc.save();
    /*final file = File('AutoreportPdf.pdf');
    await file.writeAsBytes(await doc.save());*/
  }
}
