import 'package:flutter/material.dart';

import '../../../models/survey/InspeccionEquipos/vw_inspeccion_fotos_by_id_inspeccion.dart';
import '../../../services/survey/inspeccion_equipo_service.dart';

class ImagenesEquipos extends StatefulWidget {
  const ImagenesEquipos({Key? key, required this.idInspeccionEquipo})
      : super(key: key);
  final int idInspeccionEquipo;

  @override
  State<ImagenesEquipos> createState() => _ImagenesEquiposState();
}

class _ImagenesEquiposState extends State<ImagenesEquipos> {
  String codEquipo = "";
  InspeccionEquipoService inspeccionEquipoService = InspeccionEquipoService();

  List<VwInspeccionFotosByIdInspeccion> vwInspeccionFotosByIdInspeccionList =
      [];

  obtenerListadoImagenesEquipo() async {
    vwInspeccionFotosByIdInspeccionList = await inspeccionEquipoService
        .getInspeccionFotosByIdInspeccion(widget.idInspeccionEquipo);
    setState(() {
      codEquipo = vwInspeccionFotosByIdInspeccionList[0].codEquipo!;
    });

    //print(vwInspeccionFotosByIdInspeccionList.length);
    //print(vwInspeccionFotosByIdInspeccionList[0].urlImagen);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    obtenerListadoImagenesEquipo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("EQUIPO: $codEquipo"),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(children: [
          Table(border: TableBorder.all(color: Colors.blueGrey), children: [
            for (var i = 0; i < vwInspeccionFotosByIdInspeccionList.length; i++)
              TableRow(children: [
                Column(children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.network(
                        vwInspeccionFotosByIdInspeccionList[i].urlImagen!,
                        height: 150,
                        width: 150,
                      ),
                    ],
                  ),
                ]),
              ])
          ])
        ]),
      ),
    );
  }
}
