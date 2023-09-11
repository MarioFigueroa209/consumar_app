import 'package:barcode_widget/barcode_widget.dart';
import 'package:bluetooth_print/bluetooth_print.dart';
import 'package:bluetooth_print/bluetooth_print_model.dart';
import 'package:consumar_app/models/roro/damage_report/vw_ticket_dr_listado.dart';
import 'package:consumar_app/services/roro/damage_report/damage_report_consulta_service.dart';
import 'package:flutter/material.dart';

class PrintTicketDrPage extends StatefulWidget {
  const PrintTicketDrPage({super.key});

  @override
  State<PrintTicketDrPage> createState() => _PrintTicketDrPageState();
}

class _PrintTicketDrPageState extends State<PrintTicketDrPage> {
  BluetoothPrint bluetoothPrint = BluetoothPrint.instance;

  bool _connected = false;
  BluetoothDevice? _device;
  String tips = 'Ningun dispositivo conectado';

  DamageReportConsultaService damageReportConsultaService =
      DamageReportConsultaService();

  String nave = "";
  String puerto = "";

  List<VwTicketDrListado> vwTicketDrListado = [];

  getVVwTicketDrListado(BigInt idDamageReport) async {
    vwTicketDrListado =
        await damageReportConsultaService.getVwTicketDrListado(idDamageReport);

    nave = vwTicketDrListado[0].nombreNave!;

    if (vwTicketDrListado[0].puerto != null) {
      puerto = vwTicketDrListado[0].puerto!.toUpperCase();
    } else {
      puerto = "";
    }
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) => initBluetooth());
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initBluetooth() async {
    bluetoothPrint.startScan(timeout: Duration(seconds: 4));

    bool isConnected = await bluetoothPrint.isConnected ?? false;

    bluetoothPrint.state.listen((state) {
      print('******************* estado actual del dispositivo: $state');

      switch (state) {
        case BluetoothPrint.CONNECTED:
          setState(() {
            _connected = true;
            tips = 'conectado con éxito';
          });
          break;
        case BluetoothPrint.DISCONNECTED:
          setState(() {
            _connected = false;
            tips = 'desconectado';
          });
          break;
        default:
          break;
      }
    });

    if (!mounted) return;

    if (isConnected) {
      setState(() {
        _connected = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Printer App Print QR'),
      ),
      body: RefreshIndicator(
        onRefresh: () =>
            bluetoothPrint.startScan(timeout: Duration(seconds: 4)),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    child: Text(tips),
                  ),
                ],
              ),
              Divider(),
              StreamBuilder<List<BluetoothDevice>>(
                stream: bluetoothPrint.scanResults,
                initialData: [],
                builder: (c, snapshot) => Column(
                  children: snapshot.data!
                      .map((d) => ListTile(
                            title: Text(d.name ?? ''),
                            subtitle: Text(d.address ?? ''),
                            onTap: () async {
                              setState(() {
                                _device = d;
                              });
                            },
                            trailing:
                                _device != null && _device!.address == d.address
                                    ? Icon(
                                        Icons.check,
                                        color: Colors.green,
                                      )
                                    : null,
                          ))
                      .toList(),
                ),
              ),
              Divider(),
              Container(
                padding: EdgeInsets.fromLTRB(20, 5, 20, 10),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        OutlinedButton(
                          child: Text('Conectar'),
                          onPressed: _connected
                              ? null
                              : () async {
                                  if (_device != null &&
                                      _device!.address != null) {
                                    setState(() {
                                      tips = 'Conectando...';
                                    });
                                    await bluetoothPrint.connect(_device!);
                                  } else {
                                    setState(() {
                                      tips =
                                          'Por favor seleccione un dispositivo';
                                    });
                                    print(
                                        'Por favor seleccione un dispositivo');
                                  }
                                },
                        ),
                        SizedBox(width: 10.0),
                        OutlinedButton(
                          child: Text('Desconectar'),
                          onPressed: _connected
                              ? () async {
                                  setState(() {
                                    tips = 'Desconectando...';
                                  });
                                  await bluetoothPrint.disconnect();
                                }
                              : null,
                        ),
                      ],
                    ),
                    Divider(),
                    OutlinedButton(
                      child: Text('Imprimir Dr Ticket'),
                      onPressed: _connected
                          ? () async {
                              Map<String, dynamic> config = Map();
                              config['width'] = 50; // 标签宽度，单位mm
                              config['height'] = 26; // 标签高度，单位mm
                              config['gap'] = 2; // 标签间隔，单位mm

                              List<LineText> list = [];

                              list.add(LineText(
                                type: LineText.TYPE_TEXT,
                                x: 1,
                                y: 1,
                                content: 'DAMAGE REPORT LIST',
                                align: LineText.ALIGN_CENTER,
                              ));

                              list.add(LineText(
                                type: LineText.TYPE_TEXT,
                                x: 1,
                                y: 1,
                                content: "DATE & TIME: ${DateTime.now()}",
                                align: LineText.ALIGN_CENTER,
                              ));
                              list.add(LineText(
                                type: LineText.TYPE_TEXT,
                                x: 1,
                                y: 1,
                                content: "VESSEL: $nave",
                                align: LineText.ALIGN_CENTER,
                              ));

                              list.add(LineText(
                                type: LineText.TYPE_TEXT,
                                x: 1,
                                y: 1,
                                content: "DESCRIPTION",
                                align: LineText.ALIGN_CENTER,
                              ));

                              list.add(LineText(
                                type: LineText.TYPE_TEXT,
                                x: 1,
                                y: 1,
                                content: "PORT: $puerto",
                                align: LineText.ALIGN_CENTER,
                              ));

                              list.add(LineText(
                                type: LineText.TYPE_TEXT,
                                x: 1,
                                y: 1,
                                content: "INVENTORY",
                                align: LineText.ALIGN_CENTER,
                              ));

                              Table(children: [
                                for (var i = 0;
                                    i < vwTicketDrListado.length;
                                    i++)
                                  TableRow(children: [
                                    Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(height: 2),
                                          Text(
                                              '${vwTicketDrListado[i].idVista!}) Nº DR: ${vwTicketDrListado[i].codDr!}',
                                              style:
                                                  const TextStyle(fontSize: 6)),
                                          Text(
                                              'Chassis: ${vwTicketDrListado[i].chasis!}',
                                              style:
                                                  const TextStyle(fontSize: 6)),
                                          SizedBox(height: 2),
                                          Divider(
                                              color: Colors.grey, height: 0.5),
                                          SizedBox(height: 2),
                                        ]),
                                    Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(height: 2),
                                          Text(
                                              'Amount of damage: ${vwTicketDrListado[i].cantidadDanos}',
                                              style:
                                                  const TextStyle(fontSize: 6)),
                                          Text(
                                              'BL: ${vwTicketDrListado[i].bl!}',
                                              style:
                                                  const TextStyle(fontSize: 6)),
                                          SizedBox(height: 2),
                                          Divider(
                                              color: Colors.grey, height: 0.5),
                                          SizedBox(height: 2),
                                          //Divider(color: const PdfColor.fromInt(0xff9e9e9e))
                                        ]),
                                  ])
                              ]);

                              BarcodeWidget(
                                barcode: Barcode.qrCode(),
                                data: 'consumarport.com.pe/login',
                                height: 60.0,
                                width: 60.0,
                              );

                              list.add(LineText(
                                  type: LineText.TYPE_QRCODE,
                                  x: 10,
                                  y: 190,
                                  align: LineText.ALIGN_CENTER,
                                  content:
                                      "Representation of the electronic document, "
                                      "please visit and consult this document on the web: consumarport.com.pe/login"));

                              /*  setState(() {
                                list.add(LineText(
                                    type: LineText.TYPE_QRCODE,
                                    x: 10,
                                    y: 190,
                                    align: LineText.ALIGN_CENTER,
                                    content: 1.toString()));
                              }); */

                              await bluetoothPrint.printLabel(config, list);
                            }
                          : null,
                    ),
                    /* OutlinedButton(
                        child: Text('print selftest'),
                        onPressed: _connected
                            ? () async {
                                await bluetoothPrint.printTest();
                              }
                            : null,
                      ) */
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: StreamBuilder<bool>(
        stream: bluetoothPrint.isScanning,
        initialData: false,
        builder: (c, snapshot) {
          if (snapshot.data == true) {
            return FloatingActionButton(
              child: Icon(Icons.stop),
              onPressed: () => bluetoothPrint.stopScan(),
              backgroundColor: Colors.red,
            );
          } else {
            return FloatingActionButton(
                child: Icon(Icons.search),
                onPressed: () =>
                    bluetoothPrint.startScan(timeout: Duration(seconds: 4)));
          }
        },
      ),
    );
  }
}
