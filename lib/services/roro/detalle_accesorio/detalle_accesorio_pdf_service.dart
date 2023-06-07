import 'dart:typed_data';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import '../../../models/roro/detalle_accesorio/vw_detalle_accesorio_model.dart';
import '../../../models/roro/detalle_accesorio/vw_detallea_accesorio_item_list.dart';
import 'detalle_accesorio_service.dart';

class DetalleAccesorioPdfService {
  DetalleAccesorioService detalleAccesorioService = DetalleAccesorioService();

  VwDetalleAccesorioModel vwDetalleAccesorioModel = VwDetalleAccesorioModel();

  String codDetalleAccesorio = "";
  String marca = "";
  String chasis = "";
  String urlFotoAccesorios = "";

  List<VwDetalleAccesorioItemList> vwDetalleAccesorioItemList = [];

  List<dynamic> listaImagenes = [];

  late Future<Uint8List> archivoPdf;

  Future<void> initPDF(BigInt idDetalleAccesorio) async {
    await getDetalleAccesorio(idDetalleAccesorio);
    //getParticipantesByIdAutoreport(idAutoreport);
    //print("inicalizando pdf$idDetalleAccesorio");
    archivoPdf = createPdf(idDetalleAccesorio);
  }

  getDetalleAccesorio(BigInt idDetalleAccesorio) async {
    vwDetalleAccesorioModel = await detalleAccesorioService
        .getDetalleAccesorioModel(idDetalleAccesorio);

    codDetalleAccesorio = vwDetalleAccesorioModel.codDetalleAccesorio!;
    marca = vwDetalleAccesorioModel.marca!;
    chasis = vwDetalleAccesorioModel.chasis!;
  }

  getDetalleAccesorioItemListByIdDA(BigInt idDetalleAccesorio) async {
    vwDetalleAccesorioItemList = await detalleAccesorioService
        .getDetalleAccesorioItemList(idDetalleAccesorio);

    //Prueba lista fotos iguales
    for (int i = 0; i < vwDetalleAccesorioItemList.length; i++) {
      urlFotoAccesorios = vwDetalleAccesorioItemList[i].urlFoto!;
      var imagen = await networkImage(urlFotoAccesorios);
      listaImagenes.add(imagen);

      // //print("url esperado lista: $urlFotoAccesorios");
      // //print("cantidad lista de images: ${vwDetalleAccesorioItemList.length}");
    }

    // //print("url esperado: $urlFotoAccesorios");
  }

  final doc = pw.Document();

  var pdf = pw.Document;

  Future<Uint8List> createPdf(BigInt idDetalleAccesorio) async {
    await getDetalleAccesorio(idDetalleAccesorio);
    await getDetalleAccesorioItemListByIdDA(idDetalleAccesorio);

    final apmLogo = await imageFromAssetBundle('assets/images/apmlogo.jpg');
    final consumarLogo = await imageFromAssetBundle('assets/images/splash.png');
    //final codigoQr = await imageFromAssetBundle('assets/images/qrlogo.png');

    doc.addPage(pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Container(
              child: pw.Column(children: [
            pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Image(apmLogo, height: 120, width: 120),
                  /*
                    pw.SizedBox(width: 5),
                    pw.Text("DAMAGE REPORT - DR000000 ",
                        maxLines: 2,
                        overflow: pw.TextOverflow.clip,
                        textAlign: pw.pw.TextAlign.center),
                    pw.SizedBox(width: 5),
                    */
                  pw.Image(consumarLogo, height: 120, width: 120),
                ]),
            pw.Text("DETALLE ACCESORIO - $codDetalleAccesorio",
                style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(
              height: 15,
            ),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.center,
              children: [
                pw.Container(
                  width: 240,
                  height: 15,
                  decoration: pw.BoxDecoration(
                      border: pw.Border.all(
                          color: const PdfColor.fromInt(0xff000000)),
                      color: const PdfColor.fromInt(0xff82b1ff)),
                  child: pw.Center(
                    child: pw.Text(
                      "CHASIS",
                      textAlign: pw.TextAlign.center,
                    ),
                  ),
                ),
                pw.Container(
                  width: 240,
                  height: 15,
                  decoration: pw.BoxDecoration(
                      border: pw.Border.all(
                          color: const PdfColor.fromInt(0xff000000)),
                      color: const PdfColor.fromInt(0xff82b1ff)),
                  child: pw.Center(
                    child: pw.Text(
                      "MARCA",
                      textAlign: pw.TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.center,
              children: [
                pw.Container(
                  width: 240,
                  height: 15,
                  decoration: pw.BoxDecoration(
                      border: pw.Border.all(
                          color: const PdfColor.fromInt(0xff000000)),
                      color: const PdfColor.fromInt(0xffffffff)),
                  child: pw.Center(
                    child: pw.Text(
                      chasis,
                      textAlign: pw.TextAlign.center,
                    ),
                  ),
                ),
                pw.Container(
                  width: 240,
                  height: 15,
                  decoration: pw.BoxDecoration(
                      border: pw.Border.all(
                          color: const PdfColor.fromInt(0xff000000)),
                      color: const PdfColor.fromInt(0xffffffff)),
                  child: pw.Center(
                    child: pw.Text(
                      marca,
                      textAlign: pw.TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
            pw.Container(
              width: 480,
              height: 15,
              decoration: pw.BoxDecoration(
                  border:
                      pw.Border.all(color: const PdfColor.fromInt(0xff000000)),
                  color: const PdfColor.fromInt(0xff82b1ff)),
              child: pw.Center(
                child: pw.Text(
                  "ACCESORIOS",
                  textAlign: pw.TextAlign.center,
                ),
              ),
            ),
            pw.Container(
                width: 480,
                decoration: pw.BoxDecoration(
                    border: pw.Border.all(
                        color: const PdfColor.fromInt(0xff000000)),
                    color: const PdfColor.fromInt(0xffffffff)),
                child: pw.Column(children: [
                  pw.Container(height: 10),
                  pw.Center(
                    child: pw.Table(children: [
                      for (var i = 0;
                          i < vwDetalleAccesorioItemList.length;
                          /* listImagenesDanos[i].imagenes =
                                          networkImage(
                                              damageTypeByIdDrModelList[i]
                                                  .fotoDano!), */
                          i++)
                        pw.TableRow(children: [
                          pw.Column(children: [
                            pw.Text(
                                "Descripcion ${i + 1}: ${vwDetalleAccesorioItemList[i].descripcion!}"),
                            pw.Container(height: 5),
                            pw.Image(listaImagenes[i], width: 180, height: 100),
                            pw.Container(height: 10),
                          ])
                        ])
                    ]),
                  ),
                ])),
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
