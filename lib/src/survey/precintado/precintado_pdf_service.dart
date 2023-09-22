import 'dart:typed_data';

import 'package:consumar_app/models/survey/Precintos/vw_ticket_granel_descarga_bodega.dart';
import 'package:consumar_app/models/survey/Precintos/vw_ticket_granel_precintos_carguio.dart';
import 'package:consumar_app/services/survey/precintado_service.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../../utils/constants.dart';

class PrecintadoPdfService {
  PrecintadoService precintadoService = PrecintadoService();

  List<VwTicketGranelDescargaBodega> vwTicketGranelDescargaBodega = [];

  List<VwTicketGranelPrecintosCarguio> vwTicketGranelPrecintosCarguio = [];

  String puerto = "";
  String nombreNave = "";
  int? jornada;
  String consignatario = "";
  String nombreConductor = "";
  String brevete = "";
  String empresaTransporte = "";
  String placaTolva = "";
  String placaTracto = "";
  String numeroViaje = "";
  String codDam = "";
  String codDo = "";
  DateTime? fechaDescarga;
  DateTime? fechaInicioCarguio;
  DateTime? fechaTerminoCarguio;

  getTicketGranelDescargaTolva(int idCarguio, int idServiceOrder) async {
    vwTicketGranelDescargaBodega = await precintadoService
        .getGranelDescargaTolva(idCarguio, idServiceOrder);

    puerto = vwTicketGranelDescargaBodega[0].puerto!;
    nombreNave = vwTicketGranelDescargaBodega[0].nombreNave!;
    jornada = vwTicketGranelDescargaBodega[0].jornada!;
    consignatario = vwTicketGranelDescargaBodega[0].consignatario!;
    nombreConductor = vwTicketGranelDescargaBodega[0].nombreConductor!;
    brevete = vwTicketGranelDescargaBodega[0].brevete!;
    empresaTransporte = vwTicketGranelDescargaBodega[0].empresaTransporte!;
    placaTolva = vwTicketGranelDescargaBodega[0].placaTolva!;
    placaTracto = vwTicketGranelDescargaBodega[0].placaTracto!;
    numeroViaje = vwTicketGranelDescargaBodega[0].numeroViaje!;
    codDam = vwTicketGranelDescargaBodega[0].dam!;
    codDo = vwTicketGranelDescargaBodega[0].vwTicketGranelDescargaBodegaDo!;
    fechaDescarga = vwTicketGranelDescargaBodega[0].fechaDescarga!;
    fechaInicioCarguio = vwTicketGranelDescargaBodega[0].fechaInicioCarguio!;
    fechaTerminoCarguio = vwTicketGranelDescargaBodega[0].fechaTerminoCarguio!;
  }

  getTicketGranelPrecintosCarguio(int idCarguio, int idServiceOrder) async {
    vwTicketGranelPrecintosCarguio = await precintadoService
        .getTicketGranelPrecintosCarguio(idCarguio, idServiceOrder);
  }

  final doc = pw.Document();

  var pdf = pw.Document;

  Future<Uint8List> createPdf(int idServiceOrder, int idCarguio) async {
    await getTicketGranelDescargaTolva(idServiceOrder, idCarguio);
    await getTicketGranelPrecintosCarguio(idServiceOrder, idCarguio);

    String jornadaTxt = "";

    if (jornada == 1) {
      jornadaTxt = "primera";
    } else if (jornada == 2) {
      jornadaTxt = "segunda";
    } else if (jornada == 3) {
      jornadaTxt = "tercera";
    }

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
                        pw.Text("Jornada", style: textoCuerpoTicketDR),
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
                        pw.Text(
                          "Placa Tolva",
                          style: textoCuerpoTicketDR,
                        ),
                        pw.SizedBox(height: 2),
                        pw.Text(
                          "Placa Tracto",
                          style: textoCuerpoTicketDR,
                        ),
                        pw.SizedBox(height: 2),
                        pw.Text(
                          "DO",
                          style: textoCuerpoTicketDR,
                        ),
                        pw.SizedBox(height: 2),
                        pw.Text(
                          "DAM",
                          style: textoCuerpoTicketDR,
                        ),
                        pw.SizedBox(height: 2),
                        pw.Text("Fecha/Descarga", style: textoCuerpoTicketDR),
                        pw.SizedBox(height: 2),
                        pw.Text("Inicio de Carguio",
                            style: textoCuerpoTicketDR),
                        pw.SizedBox(height: 2),
                        pw.Text("Termino de Carguio",
                            style: textoCuerpoTicketDR),
                        pw.SizedBox(height: 2),
                      ]),
                  pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      mainAxisAlignment: pw.MainAxisAlignment.start,
                      children: [
                        pw.Text("puerto", style: textoCuerpoTicketDR),
                        pw.SizedBox(height: 2),
                        pw.Text(nombreNave, style: textoCuerpoTicketDR),
                        pw.SizedBox(height: 2),
                        pw.Text(jornadaTxt, style: textoCuerpoTicketDR),
                        pw.SizedBox(height: 2),
                        pw.Text(consignatario, style: textoCuerpoTicketDR),
                        pw.SizedBox(height: 2),
                        pw.Text(nombreConductor, style: textoCuerpoTicketDR),
                        pw.SizedBox(height: 2),
                        pw.Text(brevete, style: textoCuerpoTicketDR),
                        pw.SizedBox(height: 2),
                        pw.Text(empresaTransporte, style: textoCuerpoTicketDR),
                        pw.SizedBox(height: 2),
                        pw.Text(placaTolva, style: textoCuerpoTicketDR),
                        pw.SizedBox(height: 2),
                        pw.Text(placaTracto, style: textoCuerpoTicketDR),
                        pw.SizedBox(height: 2),
                        pw.Text(codDo, style: textoCuerpoTicketDR),
                        pw.SizedBox(height: 2),
                        pw.Text(codDam, style: textoCuerpoTicketDR),
                        pw.SizedBox(height: 2),
                        pw.Text(fechaDescarga.toString(),
                            style: textoCuerpoTicketDR),
                        pw.SizedBox(height: 2),
                        pw.Text(fechaInicioCarguio.toString(),
                            style: textoCuerpoTicketDR),
                        pw.SizedBox(height: 2),
                        pw.Text(fechaTerminoCarguio.toString(),
                            style: textoCuerpoTicketDR),
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
