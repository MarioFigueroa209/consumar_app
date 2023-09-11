import 'package:barcode_widget/barcode_widget.dart';
import 'package:bluetooth_print/bluetooth_print.dart';
import 'package:bluetooth_print/bluetooth_print_model.dart';
import 'package:consumar_app/models/roro/autoreport/vw_participantes_by_autoreport_model.dart';
import 'package:consumar_app/services/roro/autoreport/autoreport_service.dart';
import 'package:flutter/material.dart';

import '../../../models/roro/autoreport/vw_autoreport_data.dart';

class PrintTicketAutoreport extends StatefulWidget {
  const PrintTicketAutoreport({super.key});

  @override
  State<PrintTicketAutoreport> createState() => _PrintTicketAutoreportState();
}

class _PrintTicketAutoreportState extends State<PrintTicketAutoreport> {
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

  String plumillasDelanterasText = "no";
  String plumillasTraserasText = "no";
  String antenaText = "no";
  String tapaNeumaticoText = "no";
  String copasAroText = "no";
  String radioText = "no";
  String controlRemotoradioText = "no";
  String tacometroText = "no";
  String tacografoText = "no";
  String encendedorText = "no";
  String relojText = "no";
  String pisosAdicionalesText = "no";
  String llantaRepuestoText = "no";
  String herramientasText = "no";
  String relaysText = "no";
  String estucheText = "no";
  String pinRemolqueText = "no";
  String cajaText = "no";
  String cajaEstadoText = "no";
  String maletinText = "no";
  String maletinEstadoText = "no";
  String bolsaPlasticaText = "no";
  String bolsaPlasticaEstadoText = "no";
  String cenicerosText = "no";
  String espejosInteriorText = "no";
  String espejosLateralesText = "no";
  String gataText = "no";
  String extintorText = "no";
  String pantallaTactilText = "no";
  String linternaText = "no";
  String cableCargadorBateriaText = "no";
  String circulinaText = "no";
  String cableCargadorVehiculoElectricoText = "no";
  String cdText = "no";
  String trianguloSeguridadText = "no";
  String catalogoText = "no";
  String llavesText = "no";
  String usbText = "no";
  String memoriaSdText = "no";
  String camaraSeguridadText = "no";
  String radioComunicadorText = "no";
  String mangueraAireText = "no";
  String cableCargadorText = "no";
  String llaveRuedasText = "no";
  String chalecoText = "no";
  String galoneraText = "no";
  String controlRemotoMaquinariaText = "no";
  String llavesPrecintasText = "no";

  String presenciaPolvoSuciedadText = "no";

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

  int cantPlumillasDelanteras = 0;
  int cantPlumillasTraseras = 0;
  int cantAntena = 0;
  int cantEspejosInteriores = 0;
  int cantEspejosLaterales = 0;
  int cantTapaLlanta = 0;
  int cantRadio = 0;
  int cantControlRemotoRadio = 0;
  int cantTacografo = 0;
  int cantTacometro = 0;
  int cantEncendedor = 0;
  int cantReloj = 0;
  int cantPisosAdicionales = 0;
  int cantCopasAro = 0;
  int cantLlantaRepuesto = 0;
  int cantHerramientas = 0;
  int cantPinRemolque = 0;
  int cantCaja = 0;
  int cantCajaEstado = 0;
  int cantMaletin = 0;
  int cantMaletinEstado = 0;
  int cantBolsaPlastica = 0;
  int cantBolsaPlasticaEstado = 0;
  int cantEstuche = 0;
  int cantRelays = 0;
  int cantCeniceros = 0;
  int cantGata = 0;
  int cantExtintor = 0;
  int cantTrianguloSeguridad = 0;
  int cantPantallaTactil = 0;
  int cantCatalogo = 0;
  int cantLinterna = 0;
  int cantCableCargadorBateria = 0;
  int cantCirculina = 0;
  int cantCableCargadorVehiculoElectrico = 0;
  int cantCd = 0;
  int cantUsb = 0;
  int cantMemoriaSd = 0;
  int cantCamaraSeguridad = 0;
  int cantRadioComunicador = 0;
  int cantMangueraAire = 0;
  int cantCableCargador = 0;
  int cantLlaveRuedas = 0;
  int cantChaleco = 0;
  int cantGalonera = 0;
  int cantControlRemotoMaquinaria = 0;
  bool presenciaPolvoSuciedad = false;
  bool protectorPlastico = false;
  String detalleProtectorPlastico = "";
  bool llavesVisibles = false;

  int nllavesSimples = 0;
  int nllavesInteligentes = 0;
  int nllavesComando = 0;
  int nllavesPin = 0;

  AutoreportService autoreportService = AutoreportService();
  VwAutoreportData vwAutoreportDataEdit = VwAutoreportData();

