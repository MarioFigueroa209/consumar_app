import 'dart:typed_data';

import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import '../../../models/roro/damage_report/vw_get_damage_report_item_model.dart';
import '../../../models/roro/damage_report/vw_get_damage_type_by_id_dr_model.dart';
import 'damage_report_consulta_service.dart';

class DamageReportPdfService {
  late Future<Uint8List> archivoPdf;
  dynamic fotoChasis;
  List<dynamic> listaImagenes = [];

  Future<void> initPDF(BigInt idAutoreport) async {
    await getDamageItem(idAutoreport);

    archivoPdf = createPdf(idAutoreport);
  }

  String vessel = "";
  DateTime? fecha;
  String port = "";
  String vesselOficer = "";
  String shift = "";
  String damageFound = "";
  String damageOcurred = "";
  String operation = "";
  String stowagePosition = "";
  String portLanding = "";
  String portDischard = "";
  String marca = "";
  String modelo = "";
  String chasis = "";
  String consignatario = "";
  String bl = "";
  String nombreConductor = "";
  String lugarAccidente = "";
  DateTime? fechaAccidente;
  String oficialBarco = "";
  String agenciaMaritima = "";
  String urlChasisFoto = "";
  String fotoFirmaCapitan = "";
  String codDR = "";
  String urlFotoDanos = "";
  String urlFirmaCapitan = "";
  String aprobadoAPMTC = "OUTSTANDING";
  String aprobadoCoordinador = "OUTSTANDING";
  String nombreAPMTC = "";
  String nombreCoordinador = "";

  bool isVisible = false;

  List<VwGetDamageTypeByIdDrModel> damageTypeByIdDrModelList = [];

  Future<List<VwGetDamageTypeByIdDrModel>>? futureDamageTypeByIdDrModelList;

  DamageReportConsultaService damageReportConsultaService =
      DamageReportConsultaService();

  VwGetDamageReportItemModel vwGetDamageReportItemModel =
      VwGetDamageReportItemModel();

  getDamageTypeListByIdDR(BigInt idDamageReport) async {
    damageTypeByIdDrModelList = await damageReportConsultaService
        .getDamageItemListByIdDR(idDamageReport);

    //Prueba lista fotos diferentes
    for (int i = 0; i < damageTypeByIdDrModelList.length; i++) {
      urlFotoDanos = damageTypeByIdDrModelList[i].fotoDano!;
      var imagen = await networkImage(urlFotoDanos);
      listaImagenes.add(imagen);
      //print("url esperado lista: $urlFotoDanos");
    }
    //print("numero de fotos${listaImagenes.length}");
    //print("hay estos registros${damageTypeByIdDrModelList.length}");
  }

  getDamageItem(BigInt idDamageReport) async {
    vwGetDamageReportItemModel =
        await damageReportConsultaService.getDamageReportItem(idDamageReport);

    vessel = vwGetDamageReportItemModel.nave!;
    fecha = vwGetDamageReportItemModel.fecha;

    if (vwGetDamageReportItemModel.puerto != null) {
      port = vwGetDamageReportItemModel.puerto!.toUpperCase();
    } else {
      port = "";
    }

    shift = vwGetDamageReportItemModel.numeroViaje!;
    damageFound = vwGetDamageReportItemModel.damageFound!;
    damageOcurred = vwGetDamageReportItemModel.damageOcurred!;
    operation = vwGetDamageReportItemModel.operation!;
    stowagePosition =
        vwGetDamageReportItemModel.posicionEstibador!.toUpperCase();

    if (vwGetDamageReportItemModel.puertoAterrizaje != null) {
      portLanding = vwGetDamageReportItemModel.puertoAterrizaje!.toUpperCase();
    } else {
      portLanding = "";
    }

    if (vwGetDamageReportItemModel.puertoDestino != null) {
      portDischard = vwGetDamageReportItemModel.puertoDestino!.toUpperCase();
    } else {
      portDischard = "";
    }
    marca = vwGetDamageReportItemModel.marca!;
    modelo = vwGetDamageReportItemModel.modelo!;
    chasis = vwGetDamageReportItemModel.chasis!;
    consignatario = vwGetDamageReportItemModel.consigntario!;
    bl = vwGetDamageReportItemModel.billOfLeading!;
    if (vwGetDamageReportItemModel.nombreConductor != null) {
      nombreConductor =
          vwGetDamageReportItemModel.nombreConductor!.toUpperCase();
    } else {
      nombreConductor = "";
    }
    lugarAccidente = vwGetDamageReportItemModel.lugarAccidente!.toUpperCase();
    fechaAccidente = vwGetDamageReportItemModel.fechaHoraAccidente;

    if (vwGetDamageReportItemModel.agenciaMaritica != null) {
      agenciaMaritima =
          vwGetDamageReportItemModel.agenciaMaritica!.toUpperCase();
    } else {
      agenciaMaritima = "";
    }

    vesselOficer =
        vwGetDamageReportItemModel.nombreResponsableNave!.toUpperCase();
    urlChasisFoto = vwGetDamageReportItemModel.fotoChasis!;
    codDR = vwGetDamageReportItemModel.codDr!;
    urlFirmaCapitan = vwGetDamageReportItemModel.firmaResponsable!;
    if (vwGetDamageReportItemModel.aprobadoApmtc == "aprobado") {
      aprobadoAPMTC = "APPROVED";
    } else if (vwGetDamageReportItemModel.aprobadoApmtc == "desaprobado") {
      aprobadoAPMTC = "REJECTED";
    }
    if (vwGetDamageReportItemModel.nombreUsuarioApmtc != null) {
      nombreAPMTC = vwGetDamageReportItemModel.nombreUsuarioApmtc!;
    } else {
      nombreAPMTC = "";
    }
    if (vwGetDamageReportItemModel.aprobadoCoordinador == "aprobado") {
      aprobadoCoordinador = "APPROVED";
    } else if (vwGetDamageReportItemModel.aprobadoCoordinador ==
        "desaprobado") {
      aprobadoCoordinador = "REJECTED";
    }
    nombreCoordinador = vwGetDamageReportItemModel.nombreUsuarioCoordinador!;

    //print("firma del capitan: $urlFirmaCapitan");
  }

