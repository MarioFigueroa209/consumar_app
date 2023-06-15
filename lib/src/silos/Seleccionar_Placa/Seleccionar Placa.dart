import 'package:flutter/material.dart';

class SeleccionarPlaca extends StatefulWidget {
  const SeleccionarPlaca({Key? key}) : super(key: key);

  @override
  State<SeleccionarPlaca> createState() => _SeleccionarPlacaState();
}

class _SeleccionarPlacaState extends State<SeleccionarPlaca> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Seleccionar Placa'),
      )
    );
  }


}