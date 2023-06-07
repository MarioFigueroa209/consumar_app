import 'dart:io';
import 'dart:typed_data';

import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import '../../../models/file_upload_result.dart';
import '../../../models/roro/damage_report/sp_create_damage_report_list_model.dart';
import '../../../models/roro/damage_report/vw_get_damage_report_item_model.dart';
import '../../../models/roro/damage_report/vw_get_damage_type_by_id_dr_model.dart';
import '../../../services/file_upload_result.dart';
import '../../../services/roro/damage_report/damage_report_consulta_service.dart';
import '../../../utils/constants.dart';
import '../../widgets/custom_snack_bar.dart';

class DrInformeFinal extends StatefulWidget {
  DrInformeFinal(
      {super.key,
      required this.idDamageReport,
      required this.idServiceOrder,
      required this.jornada,
      this.codResponsableNave,
      this.responsableNave,
      this.nombreResponsableNave,
      this.idCoordinador,
      this.idSupervisorApmtc,
      required this.responsable,
      this.urlImgFirma});

  final BigInt idDamageReport;
  final BigInt idServiceOrder;
  String? codResponsableNave;
  String? responsableNave;
  String? nombreResponsableNave;
  final String responsable;
  int? idCoordinador;
  int? idSupervisorApmtc;
  final int jornada;
  Uint8List? urlImgFirma;

  @override
  State<DrInformeFinal> createState() => _DrInformeFinal();
}

String textoQr = "QR ID VEHICLE";

class _DrInformeFinal extends State<DrInformeFinal> {
  final TextEditingController controllerCommentation = TextEditingController();

  final TextEditingController commentDecline = TextEditingController();

  VwGetDamageReportItemModel vwGetDamageReportItemModel =
      VwGetDamageReportItemModel();

  List<VwGetDamageTypeByIdDrModel> damageTypeByIdDrModelList = [];

  DamageReportConsultaService damageReportConsultaService =
      DamageReportConsultaService();

  FileUploadResult fileUploadResult = FileUploadResult();
  FileUploadService fileUploadService = FileUploadService();

  String estadoAprobado = "";

  String vessel = "";
  DateTime? fecha;
  String port = "";
  String shift = "";
  String vesselOficer = "";
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
  String codDR = "";

  getDamageTypeListByIdDR(BigInt idDamageReport) async {
    List<VwGetDamageTypeByIdDrModel> value = await damageReportConsultaService
        .getDamageItemListByIdDR(idDamageReport);
    setState(() {
      damageTypeByIdDrModelList = value;
    });
  }

  getDamageItem(BigInt idDamageReport) async {
    VwGetDamageReportItemModel value =
        await damageReportConsultaService.getDamageReportItem(idDamageReport);

    setState(() {
      vwGetDamageReportItemModel = value;
    });

    setState(() {
      codDR = vwGetDamageReportItemModel.codDr!;
      vessel = vwGetDamageReportItemModel.nave!;
      urlChasisFoto = vwGetDamageReportItemModel.fotoChasis!;
      fecha = vwGetDamageReportItemModel.fecha;
      port = vwGetDamageReportItemModel.puerto!;
      shift = vwGetDamageReportItemModel.numeroViaje!;
      damageFound = vwGetDamageReportItemModel.damageFound!;
      damageOcurred = vwGetDamageReportItemModel.damageOcurred!;
      operation = vwGetDamageReportItemModel.operation!;
      stowagePosition = vwGetDamageReportItemModel.posicionEstibador!;
      portLanding = vwGetDamageReportItemModel.puertoAterrizaje!;
      if (vwGetDamageReportItemModel.puertoDestino != null) {
        portDischard = vwGetDamageReportItemModel.puertoDestino!;
      } else {
        portDischard = "";
      }
      marca = vwGetDamageReportItemModel.marca!;
      modelo = vwGetDamageReportItemModel.modelo!;
      chasis = vwGetDamageReportItemModel.chasis!;
      consignatario = vwGetDamageReportItemModel.consigntario!;
      bl = vwGetDamageReportItemModel.billOfLeading!;
      lugarAccidente = vwGetDamageReportItemModel.lugarAccidente!;
      fechaAccidente = vwGetDamageReportItemModel.fechaHoraAccidente;
      agenciaMaritima = vwGetDamageReportItemModel.agenciaMaritica!;
      vesselOficer = vwGetDamageReportItemModel.nombreResponsableNave!;
      if (vwGetDamageReportItemModel.nombreConductor != null) {
        nombreConductor = vwGetDamageReportItemModel.nombreConductor!;
      } else {
        nombreConductor = "";
      }
    });
  }