  getAutoreportDataById(int idAutoreport) async {
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

    cantPlumillasDelanteras = vwAutoreportDataEdit.cantPlumillasDelanteras!;
    cantPlumillasTraseras = vwAutoreportDataEdit.cantPlumillasTraseras!;
    cantAntena = vwAutoreportDataEdit.cantAntena!;
    cantEspejosInteriores = vwAutoreportDataEdit.cantEspejosInteriores!;
    cantEspejosLaterales = vwAutoreportDataEdit.cantEspejosLaterales!;
    cantTapaLlanta = vwAutoreportDataEdit.cantTapaLlanta!;
    cantRadio = vwAutoreportDataEdit.cantRadio!;
    cantControlRemotoRadio = vwAutoreportDataEdit.cantControlRemotoRadio!;
    cantTacografo = vwAutoreportDataEdit.cantTacografo!;
    cantTacometro = vwAutoreportDataEdit.cantTacometro!;
    cantEncendedor = vwAutoreportDataEdit.cantEncendedor!;
    cantReloj = vwAutoreportDataEdit.cantReloj!;
    cantPisosAdicionales = vwAutoreportDataEdit.cantPisosAdicionales!;
    cantCopasAro = vwAutoreportDataEdit.cantCopasAro!;
    cantLlantaRepuesto = vwAutoreportDataEdit.cantLlantaRepuesto!;
    cantHerramientas = vwAutoreportDataEdit.cantHerramientas!;
    cantPinRemolque = vwAutoreportDataEdit.cantPinRemolque!;
    cantCaja = vwAutoreportDataEdit.cantCaja!;
    // cantCajaEstado = vwAutoreportDataEdit.cantCajaEstado!;
    cantMaletin = vwAutoreportDataEdit.cantMaletin!;
    // cantMaletinEstado = vwAutoreportDataEdit.cantMaletinEstado!;
    cantBolsaPlastica = vwAutoreportDataEdit.cantBolsaPlastica!;
    // cantBolsaPlasticaEstado = vwAutoreportDataEdit.cantBolsaPlasticaEstado!;
    cantEstuche = vwAutoreportDataEdit.cantEstuche!;
    cantRelays = vwAutoreportDataEdit.cantRelays!;
    cantCeniceros = vwAutoreportDataEdit.cantCeniceros!;
    cantGata = vwAutoreportDataEdit.cantGata!;
    cantExtintor = vwAutoreportDataEdit.cantExtintor!;
    cantTrianguloSeguridad = vwAutoreportDataEdit.cantTrianguloSeguridad!;
    cantPantallaTactil = vwAutoreportDataEdit.cantPantallaTactil!;
    cantCatalogo = vwAutoreportDataEdit.cantCatalogo!;
    cantLinterna = vwAutoreportDataEdit.cantLinterna!;
    cantCableCargadorBateria = vwAutoreportDataEdit.cantCableCargadorBateria!;
    cantCirculina = vwAutoreportDataEdit.cantCirculina!;
    cantCableCargadorVehiculoElectrico =
        vwAutoreportDataEdit.cantCableCargadorVehiculoElectrico!;
    cantCd = vwAutoreportDataEdit.cantCd!;
    cantUsb = vwAutoreportDataEdit.cantUsb!;
    cantMemoriaSd = vwAutoreportDataEdit.cantMemoriaSd!;
    cantCamaraSeguridad = vwAutoreportDataEdit.cantCamaraSeguridad!;
    cantRadioComunicador = vwAutoreportDataEdit.cantRadioComunicador!;
    cantMangueraAire = vwAutoreportDataEdit.cantMangueraAire!;
    cantCableCargador = vwAutoreportDataEdit.cantCableCargador!;
    cantLlaveRuedas = vwAutoreportDataEdit.cantLlaveRuedas!;
    cantChaleco = vwAutoreportDataEdit.cantChaleco!;
    cantGalonera = vwAutoreportDataEdit.cantGalonera!;
    cantControlRemotoMaquinaria =
        vwAutoreportDataEdit.cantControlRemotoMaquinaria!;
    presenciaPolvoSuciedad = vwAutoreportDataEdit.presenciaPolvoSuciedad!;
    protectorPlastico = vwAutoreportDataEdit.protectorPlastico!;
    detalleProtectorPlastico = vwAutoreportDataEdit.detalleProtectorPlastico!;
    llavesVisibles = vwAutoreportDataEdit.llavesVisibles!;

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
      plumillasDelanterasText = "si";
    }
    if (plumillasTraseras == true) {
      plumillasTraserasText = "si";
    }
    if (antena == true) {
      antenaText = "si";
    }
    if (espejosInterior == true) {
      espejosInteriorText = "si";
    }
    if (espejosLaterales == true) {
      espejosLateralesText = "si";
    }
    if (tapaNeumatico == true) {
      tapaNeumaticoText = "si";
    }
    if (espejosInterior == true) {
      espejosInteriorText = "si";
    }
    if (espejosLaterales == true) {
      espejosLateralesText = "si";
    }
    if (copasAro == true) {
      copasAroText = "si";
    }
    if (radio == true) {
      radioText = "si";
    }
    if (controlRemotoradio == true) {
      controlRemotoradioText = "si";
    }
    if (tacografo == true) {
      tacografoText = "si";
    }
    if (tacometro == true) {
      tacometroText = "si";
    }
    if (encendedor == true) {
      encendedorText = "si";
    }
    if (extintor == true) {
      extintorText = "si";
    }
    if (reloj == true) {
      relojText = "si";
    }
    if (pantallaTactil == true) {
      pantallaTactilText = "si";
    }
    if (pisosAdicionales == true) {
      pisosAdicionalesText = "si";
    }
    if (llantaRepuesto == true) {
      llantaRepuestoText = "si";
    }
    if (herramientas == true) {
      herramientasText = "si";
    }
    if (relays == true) {
      relaysText = "si";
    }
    if (linterna == true) {
      linternaText = "si";
    }
    if (cableCargadorBateria == true) {
      cableCargadorBateriaText = "si";
    }
    if (circulina == true) {
      circulinaText = "si";
    }
    if (cableCargadorVehiculoElectrico == true) {
      cableCargadorVehiculoElectricoText = "si";
    }
    if (cd == true) {
      cdText = "si";
    }
    if (usb == true) {
      usbText = "si";
    }
    if (memoriaSd == true) {
      memoriaSdText = "si";
    }
    if (camaraSeguridad == true) {
      camaraSeguridadText = "si";
    }
    if (radioComunicador == true) {
      radioComunicadorText = "si";
    }
    if (mangueraAire == true) {
      mangueraAireText = "si";
    }
    if (cableCargador == true) {
      cableCargadorText = "si";
    }
    if (llaveRuedas == true) {
      llaveRuedasText = "si";
    }
    if (chaleco == true) {
      chalecoText = "si";
    }
    if (galonera == true) {
      galoneraText = "si";
    }
    if (controlRemotoMaquinaria == true) {
      controlRemotoMaquinariaText = "si";
    }

