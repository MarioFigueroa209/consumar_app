import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import '../../../models/roro/autoreport/vw_autoreport_data.dart';
import '../../../models/roro/autoreport/vw_participantes_by_autoreport_model.dart';
import '../../../utils/constants.dart';
import 'autoreport_service.dart';

class AutoreportPdfService {
  bool danosAcopio = false;
  bool participantesInspeccion = false;
  bool plumillasDelanteras = false;
  bool plumillasTraseras = false;
  bool antena = false;
  bool tapaNeumatico = false;
  bool copasAro = false;
  bool radio = false;
  bool controlRemotoradio = false;
  bool tacometro = false;
  bool tacografo = false;
  bool encendedor = false;
  bool reloj = false;
  bool pisosAdicionales = false;
  bool llantaRepuesto = false;
  bool herramientas = false;
  bool relays = false;
  bool estuche = false;
  bool pinRemolque = false;
  bool caja = false;
  bool cajaEstado = false;
  bool maletin = false;
  bool maletinEstado = false;
  bool bolsaPlastica = false;
  bool bolsaPlasticaEstado = false;
  bool ceniceros = false;
  bool espejosInterior = false;
  bool espejosLaterales = false;
  bool gata = false;
  bool extintor = false;
  bool pantallaTactil = false;
  bool linterna = false;
  bool cableCargadorBateria = false;
  bool circulina = false;
  bool cableCargadorVehiculoElectrico = false;
  bool cd = false;
  bool trianguloSeguridad = false;
  bool catalogo = false;
  bool llaves = false;
  bool llavesPrecintas = false;
  bool presenciaSeguro = false;
  bool usb = false;
  bool memoriaSd = false;
  bool camaraSeguridad = false;
  bool radioComunicador = false;
  bool mangueraAire = false;
  bool cableCargador = false;
  bool llaveRuedas = false;
  bool chaleco = false;
  bool galonera = false;
  bool controlRemotoMaquinaria = false;

  String damageReportText = "NO";
  String danosAcopioText = "NO";
  String participantesInspeccionText = "NO";
  String presenciaSeguroText = "NO";

  String plumillasDelanterasText = "no visible";
  String plumillasTraserasText = "no visible";
  String antenaText = "no visible";
  String tapaNeumaticoText = "no visible";
  String copasAroText = "no visible";
  String radioText = "no visible";
  String controlRemotoradioText = "no visible";
  String tacometroText = "no visible";
  String tacografoText = "no visible";
  String encendedorText = "no visible";
  String relojText = "no visible";
  String pisosAdicionalesText = "no visible";
  String llantaRepuestoText = "no visible";
  String herramientasText = "no visible";
  String relaysText = "no visible";
  String estucheText = "no visible";
  String pinRemolqueText = "no visible";
  String cajaText = "no visible";
  String cajaEstadoText = "no visible";
  String maletinText = "no visible";
  String maletinEstadoText = "no visible";
  String bolsaPlasticaText = "no visible";
  String bolsaPlasticaEstadoText = "no visible";
  String cenicerosText = "no visible";
  String espejosInteriorText = "no visible";
  String espejosLateralesText = "no visible";
  String gataText = "no visible";
  String extintorText = "no visible";
  String pantallaTactilText = "no visible";
  String linternaText = "no visible";
  String cableCargadorBateriaText = "no visible";
  String circulinaText = "no visible";
  String cableCargadorVehiculoElectricoText = "no visible";
  String cdText = "no visible";
  String trianguloSeguridadText = "no visible";
  String catalogoText = "no visible";
  String llavesText = "no visible";
  String usbText = "no visible";
  String memoriaSdText = "no visible";
  String camaraSeguridadText = "no visible";
  String radioComunicadorText = "no visible";
  String mangueraAireText = "no visible";
  String cableCargadorText = "no visible";
  String llaveRuedasText = "no visible";
  String chalecoText = "no visible";
  String galoneraText = "no visible";
  String controlRemotoMaquinariaText = "no visible";
  String llavesPrecintasText = "no";

  String zona = "";
  DateTime? fecha;
  String fila = "";
  String nave = "";
  String bl = "";
  String chasis = "";
  String marca = "";
  String nDamageReport = "";
  String llavesSimplesText = "no";
  String llavesInteligentesText = "no";
  String llavesComandoText = "no";
  String llavesPinText = "no";
  String comentario = "";
  String idAutoreportData = "";
  String codAutoreport = "";

  String otros = "";

  int nllavesSimples = 0;
  int nllavesInteligentes = 0;
  int nllavesComando = 0;
  int nllavesPin = 0;

  AutoreportService autoreportService = AutoreportService();
  VwAutoreportData vwAutoreportDataEdit = VwAutoreportData();

