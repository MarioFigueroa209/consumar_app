import 'package:consumar_app/src/survey/precintado/precintado_pdf_service.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:printing/printing.dart';

class PrecintoPdf extends StatefulWidget {
  const PrecintoPdf({super.key});

  @override
  State<PrecintoPdf> createState() => _PrecintoPdfState();
}

class _PrecintoPdfState extends State<PrecintoPdf> {
  PrecintadoPdfService precintadoPdfService = PrecintadoPdfService();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PdfPreview(
      build: (format) {
        return precintadoPdfService.createPdf();
      },
      useActions: false,
    );
  }
}
