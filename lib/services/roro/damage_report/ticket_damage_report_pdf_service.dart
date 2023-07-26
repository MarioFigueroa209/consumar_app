import 'dart:typed_data';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import '../../../models/roro/damage_report/vw_ticket_dr_listado.dart';
import '../../../utils/constants.dart';
import 'damage_report_consulta_service.dart';

class TicketDamageReport {
  final doc = pw.Document();

  var pdf = pw.Document;

  DamageReportConsultaService damageReportConsultaService =
      DamageReportConsultaService();

  String nave = "";
  String puerto = "";

  List<VwTicketDrListado> vwTicketDrListado = [];

  getVVwTicketDrListado(BigInt idDamageReport) async {
    vwTicketDrListado =
        await damageReportConsultaService.getVwTicketDrListado(idDamageReport);

    nave = vwTicketDrListado[0].nombreNave!;

    if (vwTicketDrListado[0].puerto != null) {
      puerto = vwTicketDrListado[0].puerto!.toUpperCase();
    } else {
      puerto = "";
    }
  }

  Future<Uint8List> createPdf(BigInt idDamageReport) async {
    await getVVwTicketDrListado(idDamageReport);

    /// for using an image from assets
    final apmLogo = await imageFromAssetBundle('assets/images/apmlogo.jpg');
    final consumarLogo = await imageFromAssetBundle('assets/images/splash.png');

    doc.addPage(pw.Page(
        pageFormat: const PdfPageFormat(
            2.84 * PdfPageFormat.inch, double.infinity,
            marginAll: 0.5 * PdfPageFormat.cm),
        build: (pw.Context context) {
          return pw.Column(children: [
            pw.Column(children: [
              pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Image(apmLogo, height: 50, width: 50),
                    pw.Image(consumarLogo, height: 50, width: 50),
                  ]),
              pw.Text("DAMAGE REPORT LIST",
                  style: tituloCuerpoTicketDR,
                  overflow: pw.TextOverflow.clip,
                  textAlign: pw.TextAlign.center),
              pw.SizedBox(height: 5),
              pw.Row(
                children: List.generate(
                    150 ~/ 3,
                    (index) => pw.Expanded(
                          child: pw.Container(
                            color: index % 2 == 0
                                ? const PdfColor.fromInt(0xffffffff)
                                : const PdfColor.fromInt(0xff9e9e9e),
                            height: 0.5,
                          ),
                        )),
              ),

              pw.SizedBox(height: 5),
              pw.Text(
                "DATE & TIME: ${DateTime.now()}",
                style: textoCuerpoTicketDR,
              ),
              pw.SizedBox(height: 2),
              pw.Text("VESSEL: $nave", style: textoCuerpoTicketDR),
              pw.SizedBox(height: 5),

              pw.Divider(color: const PdfColor.fromInt(0xff9e9e9e), height: 1),
              pw.SizedBox(height: 5),
              pw.Text("DESCRIPTION",
                  style: tituloCuerpoTicketDR,
                  overflow: pw.TextOverflow.clip,
                  textAlign: pw.TextAlign.center),
              pw.SizedBox(height: 5),
              pw.Row(
                children: List.generate(
                    150 ~/ 3,
                    (index) => pw.Expanded(
                          child: pw.Container(
                            color: index % 2 == 0
                                ? const PdfColor.fromInt(0xffffffff)
                                : const PdfColor.fromInt(0xff9e9e9e),
                            height: 0.5,
                          ),
                        )),
              ),

              pw.SizedBox(height: 5),

              pw.Text("PORT: $puerto", style: textoCuerpoTicketDR),
              pw.SizedBox(height: 5),

              pw.Divider(color: const PdfColor.fromInt(0xff9e9e9e), height: 1),
              pw.SizedBox(height: 5),
              pw.Text("INVENTORY",
                  style: tituloCuerpoTicketDR,
                  overflow: pw.TextOverflow.clip,
                  textAlign: pw.TextAlign.center),
              pw.SizedBox(height: 5),
              pw.Row(
                children: List.generate(
                    300 ~/ 3,
                    (index) => pw.Expanded(
                          child: pw.Container(
                            color: index % 2 == 0
                                ? const PdfColor.fromInt(0xffffffff)
                                : const PdfColor.fromInt(0xff9e9e9e),
                            height: 0.5,
                          ),
                        )),
              ),
              pw.SizedBox(height: 2),
              //pw.SizedBox(height: 5),

              /* pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
                  children: [
                    pw.Text("Nº DR",
                        style: textoCuerpoTicketDR,
                        overflow: pw.TextOverflow.clip,
                        textAlign: pw.TextAlign.center),
                    pw.Text("CHASSIS",
                        style: textoCuerpoTicketDR,
                        overflow: pw.TextOverflow.clip,
                        textAlign: pw.TextAlign.center),
                    pw.Text("QUANTITY",
                        style: textoCuerpoTicketDR,
                        overflow: pw.TextOverflow.clip,
                        textAlign: pw.TextAlign.center),
                    pw.Text("BL",
                        style: textoCuerpoTicketDR,
                        overflow: pw.TextOverflow.clip,
                        textAlign: pw.TextAlign.center),
                  ]), */
              pw.Table(children: [
                for (var i = 0; i < vwTicketDrListado.length; i++)
                  pw.TableRow(children: [
                    pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.SizedBox(height: 2),
                          pw.Text(
                              '${vwTicketDrListado[i].idVista!}) Nº DR: ${vwTicketDrListado[i].codDr!}',
                              style: const pw.TextStyle(fontSize: 6)),
                          pw.Text('Chassis: ${vwTicketDrListado[i].chasis!}',
                              style: const pw.TextStyle(fontSize: 6)),
                          pw.SizedBox(height: 2),
                          pw.Divider(
                              color: const PdfColor.fromInt(0xff9e9e9e),
                              height: 0.5),
                          pw.SizedBox(height: 2),
                        ]),
                    /* pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.center,
                        mainAxisAlignment: pw.MainAxisAlignment.center,
                        children: [
                          pw.Text(vwTicketDrListado[i].chasis!,
                              style: pw.TextStyle(fontSize: 6)),
                          pw.Divider(thickness: 1)
                        ]), */
                    pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.SizedBox(height: 2),
                          pw.Text(
                              'Amount of damage: ${vwTicketDrListado[i].cantidadDanos}',
                              style: const pw.TextStyle(fontSize: 6)),
                          pw.Text('BL: ${vwTicketDrListado[i].bl!}',
                              style: const pw.TextStyle(fontSize: 6)),
                          pw.SizedBox(height: 2),
                          pw.Divider(
                              color: const PdfColor.fromInt(0xff9e9e9e),
                              height: 0.5),
                          pw.SizedBox(height: 2),
                          //pw.Divider(color: const PdfColor.fromInt(0xff9e9e9e))
                        ]),
                    /* pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.center,
                        mainAxisAlignment: pw.MainAxisAlignment.center,
                        children: [
                          pw.Text(vwTicketDrListado[i].bl!,
                              style: pw.TextStyle(fontSize: 6)),
                          pw.Divider(thickness: 1)
                        ]) */
                  ])
              ]),
              pw.SizedBox(height: 30),
              pw.BarcodeWidget(
                barcode: pw.Barcode.qrCode(),
                data: 'consumarport.com.pe/login',
                height: 60.0,
                width: 60.0,
              ),
              pw.SizedBox(height: 10),
              pw.Center(
                child: pw.Text(
                    "Representation of the electronic document, "
                    "please visit and consult this document on the web: consumarport.com.pe/login",
                    style: textoCuerpoTicketDR,
                    textAlign: pw.TextAlign.center),
              ),
            ]),
          ]);
        }));

    await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => doc.save());

    /// print the document using the iOS or Android print service:
    return doc.save();
    /*final file = File('AutoreportPdf.pdf');
    await file.writeAsBytes(await doc.save());*/
  }
}
