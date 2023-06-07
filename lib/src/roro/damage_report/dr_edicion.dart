import 'package:flutter/material.dart';

class DamageReportEdicion extends StatefulWidget {
  const DamageReportEdicion({Key? key}) : super(key: key);

  @override
  State<DamageReportEdicion> createState() => _DamageReportEdicionState();
}

class DamageItem {
  final String cod;
  final String damage;
  final String partOfVehicle;
  final String side;

  DamageItem(this.cod, this.damage, this.partOfVehicle, this.side);
}

final List<DamageItem> _damageList = [
  DamageItem("1.2", "Rotura", "Espejo", "Derecho"),
  DamageItem("2.2", "Abolladura", "Capo", "Centro"),
  DamageItem("3.1", "Faltante", "Llaves", "-")
];

class _DamageReportEdicionState extends State<DamageReportEdicion> {
  final _damageFound = [
    'DURING LOADING',
    'DURING VOYAGE',
    'BEFORE DISCHARGE',
    'DURING DISCHARGE',
    'AFTER DISCHARGE',
  ];

  final _nTrabajador = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10',
    '11',
    '12',
    '13',
    '14',
    '15',
    '16',
    '17',
    '18',
    '19',
    '20',
  ];

  final _damageOccurred = [
    'DURING LOADING',
    'DURING VOYAGE',
    'BEFORE DISCHARGE',
    'DURING DISCHARGE',
    'AFTER DISCHARGE',
  ];

  final _operation = [
    'LOADING',
    'UNLOADING',
    'BEFORE DISCHARGE',
    'DURING DISCHARGE',
    'AFTER DISCHARGE',
  ];

  final _cantidadDanos = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10',
  ];

  String _desplegable5 = 'Seleccione Trabajador';
  String _desplegable1 = 'Seleccione un Item';
  String _desplegable2 = 'Seleccione un Item';
  String _desplegable3 = 'Seleccione Operación';
  String _desplegable4 = 'Seleccione Cant. Daños';

  bool value1 = false;
  bool value2 = false;
  bool value3 = false;
  bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(0, 0, 85, 1),
        centerTitle: true,
        title: const Text('DAMAGE REPORT EDICION'),
      ),
      body: ListView(
        children: [
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                children: [
                  const Text("Responsable APMTC",
                      style: TextStyle(
                          fontSize: 15,
                          color: Color.fromRGBO(0, 0, 85, 1),
                          fontWeight: FontWeight.w500)),
                  const SizedBox(width: 5),
                  Switch(
                    value: value1,
                    onChanged: (value) => setState(() {
                      value1 = value;
                      isVisible = !isVisible;
                    }),
                    activeTrackColor: Colors.lightGreenAccent,
                    activeColor: Colors.green,
                  ),
                  const SizedBox(width: 8),
                  Visibility(
                      visible: isVisible,
                      child: const Row(
                        children: [
                          Text(
                            "ID JOB APMTC",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Color.fromRGBO(0, 0, 85, 1),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Column(
                            children: [
                              SizedBox(
                                height: 30,
                                width: 170,
                                child: TextField(
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)))),
                                ),
                              ),
                              SizedBox(
                                height: 30,
                                child: Text("Juan Perez"),
                              ),
                            ],
                          )
                        ],
                      )),
                ],
              ),
              Row(
                children: [
                  const Text("Nº Trabajador",
                      style: TextStyle(
                          fontSize: 15,
                          color: Color.fromRGBO(0, 0, 85, 1),
                          fontWeight: FontWeight.w500)),
                  const SizedBox(width: 15),
                  DropdownButton(
                    items: _nTrabajador.map((String a) {
                      return DropdownMenuItem(
                        value: a,
                        child: Text(a),
                      );
                    }).toList(),
                    onChanged: (value) => {
                      setState(() {
                        _desplegable5 = value as String;
                      })
                    },
                    hint: Text(_desplegable5),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Text("Damage Found",
                          style: TextStyle(
                              fontSize: 15,
                              color: Color.fromRGBO(0, 0, 85, 1),
                              fontWeight: FontWeight.w500)),
                      const SizedBox(width: 47),
                      DropdownButton(
                        items: _damageFound.map((String a) {
                          return DropdownMenuItem(
                            value: a,
                            child: Text(a),
                          );
                        }).toList(),
                        onChanged: (value) => {
                          setState(() {
                            _desplegable1 = value as String;
                          })
                        },
                        hint: Text(_desplegable1),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Text("Damage Ocurred",
                          style: TextStyle(
                              fontSize: 15,
                              color: Color.fromRGBO(0, 0, 85, 1),
                              fontWeight: FontWeight.w500)),
                      const SizedBox(width: 33),
                      DropdownButton(
                        items: _damageOccurred.map((String a) {
                          return DropdownMenuItem(
                            value: a,
                            child: Text(a),
                          );
                        }).toList(),
                        onChanged: (value) => {
                          setState(() {
                            _desplegable2 = value as String;
                          })
                        },
                        hint: Text(_desplegable2),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Text("Damage Operation",
                          style: TextStyle(
                              fontSize: 15,
                              color: Color.fromRGBO(0, 0, 85, 1),
                              fontWeight: FontWeight.w500)),
                      const SizedBox(width: 18),
                      DropdownButton(
                        items: _operation.map((String a) {
                          return DropdownMenuItem(
                            value: a,
                            child: Text(a),
                          );
                        }).toList(),
                        onChanged: (value) => {
                          setState(() {
                            _desplegable3 = value as String;
                          })
                        },
                        hint: Text(_desplegable3),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      const Text("Cantidad de Daños",
                          style: TextStyle(
                              fontSize: 15,
                              color: Color.fromRGBO(0, 0, 85, 1),
                              fontWeight: FontWeight.w500)),
                      const SizedBox(width: 15),
                      DropdownButton(
                        items: _cantidadDanos.map((String a) {
                          return DropdownMenuItem(
                            value: a,
                            child: Text(a),
                          );
                        }).toList(),
                        onChanged: (value) => {
                          setState(() {
                            _desplegable4 = value as String;
                          })
                        },
                        hint: Text(_desplegable4),
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                children: [
                  const SizedBox(height: 15),
                  Container(
                    width: 400,
                    height: 20,
                    color: const Color.fromARGB(255, 163, 163, 163),
                    child: const Text(
                      "DAMAGE CAR INFORMATION",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Container(
                    width: 400,
                    height: 20,
                    color: const Color.fromRGBO(0, 0, 85, 1),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text("MAKER",
                            style:
                                TextStyle(fontSize: 15, color: Colors.white)),
                        SizedBox(width: 20),
                        Text("MODEL",
                            style:
                                TextStyle(fontSize: 15, color: Colors.white)),
                        SizedBox(width: 20),
                        Text("CHASSIS NUMBER",
                            style:
                                TextStyle(fontSize: 15, color: Colors.white)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    width: 400,
                    height: 20,
                    color: const Color.fromRGBO(0, 0, 85, 1),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text("CONSIGNEE",
                            style:
                                TextStyle(fontSize: 15, color: Colors.white)),
                        SizedBox(width: 35),
                        Text("BILL OF LADING",
                            style:
                                TextStyle(fontSize: 15, color: Colors.white)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                      width: 400,
                      height: 20,
                      color: const Color.fromRGBO(0, 0, 85, 1),
                      child: const Text(
                        "STOWAGE POSITION",
                        style: TextStyle(fontSize: 15, color: Colors.white),
                        textAlign: TextAlign.center,
                      )),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 30,
                    width: 300,
                    child: TextFormField(
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)))),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          Container(
            color: const Color.fromARGB(255, 163, 163, 163),
            child: const Text(
              "OUTLINES OF DAMAGE",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            color: const Color.fromRGBO(0, 0, 85, 1),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "NAME OF DRIVER CAUSING DAMAGE",
                  style: TextStyle(fontSize: 15, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 10,
                ),
                Switch(
                  value: value2,
                  onChanged: (value) => setState(() => value2 = value),
                  activeTrackColor: Colors.lightGreenAccent,
                  activeColor: Colors.green,
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 150),
            child: Row(
              children: [
                Flexible(
                  child: TextField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10)))),
                  ),
                ),
                SizedBox(width: 10),
                Icon(
                  Icons.camera_alt,
                  size: 30,
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Container(
                      height: 20,
                      width: 500,
                      color: const Color.fromRGBO(0, 0, 85, 1),
                      child: const Text(
                        "PLACE OF ACCIDENT/DAMAGE",
                        style: TextStyle(fontSize: 15, color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 75),
                      child: TextField(
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)))),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Container(
                      height: 20,
                      width: 500,
                      color: const Color.fromRGBO(0, 0, 85, 1),
                      child: const Text(
                        "DATE & TIME OF ACCIDENT/DAMAGE",
                        style: TextStyle(fontSize: 15, color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 75),
                      child: TextField(
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)))),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            color: const Color.fromRGBO(0, 0, 85, 1),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "DAMAGE TYPE",
                  style: TextStyle(fontSize: 15, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  width: 100,
                ),
                const Text(
                  "FALTANTES",
                  style: TextStyle(fontSize: 15, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  width: 10,
                ),
                Switch(
                  value: value3,
                  onChanged: (value) => setState(() => value3 = value),
                  activeTrackColor: Colors.lightGreenAccent,
                  activeColor: Colors.green,
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  const Text(
                    "DAMAGE",
                    style: TextStyle(
                        fontSize: 15,
                        color: Color.fromRGBO(0, 0, 85, 1),
                        fontWeight: FontWeight.w600),
                    textAlign: TextAlign.center,
                  ),
                  DropdownButton(items: null, onChanged: null),
                ],
              ),
              Column(
                children: [
                  const Text(
                    "PART OF VEHICLE",
                    style: TextStyle(
                        fontSize: 15,
                        color: Color.fromRGBO(0, 0, 85, 1),
                        fontWeight: FontWeight.w600),
                    textAlign: TextAlign.center,
                  ),
                  DropdownButton(items: null, onChanged: null),
                ],
              ),
              Column(
                children: [
                  const Text(
                    "SIDE",
                    style: TextStyle(
                        fontSize: 15,
                        color: Color.fromRGBO(0, 0, 85, 1),
                        fontWeight: FontWeight.w600),
                    textAlign: TextAlign.center,
                  ),
                  DropdownButton(items: null, onChanged: null),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 300, vertical: 5),
            child: ElevatedButton(
                style: TextButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(255, 127, 17, 1),
                  padding: const EdgeInsets.all(10.0),
                ),
                onPressed: (() {}),
                child: const Text(
                  "Agregar",
                  style: TextStyle(fontSize: 18),
                )),
          ),
          _buildTable(),
          const SizedBox(
            height: 10,
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Text(
                    "Daños por Registrar",
                    style: TextStyle(
                        fontSize: 15,
                        color: Color.fromRGBO(0, 0, 85, 1),
                        fontWeight: FontWeight.w500),
                  ),
                  Text("5"),
                ],
              ),
              Column(
                children: [
                  Text(
                    "Daños Registrados",
                    style: TextStyle(
                        fontSize: 15,
                        color: Color.fromRGBO(0, 0, 85, 1),
                        fontWeight: FontWeight.w500),
                  ),
                  Text("2"),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            color: const Color.fromARGB(255, 163, 163, 163),
            child: const Text(
              "COMMENTS",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 50),
            child: TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)))),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 300, vertical: 10),
            child: ElevatedButton(
                style: TextButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(0, 0, 85, 1),
                  padding: const EdgeInsets.all(10.0),
                ),
                onPressed: (() {
                  /*

              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => dr_listado()));

            */
                }),
                child: const Text(
                  "GUARDAR CAMBIOS",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                  textAlign: TextAlign.center,
                )),
          ),
        ],
      ),
    );
  }
}

