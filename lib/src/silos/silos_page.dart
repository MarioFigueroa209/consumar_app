import 'package:consumar_app/src/silos/Control_Tickets/Control_Tickets.dart';
import 'package:consumar_app/src/silos/Control_Visual/Control_Visual.dart';
import 'package:consumar_app/src/silos/Seleccionar_Placa/Seleccionar%20Placa.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../models/vw_all_service_order_granel.dart';
import '../../utils/constants.dart';
import '../../utils/lists.dart';
import '../scanner_screen.dart';
import '../widgets/boton_menu.dart';
import 'Distribucion_Silos/Distribucion_Silos.dart';

class Silos extends StatefulWidget {
  const Silos({Key? key}) : super(key: key);

  @override
  State<Silos> createState() => _SilosState();
}

class _SilosState extends State<Silos> {
  
  final _formKey = GlobalKey<FormState>();

  final _fechaController = TextEditingController();
  final idUsuarioController = TextEditingController();

  List<VwAllServiceOrderGranel> serviceOrdersList = <VwAllServiceOrderGranel>[];
  
  String _valueJornadaDropdown = 'Seleccione jornada';
  bool enableJornadaDropdown = true;
  bool enableServiceOrderDropdown = true;

  List<DropdownMenuItem<String>> getServiceOrdersDropDownItems(
      List<VwAllServiceOrderGranel> orders) {
    List<DropdownMenuItem<String>> dropDownItems = [];

    for (var element in orders) {
      var newDropDown = DropdownMenuItem(
        value: element.idServiceOrder.toString(),
        child: Text(
          element.serviceOrder.toString(),
        ),
      );
      dropDownItems.add(newDropDown);
    }
    return dropDownItems;
  }

  @override
  Widget build(BuildContext context) {
    _fechaController.value =
        TextEditingValue(text: DateFormat('dd-MM-yyyy').format(DateTime.now()));
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Despacho de Silos"),
      ),
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
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
                              const ScannerScreen()
                            )
                          );
                          idUsuarioController.text = result;
                        }
                      ),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.search),
                        onPressed: () {
                        }
                      ),
                      labelText: 'Id.Job',
                      labelStyle: TextStyle(
                        color: kColorAzul,
                        fontSize: 20.0,
                      ),
                      hintText: 'Ingrese el numero de ID Job'
                    ),
                    onChanged: (value) {
                    },
                    controller: idUsuarioController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, ingrese el Id Job';
                      }
                      return null;
                    },
                  ),
                  
                  const SizedBox(height: 20),

                  IgnorePointer(
                    ignoring: enableServiceOrderDropdown,
                    child: DropdownButtonHideUnderline(
                      child: DropdownButtonFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          labelText: 'Orden de servicio',
                          hintText: 'Selecione Orden de servicio',
                          labelStyle: TextStyle(
                            color: kColorAzul,
                            fontSize: 20.0,
                          ),
                        ),
                        icon: const Icon(
                          Icons.arrow_drop_down_circle_outlined,
                        ),
                        items: getServiceOrdersDropDownItems(serviceOrdersList),
                        onChanged: (value) {
                        },
                        validator: (value) {
                          if (value == null) {
                            return 'Por favor, elige order de servicio';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 20),
                  IgnorePointer(
                    ignoring: enableServiceOrderDropdown,
                    child: DropdownButtonHideUnderline(
                      child: DropdownButtonFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          labelText: 'Lado',
                          hintText: 'Seleccione el lado',
                          labelStyle: TextStyle(
                            color: kColorAzul,
                            fontSize: 20.0,
                          ),
                        ),
                        icon: const Icon(
                          Icons.arrow_drop_down_circle_outlined,
                        ),
                        items: getServiceOrdersDropDownItems(serviceOrdersList),
                        onChanged: (value) {
                        },
                        validator: (value) {
                          if (value == null) {
                            return 'Por favor, elige el lado';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      prefixIcon: Icon(
                        Icons.calendar_month,
                        color: kColorAzul,
                      ),
                      labelText: 'Fecha',
                      labelStyle: TextStyle(
                        color: kColorAzul,
                        //fontSize: 20.0,
                      ),
                    ),
                    controller: _fechaController,
                    style: TextStyle(
                      color: kColorAzul,
                      fontSize: 20.0,
                    ),
                    enabled: false,
                  ),
                    
                  const SizedBox(height: 20),
                    
                  IgnorePointer(
                    ignoring: enableJornadaDropdown,
                    child: DropdownButtonFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        labelText: 'Jornada',
                        labelStyle: TextStyle(
                          color: kColorAzul,
                          fontSize: 20.0,
                        ),
                      ),
                      icon: const Icon(
                        Icons.arrow_drop_down_circle_outlined,
                      ),
                      items: listaJornada.map((String a) {
                        return DropdownMenuItem<String>(
                          value: a,
                          child: Center(
                            child: Text(a, textAlign: TextAlign.left)),
                        );
                      }).toList(),
                      onChanged: (value) => {
                        setState(() {
                          _valueJornadaDropdown = value as String;
                        })
                      },
                      validator: (value) {
                        if (value != _valueJornadaDropdown) {
                          return 'Por favor, elige jornada';
                        }
                        return null;
                      },
                      hint: Text(_valueJornadaDropdown),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "OPERACION",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          BotonMenu(
                            title: 'Control de Tickets',
                            icon: Icons.content_paste_search,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ControlTickets()          
                                )
                              );
                              //Insertar un showDialog
                            }
                          ),
                          const SizedBox(width: 20),
                          BotonMenu(
                            title: 'Seleccionar placa',
                            icon: Icons.domain_verification,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SeleccionarPlaca()          
                                )
                              );
                            }
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          BotonMenu(
                            title: 'Control visual',
                            icon: Icons.format_list_numbered_sharp,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ControlVisual()          
                                )
                              );
                            }
                          ),
                          const SizedBox(width: 20),
                          BotonMenu(
                            title: 'Distribucion de Silos',
                            icon: Icons.error_outline,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DistribucionSilos()          
                                )
                              );
                            }
                            
                          ),
                        ],
                      ),
                          
                  ],
                ),
                ],
          )),               
          ]),
        ),
      ),
    );
  }
}


