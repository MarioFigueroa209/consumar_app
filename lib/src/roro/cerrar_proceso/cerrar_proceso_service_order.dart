import 'package:flutter/material.dart';

import '../../../models/roro/validation_service_order_close_printer_rampa_dr.dart';
import '../../../models/roro/validation_sum_saldo_final_reestibas.dart';
import '../../../services/service_order_services.dart';
import '../../../utils/constants.dart';

class ValidationCloseServiceOrder extends StatefulWidget {
  const ValidationCloseServiceOrder(
      {super.key, required this.idServiceOrder, required this.nombreNave});
  final int idServiceOrder;
  final String nombreNave;

  @override
  State<ValidationCloseServiceOrder> createState() =>
      _ValidationCloseServiceOrderState();
}

class _ValidationCloseServiceOrderState
    extends State<ValidationCloseServiceOrder> {
  ServiceOrderService serviceOrderService = ServiceOrderService();

  List<ValidationServiceOrderClosePrinterRampaDr>
      validationServiceOrderClosePrinterRampaDr = [];

  ValidationSumSaldoFinalReestibas validationSumSaldoFinalReestibas =
      ValidationSumSaldoFinalReestibas();

  int? numeroOperaciones = 0;
  int? operacionesDescarga = 0;
  int? operacionesEmbarque = 0;
  int? cantidadDescargaEtiquetado = 0;
  int? cantidadEmbarqueEtiquetado = 0;
  int? rampaDescargada = 0;
  int? rampaEmbarcada = 0;
  int? distribucionEmbarque = 0;
  int? autoreport = 0;
  int? damageReport = 0;
  int? aprobCoordinador = 0;
  int? aprobSupervisor = 0;
  int? aprobResponsableNave = 0;

  int sumaSaldos = 0;
  int sumaSaldoMuelle = 0;
  int sumaSaldoAbordo = 0;

  validationServiceOrderClose(int idServOrder) async {
    validationServiceOrderClosePrinterRampaDr = await serviceOrderService
        .validationServiceOrderClosePrinterRampaDr(idServOrder);

    setState(() {
      numeroOperaciones =
          validationServiceOrderClosePrinterRampaDr[0].numeroOperaciones!;

      operacionesDescarga =
          validationServiceOrderClosePrinterRampaDr[0].operacionesDescarga!;
      operacionesEmbarque =
          validationServiceOrderClosePrinterRampaDr[0].operacionesEmbarque!;
      cantidadDescargaEtiquetado = validationServiceOrderClosePrinterRampaDr[0]
          .cantidadDescargaEtiquetado!;
      cantidadEmbarqueEtiquetado = validationServiceOrderClosePrinterRampaDr[0]
          .cantidadEmbarqueEtiquetado!;
      rampaDescargada =
          validationServiceOrderClosePrinterRampaDr[0].rampaDescargada!;
      rampaEmbarcada =
          validationServiceOrderClosePrinterRampaDr[0].rampaEmbarcada!;
      distribucionEmbarque =
          validationServiceOrderClosePrinterRampaDr[0].distribucionEmbarque!;
      autoreport = validationServiceOrderClosePrinterRampaDr[0].autoreport!;
      damageReport = validationServiceOrderClosePrinterRampaDr[0].damageReport!;
      aprobCoordinador =
          validationServiceOrderClosePrinterRampaDr[0].aprobCoordinador!;
      aprobSupervisor =
          validationServiceOrderClosePrinterRampaDr[0].aprobSupervisor!;
      aprobResponsableNave =
          validationServiceOrderClosePrinterRampaDr[0].aprobResponsableNave!;
    });
  }

  closeOperation(int idServiceOrder) {
    if (operacionesDescarga == cantidadDescargaEtiquetado &&
        cantidadDescargaEtiquetado == rampaDescargada &&
        operacionesEmbarque == cantidadEmbarqueEtiquetado &&
        cantidadEmbarqueEtiquetado == rampaEmbarcada &&
        rampaEmbarcada == distribucionEmbarque &&
        aprobCoordinador == damageReport &&
        aprobSupervisor == damageReport &&
        aprobResponsableNave == damageReport &&
        autoreport == rampaDescargada) {
      serviceOrderService.closeOperacionServiceOrder(idServiceOrder);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Order de servicio Cerrada"),
        backgroundColor: Colors.yellowAccent,
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Hay procesos pendientes por cerrrar"),
        backgroundColor: Colors.redAccent,
      ));
    }
  }

  validationSumSaldoReestibas(int idServiceOrder) async {
    validationSumSaldoFinalReestibas = await serviceOrderService
        .validationSumSaldoFinalReestibas(idServiceOrder);

    setState(() {
      sumaSaldos = validationSumSaldoFinalReestibas.sumaSaldos!;

      sumaSaldoMuelle = validationSumSaldoFinalReestibas.sumaSaldoMuelle!;

      sumaSaldoAbordo = validationSumSaldoFinalReestibas.sumaSaldoAbordo!;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    validationServiceOrderClose(widget.idServiceOrder);
    validationSumSaldoReestibas(widget.idServiceOrder);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("STATUS RORO CARGA RODANTE"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Column(
              children: [
                Column(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("NAVE:  ${widget.nombreNave}",
                          style: const TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 18)),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("OPERACIONES TOTALES",
                          style: TextStyle(fontWeight: FontWeight.w500)),
                      Text(numeroOperaciones.toString(),
                          style: const TextStyle(fontWeight: FontWeight.w500)),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("OPERACIÓN DESCARGA",
                          style: TextStyle(fontWeight: FontWeight.w500)),
                      Text(operacionesDescarga.toString(),
                          style: const TextStyle(fontWeight: FontWeight.w500)),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("OPERACIÓN EMBARQUE",
                          style: TextStyle(fontWeight: FontWeight.w500)),
                      Text(operacionesEmbarque.toString(),
                          style: const TextStyle(fontWeight: FontWeight.w500)),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Container(
                    height: 25,
                    color: kColorCeleste,
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "PRINTER APP",
                            style: TextStyle(
                                fontSize: 15,
                                color: kColorAzul,
                                fontWeight: FontWeight.w500),
                            textAlign: TextAlign.center,
                          ),
                          operacionesDescarga == cantidadDescargaEtiquetado &&
                                  operacionesEmbarque ==
                                      cantidadEmbarqueEtiquetado
                              ? const Icon(
                                  Icons.check_outlined,
                                  color: Colors.green,
                                )
                              : const Icon(
                                  Icons.close,
                                  color: Colors.red,
                                )
                        ],
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("CANTIDAD DESCARGA ETIQUETADO",
                          style: TextStyle(fontWeight: FontWeight.w500)),
                      Text(cantidadDescargaEtiquetado.toString(),
                          style: const TextStyle(fontWeight: FontWeight.w500)),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("CANTIDAD EMBARQUE ETIQUETADO",
                          style: TextStyle(fontWeight: FontWeight.w500)),
                      Text(cantidadEmbarqueEtiquetado.toString(),
                          style: const TextStyle(fontWeight: FontWeight.w500)),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Container(
                    height: 25,
                    color: kColorCeleste,
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "DAMAGE REPORT",
                            style: TextStyle(
                                fontSize: 15,
                                color: kColorAzul,
                                fontWeight: FontWeight.w500),
                            textAlign: TextAlign.center,
                          ),
                          aprobCoordinador == damageReport &&
                                  aprobSupervisor == damageReport &&
                                  aprobResponsableNave == damageReport
                              ? const Icon(
                                  Icons.check_outlined,
                                  color: Colors.green,
                                )
                              : const Icon(
                                  Icons.close,
                                  color: Colors.red,
                                )
                        ],
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("DR'S REGISTRADOS",
                          style: TextStyle(fontWeight: FontWeight.w500)),
                      Text(damageReport.toString(),
                          style: const TextStyle(fontWeight: FontWeight.w500)),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("APROB. COORDINADOR",
                          style: TextStyle(fontWeight: FontWeight.w500)),
                      Text(aprobCoordinador.toString(),
                          style: const TextStyle(fontWeight: FontWeight.w500)),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("APROB. SUPERVISOR",
                          style: TextStyle(fontWeight: FontWeight.w500)),
                      Text(aprobSupervisor.toString(),
                          style: const TextStyle(fontWeight: FontWeight.w500)),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("APROB. RESPONSABLE NAVE",
                          style: TextStyle(fontWeight: FontWeight.w500)),
                      Text(aprobResponsableNave.toString(),
                          style: const TextStyle(fontWeight: FontWeight.w500)),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Container(
                    height: 25,
                    color: kColorCeleste,
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "CONTROL REESTIBAS",
                            style: TextStyle(
                                fontSize: 15,
                                color: kColorAzul,
                                fontWeight: FontWeight.w500),
                            textAlign: TextAlign.center,
                          ),
                          sumaSaldos == 0
                              ? const Icon(
                                  Icons.check_outlined,
                                  color: Colors.green,
                                )
                              : const Icon(
                                  Icons.close,
                                  color: Colors.red,
                                ),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("SUMA SALDOS",
                          style: TextStyle(fontWeight: FontWeight.w500)),
                      Text(sumaSaldos.toString(),
                          style: const TextStyle(fontWeight: FontWeight.w500)),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("SUMA SALDOS MUELLE",
                          style: TextStyle(fontWeight: FontWeight.w500)),
                      Text(sumaSaldoMuelle.toString(),
                          style: const TextStyle(fontWeight: FontWeight.w500)),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("SUMA SALDOS ABORDO",
                          style: TextStyle(fontWeight: FontWeight.w500)),
                      Text(sumaSaldoAbordo.toString(),
                          style: const TextStyle(fontWeight: FontWeight.w500)),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 25,
                    color: kColorCeleste,
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "RAMPA DESCARGA",
                            style: TextStyle(
                                fontSize: 15,
                                color: kColorAzul,
                                fontWeight: FontWeight.w500),
                            textAlign: TextAlign.center,
                          ),
                          operacionesDescarga == rampaDescargada
                              ? const Icon(
                                  Icons.check_outlined,
                                  color: Colors.green,
                                )
                              : const Icon(
                                  Icons.close,
                                  color: Colors.red,
                                ),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("OPERACIONES DESCARGADAS",
                          style: TextStyle(fontWeight: FontWeight.w500)),
                      Text(rampaDescargada.toString(),
                          style: const TextStyle(fontWeight: FontWeight.w500)),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("PENDIENTES DESCARGA",
                          style: TextStyle(fontWeight: FontWeight.w500)),
                      Text("${operacionesDescarga! - rampaDescargada!}",
                          style: const TextStyle(fontWeight: FontWeight.w500)),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 25,
                    color: kColorCeleste,
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "DISTRIBUCION EMBARQUE",
                            style: TextStyle(
                                fontSize: 15,
                                color: kColorAzul,
                                fontWeight: FontWeight.w500),
                            textAlign: TextAlign.center,
                          ),
                          operacionesEmbarque == distribucionEmbarque
                              ? const Icon(
                                  Icons.check_outlined,
                                  color: Colors.green,
                                )
                              : const Icon(
                                  Icons.close,
                                  color: Colors.red,
                                ),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("OPERACIONES DISTRIBUIDAS",
                          style: TextStyle(fontWeight: FontWeight.w500)),
                      Text(distribucionEmbarque.toString(),
                          style: const TextStyle(fontWeight: FontWeight.w500)),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("PENDIENTES",
                          style: TextStyle(fontWeight: FontWeight.w500)),
                      Text("${operacionesEmbarque! - distribucionEmbarque!}",
                          style: const TextStyle(fontWeight: FontWeight.w500)),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 25,
                    color: kColorCeleste,
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "RAMPA EMBARQUE",
                            style: TextStyle(
                                fontSize: 15,
                                color: kColorAzul,
                                fontWeight: FontWeight.w500),
                            textAlign: TextAlign.center,
                          ),
                          operacionesEmbarque == rampaEmbarcada
                              ? const Icon(
                                  Icons.check_outlined,
                                  color: Colors.green,
                                )
                              : const Icon(
                                  Icons.close,
                                  color: Colors.red,
                                ),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("OPERACIONES EMBARCADAS",
                          style: TextStyle(fontWeight: FontWeight.w500)),
                      Text(rampaEmbarcada.toString(),
                          style: const TextStyle(fontWeight: FontWeight.w500)),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("PENDIENTES EMBARQUE",
                          style: TextStyle(fontWeight: FontWeight.w500)),
                      Text("${operacionesEmbarque! - rampaEmbarcada!}",
                          style: const TextStyle(fontWeight: FontWeight.w500)),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 25,
                    color: kColorCeleste,
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "AUTOREPORT",
                            style: TextStyle(
                                fontSize: 15,
                                color: kColorAzul,
                                fontWeight: FontWeight.w500),
                            textAlign: TextAlign.center,
                          ),
                          operacionesDescarga == autoreport
                              ? const Icon(
                                  Icons.check_outlined,
                                  color: Colors.green,
                                )
                              : const Icon(
                                  Icons.close,
                                  color: Colors.red,
                                ),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("AUTOREPORT REGISTRADOS",
                          style: TextStyle(fontWeight: FontWeight.w500)),
                      Text(autoreport.toString(),
                          style: const TextStyle(fontWeight: FontWeight.w500)),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("PENDIENTES AUTOREPORT",
                          style: TextStyle(fontWeight: FontWeight.w500)),
                      Text("${operacionesDescarga! - autoreport!}",
                          style: const TextStyle(fontWeight: FontWeight.w500)),
                    ],
                  ),
                ]),
                /*   const SizedBox(
                  height: 20,
                ),
                MaterialButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  minWidth: double.infinity,
                  height: 50.0,
                  color: kColorNaranja,
                  onPressed: () {},
                  child: const Text(
                    "VALIDAR PROCESO",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5),
                  ),
                ), */
                const SizedBox(
                  height: 20,
                ),
                MaterialButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  minWidth: double.infinity,
                  height: 50.0,
                  color: kColorNaranja,
                  onPressed: () {
                    closeOperation(widget.idServiceOrder);
                  },
                  child: const Text(
                    "CERRAR PROCESO",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
