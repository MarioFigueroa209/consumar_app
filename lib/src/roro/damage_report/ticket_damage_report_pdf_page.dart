import 'package:flutter/material.dart';
import 'package:printing/printing.dart';

import '../../../services/roro/damage_report/ticket_damage_report_pdf_service.dart';

class TicketDamageReportPDF extends StatefulWidget {
  const TicketDamageReportPDF({Key? key, required this.idServiceOrder})
      : super(key: key);
  final BigInt idServiceOrder;

  @override
  State<TicketDamageReportPDF> createState() => _TicketDamageReportPDFState();
}

class _TicketDamageReportPDFState extends State<TicketDamageReportPDF> {
  TicketDamageReport ticketDamageReport = TicketDamageReport();

  /* getVVwTicketDrListado() async {
    await ticketDamageReport.getVVwTicketDrListado(widget.idServiceOrder);
  } */

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getVVwTicketDrListado();
  }

  @override
  Widget build(BuildContext context) {
    return PdfPreview(
      build: (format) {
        return ticketDamageReport.createPdf(widget.idServiceOrder);
      },
      useActions: false,
    );
  }
}