  subiendofotoXD() async {
    final tempDir = await getTemporaryDirectory();
    File file = await File('${tempDir.path}/image.png').create();
    file.writeAsBytesSync(widget.urlImgFirma!);
    // File file = File.fromRawPath(urlImgFirma!);
    fileUploadResult = await fileUploadService.uploadFile(file);
    //print(fileUploadResult.fileName!);
    //print(fileUploadResult.urlPhoto!);
  }

  createDRListado(String aprobado) {
    int? idapmtccontrol = widget.idSupervisorApmtc;
    int? idcordinadorccontrol = widget.idCoordinador;

    if (widget.responsable == "COORDINADOR CSMP") {
      setState(() {
        idapmtccontrol = null;
      });
      damageReportConsultaService
          .insertDamageReportList(SpCreateDamageReportListModel(
        jornada: widget.jornada,
        fecha: DateTime.now(),
        aprobadoCoordinador: aprobado,
        comentariosCoordinador: controllerCommentation.text,
        motivoRechazoCoordinador: commentDecline.text,
        idServiceOrder: int.parse(widget.idServiceOrder.toString()),
        idCoordinador: idcordinadorccontrol,
        idCodDr: int.parse(widget.idDamageReport.toString()),
      ));
    } else if (widget.responsable == "SUPERVISOR APMTC") {
      setState(() {
        idcordinadorccontrol = null;
      });
      damageReportConsultaService
          .insertDamageReportList(SpCreateDamageReportListModel(
        jornada: widget.jornada,
        fecha: DateTime.now(),
        aprobadoSupervisorApm: aprobado,
        comentariosSupervisor: controllerCommentation.text,
        motivoRechazoSupervisor: commentDecline.text,
        idServiceOrder: int.parse(widget.idServiceOrder.toString()),
        idSupervisor: idapmtccontrol,
        idCodDr: int.parse(widget.idDamageReport.toString()),
      ));
    } else if (widget.responsable == "NAVE") {
      setState(() {
        idapmtccontrol = null;
        idcordinadorccontrol = null;
      });
      damageReportConsultaService
          .insertDamageReportList(SpCreateDamageReportListModel(
        jornada: widget.jornada,
        fecha: DateTime.now(),
        responsableNave: widget.responsableNave,
        codigoResponsableNave: widget.codResponsableNave,
        nombreResponsableNave: widget.nombreResponsableNave,
        aprobadoResponsableNave: aprobado,
        comentariosResponsableNave: controllerCommentation.text,
        motivoRechazoResponsableNave: commentDecline.text,
        idServiceOrder: int.parse(widget.idServiceOrder.toString()),
        idCodDr: int.parse(widget.idDamageReport.toString()),
        imgFirmaResponsable: fileUploadResult.fileName,
        urlFirmaResponsable: fileUploadResult.urlPhoto,
      ));
    }

    /*damageReportConsultaService
        .insertDamageReportList(SpCreateDamageReportListModel(
      jornada: widget.jornada,
      fecha: DateTime.now(),
      codigoCapitan: widget.codCapitan,
      nombreCapitan: widget.nombreCapitan,
      aprobadoCoordinador: aprobado,
      aprobadoSupervisorApm: aprobado,
      aprobadoCapitan: aprobado,
      comentariosCoordinador: controllerCommentation.text,
      motivoRechazoCoordinador: commentDecline.text,
      comentariosSupervisor: controllerCommentation.text,
      motivoRechazoSupervisor: commentDecline.text,
      comentariosCapitan: controllerCommentation.text,
      motivoRechazoCapitan: commentDecline.text,
      idServiceOrder: int.parse(widget.idServiceOrder.toString()),
      idCoordinador: idcordinadorccontrol,
      idSupervisor: idapmtccontrol,
      idCodDr: int.parse(widget.idDamageReport.toString()),
      imgFirmaResponsable: "imgFirma",
      urlFirmaResponsable: "urlFirma",
    ));*/
  }

