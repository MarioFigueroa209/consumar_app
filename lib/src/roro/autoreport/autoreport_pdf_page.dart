import 'package:flutter/material.dart';
import 'package:printing/printing.dart';

import '../../../services/roro/autoreport/autoreport_pdf_service.dart';

class AutoreportPdf extends StatefulWidget {
  const AutoreportPdf({super.key, required this.idAutoreport});

  final BigInt idAutoreport;

  @override
  State<AutoreportPdf> createState() => _AutoreportPdfState();
}

class _AutoreportPdfState extends State<AutoreportPdf> {
  AutoreportPdfService autoreportPdf = AutoreportPdfService();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PdfPreview(
      build: (format) {
        return autoreportPdf.createPdf(widget.idAutoreport);
      },
      useActions: false,
    );
  }
}
