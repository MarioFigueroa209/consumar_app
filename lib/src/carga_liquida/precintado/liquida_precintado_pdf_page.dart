import 'package:flutter/src/widgets/framework.dart';
import 'package:printing/printing.dart';

import 'liquida_precintado_pdf_service.dart';

class LiquidaPrecintadoPdf extends StatefulWidget {
  const LiquidaPrecintadoPdf({super.key});

  @override
  State<LiquidaPrecintadoPdf> createState() => _LiquidaPrecintadoPdfState();
}

class _LiquidaPrecintadoPdfState extends State<LiquidaPrecintadoPdf> {
  LiquidaPrecintadoPdfService liquidaPrecintadoPdfService =
      LiquidaPrecintadoPdfService();

  @override
  Widget build(BuildContext context) {
    return PdfPreview(
      build: (format) {
        return liquidaPrecintadoPdfService.createPdf();
      },
      useActions: false,
    );
  }
}
