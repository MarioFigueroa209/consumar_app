import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../models/marca_model.dart';
import '../../../../models/vehicle_model.dart';
import '../../../../models/vw_id_service_order_and_id_vehicle_model.dart';
import '../../../../models/vw_ship_and_travel_by_id_service_order_model.dart';
import '../../../../services/marca_services.dart';
import '../../../../services/vehicle_service.dart';
import '../../../../utils/constants.dart';
import '../../../../utils/lists.dart';
import '../../../services/roro/rampa_embarque/rampa_embarque_services.dart';
import '../../../utils/roro/distribucion_embarque_models.dart';

class EditDistribucionEmbarque extends StatefulWidget {
  final DistribucionItem distribucionItem;
  final BigInt? idServiceOrderRampa;

  const EditDistribucionEmbarque(this.distribucionItem, {super.key, this.idServiceOrderRampa});

  @override
  State<EditDistribucionEmbarque> createState() =>
      _EditDistribucionEmbarqueState();
}

TextEditingController cantidadController = TextEditingController();

String id = "null";
String _selectedMarca = 'Elegir Marca';
String _desplegable1 = 'Elegir Nivel';

List<DistribucionItem> detalleDistribucionEmbarque = [];

class _EditDistribucionEmbarqueState extends State<EditDistribucionEmbarque>
    with SingleTickerProviderStateMixin {
  late List<DistribucionItem> distribuciones;
  VehicleService vehicleService = VehicleService();
  MarcaService marcaService = MarcaService();

  late Future<List<VehicleModel>> futureVehicles;
  late Future<List<MarcaModel>> futureMarcas;

  final _formKey = GlobalKey<FormState>();

  VwShipAndTravelByIdServiceOrderModel vwShipAndTravelByIdServiceOrderModel =
      VwShipAndTravelByIdServiceOrderModel();

  late int idShip;

  VwIdServiceOrderAndIdVehicleModel vwIdServiceOrderAndIdVehicleModel =
      VwIdServiceOrderAndIdVehicleModel();

  int manifestado = 0;
  int registrado = 0;
  int saldo = 0;

  getVehicleCountByIdServiceOrder() async {
    RampaEmbarqueService rampaEmbarqueService = RampaEmbarqueService();

    vwIdServiceOrderAndIdVehicleModel = await rampaEmbarqueService
        .getVehicleCountByIdServiceOrder(widget.idServiceOrderRampa!);

    setState(() {
      manifestado = int.parse(
          vwIdServiceOrderAndIdVehicleModel.cantidadVehiculos!.toString());
      saldo = int.parse(
          vwIdServiceOrderAndIdVehicleModel.cantidadVehiculos!.toString());
    });
  }

  calcularSaldo() {
    setState(() {
      saldo = manifestado - registrado;
    });
  }

  @override
  void initState() {
    DistribucionItem e = widget.distribucionItem;
    id = e.id.toString();
    _selectedMarca = e.marca.toString();
    cantidadController = TextEditingController(text: e.cantidad.toString());
    _desplegable1 = e.nivel.toString();
    super.initState();
    futureVehicles = vehicleService.getVehicles();
    futureMarcas = marcaService.getMarcaDistinc();

    distribuciones = List.of(detalleDistribucionEmbarque);
    getVehicleCountByIdServiceOrder();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Editar Distribución"),
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  //Jalar de la BBDD Marcas Distintas
                  DropdownButtonHideUnderline(
                    child: FutureBuilder<List<MarcaModel>>(
                      future: futureMarcas,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return DropdownButtonFormField(
                            //key: _key1,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              labelText: 'Marca',
                              labelStyle: TextStyle(
                                color: kColorAzul,
                                fontSize: 20.0,
                              ),
                            ),
                            icon: const Icon(
                              Icons.arrow_drop_down_circle_outlined,
                            ),
                            items: snapshot.data
                                ?.map<DropdownMenuItem<String>>((vehicle) {
                              return DropdownMenuItem<String>(
                                value: vehicle.marca.toString(),
                                child: Text(
                                  vehicle.marca.toString(),
                                ),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                _selectedMarca = value as String;
                              });
                            },
                            validator: (value) {
                              if (value == null) {
                                return 'Por favor, elija la marca';
                              }
                              return null;
                            },
                            hint: Text(_selectedMarca),
                          );
                        } else if (snapshot.hasError) {
                          return Text("${snapshot.error}");
                        } else {
                          return const CircularProgressIndicator();
                        }
                      },
                    ),
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  TextFormField(
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        prefixIcon: Icon(
                          Icons.qr_code,
                          color: kColorAzul,
                        ),
                        labelText: 'Cantidad',
                        labelStyle: TextStyle(
                          color: kColorAzul,
                          fontSize: 20.0,
                        ),
                        suffixIcon: IconButton(
                            icon: const Icon(Icons.cancel),
                            onPressed: () {
                              setState(() {
                                cantidadController.clear();
                              });
                            }),
                        hintText: ''),
                    controller: cantidadController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        //print('Cantidad: $value');
                        return 'Por favor, ingrese la cantidad';
                      }
                      //idUsuario = BigInt.parse(value);

                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  DropdownButtonFormField(
                    //key: _key2,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      labelText: 'N° Nivel',
                      labelStyle: TextStyle(
                        color: kColorAzul,
                        fontSize: 20.0,
                      ),
                    ),
                    icon: const Icon(
                      Icons.arrow_drop_down_circle_outlined,
                    ),
                    items: nivelesLista.map((String a) {
                      return DropdownMenuItem<String>(
                        value: a,
                        child:
                            Center(child: Text(a, textAlign: TextAlign.left)),
                      );
                    }).toList(),
                    onChanged: (value) => {
                      setState(() {
                        _desplegable1 = value as String;
                      })
                    },
                    validator: (value) {
                      if (value != _desplegable1) {
                        return 'Por favor, elija el nivel';
                      }
                      return null;
                    },
                    hint: Text(_desplegable1),
                  ),
                ],
              ),
              const SizedBox(
                height: 100,
              ),
              MaterialButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                minWidth: double.infinity,
                height: 50.0,
                color: kColorNaranja,
                onPressed: () {
                  String marca = _selectedMarca.toString();
                  String cantidad = cantidadController.text;
                  String nivel = _desplegable1.toString();

                  if (marca.isNotEmpty &&
                      cantidad.isNotEmpty &&
                      nivel.isNotEmpty) {
                    Navigator.pop(
                        context,
                        DistribucionItem(
                            id: int.parse(id),
                            marca: marca,
                            cantidad: int.parse(cantidad),
                            nivel: int.parse(nivel)));
                  }
                  /*
                  Navigator.pop(
                      context,
                      DistribucionItem(
                          marca: marca,
                          cantidad: int.parse(cantidad),
                          nivel: int.parse(nivel)));
*/
                  setState(() {});
                },
                child: const Text(
                  "MODIFICAR REGISTRO",
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      )),
    );
  }
}
