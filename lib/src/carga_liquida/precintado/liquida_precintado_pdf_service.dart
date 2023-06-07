import 'dart:typed_data';

import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../../utils/constants.dart';

class LiquidaPrecintadoPdfService {
  final doc = pw.Document();

  var pdf = pw.Document;

  Future<Uint8List> createPdf() async {
    final consumarLogo =
        await imageFromAssetBundle('assets/images/logotipoconsumar.jpg');

    doc.addPage(pw.Page(
        pageFormat: const PdfPageFormat(
            2.84 * PdfPageFormat.inch, double.infinity,
            marginAll: 0.4 * PdfPageFormat.cm),
        build: (pw.Context context) {
          return pw.Container(
              child: pw.Column(children: [
            pw.Image(consumarLogo, height: 50, width: 50),
            pw.Text("CONTROL DE DESCARGA UNIDADES/ CISTERNA NAVE",
                maxLines: 2,
                style: tituloCuerpoTicketDR,
                overflow: pw.TextOverflow.clip,
                textAlign: pw.TextAlign.center),
            pw.SizedBox(
              height: 10,
            ),
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
            pw.SizedBox(height: 2),
            pw.Text("TICKET: ", style: tituloCuerpoTicketDR),
            pw.SizedBox(height: 2),
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
            pw.SizedBox(
              height: 10,
            ),
            pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text("Puerto/Terminal:", style: textoCuerpoTicketDR),
                        pw.SizedBox(height: 2),
                        pw.Text("Nave:", style: textoCuerpoTicketDR),
                        pw.SizedBox(height: 2),
                        pw.Text("Consignatario:", style: textoCuerpoTicketDR),
                        pw.SizedBox(height: 2),
                        pw.Text("Conductor", style: textoCuerpoTicketDR),
                        pw.SizedBox(height: 2),
                        pw.Text("Brevete", style: textoCuerpoTicketDR),
                        pw.SizedBox(height: 2),
                        pw.Text("Empresa de Transporte",
                            style: textoCuerpoTicketDR),
                        pw.SizedBox(height: 2),
                        pw.Text("Jornada", style: textoCuerpoTicketDR),
                        pw.SizedBox(height: 2),
                        pw.Text("Placa Tracto", style: textoCuerpoTicketDR),
                        pw.SizedBox(height: 2),
                        pw.Text(
                          "Placa Cisterna",
                          style: textoCuerpoTicketDR,
                        ),
                        pw.SizedBox(height: 2),
                        pw.Text("N° Taria", style: textoCuerpoTicketDR),
                        pw.SizedBox(height: 2),
                        pw.Text("N° Autorizacion", style: textoCuerpoTicketDR),
                        pw.SizedBox(height: 2),
                        pw.Text("Fecha/Descarga", style: textoCuerpoTicketDR),
                        pw.SizedBox(height: 2),
                        pw.Text("Inicio de Carguio",
                            style: textoCuerpoTicketDR),
                        pw.SizedBox(height: 2),
                        pw.Text("Termino de Carguio",
                            style: textoCuerpoTicketDR),
                        pw.SizedBox(height: 2),
                        pw.Text("N° Precintos Valvula de Ingreso",
                            style: textoCuerpoTicketDR),
                        pw.SizedBox(height: 2),
                        pw.Text("N° Precintos Valvula de Salida",
                            style: textoCuerpoTicketDR),
                      ]),
                  pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      mainAxisAlignment: pw.MainAxisAlignment.start,
                      children: [
                        pw.Text("", style: textoCuerpoTicketDR),
                        pw.SizedBox(height: 2),
                        pw.Text("", style: textoCuerpoTicketDR),
                        pw.SizedBox(height: 2),
                        pw.Text("", style: textoCuerpoTicketDR),
                        pw.SizedBox(height: 2),
                        pw.Text("", style: textoCuerpoTicketDR),
                        pw.SizedBox(height: 2),
                        pw.Text("", style: textoCuerpoTicketDR),
                        pw.SizedBox(height: 2),
                        pw.Text("", style: textoCuerpoTicketDR),
                        pw.SizedBox(height: 2),
                        pw.Text("", style: textoCuerpoTicketDR),
                        pw.SizedBox(height: 2),
                        pw.Text("", style: textoCuerpoTicketDR),
                        pw.SizedBox(height: 2),
                        pw.Text("", style: textoCuerpoTicketDR),
                        pw.SizedBox(height: 2),
                        pw.Text("", style: textoCuerpoTicketDR),
                        pw.SizedBox(height: 2),
                        pw.Text("", style: textoCuerpoTicketDR),
                        pw.SizedBox(height: 2),
                        pw.Text("", style: textoCuerpoTicketDR),
                        pw.SizedBox(height: 2),
                        pw.Text("", style: textoCuerpoTicketDR),
                        pw.SizedBox(height: 2),
                        pw.Text("", style: textoCuerpoTicketDR),
                        pw.SizedBox(height: 2),
                        pw.Text("", style: textoCuerpoTicketDR),
                        pw.SizedBox(height: 2),
                        pw.Text("", style: textoCuerpoTicketDR),
                      ]),
                ]),
            pw.SizedBox(height: 10),
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
            pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.stretch,
                children: [
                  pw.Text(
                      "El conductor ha presenciado el carguio del producto en su unidad, dando fe y conformidad de lo siguiente:  ",
                      style: textoCuerpoTicketDR),
                  pw.SizedBox(height: 2),
                  pw.Text(
                      "- Los precintos especificados en el ticket fueron colocados de manera correcta en todas las valvulas de la cisterna, tanto de ingreso como de salida",
                      style: textoCuerpoTicketDR),
                  pw.SizedBox(height: 2),
                  pw.Text(
                      "- La correcta colocación de los stickers de seguridad CONSUMARPORT en la caja metálica de protección de las valvulas de salida de la cisterna",
                      style: textoCuerpoTicketDR)
                ]),
            pw.SizedBox(height: 50),
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
            pw.SizedBox(height: 2),
            pw.Center(child: pw.Text("Firma", style: textoCuerpoTicketDR)),
            pw.SizedBox(height: 1),
            pw.Center(
                child: pw.Text("Inspector/Consumarport",
                    style: textoCuerpoTicketDR)),
            pw.SizedBox(height: 50),
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
            pw.SizedBox(height: 2),
            pw.Center(child: pw.Text("Firma", style: textoCuerpoTicketDR)),
            pw.SizedBox(height: 1),
            pw.Center(
                child: pw.Text("Inspector/Consumarport",
                    style: textoCuerpoTicketDR)),
            pw.SizedBox(height: 20),
            pw.BarcodeWidget(
              barcode: pw.Barcode.qrCode(),
              data: 'consumarport.com.pe/login',
              height: 80.0,
              width: 80.0,
            ),
            pw.SizedBox(height: 10),
            pw.Center(
              child: pw.Container(
                width: 150,
                child: pw.Text(
                    "Representacion del documento Electronico, consultar su documento en consumarport.com.pe/login",
                    style: textoCuerpoTicketDR,
                    textAlign: pw.TextAlign.center),
              ),
            ),
            pw.SizedBox(height: 10),
          ]));
        }));
    await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => doc.save());

    /// print the document using the iOS or Android print service:
    return doc.save();
  }
}
