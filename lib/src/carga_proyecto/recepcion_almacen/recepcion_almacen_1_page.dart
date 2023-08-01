import 'package:consumar_app/src/carga_proyecto/recepcion_almacen/recepcion_almacen_ingreso.dart';
import 'package:consumar_app/src/carga_proyecto/recepcion_almacen/recepcion_almacen_manipulado.dart';
import 'package:consumar_app/src/carga_proyecto/recepcion_almacen/recepcion_almacen_posicionado.dart';
import 'package:consumar_app/utils/qr_scanner/barcode_scanner_window.dart';
import 'package:flutter/material.dart';
import '../../../utils/constants.dart';

class RecepcionAlmacen1 extends StatefulWidget {
  RecepcionAlmacen1(
      {super.key,
      required this.jornada,
      required this.idUsuario,
      required this.idServiceOrder});
  final int jornada;
  final int idUsuario;
  final int idServiceOrder;

  @override
  State<RecepcionAlmacen1> createState() => _RecepcionAlmacen1State();
}

class DatosAlmacen {
  DatosAlmacen({this.cod, this.bulto, this.placaTracto, this.placaTolva});

  String? cod;
  String? bulto;
  String? placaTracto;
  String? placaTolva;
}

class _RecepcionAlmacen1State extends State<RecepcionAlmacen1> {
  final TextEditingController qrCodigoController = TextEditingController();