  final doc = pw.Document();

  var pdf = pw.Document;

  //Future<Uint8List> createPdf(VwGetDamageReportItemModel vwGetDamageReportItemModel,VwGetDamageTypeByIdDrModel damageTypeByIdDrModelList) async {
  //Future<Uint8List> createPdf() async {
  Future<Uint8List> createPdf(BigInt idDamageReport) async {
    //Pruebas
    await getDamageItem(idDamageReport);
    await getDamageTypeListByIdDR(idDamageReport);
    //Fin Pruebas

    /// for using an image from assets
    final apmLogo = await imageFromAssetBundle('assets/images/apmlogo.jpg');
    final consumarLogo = await imageFromAssetBundle('assets/images/splash.png');

    fotoChasis = await networkImage(urlChasisFoto);

    final pw.ImageProvider fotoFirmaCapitan;

    if (urlFirmaCapitan == "") {
      fotoFirmaCapitan =
          await imageFromAssetBundle('assets/images/fotoBlancoFirma.jpg');
    } else {
      fotoFirmaCapitan = await networkImage(urlFirmaCapitan);
    }

    doc.addPage(
      pw.Page(
        pageFormat: const PdfPageFormat(
            21.0 * PdfPageFormat.cm, 45 * PdfPageFormat.cm,
            marginAll: 1.5 * PdfPageFormat.cm),
        build: (pw.Context context) {
          return pw.Container(
            child: pw.Column(children: [
              pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Image(apmLogo, height: 120, width: 120),
                    pw.Image(consumarLogo, height: 120, width: 120),
                  ]),
              pw.Text("DAMAGE REPORT - $codDR",
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
              pw.SizedBox(
                height: 15,
              ),
              pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.center,
                children: [
                  pw.Container(
                    width: 510,
                    height: 15,
                    decoration: pw.BoxDecoration(
                        border: pw.Border.all(
                            color: const PdfColor.fromInt(0xff000000)),
                        color: const PdfColor.fromInt(0xff000000)),
                    child: pw.Center(
                      child: pw.Text(
                        "INITIAL INFORMATION",
                        textAlign: pw.TextAlign.center,
                        style: const pw.TextStyle(
                            color: PdfColor.fromInt(0xffffffff), fontSize: 10),
                      ),
                    ),
                  ),
                  pw.Column(
                    children: [
                      pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.center,
                        children: [
                          pw.Container(
                            width: 127.5,
                            height: 15,
                            decoration: pw.BoxDecoration(
                                border: pw.Border.all(
                                    color: const PdfColor.fromInt(0xff000000)),
                                color: const PdfColor.fromInt(0xff82b1ff)),
                            child: pw.Center(
                              child: pw.Text(
                                "VESSEL",
                                textAlign: pw.TextAlign.center,
                                style: const pw.TextStyle(fontSize: 10),
                              ),
                            ),
                          ),
                          pw.Container(
                            width: 127.5,
                            height: 15,
                            decoration: pw.BoxDecoration(
                                border: pw.Border.all(
                                    color: const PdfColor.fromInt(0xff000000)),
                                color: const PdfColor.fromInt(0xff82b1ff)),
                            child: pw.Center(
                              child: pw.Text(
                                "DATE",
                                textAlign: pw.TextAlign.center,
                                style: const pw.TextStyle(fontSize: 10),
                              ),
                            ),
                          ),
                          pw.Container(
                            width: 127.5,
                            height: 15,
                            decoration: pw.BoxDecoration(
                                border: pw.Border.all(
                                    color: const PdfColor.fromInt(0xff000000)),
                                color: const PdfColor.fromInt(0xffffd180)),
                            child: pw.Center(
                              child: pw.Text(
                                "DAMAGE FOUND",
                                textAlign: pw.TextAlign.center,
                                style: const pw.TextStyle(fontSize: 10),
                              ),
                            ),
                          ),
                          pw.Container(
                            width: 127.5,
                            height: 15,
                            decoration: pw.BoxDecoration(
                                border: pw.Border.all(
                                    color: const PdfColor.fromInt(0xff000000)),
                                color: const PdfColor.fromInt(0xffffd180)),
                            child: pw.Center(
                              child: pw.Text(
                                "DAMAGE OCURRED",
                                textAlign: pw.TextAlign.center,
                                style: const pw.TextStyle(fontSize: 10),
                              ),
                            ),
                          ),
                        ],
                      ),
                      pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.center,
                        children: [
                          pw.Container(
                            width: 127.5,
                            height: 15,
                            decoration: pw.BoxDecoration(
                                border: pw.Border.all(
                                    color: const PdfColor.fromInt(0xff000000)),
                                color: const PdfColor.fromInt(0xffffffff)),
                            child: pw.Center(
                              child: pw.Text(
                                vessel,
                                textAlign: pw.TextAlign.center,
                                style: const pw.TextStyle(fontSize: 10),
                              ),
                            ),
                          ),
                          pw.Container(
                            width: 127.5,
                            height: 15,
                            decoration: pw.BoxDecoration(
                                border: pw.Border.all(
                                    color: const PdfColor.fromInt(0xff000000)),
                                color: const PdfColor.fromInt(0xffffffff)),
                            child: pw.Center(
                              child: pw.Text(
                                  DateFormat('dd-MM-yyyy').format(fecha!)),
                            ),
                          ),
                          pw.Container(
                            width: 127.5,
                            height: 15,
                            decoration: pw.BoxDecoration(
                                border: pw.Border.all(
                                    color: const PdfColor.fromInt(0xff000000)),
                                color: const PdfColor.fromInt(0xffffffff)),
                            child: pw.Center(
                              child: pw.Text(damageFound,
                                  style: const pw.TextStyle(fontSize: 10)),
                            ),
                          ),
                          pw.Container(
                            width: 127.5,
                            height: 15,
                            decoration: pw.BoxDecoration(
                                border: pw.Border.all(
                                    color: const PdfColor.fromInt(0xff000000)),
                                color: const PdfColor.fromInt(0xffffffff)),
                            child: pw.Center(
                              child: pw.Text(damageOcurred,
                                  style: const pw.TextStyle(fontSize: 10)),
                            ),
                          ),
                        ],
                      ),
                      pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.center,
                        children: [
                          pw.Container(
                            width: 127.5,
                            height: 15,
                            decoration: pw.BoxDecoration(
                                border: pw.Border.all(
                                    color: const PdfColor.fromInt(0xff000000)),
                                color: const PdfColor.fromInt(0xff82b1ff)),
                            child: pw.Center(
                              child: pw.Text(
                                "PORT",
                                textAlign: pw.TextAlign.center,
                                style: const pw.TextStyle(fontSize: 10),
                              ),
                            ),
                          ),
                          pw.Container(
                            width: 127.5,
                            height: 15,
                            decoration: pw.BoxDecoration(
                                border: pw.Border.all(
                                    color: const PdfColor.fromInt(0xff000000)),
                                color: const PdfColor.fromInt(0xff82b1ff)),
                            child: pw.Center(
                              child: pw.Text(
                                "SHIFT",
                                textAlign: pw.TextAlign.center,
                                style: const pw.TextStyle(fontSize: 10),
                              ),
                            ),
                          ),
                          pw.Container(
                            width: 255,
                            height: 15,
                            decoration: pw.BoxDecoration(
                                border: pw.Border.all(
                                    color: const PdfColor.fromInt(0xff000000)),
                                color: const PdfColor.fromInt(0xffffd180)),
                            child: pw.Center(
                              child: pw.Text(
                                "OPERATION",
                                textAlign: pw.TextAlign.center,
                                style: const pw.TextStyle(fontSize: 10),
                              ),
                            ),
                          ),
                        ],
                      ),
                      pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.center,
                        children: [
                          pw.Container(
                            width: 127.5,
                            height: 15,
                            decoration: pw.BoxDecoration(
                                border: pw.Border.all(
                                    color: const PdfColor.fromInt(0xff000000)),
                                color: const PdfColor.fromInt(0xffffffff)),
                            child: pw.Center(
                              child: pw.Text(
                                port,
                                textAlign: pw.TextAlign.center,
                                style: const pw.TextStyle(fontSize: 10),
                              ),
                            ),
                          ),
                          pw.Container(
                            width: 127.5,
                            height: 15,
                            decoration: pw.BoxDecoration(
                                border: pw.Border.all(
                                    color: const PdfColor.fromInt(0xff000000)),
                                color: const PdfColor.fromInt(0xffffffff)),
                            child: pw.Center(
                              child: pw.Text(
                                shift,
                                textAlign: pw.TextAlign.center,
                                style: const pw.TextStyle(fontSize: 10),
                              ),
                            ),
                          ),
                          pw.Container(
                            width: 255,
                            height: 15,
                            decoration: pw.BoxDecoration(
                                border: pw.Border.all(
                                    color: const PdfColor.fromInt(0xff000000)),
                                color: const PdfColor.fromInt(0xffffffff)),
                            child: pw.Center(
                              child: pw.Text(
                                operation,
                                textAlign: pw.TextAlign.center,
                                style: const pw.TextStyle(fontSize: 10),
                              ),
                            ),
                          ),
                        ],
                      ),
                      pw.Container(
                        width: 510,
                        height: 15,
                        decoration: pw.BoxDecoration(
                            border: pw.Border.all(
                                color: const PdfColor.fromInt(0xff000000)),
                            color: const PdfColor.fromInt(0xffe0e0e0)),
                        child: pw.Center(
                          child: pw.Text(
                            "DAMAGE CAR INFORMATION",
                            textAlign: pw.TextAlign.center,
                            style: const pw.TextStyle(fontSize: 10),
                          ),
                        ),
                      ),
                      pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.center,
                        children: [
                          pw.Container(
                            width: 255,
                            height: 15,
                            decoration: pw.BoxDecoration(
                                border: pw.Border.all(
                                    color: const PdfColor.fromInt(0xff000000)),
                                color: const PdfColor.fromInt(0xff82b1ff)),
                            child: pw.Center(
                              child: pw.Text(
                                "STOWAGE POSITION",
                                textAlign: pw.TextAlign.center,
                                style: const pw.TextStyle(fontSize: 10),
                              ),
                            ),
                          ),
                          pw.Container(
                            width: 127.5,
                            height: 15,
                            decoration: pw.BoxDecoration(
                                border: pw.Border.all(
                                    color: const PdfColor.fromInt(0xff000000)),
                                color: const PdfColor.fromInt(0xff82b1ff)),
                            child: pw.Center(
                              child: pw.Text(
                                "PORT OF LANDING",
                                textAlign: pw.TextAlign.center,
                                style: const pw.TextStyle(fontSize: 10),
                              ),
                            ),
                          ),
                          pw.Container(
                            width: 127.5,
                            height: 15,
                            decoration: pw.BoxDecoration(
                                border: pw.Border.all(
                                    color: const PdfColor.fromInt(0xff000000)),
                                color: const PdfColor.fromInt(0xff82b1ff)),
                            child: pw.Center(
                              child: pw.Text(
                                "PORT OF DISCHARDING",
                                textAlign: pw.TextAlign.center,
                                style: const pw.TextStyle(fontSize: 10),
                              ),
                            ),
                          ),
                        ],
                      ),
                      pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.center,
                        children: [
                          pw.Container(
                            width: 255,
                            height: 15,
                            decoration: pw.BoxDecoration(
                                border: pw.Border.all(
                                    color: const PdfColor.fromInt(0xff000000)),
                                color: const PdfColor.fromInt(0xffffffff)),
                            child: pw.Center(
                              child: pw.Text(
                                stowagePosition,
                                textAlign: pw.TextAlign.center,
                                style: const pw.TextStyle(fontSize: 10),
                              ),
                            ),
                          ),
                          pw.Container(
                            width: 127.5,
                            height: 15,
                            decoration: pw.BoxDecoration(
                                border: pw.Border.all(
                                    color: const PdfColor.fromInt(0xff000000)),
                                color: const PdfColor.fromInt(0xffffffff)),
                            child: pw.Center(
                              child: pw.Text(
                                portLanding,
                                textAlign: pw.TextAlign.center,
                                style: const pw.TextStyle(fontSize: 10),
                              ),
                            ),
                          ),
                          pw.Container(
                            width: 127.5,
                            height: 15,
                            decoration: pw.BoxDecoration(
                                border: pw.Border.all(
                                    color: const PdfColor.fromInt(0xff000000)),
                                color: const PdfColor.fromInt(0xffffffff)),
                            child: pw.Center(
                              child: pw.Text(
                                portDischard,
                                textAlign: pw.TextAlign.center,
                                style: const pw.TextStyle(fontSize: 10),
                              ),
                            ),
                          ),
                        ],
                      ),
                      pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.center,
                        children: [
                          pw.Container(
                            width: 127.5,
                            height: 15,
                            decoration: pw.BoxDecoration(
                                border: pw.Border.all(
                                    color: const PdfColor.fromInt(0xff000000)),
                                color: const PdfColor.fromInt(0xff82b1ff)),
                            child: pw.Center(
                              child: pw.Text(
                                "MAKER",
                                textAlign: pw.TextAlign.center,
                                style: const pw.TextStyle(fontSize: 10),
                              ),
                            ),
                          ),
                          pw.Container(
                            width: 127.5,
                            height: 15,
                            decoration: pw.BoxDecoration(
                                border: pw.Border.all(
                                    color: const PdfColor.fromInt(0xff000000)),
                                color: const PdfColor.fromInt(0xff82b1ff)),
                            child: pw.Center(
                              child: pw.Text(
                                "MODEL",
                                textAlign: pw.TextAlign.center,
                                style: const pw.TextStyle(fontSize: 10),
                              ),
                            ),
                          ),
                          pw.Container(
                            width: 255,
                            height: 15,
                            decoration: pw.BoxDecoration(
                                border: pw.Border.all(
                                    color: const PdfColor.fromInt(0xff000000)),
                                color: const PdfColor.fromInt(0xff82b1ff)),
                            child: pw.Center(
                              child: pw.Text(
                                "CONSIGNEE",
                                textAlign: pw.TextAlign.center,
                                style: const pw.TextStyle(fontSize: 10),
                              ),
                            ),
                          ),
                        ],
                      ),
                      pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.center,
                        children: [
                          pw.Container(
                            width: 127.5,
                            height: 15,
                            decoration: pw.BoxDecoration(
                                border: pw.Border.all(
                                    color: const PdfColor.fromInt(0xff000000)),
                                color: const PdfColor.fromInt(0xffffffff)),
                            child: pw.Center(
                              child: pw.Text(
                                marca,
                                textAlign: pw.TextAlign.center,
                                style: const pw.TextStyle(fontSize: 10),
                              ),
                            ),
                          ),
                          pw.Container(
                            width: 127.5,
                            height: 15,
                            decoration: pw.BoxDecoration(
                                border: pw.Border.all(
                                    color: const PdfColor.fromInt(0xff000000)),
                                color: const PdfColor.fromInt(0xffffffff)),
                            child: pw.Center(
                              child: pw.Text(
                                modelo,
                                textAlign: pw.TextAlign.center,
                                style: const pw.TextStyle(fontSize: 10),
                              ),
                            ),
                          ),
                          pw.Container(
                            width: 255,
                            height: 15,
                            decoration: pw.BoxDecoration(
                                border: pw.Border.all(
                                    color: const PdfColor.fromInt(0xff000000)),
                                color: const PdfColor.fromInt(0xffffffff)),
                            child: pw.Center(
                              child: pw.Text(
                                consignatario,
                                textAlign: pw.TextAlign.center,
                                style: const pw.TextStyle(fontSize: 10),
                              ),
                            ),
                          ),
                        ],
                      ),
                      pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.center,
                        children: [
                          pw.Container(
                            width: 255,
                            height: 15,
                            decoration: pw.BoxDecoration(
                                border: pw.Border.all(
                                    color: const PdfColor.fromInt(0xff000000)),
                                color: const PdfColor.fromInt(0xff82b1ff)),
                            child: pw.Center(
                              child: pw.Text(
                                "CHASSIS NUMBER",
                                textAlign: pw.TextAlign.center,
                                style: const pw.TextStyle(fontSize: 10),
                              ),
                            ),
                          ),
                          pw.Container(
                            width: 255,
                            height: 15,
                            decoration: pw.BoxDecoration(
                                border: pw.Border.all(
                                    color: const PdfColor.fromInt(0xff000000)),
                                color: const PdfColor.fromInt(0xff82b1ff)),
                            child: pw.Center(
                              child: pw.Text(
                                "BILL OF LADING",
                                textAlign: pw.TextAlign.center,
                                style: const pw.TextStyle(fontSize: 10),
                              ),
                            ),
                          ),
                        ],
                      ),
                      pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.center,
                        children: [
                          pw.Container(
                            width: 255,
                            height: 15,
                            decoration: pw.BoxDecoration(
                                border: pw.Border.all(
                                    color: const PdfColor.fromInt(0xff000000)),
                                color: const PdfColor.fromInt(0xffffffff)),
                            child: pw.Center(
                              child: pw.Text(
                                chasis,
                                textAlign: pw.TextAlign.center,
                                style: const pw.TextStyle(fontSize: 10),
                              ),
                            ),
                          ),
                          pw.Container(
                            width: 255,
                            height: 15,
                            decoration: pw.BoxDecoration(
                                border: pw.Border.all(
                                    color: const PdfColor.fromInt(0xff000000)),
                                color: const PdfColor.fromInt(0xffffffff)),
                            child: pw.Center(
                              child: pw.Text(
                                bl,
                                textAlign: pw.TextAlign.center,
                                style: const pw.TextStyle(fontSize: 10),
                              ),
                            ),
                          ),
                        ],
                      ),
                      pw.Row(children: [
                        pw.Column(children: [
                          pw.Container(
                            width: 255,
                            height: 15,
                            decoration: pw.BoxDecoration(
                                border: pw.Border.all(
                                    color: const PdfColor.fromInt(0xff000000)),
                                color: const PdfColor.fromInt(0xff82b1ff)),
                            child: pw.Center(
                              child: pw.Text(
                                "CHASSIS PHOTO",
                                textAlign: pw.TextAlign.center,
                                style: const pw.TextStyle(fontSize: 10),
                              ),
                            ),
                          ),
                          pw.Container(
                              width: 255,
                              height: 90,
                              decoration: pw.BoxDecoration(
                                  border: pw.Border.all(
                                      color:
                                          const PdfColor.fromInt(0xff000000)),
                                  color: const PdfColor.fromInt(0xffffffff)),
                              child: pw.Center(
                                  child: pw.Image(
                                fotoChasis,
                                width: 110,
                              ))),
                        ]),
                        pw.Column(
                          mainAxisAlignment: pw.MainAxisAlignment.center,
                          children: [
                            pw.Container(
                              width: 255,
                              height: 15,
                              decoration: pw.BoxDecoration(
                                  border: pw.Border.all(
                                      color:
                                          const PdfColor.fromInt(0xff000000)),
                                  color: const PdfColor.fromInt(0xffe0e0e0)),
                              child: pw.Center(
                                child: pw.Text(
                                  "OUTLINES OF DAMAGE",
                                  textAlign: pw.TextAlign.center,
                                  style: const pw.TextStyle(fontSize: 10),
                                ),
                              ),
                            ),
                            pw.Container(
                              width: 255,
                              height: 15,
                              decoration: pw.BoxDecoration(
                                  border: pw.Border.all(
                                      color:
                                          const PdfColor.fromInt(0xff000000)),
                                  color: const PdfColor.fromInt(0xff82b1ff)),
                              child: pw.Center(
                                child: pw.Text(
                                  "NAME OF DRIVER CAUSING DAMAGE",
                                  textAlign: pw.TextAlign.center,
                                  style: const pw.TextStyle(fontSize: 10),
                                ),
                              ),
                            ),
                            pw.Container(
                              width: 255,
                              height: 15,
                              decoration: pw.BoxDecoration(
                                  border: pw.Border.all(
                                      color:
                                          const PdfColor.fromInt(0xff000000)),
                                  color: const PdfColor.fromInt(0xffffffff)),
                              child: pw.Center(
                                child: pw.Text(
                                  nombreConductor,
                                  textAlign: pw.TextAlign.center,
                                  style: const pw.TextStyle(fontSize: 10),
                                ),
                              ),
                            ),
                            pw.Container(
                              width: 255,
                              height: 15,
                              decoration: pw.BoxDecoration(
                                  border: pw.Border.all(
                                      color:
                                          const PdfColor.fromInt(0xff000000)),
                                  color: const PdfColor.fromInt(0xff82b1ff)),
                              child: pw.Center(
                                child: pw.Text(
                                  "PLACE OF ACCIDENT/DAMAGE",
                                  textAlign: pw.TextAlign.center,
                                  style: const pw.TextStyle(fontSize: 10),
                                ),
                              ),
                            ),
                            pw.Container(
                              width: 255,
                              height: 15,
                              decoration: pw.BoxDecoration(
                                  border: pw.Border.all(
                                      color:
                                          const PdfColor.fromInt(0xff000000)),
                                  color: const PdfColor.fromInt(0xffffffff)),
                              child: pw.Center(
                                child: pw.Text(
                                  lugarAccidente,
                                  textAlign: pw.TextAlign.center,
                                  style: const pw.TextStyle(fontSize: 10),
                                ),
                              ),
                            ),
                            pw.Container(
                              width: 255,
                              height: 15,
                              decoration: pw.BoxDecoration(
                                  border: pw.Border.all(
                                      color:
                                          const PdfColor.fromInt(0xff000000)),
                                  color: const PdfColor.fromInt(0xff82b1ff)),
                              child: pw.Center(
                                child: pw.Text(
                                  "DATE & TIME ACCIDENT/DAMAGE",
                                  textAlign: pw.TextAlign.center,
                                  style: const pw.TextStyle(fontSize: 10),
                                ),
                              ),
                            ),
                            pw.Container(
                              width: 255,
                              height: 15,
                              decoration: pw.BoxDecoration(
                                  border: pw.Border.all(
                                      color:
                                          const PdfColor.fromInt(0xff000000)),
                                  color: const PdfColor.fromInt(0xffffffff)),
                              child: pw.Center(
                                child: pw.Text(
                                  fechaAccidente.toString(),
                                  textAlign: pw.TextAlign.center,
                                  style: const pw.TextStyle(fontSize: 10),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ]),
                    ],
                  ),
                  pw.Container(
                    width: 510,
                    height: 15,
                    decoration: pw.BoxDecoration(
                        border: pw.Border.all(
                            color: const PdfColor.fromInt(0xff000000)),
                        color: const PdfColor.fromInt(0xff000000)),
                    child: pw.Center(
                      child: pw.Text(
                        "2ND INFORMATION",
                        style: const pw.TextStyle(
                            color: PdfColor.fromInt(0xffffffff), fontSize: 10),
                      ),
                    ),
                  ),
                  pw.Column(
                    children: [
                      /* pw.Container(
                        width: 510,
                        height: 15,
                        decoration: pw.BoxDecoration(
                            border: pw.Border.all(
                                color: const PdfColor.fromInt(0xff000000)),
                            color: const PdfColor.fromInt(0xff82b1ff)),
                        child: pw.Center(
                          child: pw.Text(
                            "DAMAGE TYPE",
                            textAlign: pw.TextAlign.center,
                            style: const pw.TextStyle(fontSize: 10),
                          ),
                        ),
                      ),
                      pw.Container(
                        width: 510,
                        height: 100,
                        decoration: pw.BoxDecoration(
                            border: pw.Border.all(
                                color: const PdfColor.fromInt(0xff000000)),
                            color: const PdfColor.fromInt(0xffffffff)),
                        child: pw.Column(
                          children: [
                            pw.Row(
                                crossAxisAlignment: pw.CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    pw.MainAxisAlignment.spaceBetween,
                                children: [
                                  pw.Text("codigo"),
                                  pw.SizedBox(width: 10),
                                  pw.Text("dano"),
                                  pw.SizedBox(width: 10),
                                  pw.Text("parte"),
                                  pw.SizedBox(width: 10),
                                  pw.Text("zona"),
                                  pw.SizedBox(width: 10),
                                ]),
                            pw.Center(
                                child: pw.Table(children: [
                              for (var i = 0;
                                  i < damageTypeByIdDrModelList.length;
                                  i++)
                                pw.TableRow(children: [
                                  pw.Column(
                                      crossAxisAlignment:
                                          pw.CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          pw.MainAxisAlignment.center,
                                      children: [
                                        pw.Text(
                                            damageTypeByIdDrModelList[i]
                                                .codigoDano!,
                                            style: pw.TextStyle(fontSize: 10)),
                                        pw.Divider(thickness: 1)
                                      ]),
                                  pw.Column(
                                      crossAxisAlignment:
                                          pw.CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          pw.MainAxisAlignment.center,
                                      children: [
                                        pw.Text(
                                            damageTypeByIdDrModelList[i]
                                                .danoRegistrado!,
                                            style: pw.TextStyle(fontSize: 10)),
                                        pw.Divider(thickness: 1)
                                      ]),
                                  pw.Column(
                                      crossAxisAlignment:
                                          pw.CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          pw.MainAxisAlignment.center,
                                      children: [
                                        pw.Text(
                                            damageTypeByIdDrModelList[i]
                                                .parteVehiculo!,
                                            style: pw.TextStyle(fontSize: 10)),
                                        pw.Divider(thickness: 1)
                                      ]),
                                  pw.Column(
                                      crossAxisAlignment:
                                          pw.CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          pw.MainAxisAlignment.center,
                                      children: [
                                        pw.Text(
                                            damageTypeByIdDrModelList[i]
                                                .zonaVehiculo!,
                                            style: pw.TextStyle(fontSize: 10)),
                                        pw.Divider(thickness: 1)
                                      ])
                                ])
                            ])),
                          ],
                        ),
                      ), */
                      pw.Container(
                        width: 510,
                        height: 15,
                        decoration: pw.BoxDecoration(
                            border: pw.Border.all(
                                color: const PdfColor.fromInt(0xff000000)),
                            color: const PdfColor.fromInt(0xff82b1ff)),
                        child: pw.Center(
                          child: pw.Text(
                            "EVIDENCE",
                            textAlign: pw.TextAlign.center,
                            style: const pw.TextStyle(fontSize: 10),
                          ),
                        ),
                      ),
                      pw.Container(
                        width: 510,
                        decoration: pw.BoxDecoration(
                            border: pw.Border.all(
                                color: const PdfColor.fromInt(0xff000000)),
                            color: const PdfColor.fromInt(0xffffffff)),
                        child: pw.Column(
                          children: [
                            /* pw.SizedBox(
                              height: 10,
                            ),
                            pw.Text("Chassis Photo"),
                            pw.SizedBox(
                              height: 5,
                            ),
                            pw.Image(
                              fotoChasis,
                              height: 100,
                              width: 100,
                            ),*/
                            pw.SizedBox(height: 10),
                            /* pw.ListView.builder(
                              itemCount: damageTypeByIdDrModelList.length,
                              itemBuilder: (context, index) {
                                final item = damageTypeByIdDrModelList[index];
                                return pw.Column(
                                    crossAxisAlignment:
                                        pw.CrossAxisAlignment.start,
                                    children: [
                                      pw.Image(
                                        foto2danos,
                                        height: 15,
                                        width: 20,
                                      ),
                                    ]);
                              },
                            ), */
                            /* pw.Table(
                                /* border:
                                    pw.TableBorder.all(color: Colors.blueGrey), */
                                children: [
                                  for (var i = 0;
                                      i < damageTypeByIdDrModelList.length;
                                      /* listImagenesDanos[i].imagenes =
                                          networkImage(
                                              damageTypeByIdDrModelList[i]
                                                  .fotoDano!), */
                                      i++)
                                    pw.TableRow(children: [
                                      pw.Column(children: [
                                        pw.SizedBox(
                                          height: 10,
                                        ),
                                        pw.Row(
                                          mainAxisAlignment:
                                              pw.MainAxisAlignment.spaceEvenly,
                                          children: [
                                            pw.Image(listaImagenes[i],
                                                height: 100, width: 100),
                                            pw.Column(
                                              crossAxisAlignment:
                                                  pw.CrossAxisAlignment.start,
                                              children: [
                                                pw.Text(
                                                  "Codigo de daño: ${damageTypeByIdDrModelList[i].codigoDano!}",
                                                ),
                                                pw.Text(
                                                  "Daño: ${damageTypeByIdDrModelList[i].danoRegistrado!}",
                                                ),
                                                pw.Text(
                                                  "Parte: ${damageTypeByIdDrModelList[i].parteVehiculo!}",
                                                ),
                                                pw.Text(
                                                  "Zona: ${damageTypeByIdDrModelList[i].zonaVehiculo!}",
                                                ),
                                                pw.Text(
                                                  "Faltantes: ${damageTypeByIdDrModelList[i].descipcionFaltantes!}",
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        pw.SizedBox(
                                          height: 10,
                                        ),

                                      ]),
                                    ])
                                ]), */
                            pw.GridView(
                                // crossAxisCount is the number of columns
                                crossAxisCount: 2,
                                childAspectRatio: 1 / 1.40,
                                /*  mainAxisSpacing: 8.0,
                                crossAxisSpacing: 8.0, */

                                // This creates two columns with two items in each column
                                children: [
                                  for (var i = 0;
                                      i < damageTypeByIdDrModelList.length;
                                      /* listImagenesDanos[i].imagenes =
                                          networkImage(
                                              damageTypeByIdDrModelList[i]
                                                  .fotoDano!), */
                                      i++)
                                    pw.Container(
                                      child: pw.Column(children: [
                                        pw.Image(listaImagenes[i],
                                            width: 100, height: 100),
                                        pw.Text(
                                            "${damageTypeByIdDrModelList[i].codigoDano!} / ${damageTypeByIdDrModelList[i].danoRegistrado!} / ${damageTypeByIdDrModelList[i].parteVehiculo!} / ${damageTypeByIdDrModelList[i].zonaVehiculo!}",
                                            style: const pw.TextStyle(
                                                fontSize: 10)),
                                        pw.Text(
                                            "Faltantes: ${damageTypeByIdDrModelList[i].descipcionFaltantes!}",
                                            style: const pw.TextStyle(
                                                fontSize: 10)),
                                      ]),
                                    )
                                ]),
                            pw.SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                      pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.center,
                        children: [
                          pw.Container(
                            width: 255,
                            height: 15,
                            decoration: pw.BoxDecoration(
                                border: pw.Border.all(
                                    color: const PdfColor.fromInt(0xff000000)),
                                color: const PdfColor.fromInt(0xff82b1ff)),
                            child: pw.Center(
                              child: pw.Text(
                                "VESSEL OFFICER",
                                textAlign: pw.TextAlign.center,
                                style: const pw.TextStyle(fontSize: 10),
                              ),
                            ),
                          ),
                          pw.Container(
                            width: 255,
                            height: 15,
                            decoration: pw.BoxDecoration(
                                border: pw.Border.all(
                                    color: const PdfColor.fromInt(0xff000000)),
                                color: const PdfColor.fromInt(0xff82b1ff)),
                            child: pw.Center(
                              child: pw.Text(
                                "MARITIME AGENCY",
                                textAlign: pw.TextAlign.center,
                                style: const pw.TextStyle(fontSize: 10),
                              ),
                            ),
                          ),
                        ],
                      ),
                      pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.center,
                        children: [
                          pw.Container(
                            width: 255,
                            height: 15,
                            decoration: pw.BoxDecoration(
                                border: pw.Border.all(
                                    color: const PdfColor.fromInt(0xff000000)),
                                color: const PdfColor.fromInt(0xffffffff)),
                            child: pw.Center(
                              child: pw.Text(
                                vesselOficer,
                                textAlign: pw.TextAlign.center,
                                style: const pw.TextStyle(fontSize: 10),
                              ),
                            ),
                          ),
                          pw.Container(
                            width: 255,
                            height: 15,
                            decoration: pw.BoxDecoration(
                                border: pw.Border.all(
                                    color: const PdfColor.fromInt(0xff000000)),
                                color: const PdfColor.fromInt(0xffffffff)),
                            child: pw.Center(
                              child: pw.Text(
                                agenciaMaritima,
                                textAlign: pw.TextAlign.center,
                                style: const pw.TextStyle(fontSize: 10),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              pw.SizedBox(
                height: 15,
              ),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                crossAxisAlignment: pw.CrossAxisAlignment.center,
                children: [
                  pw.Column(
                    mainAxisAlignment: pw.MainAxisAlignment.center,
                    children: [
                      pw.Container(
                          width: 250,
                          padding: const pw.EdgeInsets.all(5.0),
                          decoration: pw.BoxDecoration(
                              border: pw.Border.all(
                                  color: const PdfColor.fromInt(0xff000000)),
                              color: const PdfColor.fromInt(0xffffffff)),
                          child: pw.Row(children: [
                            pw.Image(apmLogo, height: 50, width: 50),
                            pw.SizedBox(
                              width: 10,
                            ),
                            pw.Column(
                                crossAxisAlignment: pw.CrossAxisAlignment.start,
                                children: [
                                  pw.Text(
                                    "Digitally signed by:",
                                    style: const pw.TextStyle(fontSize: 10),
                                  ),
                                  pw.Text(
                                    nombreAPMTC,
                                    style: const pw.TextStyle(fontSize: 10),
                                  ),
                                  pw.Text(
                                    "APMTC TERMINALS",
                                    style: const pw.TextStyle(fontSize: 10),
                                  ),
                                  pw.Text(
                                    "Document Status: $aprobadoAPMTC",
                                    style: const pw.TextStyle(fontSize: 10),
                                  ),
                                ])
                          ])),
                      pw.SizedBox(
                        height: 10,
                      ),
                      pw.Container(
                          width: 250,
                          padding: const pw.EdgeInsets.all(5.0),
                          decoration: pw.BoxDecoration(
                              border: pw.Border.all(
                                  color: const PdfColor.fromInt(0xff000000)),
                              color: const PdfColor.fromInt(0xffffffff)),
                          child: pw.Row(children: [
                            pw.Image(consumarLogo, height: 50, width: 50),
                            pw.SizedBox(
                              width: 10,
                            ),
                            pw.Column(
                                crossAxisAlignment: pw.CrossAxisAlignment.start,
                                children: [
                                  pw.Text(
                                    "Digitally signed by:",
                                    style: const pw.TextStyle(fontSize: 10),
                                  ),
                                  pw.Text(
                                    nombreCoordinador,
                                    style: const pw.TextStyle(fontSize: 10),
                                  ),
                                  pw.Text(
                                    "CONSUMARPORT SURVEYOR",
                                    style: const pw.TextStyle(fontSize: 10),
                                  ),
                                  pw.Text(
                                    "Document Status: $aprobadoCoordinador",
                                    style: const pw.TextStyle(fontSize: 10),
                                  ),
                                ])
                          ])),
                    ],
                  ),
                  pw.Container(
                    width: 150,
                    padding: const pw.EdgeInsets.all(5.0),
                    decoration: pw.BoxDecoration(
                        border: pw.Border.all(
                            color: const PdfColor.fromInt(0xff000000)),
                        color: const PdfColor.fromInt(0xffffffff)),
                    child: pw.Column(children: [
                      pw.Text(vessel,
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                      pw.Center(
                        child:
                            pw.Image(fotoFirmaCapitan, height: 80, width: 80),
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
                      pw.Text(vesselOficer,
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                          textAlign: pw.TextAlign.center),
                    ]),
                  ),
                ],
              ),
              pw.SizedBox(
                height: 50,
              ),
              pw.BarcodeWidget(
                barcode: pw.Barcode.qrCode(),
                data: 'consumarport.com.pe/login',
                height: 100.0,
                width: 100.0,
              ),
              pw.SizedBox(height: 10),
              pw.Container(
                width: 200,
                padding: const pw.EdgeInsets.all(5.0),
                decoration: pw.BoxDecoration(
                    border: pw.Border.all(
                        color: const PdfColor.fromInt(0xff000000)),
                    color: const PdfColor.fromInt(0xffffffff)),
                child: pw.Text(
                    "Representacion del documento Electronico, consultar su documento en consumarport.com.pe/login",
                    style: const pw.TextStyle(fontSize: 10),
                    textAlign: pw.TextAlign.center),
              ),
              pw.SizedBox(
                height: 20,
              ),
            ]),
          ); // Center
        },
      ),
    ); // Page
    await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => doc.save());

    /// print the document using the iOS or Android print service:
    return doc.save();
    /*final file = File('AutoreportPdf.pdf');
    await file.writeAsBytes(await doc.save());*/
  }
}