  @override
  void initState() {
    // VwGetDamageReportListModel e = widget.damageItem;
    super.initState();
    //print(widget.idDamageReport);
    getDamageItem(widget.idDamageReport);
    getDamageTypeListByIdDR(widget.idDamageReport);
    print(codDR);

    //print(damageTypeByIdDrModelList.length);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 40,
            ),
            Text("DAMAGE REPORT - $codDR",
                style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(
              height: 20,
            ),
            /* Image.network(qrImage.toString(), width: 200, height: 200),
            const SizedBox(
              height: 20,
            ), */
            Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: 20,
                  decoration: const BoxDecoration(color: Colors.black),
                  child: const Text(
                    "INITIAL INFORMATION",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: 20,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      color: Colors.lightBlueAccent),
                  child: const Text(
                    "VESSEL",
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: 20,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      color: Colors.white),
                  child: Text(
                    vessel,
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: 20,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      color: Colors.lightBlueAccent),
                  child: const Text(
                    "DATE",
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: 20,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      color: Colors.white),
                  child: Text(
                    fecha.toString(),
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: 20,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      color: Colors.lightBlueAccent),
                  child: const Text(
                    "PORT",
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: 20,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      color: Colors.white),
                  child: Text(
                    port,
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: 20,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      color: Colors.lightBlueAccent),
                  child: const Text(
                    "SHIFT",
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: 20,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      color: Colors.white),
                  child: Text(
                    shift,
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: 20,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      color: Colors.orangeAccent),
                  child: const Text(
                    "DAMAGE FOUND",
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: 20,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      color: Colors.white),
                  child: Text(
                    damageFound,
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: 20,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      color: Colors.orangeAccent),
                  child: const Text(
                    "DAMAGE OCURRED",
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: 20,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      color: Colors.white),
                  child: Text(
                    damageOcurred,
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: 20,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      color: Colors.orangeAccent),
                  child: const Text(
                    "OPERATION",
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: 20,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      color: Colors.white),
                  child: Text(
                    operation,
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: 20,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      color: Colors.grey.shade300),
                  child: const Text(
                    "DAMAGE CAR INFORMATION",
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: 20,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      color: Colors.lightBlueAccent),
                  child: const Text(
                    "STOWAGE POSITION",
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: 20,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      color: Colors.white),
                  child: Text(
                    stowagePosition,
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: 20,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      color: Colors.lightBlueAccent),
                  child: const Text(
                    "PORT OF LANDING",
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: 20,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      color: Colors.white),
                  child: Text(
                    portLanding,
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: 20,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      color: Colors.lightBlueAccent),
                  child: const Text(
                    "PORT OF DISCHARDING",
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: 20,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      color: Colors.white),
                  child: Text(
                    portDischard,
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: 20,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      color: Colors.lightBlueAccent),
                  child: const Text(
                    "MAKER",
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: 20,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      color: Colors.white),
                  child: Text(
                    marca,
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: 20,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      color: Colors.lightBlueAccent),
                  child: const Text(
                    "MODEL",
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: 20,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      color: Colors.white),
                  child: Text(
                    modelo,
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: 20,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      color: Colors.lightBlueAccent),
                  child: const Text(
                    "CHASSIS NUMBER",
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: 20,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      color: Colors.white),
                  child: Text(
                    chasis,
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: 20,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      color: Colors.lightBlueAccent),
                  child: const Text(
                    "CONSIGNEE",
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: 20,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      color: Colors.white),
                  child: Text(
                    consignatario,
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: 20,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      color: Colors.lightBlueAccent),
                  child: const Text(
                    "BILL OF LADING",
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: 20,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      color: Colors.white),
                  child: Text(
                    bl,
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: 20,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      color: Colors.grey.shade300),
                  child: const Text(
                    "OUTLINES OF DAMAGE",
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: 20,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      color: Colors.lightBlueAccent),
                  child: const Text(
                    "NAME OF DRIVER CAUSING DAMAGE",
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: 20,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      color: Colors.white),
                  child: Text(
                    nombreConductor,
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: 20,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      color: Colors.lightBlueAccent),
                  child: const Text(
                    "PLACE OF ACCIDENT/DAMAGE",
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: 20,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      color: Colors.white),
                  child: Text(
                    lugarAccidente,
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: 20,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      color: Colors.lightBlueAccent),
                  child: const Text(
                    "DATE & TIME ACCIDENT/DAMAGE",
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: 20,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      color: Colors.white),
                  child: Text(
                    fechaAccidente.toString(),
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: 20,
                  decoration: const BoxDecoration(color: Colors.black),
                  child: const Text(
                    "2ND INFORMATION",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: 20,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      color: Colors.lightBlueAccent),
                  child: const Text(
                    "EVIDENCE",
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  //height: 800,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      color: Colors.white),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      const Text("Chassis Photo"),
                      const SizedBox(
                        height: 5,
                      ),
                      Image.network(
                        urlChasisFoto,
                        height: 200,
                        //width: 200,
                      ),
                      const SizedBox(height: 10),
                      Table(
                          border: TableBorder.all(color: Colors.blueGrey),
                          children: [
                            for (var i = 0;
                                i < damageTypeByIdDrModelList.length;
                                i++)
                              TableRow(children: [
                                Column(children: [
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Image.network(
                                        damageTypeByIdDrModelList[i].fotoDano!,
                                        height: 150,
                                        width: 150,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Codigo de daño: ${damageTypeByIdDrModelList[i].codigoDano!}",
                                          ),
                                          Text(
                                            "Daño: ${damageTypeByIdDrModelList[i].danoRegistrado!}",
                                          ),
                                          Text(
                                            "Parte: ${damageTypeByIdDrModelList[i].parteVehiculo!}",
                                          ),
                                          Text(
                                            "Zona: ${damageTypeByIdDrModelList[i].zonaVehiculo!}",
                                          ),
                                          Text(
                                            "Faltantes: ${damageTypeByIdDrModelList[i].zonaVehiculo!}",
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  /* Text(damageTypeByIdDrModelList[i].fotoDano!,
                                  style: TextStyle(fontSize: 10)),
                               */
                                  //Divider(thickness: 1),
                                ]),
                              ])
                          ]),
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: 20,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      color: Colors.lightBlueAccent),
                  child: const Text(
                    "VESSEL OFFICER",
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: 20,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      color: Colors.white),
                  child: Text(
                    vesselOficer,
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: 20,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      color: Colors.lightBlueAccent),
                  child: const Text(
                    "MARITIME AGENCY",
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: 20,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      color: Colors.white),
                  child: Text(
                    agenciaMaritima,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),

            /*
            Container(
              width: MediaQuery.of(context).size.width * 0.33,
              height: 100,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black), color: Colors.white),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.asset(
                    'assets/logotipoconsumar.jpg',
                    height: 100.0,
                    width: 200,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Digitally signed by Figueroa Correa Mario",
                        style: TextStyle(fontSize: 10),
                      ),
                      Text(
                        "CONSUMARPORT",
                        style: TextStyle(fontSize: 10),
                      ),
                      Text(
                        "Reason: I endose this document",
                        style: TextStyle(fontSize: 10),
                      ),
                      Text(
                        "Date: " +
                            DateFormat('dd-MM-yyyy').format(DateTime.now()),
                        style: TextStyle(fontSize: 10),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.33,
              height: 100,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black), color: Colors.white),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.network(
                    "assets/apmlogo.jpg",
                    height: 50,
                    width: 50,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Digitally signed by Figueroa Correa Mario",
                        style: TextStyle(fontSize: 10),
                      ),
                      Text(
                        "APM TERMINALS",
                        style: TextStyle(fontSize: 10),
                      ),
                      Text(
                        "Reason: I endose this document",
                        style: TextStyle(fontSize: 10),
                      ),
                      Text(
                        "Date: " +
                            DateFormat('dd-MM-yyyy').format(DateTime.now()),
                        style: TextStyle(fontSize: 10),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            */
            const SizedBox(
              height: 20,
            ),
            Text(
              "COMMENTATION",
              style: TextStyle(color: kColorAzul),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                //textAlign: TextAlign.justify,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)))),
                controller: controllerCommentation,
                maxLines: 3,
                minLines: 1,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            BarcodeWidget(
              barcode: Barcode.qrCode(),
              data: textoQr,
              height: 150,
              width: 150,
            ),
            const SizedBox(
              height: 5,
            ),
            Container(
              width: 200,
              height: 50,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black), color: Colors.white),
              child: const Text(
                "Representación del Documento Electrónico, consultar su documento en consumarport.com.pe/login",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.40,
                  height: 30,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 20, 200, 20),
                    ),
                    child: const Text(
                      "APPROVE",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      setState(() {
                        estadoAprobado = "aprobado";
                      });
                      if (widget.urlImgFirma != null) {
                        await subiendofotoXD();
                        createDRListado(estadoAprobado);
                        if (context.mounted) {
                          CustomSnackBar.successSnackBar(
                              context, "Documento aprobado");
                          Navigator.pop(context);
                        }
                      } else {
                        createDRListado(estadoAprobado);
                        if (context.mounted) {
                          CustomSnackBar.successSnackBar(
                              context, "Documento aprobado");
                          Navigator.pop(context);
                        }
                      }
                    },
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.40,
                  height: 30,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 200, 20, 20),
                    ),
                    child: const Text(
                      "DECLINE",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      dialogo(context, 0);

                      /*
                      ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
                        content: Text('DECLINE DOCUMENT',
                            style: TextStyle(fontSize: 30)),
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        margin: EdgeInsets.only(
                            bottom: MediaQuery.of(context).size.height - 100,
                            right: 20,
                            left: 20),
                      ));
                    */
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
    );
  }

  void dialogo(BuildContext context, int index) {
    showDialog<void>(
        context: context,
        builder: (context) => AlertDialog(
              actions: [
                Center(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.60,
                    child: const Text(
                      'INDICATE THE REASON FOR THE DECLINE',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                TextField(
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)))),
                  controller: commentDecline,
                  maxLines: 3,
                  minLines: 2,
                ),
                const SizedBox(
                  height: 5,
                ),
                Center(
                  child: SizedBox(
                      width: 120,
                      child: TextButton(
                        style: TextButton.styleFrom(
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            padding: const EdgeInsets.all(1),
                            /*textStyle: const TextStyle(
                                fontSize: 15, color: Colors.white),*/
                            backgroundColor: Colors.blue),
                        onPressed: () async {
                          setState(() {
                            estadoAprobado = "desaprobado";
                          });
                          if (widget.urlImgFirma != null) {
                            await subiendofotoXD();
                            createDRListado(estadoAprobado);
                            Navigator.pop(context);
                            Navigator.pop(context);
                            if (context.mounted) return;
                          } else {
                            createDRListado(estadoAprobado);
                            Navigator.pop(context);
                            Navigator.pop(context);
                            if (context.mounted) return;
                          }
                        },
                        child: const Text(
                          'ACCEPT',
                          style: TextStyle(
                              fontWeight: FontWeight.w500, color: Colors.white),
                        ),
                      )),
                ),
              ],
            ));
  }
}
