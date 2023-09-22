import 'package:consumar_app/src/survey/precintado/precintado_pdf_service.dart';
import 'package:flutter/material.dart';
import 'package:printing/printing.dart';

class PrecintoPdf extends StatefulWidget {
  const PrecintoPdf(
      {super.key, required this.idCarguio, required this.idServiceOrder});
  final int idCarguio;
  final int idServiceOrder;

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
        return precintadoPdfService.createPdf(
            widget.idServiceOrder, widget.idCarguio);
      },
      useActions: false,
    );
  }
}
