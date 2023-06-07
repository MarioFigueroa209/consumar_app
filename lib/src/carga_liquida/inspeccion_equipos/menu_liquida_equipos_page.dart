import 'package:consumar_app/src/carga_liquida/inspeccion_equipos/inspeccion_equipos_liquida_page.dart';
import 'package:consumar_app/src/carga_liquida/inspeccion_equipos/registro_equipos_liquida_page.dart';
import 'package:flutter/material.dart';

import '../../widgets/boton_menu.dart';

class MenuLiquidaEquipos extends StatelessWidget {
  const MenuLiquidaEquipos(
      {super.key,
      required this.jornada,
      required this.idUsuario,
      required this.idServiceOrder});
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
                        builder: (context) => const RegistroEquiposLiquida()));
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
                        builder: (context) => InspeccionEquiposLiquidaPage(
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
