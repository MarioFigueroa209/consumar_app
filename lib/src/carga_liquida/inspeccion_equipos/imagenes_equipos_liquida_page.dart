import 'package:flutter/material.dart';

import '../../../models/carga_liquida/inspeccionEquipos/vw_liquida_inspeccion_fotos_by_id_inspeccion.dart';
import '../../../services/carga_liquida/inspeccion_equipo_liquida_service.dart';

class ImagenesEquiposLiquida extends StatefulWidget {
  const ImagenesEquiposLiquida({super.key, required this.idInspeccionEquipo});
  final int idInspeccionEquipo;

  @override
  State<ImagenesEquiposLiquida> createState() => _ImagenesEquiposLiquidaState();
}

class _ImagenesEquiposLiquidaState extends State<ImagenesEquiposLiquida> {
  InspeccionEquipoLiquidaService inspeccionEquipoLiquidaService =
      InspeccionEquipoLiquidaService();

  String codEquipo = "";

  List<VwLiquidaInspeccionFotosByIdInspeccion>
      vwInspeccionFotosByIdInspeccionList = [];

  obtenerListadoImagenesEquipo() async {
    vwInspeccionFotosByIdInspeccionList = await inspeccionEquipoLiquidaService
        .getInspeccionFotosLiquidaByIdInspeccion(widget.idInspeccionEquipo);
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