  List<DatosAlmacen> listDatosAlmacen = <DatosAlmacen>[
    DatosAlmacen(
        cod: "231313",
        bulto: "Bowl Botton",
        placaTracto: "D3K-909",
        placaTolva: "AJE-986")
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("RECEPCION ALMACEN"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(children: [
            TextFormField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  prefixIcon: IconButton(
                      icon: const Icon(Icons.qr_code),
                      onPressed: () async {
                        final result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const BarcodeScannerWithScanWindow()));
                        qrCodigoController.text = result;
                      }),
                  suffixIcon: IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: () {
                        // getUserConductorDataByCodUser();
                      }),
                  labelText: 'PLACA',
                  labelStyle: TextStyle(
                    color: kColorAzul,
                    fontSize: 20.0,
                  ),
                  hintText: 'Ingrese la placa'),
              onChanged: (value) {
                // getUserConductorDataByCodUser();
              },
              controller: qrCodigoController,
              /*    validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, ingrese la placa';
                }
                return null;
              }, */
            ),
            const SizedBox(height: 20),
            TextFormField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  prefixIcon: IconButton(
                      icon: const Icon(Icons.qr_code),
                      onPressed: () async {
                        final result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const BarcodeScannerWithScanWindow()));
                        qrCodigoController.text = result;
                      }),
                  suffixIcon: IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: () {
                        // getUserConductorDataByCodUser();
                      }),
                  labelText: 'Qr',
                  labelStyle: TextStyle(
                    color: kColorAzul,
                    fontSize: 20.0,
                  ),
                  hintText: 'Ingrese el cod Qr'),
              onChanged: (value) {
                // getUserConductorDataByCodUser();
              },
              controller: qrCodigoController,
              /*  validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, ingrese el Qr';
                }
                return null;
              }, */
            ),
            const SizedBox(height: 20),
            TextFormField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  suffixIcon: IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: () {
                        // getUserConductorDataByCodUser();
                      }),
                  labelText: 'Descripcion',
                  labelStyle: TextStyle(
                    color: kColorAzul,
                    fontSize: 20.0,
                  ),
                  hintText: 'Ingrese la descripcion'),
              onChanged: (value) {
                // getUserConductorDataByCodUser();
              },
              controller: qrCodigoController,
              /*  validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, ingrese la descripcion';
                }
                return null;
              }, */
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 700,
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: listDatosAlmacen.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      /* onTap: () {
                            setState(() {});
                          }, */
                      onLongPress: () {
                        /*   getPrecintosById(listGranelPrecinto[index].idCarguio!);
                        _tabController.animateTo((_tabController.index = 1)); */
                        /*    if (_valueResponsableDropdown ==
                                    "TODOS LOS REGISTROS") {
                                  CustomSnackBar.errorSnackBar(context,
                                      "Por favor, seleccionar responsable e ingresar sus datos");
                                } else {
                                  setState(() {
                                    idDamageReportNxtPage = BigInt.parse(
                                        allDR[index].idDamageReport.toString());
                                  });
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => DrInformeFinal(
                                                idDamageReport:
                                                    idDamageReportNxtPage,
                                                codCapitan: codCapitan.text,
                                                nombreCapitan: nombrecapitan.text,
                                                idServiceOrder:
                                                    widget.idServiceOrder,
                                                jornada: widget.jornada,
                                                idCoordinador: int.parse(widget
                                                    .idUsuarioCoordinador
                                                    .toString()),
                                                idSupervisorApmtc: idApmtc,
                                                responsable:
                                                    _valueResponsableDropdown,
                                                urlImgFirma: urlImgFirma!,
                                              )));
                                } */
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        borderOnForeground: true,
                        margin: const EdgeInsets.all(10),
                        color: Colors.white,
                        shadowColor: Colors.grey,
                        elevation: 10,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: SizedBox(
                            //height: 240.0,
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        /*  Row(
                                          children: [
                                            const Icon(Icons.receipt),
                                            const SizedBox(
                                              width: 10.0,
                                            ),
                                            Text(
                                              listDatosAlmacen[index].cod.toString(),
                                              style: tituloCardDamage,
                                            ),
                                          ],
                                        ),
                                        const Divider(), */
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Cod: ",
                                              style: etiquetasCardDamage,
                                            ),
                                            Text(
                                              listDatosAlmacen[index]
                                                  .cod
                                                  .toString(),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Bulto: ",
                                              style: etiquetasCardDamage,
                                            ),
                                            Text(
                                              listDatosAlmacen[index]
                                                  .bulto
                                                  .toString(),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Text("Placa Tracto: ",
                                                style: etiquetasCardDamage),
                                            Text(listDatosAlmacen[index]
                                                .placaTracto
                                                .toString())
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Placa Tolva: ",
                                              style: etiquetasCardDamage,
                                            ),
                                            Text(
                                              listDatosAlmacen[index]
                                                  .placaTolva
                                                  .toString(),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      // mainAxisAlignment: MainAxisAlignment.,
                                      children: <Widget>[
                                        ElevatedButton(
                                            style: TextButton.styleFrom(
                                              backgroundColor: Colors.green,
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                            ),
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          RecepcionAlmacenIngreso()));
                                            },
                                            child: const Text(
                                              "INGRESADO",
                                              style: TextStyle(fontSize: 15),
                                            )),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        ElevatedButton(
                                            style: TextButton.styleFrom(
                                              backgroundColor: Colors.green,
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                            ),
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          RecepcionAlmacenManipuleo()));
                                            },
                                            child: const Text(
                                              "MANIPULADO",
                                              style: TextStyle(fontSize: 15),
                                            )),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        ElevatedButton(
                                            style: TextButton.styleFrom(
                                              backgroundColor: Colors.green,
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                            ),
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          RecepcionAlmacenPosicion()));
                                            },
                                            child: const Text(
                                              "POSICIONADO",
                                              style: TextStyle(fontSize: 15),
                                            )),
                                      ],
                                    ),
                                  ],
                                ),
                                /* const Divider(),
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      IconButton(
                                        icon: const Icon(
                                          Icons.delete,
                                          color: Colors.grey,
                                        ),
                                        onPressed: () {
                                          /*    dialogoEliminar(
                                                          context, allDR[index]); */
                                        },
                                      ),
                                    ]), */
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
            ),
          ]),
        ),
      ),
    );
  }
}