    if (pinRemolque == true) {
      pinRemolqueText = "si";
    }
    if (caja == true) {
      cajaText = "si";
    }
    if (cajaEstado == true) {
      cajaEstadoText = "si";
    }
    if (maletin == true) {
      maletinText = "si";
    }
    if (maletinEstado == true) {
      maletinEstadoText = "si";
    }
    if (bolsaPlastica == true) {
      bolsaPlasticaText = "si";
    }
    if (bolsaPlasticaEstado == true) {
      bolsaPlasticaEstadoText = "si";
    }
    if (estuche == true) {
      estucheText = "si";
    }

    if (ceniceros == true) {
      cenicerosText = "si";
    }
    if (gata == true) {
      gataText = "si";
    }
    if (trianguloSeguridad == true) {
      trianguloSeguridadText = "si";
    }
    if (catalogo == true) {
      catalogoText = "si";
    }
    if (llaves == true) {
      llavesText = "si";
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

    if (presenciaPolvoSuciedad == true) {
      presenciaPolvoSuciedadText = "si";
    }
  }

  List<VwParticipantesByAutoreportModel> spParticipantesInspeccionModel = [];

  getParticipantesByIdAutoreport(int idAutoreport) async {
    spParticipantesInspeccionModel =
        await autoreportService.getParticipantesByAutoreport(idAutoreport);
  }

  BluetoothPrint bluetoothPrint = BluetoothPrint.instance;

  bool _connected = false;
  BluetoothDevice? _device;
  String tips = 'Ningun dispositivo conectado';

