import 'dart:io';

import 'package:consumar_app/src/carga_proyecto/recepcion_almacen/recepcion_almacen_ingreso.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import '../../../utils/constants.dart';

class RecepcionAlmacenPosicion extends StatefulWidget {
  const RecepcionAlmacenPosicion({super.key});

  @override
  State<RecepcionAlmacenPosicion> createState() =>
      _RecepcionAlmacenPosicionState();
}

class _RecepcionAlmacenPosicionState extends State<RecepcionAlmacenPosicion> {
  File? imagePosicionamientoMercaderia;

  List<ListBultoTransporte> listBultoTransporte = [];

  final TextEditingController ubicacionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("RECEPCION ALMACEN INGRESO"),
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(children: [
          Container(
            height: 40,
            color: kColorAzul,
            child: const Center(
              child: Text("BULTO SOBRE UND. TRANSPORTE",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white)),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                labelText: 'Ubicación',
                labelStyle: TextStyle(
                  color: kColorAzul,
                  fontSize: 20.0,
                ),
                hintText: 'Ingrese la Ubicación'),
            controller: ubicacionController,
            /* validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, ingrese el Qr';
                        }
                        return null;
                      }, */
          ),
          const SizedBox(height: 20),
          MaterialButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            minWidth: double.infinity,
            height: 50.0,
            color: kColorCeleste2,
            onPressed: () {
              setState(() {
                /*  listFotosLiquidaParalizaciones.add(
                              ListFotosLiquidaParalizaciones(
                                  fotoParalizacion: imageInicioParalizacion!,
                                  urlFoto: imageInicioParalizacion!.path)); */
              });
            },
            child: Text(
              "AGREGAR COORDENADAS",
              style: TextStyle(
                fontSize: 20,
                color: kColorBlanco,
                fontWeight: FontWeight.bold, /* letterSpacing: 1.5 */
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              border: Border.all(
                width: 1,
                color: Colors.grey,
              ),
            ),
            child: Column(
              children: [
                const SizedBox(height: 15),
                Text(
                  "Ingrese Fotos de Posicionamiento",
                  style: TextStyle(
                      fontSize: 15,
                      color: kColorAzul,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.grey),
                      ),
                      width: 150,
                      height: 150,
                      child: imagePosicionamientoMercaderia != null
                          ? Image.file(imagePosicionamientoMercaderia!,
                              width: 150, height: 150, fit: BoxFit.cover)
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Transform.scale(
                                  scale: 3,
                                  child: const Icon(
                                    Icons.camera_alt,
                                    color: Colors.grey,
                                  ),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                const Center(
                                    child: Text(
                                  "Inserte Posicionamiento Mercaderia",
                                  style: TextStyle(color: Colors.grey),
                                  textAlign: TextAlign.center,
                                )),
                              ],
                            ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.40,
                          child: ElevatedButton(
                              style: TextButton.styleFrom(
                                backgroundColor: kColorNaranja,
                                padding: const EdgeInsets.all(10.0),
                              ),
                              onPressed: (() => pickPosicionamientoMercaderia(
                                  ImageSource.gallery)),
                              child: const Text(
                                "Abrir Galería",
                                style: TextStyle(fontSize: 18),
                              )),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.40,
                          child: ElevatedButton(
                              style: TextButton.styleFrom(
                                backgroundColor: kColorNaranja,
                                padding: const EdgeInsets.all(10.0),
                              ),
                              onPressed: (() => pickPosicionamientoMercaderia(
                                  ImageSource.camera)),
                              child: const Text(
                                "Tomar Foto",
                                style: TextStyle(fontSize: 18),
                              )),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
          const SizedBox(height: 20.0),
          MaterialButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            minWidth: double.infinity,
            height: 50.0,
            color: kColorCeleste2,
            onPressed: () {
              setState(() {
                /*     listTransporteFotos.add(ListTransporteFotos(
                    fotoParalizacion: imageTransporte!,
                    urlFoto: imageTransporte!.path)); */
              });
            },
            child: Text(
              "AGREGAR FOTO",
              style: TextStyle(
                fontSize: 20,
                color: kColorBlanco,
                fontWeight: FontWeight.bold, /* letterSpacing: 1.5 */
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black), color: Colors.white),
              height: 400,
              child: ListView.builder(
                  itemCount: listBultoTransporte.length,
                  itemBuilder: (_, int i) {
                    return Column(children: [
                      const SizedBox(height: 10),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.grey),
                        ),
                        width: 200,
                        height: 200,
                        child:
                            listBultoTransporte[i].fotoBultoTransporte != null
                                ? Image.file(
                                    listBultoTransporte[i].fotoBultoTransporte!,
                                    /* width: 150, height: 150, */ fit:
                                        BoxFit.cover)
                                : Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Transform.scale(
                                        scale: 3,
                                        child: const Icon(
                                          Icons.camera_alt,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      const Center(
                                          child: Text(
                                        "No Image",
                                        style: TextStyle(color: Colors.grey),
                                        textAlign: TextAlign.center,
                                      )),
                                    ],
                                  ),
                      ),
                      const Divider(),
                    ]);
                  })),
          const SizedBox(height: 20),
          MaterialButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            minWidth: double.infinity,
            height: 50.0,
            color: kColorNaranja,
            onPressed: () async {},
            child: const Text(
              "REGISTRAR POSIC. MERCADERIA",
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5),
            ),
          ),
        ]),
      )),
    );
  }

  Future pickPosicionamientoMercaderia(ImageSource source) async {
    try {
      final imageInicioParalizacion =
          await ImagePicker().pickImage(source: source);

      if (imageInicioParalizacion == null) return;

      final imageTemporary = File(imageInicioParalizacion.path);

      setState(() => this.imagePosicionamientoMercaderia = imageTemporary);
    } on PlatformException catch (e) {
      e.message;
    }
  }
}
