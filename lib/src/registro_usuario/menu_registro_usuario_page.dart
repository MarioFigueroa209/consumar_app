import 'package:flutter/material.dart';
import '../widgets/boton_menu.dart';
import 'registro_transporte_list_page.dart';
import 'registro_transporte_page.dart';
import 'registro_usuario_list_page.dart';
import 'registro_usuario_page.dart';

class MenuRegistroUsuarios extends StatelessWidget {
  const MenuRegistroUsuarios({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("REGISTRO DE USUARIOS"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BotonMenu(
                  title: 'REGISTRO DE USUARIOS',
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const RegistroUsuarioPage()));
                  },
                  icon: Icons.person_add,
                ),
                const SizedBox(
                  width: 20,
                ),
                BotonMenu(
                  title: 'LISTA DE USUARIOS',
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const RegistroUsuarioList()));
                  },
                  icon: Icons.list,
                ),
              ],
            ),
            const SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BotonMenu(
                  title: 'REGISTRO TRANSPORTE',
                  icon: Icons.car_repair,
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const RegistroTransportePage()));
                  },
                ),
                const SizedBox(
                  width: 20,
                ),
                BotonMenu(
                  title: 'LISTA DE TRANSPORTE',
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const RegistroTransporteList()));
                  },
                  icon: Icons.list,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
