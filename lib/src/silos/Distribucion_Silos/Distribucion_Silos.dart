
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../utils/constants.dart';
import '../../../utils/lists.dart';


class DistribucionSilos extends StatefulWidget {
  const DistribucionSilos({Key? key}) : super(key: key);

  @override
  State<DistribucionSilos> createState() => _DistribucionSilosState();
}

class _DistribucionSilosState extends State<DistribucionSilos> {
  
  final _formKey = GlobalKey<FormState>();

  final _fechaController = TextEditingController();
  final SiloController = TextEditingController();
  
  String _valueJornadaDropdown = 'Seleccione jornada';
  String _valueSilosDropdown = 'Seleccione Silos';
  String _valueNaveDropdown = 'Seleccione Nave';
  String _valuePuntoDespachoDropdown = 'Seleccione Punto de Despacho';
  String _valueBLDropdown = 'Seleccione BL';

  bool enableJornadaDropdown = true;
  bool enableSilosDropdown = true;
  bool enableNaveDropdown = true; 
  bool enablePuntoDespachoDropdown = true;
  bool enableServiceOrderDropdown = true;
  bool enableBLDropdown = true;


  @override
  Widget build(BuildContext context) {
    _fechaController.value =
        TextEditingValue(text: DateFormat('dd-MM-yyyy').format(DateTime.now()));
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Distribucion de Silos"),
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
                  IgnorePointer(
                    ignoring: enableJornadaDropdown,
                    child: DropdownButtonFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        labelText: 'Silo',
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
                          _valueSilosDropdown = value as String;
                        })
                      },
                      validator: (value) {
                        if (value != _valueSilosDropdown) {
                          return 'Por favor, elige Silo';
                        }
                        return null;
                      },
                      hint: Text(_valueSilosDropdown),
                    ),
                  ),

                  const SizedBox(height: 20),

                  IgnorePointer(
                    ignoring: enableSilosDropdown,
                    child: DropdownButtonFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        labelText: 'Nave',
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
                          _valueNaveDropdown = value as String;
                        })
                      },
                      validator: (value) {
                        if (value != _valueNaveDropdown) {
                          return 'Por favor, elige Nave';
                        }
                        return null;
                      },
                      hint: Text(_valueNaveDropdown),
                    ),
                  ),

                  const SizedBox(height: 20),

                  IgnorePointer(
                    ignoring: enableNaveDropdown,
                    child: DropdownButtonFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        labelText: 'Nave',
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
                          _valueNaveDropdown = value as String;
                        })
                      },
                      validator: (value) {
                        if (value != _valueNaveDropdown) {
                          return 'Por favor, elige Nave';
                        }
                        return null;
                      },
                      hint: Text(_valueNaveDropdown),
                    ),
                  ),

                  const SizedBox(height: 20),

                  IgnorePointer(
                    ignoring: enablePuntoDespachoDropdown,
                    child: DropdownButtonFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        labelText: 'Punto de Despacho',
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
                          _valuePuntoDespachoDropdown = value as String;
                        })
                      },
                      validator: (value) {
                        if (value != _valuePuntoDespachoDropdown) {
                          return 'Por favor, elige Punto de Despacho';
                        }
                        return null;
                      },
                      hint: Text(_valuePuntoDespachoDropdown),
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

                  IgnorePointer(
                    ignoring: enableBLDropdown,
                    child: DropdownButtonFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        labelText: 'BL',
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
                          _valueBLDropdown = value as String;
                        })
                      },
                      validator: (value) {
                        if (value != _valueBLDropdown) {
                          return 'Por favor, elige BL';
                        }
                        return null;
                      },
                      hint: Text(_valueBLDropdown),
                    ),
                  ),

                  const SizedBox(height: 20),
            
                  MaterialButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    minWidth: double.infinity,
                    height: 50.0,
                    color: kColorNaranja,
                    onPressed: () {
                    },
                    child: const Text(
                      "AGREGAR",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5
                      ),
                    ),
                  ),

                  const SizedBox(height: 200),
                  
                  MaterialButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    minWidth: double.infinity,
                    height: 50.0,
                    color: kColorNaranja,
                    onPressed: () {
                    },
                    child: const Text(
                      "REGISTRAR DISTRIBUCION",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5
                      ),
                    ),
                  ),
                  
                ],
          )),               
          ]),
        ),
      ),
    );
  }
}


