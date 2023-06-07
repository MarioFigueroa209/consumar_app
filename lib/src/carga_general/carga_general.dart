import 'package:flutter/material.dart';

class CargaGeneral extends StatefulWidget {
  const CargaGeneral({Key? key}) : super(key: key);

  @override
  State<CargaGeneral> createState() => _CargaGeneralState();
}

class _CargaGeneralState extends State<CargaGeneral> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("CARGA GENERAL"),
      ),
    );
  }
}
