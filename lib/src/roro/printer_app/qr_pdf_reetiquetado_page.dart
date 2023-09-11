import 'package:flutter/material.dart';
import 'package:printing/printing.dart';

import '../../../services/qr_roro_pdf_reetiquetado_service.dart';

class QrPdfReetiquetadoPage extends StatefulWidget {
  const QrPdfReetiquetadoPage({super.key, required this.idVehicle});
  final int idVehicle;

  @override
  State<QrPdfReetiquetadoPage> createState() => _QrPdfReetiquetadoPageState();
}

class _QrPdfReetiquetadoPageState extends State<QrPdfReetiquetadoPage> {
  QrRoroPdfReetiquetadoService qrRoroPdfService =
      QrRoroPdfReetiquetadoService();

  @override
  Widget build(BuildContext context) {
    return PdfPreview(
      build: (format) {
        return qrRoroPdfService
            .createPdf(int.parse(widget.idVehicle.toString()));
      },
      useActions: false,
    );
  }
}