  @override
  void initState() {
    super.initState();
    getAutoreportDataById(1);
    getParticipantesByIdAutoreport(1);
    WidgetsBinding.instance.addPostFrameCallback((_) => initBluetooth());
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initBluetooth() async {
    bluetoothPrint.startScan(timeout: Duration(seconds: 4));

    bool isConnected = await bluetoothPrint.isConnected ?? false;

    bluetoothPrint.state.listen((state) {
      print('******************* estado actual del dispositivo: $state');

      switch (state) {
        case BluetoothPrint.CONNECTED:
          setState(() {
            _connected = true;
            tips = 'conectado con éxito';
          });
          break;
        case BluetoothPrint.DISCONNECTED:
          setState(() {
            _connected = false;
            tips = 'desconectado';
          });
          break;
        default:
          break;
      }
    });

    if (!mounted) return;

    if (isConnected) {
      setState(() {
        _connected = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Printer App Print QR'),
      ),
      body: RefreshIndicator(
        onRefresh: () =>
            bluetoothPrint.startScan(timeout: Duration(seconds: 4)),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    child: Text(tips),
                  ),
                ],
              ),
              Divider(),
              StreamBuilder<List<BluetoothDevice>>(
                stream: bluetoothPrint.scanResults,
                initialData: [],
                builder: (c, snapshot) => Column(
                  children: snapshot.data!
                      .map((d) => ListTile(
                            title: Text(d.name ?? ''),
                            subtitle: Text(d.address ?? ''),
                            onTap: () async {
                              setState(() {
                                _device = d;
                              });
                            },
                            trailing:
                                _device != null && _device!.address == d.address
                                    ? Icon(
                                        Icons.check,
                                        color: Colors.green,
                                      )
                                    : null,
                          ))
                      .toList(),
                ),
              ),
              Divider(),
              Container(
                padding: EdgeInsets.fromLTRB(20, 5, 20, 10),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        OutlinedButton(
                          child: Text('Conectar'),
                          onPressed: _connected
                              ? null
                              : () async {
                                  if (_device != null &&
                                      _device!.address != null) {
                                    setState(() {
                                      tips = 'Conectando...';
                                    });
                                    await bluetoothPrint.connect(_device!);
                                  } else {
                                    setState(() {
                                      tips =
                                          'Por favor seleccione un dispositivo';
                                    });
                                    print(
                                        'Por favor seleccione un dispositivo');
                                  }
                                },
                        ),
                        SizedBox(width: 10.0),
                        OutlinedButton(
                          child: Text('Desconectar'),
                          onPressed: _connected
                              ? () async {
                                  setState(() {
                                    tips = 'Desconectando...';
                                  });
                                  await bluetoothPrint.disconnect();
                                }
                              : null,
                        ),
                      ],
                    ),
                    Divider(),
                    OutlinedButton(
                      child: Text('Imprimir QR de Vehiculo'),
                      onPressed: _connected
                          ? () async {
                              Map<String, dynamic> config = Map();
                              config['width'] = 50; // 标签宽度，单位mm
                              config['height'] = 26; // 标签高度，单位mm
                              config['gap'] = 2; // 标签间隔，单位mm

                              List<LineText> list = [];

                              list.add(LineText(
                                type: LineText.TYPE_TEXT,
                                x: 1,
                                y: 1,
                                content: "AUTOREPORT RORO",
                                align: LineText.ALIGN_CENTER,
                              ));

                              list.add(LineText(
                                type: LineText.TYPE_TEXT,
                                x: 1,
                                y: 1,
                                content: codAutoreport,
                                align: LineText.ALIGN_CENTER,
                              ));

                              list.add(LineText(
                                type: LineText.TYPE_TEXT,
                                x: 1,
                                y: 1,
                                content: "Fecha y hora: $fecha",
                                align: LineText.ALIGN_CENTER,
                              ));

                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Nave: $nave",
                                    ),
                                    Text(
                                      "Zona: $zona Fila: $fila",
                                    ),
                                    //pw.Text("Fila: $fila", style: kTextoCuerpoPdfAutoreport(ttf)),
                                  ]);

