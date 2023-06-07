import 'package:flutter/material.dart';

import '../../widgets/boton_menu.dart';
import 'inspeccion_equipos_page.dart';
import 'registro_equipos_page.dart';

class MenuRegistroEquipos extends StatelessWidget {
  const MenuRegistroEquipos(
      {Key? key,
      required this.jornada,
      required this.idUsuario,
      required this.idServiceOrder})
      : super(key: key);
  final int jornada;
  final int idUsuario;
  final int idServiceOrder;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("INSPECCION DE EQUIPOS"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BotonMenu(
              title: 'REGISTRO DE EQUIPOS',
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const RegistroEquipos()));
              },
              icon: Icons.person_add,
            ),
            const SizedBox(
              height: 20,
            ),
            BotonMenu(
              title: 'INSPECCION DE EQUIPOS',
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Inspeccionequipos(
                              idServiceOrder: idServiceOrder,
                              idUsuario: idUsuario,
                              jornada: jornada,
                            )));
              },
              icon: Icons.list,
            ),
          ],
        ),
      ),
    );
  }
}