  getAutoreportDataById(BigInt idAutoreport) async {
    vwAutoreportDataEdit =
        await autoreportService.getAutoreportDataById(idAutoreport);

    idAutoreportData = vwAutoreportDataEdit.idAutoreport!.toString();
    nave = vwAutoreportDataEdit.nave!;
    fecha = vwAutoreportDataEdit.fechaHora!;
    bl = vwAutoreportDataEdit.bl!;
    zona = vwAutoreportDataEdit.zona!;
    fila = vwAutoreportDataEdit.fila!;
    chasis = vwAutoreportDataEdit.chassis!;
    marca = vwAutoreportDataEdit.marca!;
    nDamageReport = vwAutoreportDataEdit.codigoDr!;
    danosAcopio = vwAutoreportDataEdit.danoAcopio!;
    participantesInspeccion = vwAutoreportDataEdit.participantesInspeccion!;
    presenciaSeguro = vwAutoreportDataEdit.presenciaSeguro!;
    plumillasDelanteras = vwAutoreportDataEdit.plumillasDelanteras!;
    plumillasTraseras = vwAutoreportDataEdit.plumillasTraseras!;
    antena = vwAutoreportDataEdit.antena!;
    controlRemotoradio = vwAutoreportDataEdit.controlRemotoRadio!;
    espejosInterior = vwAutoreportDataEdit.espejosInteriores!;
    espejosLaterales = vwAutoreportDataEdit.espejosLaterales!;
    extintor = vwAutoreportDataEdit.extintor!;
    pantallaTactil = vwAutoreportDataEdit.pantallaTactil!;
    copasAro = vwAutoreportDataEdit.copasAro!;
    tapaNeumatico = vwAutoreportDataEdit.tapaLlanta!;
    radio = vwAutoreportDataEdit.radio!;
    tacografo = vwAutoreportDataEdit.tacografo!;
    tacometro = vwAutoreportDataEdit.tacometro!;
    encendedor = vwAutoreportDataEdit.encendedor!;
    reloj = vwAutoreportDataEdit.reloj!;
    pinRemolque = vwAutoreportDataEdit.pinRemolque!;
    caja = vwAutoreportDataEdit.caja!;
    cajaEstado = vwAutoreportDataEdit.cajaEstado!;
    maletin = vwAutoreportDataEdit.maletin!;
    maletinEstado = vwAutoreportDataEdit.maletinEstado!;
    bolsaPlastica = vwAutoreportDataEdit.bolsaPlastica!;
    bolsaPlasticaEstado = vwAutoreportDataEdit.bolsaPlasticaEstado!;
    estuche = vwAutoreportDataEdit.estuche!;
    pisosAdicionales = vwAutoreportDataEdit.pisosAdicionales!;
    llantaRepuesto = vwAutoreportDataEdit.llantaRepuesto!;
    herramientas = vwAutoreportDataEdit.herramienta!;
    relays = vwAutoreportDataEdit.relays!;
    ceniceros = vwAutoreportDataEdit.ceniceros!;
    linterna = vwAutoreportDataEdit.linterna!;
    cableCargadorBateria = vwAutoreportDataEdit.cableCargadorBateria!;
    circulina = vwAutoreportDataEdit.circulina!;
    cableCargadorVehiculoElectrico =
        vwAutoreportDataEdit.cableCargadorVehiculoElectrico!;
    cd = vwAutoreportDataEdit.cd!;
    usb = vwAutoreportDataEdit.usb!;
    memoriaSd = vwAutoreportDataEdit.memoriaSd!;
    camaraSeguridad = vwAutoreportDataEdit.camaraSeguridad!;
    radioComunicador = vwAutoreportDataEdit.radioComunicador!;
    mangueraAire = vwAutoreportDataEdit.mangueraAire!;
    cableCargador = vwAutoreportDataEdit.cableCargador!;
    llaveRuedas = vwAutoreportDataEdit.llaveRuedas!;
    chaleco = vwAutoreportDataEdit.chaleco!;
    galonera = vwAutoreportDataEdit.galonera!;
    controlRemotoMaquinaria = vwAutoreportDataEdit.controlRemotoMaquinaria!;
    otros = vwAutoreportDataEdit.otros!;
    gata = vwAutoreportDataEdit.gata!;
    trianguloSeguridad = vwAutoreportDataEdit.trianguloSeguridad!;
    catalogo = vwAutoreportDataEdit.catalogos!;
    llaves = vwAutoreportDataEdit.llave!;
    llavesPrecintas = vwAutoreportDataEdit.llavesPrecintas!;
    nllavesSimples = vwAutoreportDataEdit.nllavesSimples!;
    nllavesInteligentes = vwAutoreportDataEdit.nllavesInteligentes!;
    nllavesComando = vwAutoreportDataEdit.nllavesComando!;
    nllavesPin = vwAutoreportDataEdit.nllavesPin!;
    comentario = vwAutoreportDataEdit.comentario!;
    codAutoreport = vwAutoreportDataEdit.codAutoreport!;

    if (nDamageReport != "") {
      damageReportText = "SI";
    }
    if (danosAcopio == true) {
      danosAcopioText = "SI";
    }
    if (participantesInspeccion == true) {
      participantesInspeccionText = "SI";
    }
    if (presenciaSeguro == true) {
      presenciaSeguroText = "SI";
    }
    if (plumillasDelanteras == true) {
      plumillasDelanterasText = "visible";
    }
    if (plumillasTraseras == true) {
      plumillasTraserasText = "visible";
    }
    if (antena == true) {
      antenaText = "visible";
    }
    if (espejosInterior == true) {
      espejosInteriorText = "visible";
    }
    if (espejosLaterales == true) {
      espejosLateralesText = "visible";
    }
    if (tapaNeumatico == true) {
      tapaNeumaticoText = "visible";
    }
    if (espejosInterior == true) {
      espejosInteriorText = "visible";
    }
    if (espejosLaterales == true) {
      espejosLateralesText = "visible";
    }
    if (copasAro == true) {
      copasAroText = "visible";
    }
    if (radio == true) {
      radioText = "visible";
    }
    if (controlRemotoradio == true) {
      controlRemotoradioText = "visible";
    }
    if (tacografo == true) {
      tacografoText = "visible";
    }
    if (tacometro == true) {
      tacometroText = "visible";
    }
    if (encendedor == true) {
      encendedorText = "visible";
    }
    if (extintor == true) {
      extintorText = "visible";
    }
    if (reloj == true) {
      relojText = "visible";
    }
    if (pantallaTactil == true) {
      pantallaTactilText = "visible";
    }
    if (pisosAdicionales == true) {
      pisosAdicionalesText = "visible";
    }
    if (llantaRepuesto == true) {
      llantaRepuestoText = "visible";
    }
    if (herramientas == true) {
      herramientasText = "visible";
    }
    if (relays == true) {
      relaysText = "visible";
    }
    if (linterna == true) {
      linternaText = "visible";
    }
    if (cableCargadorBateria == true) {
      cableCargadorBateriaText = "visible";
    }
    if (circulina == true) {
      circulinaText = "visible";
    }
    if (cableCargadorVehiculoElectrico == true) {
      cableCargadorVehiculoElectricoText = "visible";
    }
    if (cd == true) {
      cdText = "visible";
    }
    if (usb == true) {
      usbText = "visible";
    }
    if (memoriaSd == true) {
      memoriaSdText = "visible";
    }
    if (camaraSeguridad == true) {
      camaraSeguridadText = "visible";
    }
    if (radioComunicador == true) {
      radioComunicadorText = "visible";
    }
    if (mangueraAire == true) {
      mangueraAireText = "visible";
    }
    if (cableCargador == true) {
      cableCargadorText = "visible";
    }
    if (llaveRuedas == true) {
      llaveRuedasText = "visible";
    }
    if (chaleco == true) {
      chalecoText = "visible";
    }
    if (galonera == true) {
      galoneraText = "visible";
    }
    if (controlRemotoMaquinaria == true) {
      controlRemotoMaquinariaText = "visible";
    }

    if (pinRemolque == true) {
      pinRemolqueText = "visible";
    }
    if (caja == true) {
      cajaText = "visible";
    }
    if (cajaEstado == true) {
      cajaEstadoText = "visible";
    }
    if (maletin == true) {
      maletinText = "visible";
    }
    if (maletinEstado == true) {
      maletinEstadoText = "visible";
    }
    if (bolsaPlastica == true) {
      bolsaPlasticaText = "visible";
    }
    if (bolsaPlasticaEstado == true) {
      bolsaPlasticaEstadoText = "visible";
    }
    if (estuche == true) {
      estucheText = "visible";
    }

    if (ceniceros == true) {
      cenicerosText = "visible";
    }
    if (gata == true) {
      gataText = "visible";
    }
    if (trianguloSeguridad == true) {
      trianguloSeguridadText = "visible";
    }
    if (catalogo == true) {
      catalogoText = "visible";
    }
    if (llaves == true) {
      llavesText = "visible";
    }
    if (llavesPrecintas == true) {
      llavesPrecintasText = "si";
    }
    if (nllavesSimples != 0) {
      llavesSimplesText = "si";
    }
    if (nllavesInteligentes != 0) {
      llavesInteligentesText = "si";
    }
    if (nllavesComando != 0) {
      llavesComandoText = "si";
    }
    if (nllavesPin != 0) {
      llavesPinText = "si";
    }
  }