Widget _buildTable() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 50),
    child: DataTable(
      columns: const <DataColumn>[
        DataColumn(
          label: Text(""),
          tooltip: "",
        ),
        DataColumn(
          label: Text(
            "COD",
            style: TextStyle(
              color: Color.fromRGBO(0, 0, 85, 1),
            ),
          ),
          tooltip: "Codigo de Daño",
        ),
        DataColumn(
          label: Text(
            "DAMAGE",
            style: TextStyle(
              color: Color.fromRGBO(0, 0, 85, 1),
            ),
          ),
          tooltip: "Daño",
        ),
        DataColumn(
          label: Text(
            "PART OF VEHICLE",
            style: TextStyle(
              color: Color.fromRGBO(0, 0, 85, 1),
            ),
          ),
          tooltip: "Parte del vehiculo",
        ),
        DataColumn(
          label: Text(
            "SIDE",
            style: TextStyle(
              color: Color.fromRGBO(0, 0, 85, 1),
            ),
          ),
          tooltip: "Sitio",
        ),
        DataColumn(
          label: Text(""),
          tooltip: "",
        ),
      ],
      rows: _damageList.map<DataRow>((DamageItem damageItem) {
        return DataRow(cells: <DataCell>[
          const DataCell(Icon(Icons.camera_alt)),
          DataCell(Text(damageItem.cod)),
          DataCell(Text(damageItem.damage)),
          DataCell(Text(damageItem.partOfVehicle)),
          DataCell(Text(damageItem.side)),
          const DataCell(Icon(Icons.delete)),
        ]);
      }).toList(),
    ),
  );
}