                              list.add(LineText(
                                type: LineText.TYPE_TEXT,
                                x: 1,
                                y: 1,
                                content: "Descripcion",
                                align: LineText.ALIGN_CENTER,
                              ));

                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "BL: $bl",
                                    ),
                                    Text(
                                      "Marca: $marca",
                                    ),
                                    //pw.Text("Fila: $fila", style: kTextoCuerpoPdfAutoreport(ttf)),
                                  ]);

                              list.add(LineText(
                                type: LineText.TYPE_TEXT,
                                x: 1,
                                y: 1,
                                content: "Chasis: $chasis",
                                align: LineText.ALIGN_CENTER,
                              ));

                              list.add(LineText(
                                type: LineText.TYPE_TEXT,
                                x: 1,
                                y: 1,
                                content: "Inventario",
                                align: LineText.ALIGN_CENTER,
                              ));

                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Damage Report",
                                          ),
                                          SizedBox(height: 2),
                                          Text(
                                            "Participantes Insp.",
                                          ),
                                          SizedBox(height: 2),
                                          Text(
                                            "Presencia Seguro",
                                          ),
                                          ListView.builder(
                                            itemCount:
                                                spParticipantesInspeccionModel
                                                    .length,
                                            itemBuilder: (context, index) {
                                              final item =
                                                  spParticipantesInspeccionModel[
                                                      index];
                                              return Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "- ${item.nombreParticipante!}",
                                                    ),
                                                    Text(
                                                      "(${item.empresa!})",
                                                    ),
                                                  ]);
                                            },
                                          )
                                        ]),
                                    Column(children: [
                                      Text(
                                        damageReportText,
                                      ),
                                      SizedBox(height: 2),
                                      Text(
                                        participantesInspeccionText,
                                      ),
                                      SizedBox(height: 2),
                                      Text(
                                        presenciaSeguroText,
                                      )
                                    ]),
                                    Column(children: [
                                      Text(
                                        nDamageReport,
                                      ),
                                      SizedBox(height: 2),
                                      Text(
                                        "-",
                                      )
                                    ])
                                  ]);

                              Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Inventario",
                                          ),
                                          SizedBox(height: 5),
                                          Text(
                                            "Antena",
                                          ),
                                          SizedBox(height: 2),
                                          Text(
                                            "Catálogo",
                                          ),
                                          SizedBox(height: 2),
                                          Text(
                                            "Ceniceros",
                                          ),
                                          SizedBox(height: 2),
                                          Text(
                                            "Encendedor",
                                          ),
                                          SizedBox(height: 2),
                                          Text(
                                            "Plumillas Delanteras",
                                          ),
                                          SizedBox(height: 2),
                                          Text(
                                            "Plumillas Traseras",
                                          ),
                                          SizedBox(height: 2),
                                          Text(
                                            "Radio",
                                          ),
                                          SizedBox(height: 2),
                                          Text(
                                            "Control Remoto Radio",
                                          ),
                                          SizedBox(height: 2),
                                          Text(
                                            "Espejos Interiores",
                                          ),
                                          SizedBox(height: 2),
                                          Text(
                                            "Espejos Laterales",
                                          ),
                                          SizedBox(height: 2),
                                          Text(
                                            "Tacógrafo",
                                          ),
                                          SizedBox(height: 2),
                                          Text(
                                            "Tacómetro",
                                          ),
                                          SizedBox(height: 2),
                                          Text(
                                            "Tapa Neumatico",
                                          ),
                                          SizedBox(height: 2),
                                          Text(
                                            "Copas Aro",
                                          ),
                                          SizedBox(height: 2),
                                          Text(
                                            "Reloj",
                                          ),
                                          SizedBox(height: 2),
                                          Text(
                                            "Pisos Adicionales",
                                          ),
                                          SizedBox(height: 2),
                                          Text(
                                            "Pantalla Táctil",
                                          ),
                                          SizedBox(height: 2),
                                          Text(
                                            "Llanta de repuesto",
                                          ),
                                          SizedBox(height: 2),
                                          Text(
                                            "Herramientas",
                                          ),
                                          SizedBox(height: 2),
                                          Text(
                                            "Relays",
                                          ),
                                          SizedBox(height: 2),
                                          Text(
                                            "Pin de Remolque",
                                          ),
                                          SizedBox(height: 2),
                                          Text(
                                            "Caja",
                                          ),
                                          SizedBox(height: 2),
                                          Text(
                                            "Caja Estado",
                                          ),
                                          SizedBox(height: 2),
                                          Text(
                                            "Maletín",
                                          ),
                                          SizedBox(height: 2),
                                          Text(
                                            "Maletín Estado",
                                          ),
                                          SizedBox(height: 2),
                                          Text(
                                            "Bolsa Plástica",
                                          ),
                                          SizedBox(height: 2),
                                          Text(
                                            "Bolsa Plástica Estado",
                                          ),
                                          SizedBox(height: 2),
                                          Text(
                                            "Estuche",
                                          ),
                                          SizedBox(height: 2),
                                          Text(
                                            "Gata",
                                          ),
                                          SizedBox(height: 2),
                                          Text(
                                            "Extintor",
                                          ),
                                          SizedBox(height: 2),
                                          Text(
                                            "Llaves Visibles",
                                          ),
                                          SizedBox(height: 2),
                                          Text(
                                            "Llaves Simples",
                                          ),
                                          SizedBox(height: 2),
                                          Container(
                                              width: 70,
                                              child: Text(
                                                "Llaves Inteligentes",
                                              )),
                                          SizedBox(height: 2),
                                          Container(
                                              width: 70,
                                              child: Text(
                                                "Llaves Comando",
                                              )),
                                          SizedBox(height: 2),
                                          Container(
                                              width: 70,
                                              child: Text(
                                                "Llaves Pin",
                                              )),
                                          SizedBox(height: 2),
                                          Text(
                                            "Linterna",
                                          ),
                                          SizedBox(height: 2),
                                          Container(
                                              width: 70,
                                              child: Text(
                                                "Cable Cargador Batería",
                                              )),
                                          SizedBox(height: 2),
                                          Text(
                                            "Circulina",
                                          ),
                                          SizedBox(height: 2),
                                          Container(
                                              width: 70,
                                              child: Text(
                                                "Cable Cargador Vehículo Electrónico",
                                              )),
                                          SizedBox(height: 2),
                                          Text(
                                            "Cd",
                                          ),
                                          SizedBox(height: 2),
                                          Text(
                                            "Usb",
                                          ),
                                          SizedBox(height: 2),
                                          Text(
                                            "Memoria SD",
                                          ),
                                          SizedBox(height: 2),
                                          Text(
                                            "Cámara Seguridad",
                                          ),
                                          SizedBox(height: 2),
                                          Text(
                                            "Radio Comunicador",
                                          ),
                                          SizedBox(height: 2),
                                          Text(
                                            "Manguera de Aire",
                                          ),
                                          SizedBox(height: 2),
                                          Text(
                                            "Cable Cargador",
                                          ),
                                          SizedBox(height: 2),
                                          Text(
                                            "Llaves Ruedas",
                                          ),
                                          SizedBox(height: 2),
                                          Text(
                                            "Chaleco",
                                          ),
                                          SizedBox(height: 2),
                                          Text(
                                            "Galonera",
                                          ),
                                          SizedBox(height: 2),
                                          Container(
                                              width: 70,
                                              child: Text(
                                                "Control Remoto Maquinaria",
                                              )),
                                          SizedBox(height: 2),
                                          Container(
                                              width: 70,
                                              child: Text(
                                                "Unidad con presencia Polvo y Suciedad",
                                              )),
                                          SizedBox(height: 2),
                                          Container(
                                              width: 70,
                                              child: Text(
                                                "Unidad cuenta con protector Plastico",
                                              )),
                                          SizedBox(height: 6),
                                          Text(
                                            "Otros",
                                          ),
                                        ]),
                                    Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Estado",
                                          ),
                                          SizedBox(height: 5),
                                          Text(
                                            antenaText,
                                          ),
                                          SizedBox(height: 2),
                                          Text(
                                            catalogoText,
                                          ),
                                          SizedBox(height: 2),
                                          Text(
                                            cenicerosText,
                                          ),
                                          SizedBox(height: 2),
                                          Text(
                                            encendedorText,
                                          ),
                                          SizedBox(height: 2),
                                          Text(
                                            plumillasDelanterasText,
                                          ),
                                          SizedBox(height: 2),
                                          Text(
                                            plumillasTraserasText,
                                          ),
                                          SizedBox(height: 2),
                                          Text(
                                            radioText,
                                          ),
                                          SizedBox(height: 2),
                                          Text(
                                            controlRemotoradioText,
                                          ),
                                          SizedBox(height: 2),
                                          Text(
                                            espejosInteriorText,
                                          ),
                                          SizedBox(height: 2),
                                          Text(
                                            espejosLateralesText,
                                          ),
                                          SizedBox(height: 2),
                                          Text(
                                            tacografoText,
                                          ),
                                          SizedBox(height: 2),
                                          Text(
                                            tacometroText,
                                          ),
                                          SizedBox(height: 2),
                                          Text(
                                            tapaNeumaticoText,
                                          ),
                                          SizedBox(height: 2),
                                          Text(
                                            copasAroText,
                                          ),
                                          SizedBox(height: 2),
                                          Text(
                                            relojText,
                                          ),
                                          SizedBox(height: 2),
                                          Text(
                                            pisosAdicionalesText,
                                          ),
                                          SizedBox(height: 2),
                                          Text(
                                            pantallaTactilText,
                                          ),
                                          SizedBox(height: 2),
                                          Text(
                                            llantaRepuestoText,
                                          ),
                                          SizedBox(height: 2),
                                          Text(
                                            herramientasText,
                                          ),
                                          SizedBox(height: 2),
                                          Text(
                                            relaysText,
                                          ),
                                          SizedBox(height: 2),
                                          Text(
                                            pinRemolqueText,
                                          ),
                                          SizedBox(height: 2),
                                          Text(
                                            cajaText,
                                          ),
                                          SizedBox(height: 2),
                                          Text(
                                            cajaEstadoText,
                                          ),
                                          SizedBox(height: 2),
                                          Text(
                                            maletinText,
                                          ),
                                          SizedBox(height: 2),
                                          Text(
                                            maletinEstadoText,
                                          ),
                                          SizedBox(height: 2),
                                          Text(
                                            bolsaPlasticaText,
                                          ),
                                          SizedBox(height: 2),
                                          Text(
                                            bolsaPlasticaEstadoText,
                                          ),
                                          SizedBox(height: 2),
                                          Text(
                                            estucheText,
                                          ),
                                          SizedBox(height: 2),
                                          Text(
                                            gataText,
                                          ),
                                          SizedBox(height: 2),
                                          Text(
                                            extintorText,
                                          ),
                                          SizedBox(height: 2),
                                          Text(
                                            llavesText,
                                          ),
                                          SizedBox(height: 2),
                                          Text(
                                            llavesSimplesText,
                                          ),
                                          SizedBox(height: 2),
                                          Text(
                                            llavesInteligentesText,
                                          ),
                                          SizedBox(height: 2),
                                          Text(
                                            llavesComandoText,
                                          ),
                                          SizedBox(height: 2),
                                          Text(
                                            llavesPinText,
                                          ),
                                          SizedBox(height: 2),
                                          Text(
                                            linternaText,
                                          ),
                                          SizedBox(height: 3),
                                          Text(
                                            cableCargadorBateriaText,
                                          ),
                                          SizedBox(height: 9),
                                          Text(
                                            circulinaText,
                                          ),
                                          SizedBox(height: 7),
                                          Text(
                                            cableCargadorVehiculoElectricoText,
                                          ),
                                          SizedBox(height: 17),
                                          Text(
                                            cdText,
                                          ),
                                          SizedBox(height: 2),
                                          Text(
                                            usbText,
                                          ),
                                          SizedBox(height: 2),
                                          Text(
                                            memoriaSdText,
                                          ),
                                          SizedBox(height: 2),
                                          Text(
                                            camaraSeguridadText,
                                          ),
                                          SizedBox(height: 2),
                                          Text(
                                            radioComunicadorText,
                                          ),
                                          SizedBox(height: 2),
                                          Text(
                                            mangueraAireText,
                                          ),
                                          SizedBox(height: 2),
                                          Text(
                                            cableCargadorText,
                                          ),
                                          SizedBox(height: 2),
                                          Text(
                                            llaveRuedasText,
                                          ),
                                          SizedBox(height: 2),
                                          Text(
                                            chalecoText,
                                          ),
                                          SizedBox(height: 2),
                                          Text(
                                            galoneraText,
                                          ),
                                          SizedBox(height: 2),
                                          Text(
                                            controlRemotoMaquinariaText,
                                          ),
                                          SizedBox(height: 12),
                                          Text(
                                            presenciaPolvoSuciedadText,
                                          ),
                                          SizedBox(height: 18),
                                          Container(
                                              width: 32,
                                              child: Text(
                                                detalleProtectorPlastico,
                                              )),
                                          SizedBox(height: 2),
                                          Container(
                                              width: 30,
                                              child: Text(
                                                otros,
                                              )),
                                        ]),
                                    Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Cantidad",
                                          ),
                                          SizedBox(height: 5),
                                          Text(
                                            cantAntena.toString(),
                                          ),
                                          SizedBox(height: 2),
                                          Text(
                                            cantCatalogo.toString(),
                                          ),
                                          SizedBox(height: 2),
                                          Text(
                                            cantCeniceros.toString(),
                                          ),
                                          SizedBox(height: 2),
                                          Text(
                                            cantEncendedor.toString(),
                                          ),
                                          SizedBox(height: 2),
                                          Text(
                                            cantPlumillasDelanteras.toString(),
                                          ),
                                          SizedBox(height: 2),
                                          Text(
                                            cantPlumillasTraseras.toString(),
                                          ),
                                          SizedBox(height: 2),
                                          Text(
                                            cantRadio.toString(),
                                          ),
                                          SizedBox(height: 2),
                                          Text(
                                            cantControlRemotoRadio.toString(),
                                          ),
                                          SizedBox(height: 2),
                                          Text(
                                            cantEspejosInteriores.toString(),
                                          ),
                                          SizedBox(height: 2),
                                          Text(
                                            cantEspejosLaterales.toString(),
                                          ),
                                          SizedBox(height: 2),
                                          Text(
                                            cantTacografo.toString(),
                                          ),
                                          SizedBox(height: 2),
                                          Text(
                                            cantTacometro.toString(),
                                          ),
                                          SizedBox(height: 2),
                                          Text(
                                            cantTapaLlanta.toString(),
                                          ),
                                          SizedBox(height: 2),
                                          Text(
                                            cantCopasAro.toString(),
                                          ),
                                          SizedBox(height: 2),
                                          Text(
                                            cantReloj.toString(),
                                          ),
                                          SizedBox(height: 2),
                                          Text(
                                            cantPisosAdicionales.toString(),
                                          ),
                                          SizedBox(height: 2),
                                          Text(
                                            cantPantallaTactil.toString(),
                                          ),
                                          SizedBox(height: 2),
                                          Text(
                                            cantLlantaRepuesto.toString(),
                                          ), //----
                                          SizedBox(height: 2),
                                          Text(
                                            cantHerramientas.toString(),
                                          ),
                                          SizedBox(height: 2),
                                          Text(
                                            cantRelays.toString(),
                                          ),
                                          SizedBox(height: 2),
                                          Text(
                                            cantPinRemolque.toString(),
                                          ),
                                          SizedBox(height: 2),
                                          Text(
                                            cantCaja.toString(),
                                          ),
                                          SizedBox(height: 2),
                                          Text(
                                            "-",
                                          ),
                                          SizedBox(height: 2),
                                          Text(
                                            cantMaletin.toString(),
                                          ),
                                          SizedBox(height: 2),
                                          Text(
                                            "-",
                                          ),
                                          SizedBox(height: 2),
                                          Text(
                                            cantBolsaPlastica.toString(),
                                          ),
                                          SizedBox(height: 2),
                                          Text(
                                            "-",
                                          ),
                                          SizedBox(height: 2),
                                          Text(
                                            cantEstuche.toString(),
                                          ),
                                          SizedBox(height: 2),
                                          Text(
                                            cantGata.toString(),
                                          ),
                                          SizedBox(height: 2),
                                          Text(
                                            cantExtintor.toString(),
                                          ),
                                          SizedBox(height: 2),
                                          Text(
                                            "-",
                                          ),
                                          SizedBox(height: 2),
                                          Text(
                                            nllavesSimples.toString(),
                                          ),
                                          SizedBox(height: 2),
                                          Text(
                                            nllavesInteligentes.toString(),
                                          ),
                                          SizedBox(height: 2),
                                          Text(
                                            nllavesComando.toString(),
                                          ),
                                          SizedBox(height: 2),
                                          Text(
                                            nllavesPin.toString(),
                                          ),
                                          SizedBox(height: 2),
                                          Text(
                                            cantLinterna.toString(),
                                          ),
                                          SizedBox(height: 2),
                                          Text(
                                            cantCableCargadorBateria.toString(),
                                          ),
                                          SizedBox(height: 9),
                                          Text(
                                            cantCirculina.toString(),
                                          ),
                                          SizedBox(height: 8),
                                          Text(
                                            cantCableCargadorVehiculoElectrico
                                                .toString(),
                                          ),
                                          SizedBox(height: 17),
                                          Text(
                                            cantCd.toString(),
                                          ),
                                          SizedBox(height: 2),
                                          Text(
                                            cantUsb.toString(),
                                          ),
                                          SizedBox(height: 2),
                                          Text(
                                            cantMemoriaSd.toString(),
                                          ),
                                          SizedBox(height: 2),
                                          Text(
                                            cantCamaraSeguridad.toString(),
                                          ),
                                          SizedBox(height: 2),
                                          Text(
                                            cantRadioComunicador.toString(),
                                          ),
                                          SizedBox(height: 2),
                                          Text(
                                            cantMangueraAire.toString(),
                                          ),
                                          SizedBox(height: 2),
                                          Text(
                                            cantCableCargador.toString(),
                                          ),
                                          SizedBox(height: 2),
                                          Text(
                                            cantLlaveRuedas.toString(),
                                          ),
                                          SizedBox(height: 2),
                                          Text(
                                            cantChaleco.toString(),
                                          ),
                                          SizedBox(height: 2),
                                          Text(
                                            cantGalonera.toString(),
                                          ),
                                          SizedBox(height: 2),
                                          Text(
                                            cantControlRemotoMaquinaria
                                                .toString(),
                                          ),
                                        ])
                                  ]);

                              list.add(LineText(
                                type: LineText.TYPE_TEXT,
                                x: 1,
                                y: 1,
                                content: "Notas: ",
                                align: LineText.ALIGN_CENTER,
                              ));

                              Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Text(
                                      "1) Llaves Precintadas: $llavesPrecintasText",
                                    ),
                                    SizedBox(height: 2),
                                    Text(
                                      "2) No se aperturo maletera",
                                    ),
                                    SizedBox(height: 2),
                                    Text(
                                      "3) Se aperturo puerta de piloto",
                                    )
                                  ]);
                              SizedBox(height: 30);
                              BarcodeWidget(
                                barcode: Barcode.qrCode(),
                                data: 'consumarport.com.pe/login',
                                height: 80.0,
                                width: 80.0,
                              );
                              SizedBox(height: 10);
                              Center(
                                child: Container(
                                  width: 150,
                                  child: Text(
                                      "Representacion del documento Electronico, consultar su documento en consumarport.com.pe/login",
                                      textAlign: TextAlign.center),
                                ),
                              );

                              await bluetoothPrint.printLabel(config, list);
                            }
                          : null,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: StreamBuilder<bool>(
        stream: bluetoothPrint.isScanning,
        initialData: false,
        builder: (c, snapshot) {
          if (snapshot.data == true) {
            return FloatingActionButton(
              child: Icon(Icons.stop),
              onPressed: () => bluetoothPrint.stopScan(),
              backgroundColor: Colors.red,
            );
          } else {
            return FloatingActionButton(
                child: Icon(Icons.search),
                onPressed: () =>
                    bluetoothPrint.startScan(timeout: Duration(seconds: 4)));
          }
        },
      ),
    );
  }
}
