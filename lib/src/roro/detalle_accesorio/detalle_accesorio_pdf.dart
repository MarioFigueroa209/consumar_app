import 'package:flutter/material.dart';
import 'package:printing/printing.dart';

import '../../../services/roro/detalle_accesorio/detalle_accesorio_pdf_service.dart';

class DetalleAccesorioPDF extends StatefulWidget {
  const DetalleAccesorioPDF({super.key, required this.idDetalleAccesorio});

  final BigInt idDetalleAccesorio;

  @override
  State<DetalleAccesorioPDF> createState() => _DetalleAccesorioPDFState();
}

class _DetalleAccesorioPDFState extends State<DetalleAccesorioPDF> {
  DetalleAccesorioPdfService detalleAccesorioPdf = DetalleAccesorioPdfService();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // //print("el Id de Detalle Accesorio es ${widget.idDetalleAccesorio}");
  }

  @override
  Widget build(BuildContext context) {
    return PdfPreview(
      build: (format) {
        return detalleAccesorioPdf.createPdf(widget.idDetalleAccesorio);
      },
      useActions: false,
    );
  }
}