  List<VwParticipantesByAutoreportModel> spParticipantesInspeccionModel = [];

  getParticipantesByIdAutoreport(BigInt idAutoreport) async {
    spParticipantesInspeccionModel =
        await autoreportService.getParticipantesByAutoreport(idAutoreport);
  }

  final doc = pw.Document();

  var pdf = pw.Document;
  late Future<Uint8List> archivoPdf;

  Future<void> initPDF(BigInt idAutoreport) async {
    getAutoreportDataById(idAutoreport);
    getParticipantesByIdAutoreport(idAutoreport);
    // //print("inicalizando pdf$idAutoreport");
    archivoPdf = createPdf(idAutoreport);
  }

  Future<Uint8List> createPdf(BigInt idAutoreport) async {
    await getAutoreportDataById(idAutoreport);
    await getParticipantesByIdAutoreport(idAutoreport);

    /// for using an image from assets
    final apmLogo = await imageFromAssetBundle('assets/images/apmlogo.jpg');
    final consumarLogo =
        await imageFromAssetBundle('assets/images/logotipoconsumar.jpg');

    final font = await rootBundle.load("assets/fonts/Ticketing.ttf");
    final ttf = pw.Font.ttf(font);
    //final codigoQr = await imageFromAssetBundle('assets/images/qrlogo.png');

    doc.addPage(
      pw.Page(
        // pageFormat: PdfPageFormat.a4,
        pageFormat: const PdfPageFormat(
            2.84 * PdfPageFormat.inch, double.infinity,
            marginAll: 0.4 * PdfPageFormat.cm),

        build: (pw.Context context) {
          return pw.Container(
            child: pw.Column(children: [
              pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Image(apmLogo, height: 50, width: 50),
                    pw.Image(consumarLogo, height: 50, width: 50),
                  ]),
              pw.Text("AUTOREPORT RORO",
                  maxLines: 2,
                  style: kTextoTituloPdfAutoreport(ttf),
                  overflow: pw.TextOverflow.clip,
                  textAlign: pw.TextAlign.center),
              pw.SizedBox(height: 2),
              pw.Text(codAutoreport,
                  maxLines: 2,
                  style: kTextoTituloPdfAutoreport(ttf),
                  overflow: pw.TextOverflow.clip,
                  textAlign: pw.TextAlign.center),
              pw.SizedBox(height: 5),
              pw.Container(
                width: 140,
                child: pw.Text("Fecha y hora: $fecha",
                    style: kTextoCuerpoPdfAutoreport(ttf),
                    textAlign: pw.TextAlign.center),
              ),
              pw.SizedBox(height: 5),
              pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text("Nave: $nave",
                        style: kTextoCuerpoPdfAutoreport(ttf)),
                    pw.Text("Zona: $zona Fila: $fila",
                        style: kTextoCuerpoPdfAutoreport(ttf)),
                    //pw.Text("Fila: $fila", style: kTextoCuerpoPdfAutoreport(ttf)),
                  ]),
              pw.SizedBox(
                height: 5,
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
              pw.Text("Descripcion", style: kTextoTituloPdfAutoreport(ttf)),
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
              pw.SizedBox(height: 5),
              pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text("BL: $bl", style: kTextoCuerpoPdfAutoreport(ttf)),
                    // pw.SizedBox(width: 60),
                    pw.Text("Marca: $marca",
                        style: kTextoCuerpoPdfAutoreport(ttf)),
                  ]),
              pw.SizedBox(height: 5),
              pw.Text("Chasis: $chasis", style: kTextoCuerpoPdfAutoreport(ttf)),
              pw.SizedBox(height: 8),
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
              pw.Text("Inventario", style: kTextoTituloPdfAutoreport(ttf)),
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
              pw.SizedBox(height: 5),
              pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Text("Damage Report",
                              style: kTextoCuerpoPdfAutoreport(ttf)),
                          pw.SizedBox(height: 2),
                          pw.Text("Participantes Insp.",
                              style: kTextoCuerpoPdfAutoreport(ttf)),
                          pw.SizedBox(height: 2),
                          pw.Text("Presencia Seguro",
                              style: kTextoCuerpoPdfAutoreport(ttf)),
                          pw.ListView.builder(
                            itemCount: spParticipantesInspeccionModel.length,
                            itemBuilder: (context, index) {
                              final item =
                                  spParticipantesInspeccionModel[index];
                              return pw.Column(
                                  crossAxisAlignment:
                                      pw.CrossAxisAlignment.start,
                                  children: [
                                    pw.Text("- ${item.nombreParticipante!}",
                                        style: kTextoCuerpoPdfAutoreport(ttf)),
                                    pw.Text("(${item.empresa!})",
                                        style: kTextoCuerpoPdfAutoreport(ttf)),
                                  ]);
                            },
                          )
                        ]),
                    pw.Column(children: [
                      pw.Text(damageReportText,
                          style: kTextoCuerpoPdfAutoreport(ttf)),
                      pw.SizedBox(height: 2),
                      pw.Text(participantesInspeccionText,
                          style: kTextoCuerpoPdfAutoreport(ttf)),
                      pw.SizedBox(height: 2),
                      pw.Text(presenciaSeguroText,
                          style: kTextoCuerpoPdfAutoreport(ttf))
                    ]),
                    pw.Column(children: [
                      pw.Text(nDamageReport,
                          style: kTextoCuerpoPdfAutoreport(ttf)),
                      pw.SizedBox(height: 2),
                      pw.Text("-", style: kTextoCuerpoPdfAutoreport(ttf))
                    ])
                  ]),
              pw.SizedBox(height: 10),
              pw.Row(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Text("Inventario",
                              style: kTextoTituloPdfAutoreport(ttf)),
                          pw.SizedBox(height: 5),
                          pw.Text("Antena",
                              style: kTextoCuerpoPdfAutoreport(ttf)),
                          pw.SizedBox(height: 2),
                          pw.Text("Catálogo",
                              style: kTextoCuerpoPdfAutoreport(ttf)),
                          pw.SizedBox(height: 2),
                          pw.Text("Ceniceros",
                              style: kTextoCuerpoPdfAutoreport(ttf)),
                          pw.SizedBox(height: 2),
                          pw.Text("Encendedor",
                              style: kTextoCuerpoPdfAutoreport(ttf)),
                          pw.SizedBox(height: 2),
                          pw.Text("Plumillas Delanteras",
                              style: kTextoCuerpoPdfAutoreport(ttf)),
                          pw.SizedBox(height: 2),
                          pw.Text("Plumillas Traseras",
                              style: kTextoCuerpoPdfAutoreport(ttf)),
                          pw.SizedBox(height: 2),
                          pw.Text("Radio",
                              style: kTextoCuerpoPdfAutoreport(ttf)),
                          pw.SizedBox(height: 2),
                          pw.Text("Control Remoto Radio",
                              style: kTextoCuerpoPdfAutoreport(ttf)),
                          pw.SizedBox(height: 2),
                          pw.Text("Espejos Interiores",
                              style: kTextoCuerpoPdfAutoreport(ttf)),
                          pw.SizedBox(height: 2),
                          pw.Text(
                            "Espejos Laterales",
                            style: kTextoCuerpoPdfAutoreport(ttf),
                          ),
                          pw.SizedBox(height: 2),
                          pw.Text("Tacógrafo",
                              style: kTextoCuerpoPdfAutoreport(ttf)),
                          pw.SizedBox(height: 2),
                          pw.Text("Tacómetro",
                              style: kTextoCuerpoPdfAutoreport(ttf)),
                          pw.SizedBox(height: 2),
                          pw.Text("Tapa Neumatico",
                              style: kTextoCuerpoPdfAutoreport(ttf)),
                          pw.SizedBox(height: 2),
                          pw.Text("Copas Aro",
                              style: kTextoCuerpoPdfAutoreport(ttf)),
                          pw.SizedBox(height: 2),
                          pw.Text("Reloj",
                              style: kTextoCuerpoPdfAutoreport(ttf)),
                          pw.SizedBox(height: 2),
                          pw.Text("Pisos Adicionales",
                              style: kTextoCuerpoPdfAutoreport(ttf)),
                          pw.SizedBox(height: 2),
                          pw.Text("Pantalla Táctil",
                              style: kTextoCuerpoPdfAutoreport(ttf)),
                          pw.SizedBox(height: 2),
                          pw.Text("Llanta de repuesto",
                              style: kTextoCuerpoPdfAutoreport(ttf)),
                          pw.SizedBox(height: 2),
                          pw.Text("Herramientas",
                              style: kTextoCuerpoPdfAutoreport(ttf)),
                          pw.SizedBox(height: 2),
                          pw.Text("Relays",
                              style: kTextoCuerpoPdfAutoreport(ttf)),
                          pw.SizedBox(height: 2),
                          pw.Text("Pin de Remolque",
                              style: kTextoCuerpoPdfAutoreport(ttf)),
                          pw.SizedBox(height: 2),
                          pw.Text("Caja",
                              style: kTextoCuerpoPdfAutoreport(ttf)),
                          pw.SizedBox(height: 2),
                          pw.Text("Caja Estado",
                              style: kTextoCuerpoPdfAutoreport(ttf)),
                          pw.SizedBox(height: 2),
                          pw.Text("Maletín",
                              style: kTextoCuerpoPdfAutoreport(ttf)),
                          pw.SizedBox(height: 2),
                          pw.Text("Maletín Estado",
                              style: kTextoCuerpoPdfAutoreport(ttf)),
                          pw.SizedBox(height: 2),
                          pw.Text("Bolsa Plástica",
                              style: kTextoCuerpoPdfAutoreport(ttf)),
                          pw.SizedBox(height: 2),
                          pw.Text("Bolsa Plástica Estado",
                              style: kTextoCuerpoPdfAutoreport(ttf)),
                          pw.SizedBox(height: 2),
                          pw.Text("Estuche",
                              style: kTextoCuerpoPdfAutoreport(ttf)),
                          pw.SizedBox(height: 2),
                          pw.Text("Gata",
                              style: kTextoCuerpoPdfAutoreport(ttf)),
                          pw.SizedBox(height: 2),
                          pw.Text("Extintor",
                              style: kTextoCuerpoPdfAutoreport(ttf)),
                          pw.SizedBox(height: 2),
                          pw.Text("Llaves Visibles",
                              style: kTextoCuerpoPdfAutoreport(ttf)),
                          pw.SizedBox(height: 2),
                          pw.Text("Llaves Simples",
                              style: kTextoCuerpoPdfAutoreport(ttf)),
                          pw.SizedBox(height: 2),
                          pw.Container(
                              width: 70,
                              child: pw.Text("Llaves Inteligentes",
                                  style: kTextoCuerpoPdfAutoreport(ttf))),
                          pw.SizedBox(height: 2),
                          pw.Container(
                              width: 70,
                              child: pw.Text("Llaves Comando",
                                  style: kTextoCuerpoPdfAutoreport(ttf))),
                          pw.SizedBox(height: 2),
                          pw.Container(
                              width: 70,
                              child: pw.Text("Llaves Pin",
                                  style: kTextoCuerpoPdfAutoreport(ttf))),
                          pw.SizedBox(height: 2),
                          pw.Text("Linterna",
                              style: kTextoCuerpoPdfAutoreport(ttf)),
                          pw.SizedBox(height: 2),
                          pw.Container(
                              width: 70,
                              child: pw.Text("Cable Cargador Batería",
                                  style: kTextoCuerpoPdfAutoreport(ttf))),
                          pw.SizedBox(height: 2),
                          pw.Text("Circulina",
                              style: kTextoCuerpoPdfAutoreport(ttf)),
                          pw.SizedBox(height: 2),
                          pw.Container(
                              width: 70,
                              child: pw.Text(
                                  "Cable Cargador Vehículo Electrónico",
                                  style: kTextoCuerpoPdfAutoreport(ttf))),
                          pw.SizedBox(height: 2),
                          pw.Text("Cd", style: kTextoCuerpoPdfAutoreport(ttf)),
                          pw.SizedBox(height: 2),
                          pw.Text("Usb", style: kTextoCuerpoPdfAutoreport(ttf)),
                          pw.SizedBox(height: 2),
                          pw.Text("Memoria SD",
                              style: kTextoCuerpoPdfAutoreport(ttf)),
                          pw.SizedBox(height: 2),
                          pw.Text("Cámara Seguridad",
                              style: kTextoCuerpoPdfAutoreport(ttf)),
                          pw.SizedBox(height: 2),
                          pw.Text("Radio Comunicador",
                              style: kTextoCuerpoPdfAutoreport(ttf)),
                          pw.SizedBox(height: 2),
                          pw.Text("Manguera de Aire",
                              style: kTextoCuerpoPdfAutoreport(ttf)),
                          pw.SizedBox(height: 2),
                          pw.Text("Cable Cargador",
                              style: kTextoCuerpoPdfAutoreport(ttf)),
                          pw.SizedBox(height: 2),
                          pw.Text("Llaves Ruedas",
                              style: kTextoCuerpoPdfAutoreport(ttf)),
                          pw.SizedBox(height: 2),
                          pw.Text("Chaleco",
                              style: kTextoCuerpoPdfAutoreport(ttf)),
                          pw.SizedBox(height: 2),
                          pw.Text("Galonera",
                              style: kTextoCuerpoPdfAutoreport(ttf)),
                          pw.SizedBox(height: 2),
                          pw.Container(
                              width: 70,
                              child: pw.Text("Control Remoto Maquinaria",
                                  style: kTextoCuerpoPdfAutoreport(ttf))),
                          pw.SizedBox(height: 2),
                          pw.Text("Otros",
                              style: kTextoCuerpoPdfAutoreport(ttf)),
                        ]),
                    pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        mainAxisAlignment: pw.MainAxisAlignment.start,
                        children: [
                          pw.Text("Estado",
                              style: kTextoTituloPdfAutoreport(ttf)),
                          pw.SizedBox(height: 5),
                          pw.Text(antenaText,
                              style: kTextoCuerpoPdfAutoreport(ttf)),
                          pw.SizedBox(height: 2),
                          pw.Text(catalogoText,
                              style: kTextoCuerpoPdfAutoreport(ttf)),
                          pw.SizedBox(height: 2),
                          pw.Text(cenicerosText,
                              style: kTextoCuerpoPdfAutoreport(ttf)),
                          pw.SizedBox(height: 2),
                          pw.Text(encendedorText,
                              style: kTextoCuerpoPdfAutoreport(ttf)),
                          pw.SizedBox(height: 2),
                          pw.Text(plumillasDelanterasText,
                              style: kTextoCuerpoPdfAutoreport(ttf)),
                          pw.SizedBox(height: 2),
                          pw.Text(plumillasTraserasText,
                              style: kTextoCuerpoPdfAutoreport(ttf)),
                          pw.SizedBox(height: 2),
                          pw.Text(radioText,
                              style: kTextoCuerpoPdfAutoreport(ttf)),
                          pw.SizedBox(height: 2),
                          pw.Text(controlRemotoradioText,
                              style: kTextoCuerpoPdfAutoreport(ttf)),
                          pw.SizedBox(height: 2),
                          pw.Text(espejosInteriorText,
                              style: kTextoCuerpoPdfAutoreport(ttf)),
                          pw.SizedBox(height: 2),
                          pw.Text(espejosLateralesText,
                              style: kTextoCuerpoPdfAutoreport(ttf)),
                          pw.SizedBox(height: 2),
                          pw.Text(tacografoText,
                              style: kTextoCuerpoPdfAutoreport(ttf)),
                          pw.SizedBox(height: 2),
                          pw.Text(tacometroText,
                              style: kTextoCuerpoPdfAutoreport(ttf)),
                          pw.SizedBox(height: 2),
                          pw.Text(tapaNeumaticoText,
                              style: kTextoCuerpoPdfAutoreport(ttf)),
                          pw.SizedBox(height: 2),
                          pw.Text(copasAroText,
                              style: kTextoCuerpoPdfAutoreport(ttf)),
                          pw.SizedBox(height: 2),
                          pw.Text(relojText,
                              style: kTextoCuerpoPdfAutoreport(ttf)),
                          pw.SizedBox(height: 2),
                          pw.Text(pisosAdicionalesText,
                              style: kTextoCuerpoPdfAutoreport(ttf)),
                          pw.SizedBox(height: 2),
                          pw.Text(pantallaTactilText,
                              style: kTextoCuerpoPdfAutoreport(ttf)),
                          pw.SizedBox(height: 2),
                          pw.Text(llantaRepuestoText,
                              style: kTextoCuerpoPdfAutoreport(ttf)),
                          pw.SizedBox(height: 2),
                          pw.Text(herramientasText,
                              style: kTextoCuerpoPdfAutoreport(ttf)),
                          pw.SizedBox(height: 2),
                          pw.Text(relaysText,
                              style: kTextoCuerpoPdfAutoreport(ttf)),
                          pw.SizedBox(height: 2),
                          pw.Text(pinRemolqueText,
                              style: kTextoCuerpoPdfAutoreport(ttf)),
                          pw.SizedBox(height: 2),
                          pw.Text(cajaText,
                              style: kTextoCuerpoPdfAutoreport(ttf)),
                          pw.SizedBox(height: 2),
                          pw.Text(cajaEstadoText,
                              style: kTextoCuerpoPdfAutoreport(ttf)),
                          pw.SizedBox(height: 2),
                          pw.Text(maletinText,
                              style: kTextoCuerpoPdfAutoreport(ttf)),
                          pw.SizedBox(height: 2),
                          pw.Text(maletinEstadoText,
                              style: kTextoCuerpoPdfAutoreport(ttf)),
                          pw.SizedBox(height: 2),
                          pw.Text(bolsaPlasticaText,
                              style: kTextoCuerpoPdfAutoreport(ttf)),
                          pw.SizedBox(height: 2),
                          pw.Text(bolsaPlasticaEstadoText,
                              style: kTextoCuerpoPdfAutoreport(ttf)),
                          pw.SizedBox(height: 2),
                          pw.Text(estucheText,
                              style: kTextoCuerpoPdfAutoreport(ttf)),
                          pw.SizedBox(height: 2),
                          pw.Text(gataText,
                              style: kTextoCuerpoPdfAutoreport(ttf)),
                          pw.SizedBox(height: 2),
                          pw.Text(extintorText,
                              style: kTextoCuerpoPdfAutoreport(ttf)),
                          pw.SizedBox(height: 2),
                          pw.Text(llavesText,
                              style: kTextoCuerpoPdfAutoreport(ttf)),
                          pw.SizedBox(height: 2),
                          pw.Text(llavesSimplesText,
                              style: kTextoCuerpoPdfAutoreport(ttf)),
                          pw.SizedBox(height: 2),
                          pw.Text(llavesInteligentesText,
                              style: kTextoCuerpoPdfAutoreport(ttf)),
                          pw.SizedBox(height: 2),
                          pw.Text(llavesComandoText,
                              style: kTextoCuerpoPdfAutoreport(ttf)),
                          pw.SizedBox(height: 2),
                          pw.Text(llavesPinText,
                              style: kTextoCuerpoPdfAutoreport(ttf)),
                          pw.SizedBox(height: 2),
                          pw.Text(linternaText,
                              style: kTextoCuerpoPdfAutoreport(ttf)),
                          pw.SizedBox(height: 3),
                          pw.Text(cableCargadorBateriaText,
                              style: kTextoCuerpoPdfAutoreport(ttf)),
                          pw.SizedBox(height: 9),
                          pw.Text(circulinaText,
                              style: kTextoCuerpoPdfAutoreport(ttf)),
                          pw.SizedBox(height: 7),
                          pw.Text(cableCargadorVehiculoElectricoText,
                              style: kTextoCuerpoPdfAutoreport(ttf)),
                          pw.SizedBox(height: 17),
                          pw.Text(cdText,
                              style: kTextoCuerpoPdfAutoreport(ttf)),
                          pw.SizedBox(height: 2),
                          pw.Text(usbText,
                              style: kTextoCuerpoPdfAutoreport(ttf)),
                          pw.SizedBox(height: 2),
                          pw.Text(memoriaSdText,
                              style: kTextoCuerpoPdfAutoreport(ttf)),
                          pw.SizedBox(height: 2),
                          pw.Text(camaraSeguridadText,
                              style: kTextoCuerpoPdfAutoreport(ttf)),
                          pw.SizedBox(height: 2),
                          pw.Text(radioComunicadorText,
                              style: kTextoCuerpoPdfAutoreport(ttf)),
                          pw.SizedBox(height: 2),
                          pw.Text(mangueraAireText,
                              style: kTextoCuerpoPdfAutoreport(ttf)),
                          pw.SizedBox(height: 2),
                          pw.Text(cableCargadorText,
                              style: kTextoCuerpoPdfAutoreport(ttf)),
                          pw.SizedBox(height: 2),
                          pw.Text(llaveRuedasText,
                              style: kTextoCuerpoPdfAutoreport(ttf)),
                          pw.SizedBox(height: 2),
                          pw.Text(chalecoText,
                              style: kTextoCuerpoPdfAutoreport(ttf)),
                          pw.SizedBox(height: 2),
                          pw.Text(galoneraText,
                              style: kTextoCuerpoPdfAutoreport(ttf)),
                          pw.SizedBox(height: 2),
                          pw.Text(controlRemotoMaquinariaText,
                              style: kTextoCuerpoPdfAutoreport(ttf)),
                          pw.SizedBox(height: 12),
                          pw.Container(
                              width: 30,
                              child: pw.Text(otros,
                                  style: kTextoCuerpoPdfAutoreport(ttf))),
                        ]),
                    pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.center,
                        mainAxisAlignment: pw.MainAxisAlignment.start,
                        children: [
                          pw.Text("Cantidad",
                              style: kTextoTituloPdfAutoreport(ttf)),
                          pw.SizedBox(height: 5),
                          pw.Text("-", style: kTextoCuerpoPdfAutoreport(ttf)),
                          pw.SizedBox(height: 2),
                          pw.Text("-", style: kTextoCuerpoPdfAutoreport(ttf)),
                          pw.SizedBox(height: 2),
                          pw.Text("-", style: kTextoCuerpoPdfAutoreport(ttf)),
                          pw.SizedBox(height: 2),
                          pw.Text("-", style: kTextoCuerpoPdfAutoreport(ttf)),
                          pw.SizedBox(height: 2),
                          pw.Text("-", style: kTextoCuerpoPdfAutoreport(ttf)),
                          pw.SizedBox(height: 2),
                          pw.Text("-", style: kTextoCuerpoPdfAutoreport(ttf)),
                          pw.SizedBox(height: 2),
                          pw.Text("-", style: kTextoCuerpoPdfAutoreport(ttf)),
                          pw.SizedBox(height: 2),
                          pw.Text("-", style: kTextoCuerpoPdfAutoreport(ttf)),
                          pw.SizedBox(height: 2),
                          pw.Text("-", style: kTextoCuerpoPdfAutoreport(ttf)),
                          pw.SizedBox(height: 2),
                          pw.Text("-", style: kTextoCuerpoPdfAutoreport(ttf)),
                          pw.SizedBox(height: 2),
                          pw.Text("-", style: kTextoCuerpoPdfAutoreport(ttf)),
                          pw.SizedBox(height: 2),
                          pw.Text("-", style: kTextoCuerpoPdfAutoreport(ttf)),
                          pw.SizedBox(height: 2),
                          pw.Text("-", style: kTextoCuerpoPdfAutoreport(ttf)),
                          pw.SizedBox(height: 2),
                          pw.Text("-", style: kTextoCuerpoPdfAutoreport(ttf)),
                          pw.SizedBox(height: 2),
                          pw.Text("-", style: kTextoCuerpoPdfAutoreport(ttf)),
                          pw.SizedBox(height: 2),
                          pw.Text("-", style: kTextoCuerpoPdfAutoreport(ttf)),
                          pw.SizedBox(height: 2),
                          pw.Text("-", style: kTextoCuerpoPdfAutoreport(ttf)),
                          pw.SizedBox(height: 2),
                          pw.Text("-", style: kTextoCuerpoPdfAutoreport(ttf)),
                          pw.SizedBox(height: 2),
                          pw.Text("-", style: kTextoCuerpoPdfAutoreport(ttf)),
                          pw.SizedBox(height: 2),
                          pw.Text("-", style: kTextoCuerpoPdfAutoreport(ttf)),
                          pw.SizedBox(height: 2),
                          pw.Text("-", style: kTextoCuerpoPdfAutoreport(ttf)),
                          pw.SizedBox(height: 2),
                          pw.Text("-", style: kTextoCuerpoPdfAutoreport(ttf)),
                          pw.SizedBox(height: 2),
                          pw.Text("-", style: kTextoCuerpoPdfAutoreport(ttf)),
                          pw.SizedBox(height: 2),
                          pw.Text("-", style: kTextoCuerpoPdfAutoreport(ttf)),
                          pw.SizedBox(height: 2),
                          pw.Text("-", style: kTextoCuerpoPdfAutoreport(ttf)),
                          pw.SizedBox(height: 2),
                          pw.Text("-", style: kTextoCuerpoPdfAutoreport(ttf)),
                          pw.SizedBox(height: 2),
                          pw.Text("-", style: kTextoCuerpoPdfAutoreport(ttf)),
                          pw.SizedBox(height: 2),
                          pw.Text("-", style: kTextoCuerpoPdfAutoreport(ttf)),
                          pw.SizedBox(height: 2),
                          pw.Text("-", style: kTextoCuerpoPdfAutoreport(ttf)),
                          pw.SizedBox(height: 2),
                          pw.Text("-", style: kTextoCuerpoPdfAutoreport(ttf)),
                          pw.SizedBox(height: 2),
                          pw.Text("-", style: kTextoCuerpoPdfAutoreport(ttf)),
                          pw.SizedBox(height: 2),
                          pw.Text(nllavesSimples.toString(),
                              style: kTextoCuerpoPdfAutoreport(ttf)),
                          pw.SizedBox(height: 2),
                          pw.Text(nllavesInteligentes.toString(),
                              style: kTextoCuerpoPdfAutoreport(ttf)),
                          pw.SizedBox(height: 2),
                          pw.Text(nllavesComando.toString(),
                              style: kTextoCuerpoPdfAutoreport(ttf)),
                          pw.SizedBox(height: 2),
                          pw.Text(nllavesPin.toString(),
                              style: kTextoCuerpoPdfAutoreport(ttf)),
                          pw.SizedBox(height: 2),
                          pw.Text("-", style: kTextoCuerpoPdfAutoreport(ttf)),
                          pw.SizedBox(height: 2),
                          pw.Text("-", style: kTextoCuerpoPdfAutoreport(ttf)),
                          pw.SizedBox(height: 9),
                          pw.Text("-", style: kTextoCuerpoPdfAutoreport(ttf)),
                          pw.SizedBox(height: 8),
                          pw.Text("-", style: kTextoCuerpoPdfAutoreport(ttf)),
                          pw.SizedBox(height: 15),
                          pw.Text("-", style: kTextoCuerpoPdfAutoreport(ttf)),
                          pw.SizedBox(height: 2),
                          pw.Text("-", style: kTextoCuerpoPdfAutoreport(ttf)),
                          pw.SizedBox(height: 2),
                          pw.Text("-", style: kTextoCuerpoPdfAutoreport(ttf)),
                          pw.SizedBox(height: 2),
                          pw.Text("-", style: kTextoCuerpoPdfAutoreport(ttf)),
                          pw.SizedBox(height: 2),
                          pw.Text("-", style: kTextoCuerpoPdfAutoreport(ttf)),
                          pw.SizedBox(height: 2),
                          pw.Text("-", style: kTextoCuerpoPdfAutoreport(ttf)),
                          pw.SizedBox(height: 2),
                          pw.Text("-", style: kTextoCuerpoPdfAutoreport(ttf)),
                          pw.SizedBox(height: 2),
                          pw.Text("-", style: kTextoCuerpoPdfAutoreport(ttf)),
                          pw.SizedBox(height: 2),
                          pw.Text("-", style: kTextoCuerpoPdfAutoreport(ttf)),
                          pw.SizedBox(height: 2),
                          pw.Text("-", style: kTextoCuerpoPdfAutoreport(ttf)),
                          pw.SizedBox(height: 2),
                          pw.Text("-", style: kTextoCuerpoPdfAutoreport(ttf)),
                        ]),
                  ]),
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
              pw.Center(
                  child: pw.Text("Notas: ",
                      style: kTextoTituloPdfAutoreport(ttf))),
              pw.SizedBox(height: 3),
              pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.stretch,
                  children: [
                    pw.Text("1) Llaves Precintadas: $llavesPrecintasText",
                        style: kTextoCuerpoPdfAutoreport(ttf)),
                    pw.SizedBox(height: 2),
                    pw.Text("2) No se aperturo maletera",
                        style: kTextoCuerpoPdfAutoreport(ttf)),
                    pw.SizedBox(height: 2),
                    pw.Text("3) Se aperturo puerta de piloto",
                        style: kTextoCuerpoPdfAutoreport(ttf))
                  ]),
              pw.SizedBox(height: 30),
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
                      style: kTextoCuerpoPdfAutoreport(ttf),
                      textAlign: pw.TextAlign.center),
                ),
              ),
              pw.SizedBox(height: 20),
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
