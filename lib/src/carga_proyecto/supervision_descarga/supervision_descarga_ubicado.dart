import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import '../../../utils/constants.dart';

class SupervisionDescargaUbicado extends StatefulWidget {
  const SupervisionDescargaUbicado({super.key});

  @override
  State<SupervisionDescargaUbicado> createState() =>
      _SupervisionDescargaUbicadoState();
}

class ListUbicadoMercaderia {
  ListUbicadoMercaderia({this.id, this.fotoUbicadoMercaderia, this.urlFoto});

  int? id;
  File? fotoUbicadoMercaderia;
  String? urlFoto;
}

class _SupervisionDescargaUbicadoState
    extends State<SupervisionDescargaUbicado> {
  final TextEditingController posicionController = TextEditingController();

  File? imagePosicionMercaderia;

  List<ListUbicadoMercaderia> listUbicadoMercaderia = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("SUPERVISION DESCARGA"),
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(children: [
          Container(
            height: 40,
            color: kColorAzul,
            child: const Center(
              child: Text("POSICIÓN MERCADERIA",
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
                labelText: 'Posición Muelle',
                labelStyle: TextStyle(
                  color: kColorAzul,
                  fontSize: 20.0,
                ),
                hintText: 'Ingrese la Posicion Muelle'),
            controller: posicionController,
            /* validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, ingrese el Qr';
                        }
                        return null;
                      }, */
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
          const SizedBox(height: 10),
          const SizedBox(height: 20),
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
                  "Ingrese Fotos Posición",
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
                      child: imagePosicionMercaderia != null
                          ? Image.file(imagePosicionMercaderia!,
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
                                  "Inserte Bulto Transporte",
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
                              onPressed: (() =>
                                  pickUbicadoMercaderia(ImageSource.gallery)),
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
                              onPressed: (() =>
                                  pickUbicadoMercaderia(ImageSource.camera)),
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
                  itemCount: listUbicadoMercaderia.length,
                  itemBuilder: (_, int i) {
                    return Column(children: [
                      const SizedBox(height: 10),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.grey),
                        ),
                        width: 200,
                        height: 200,
                        child: listUbicadoMercaderia[i].fotoUbicadoMercaderia !=
                                null
                            ? Image.file(
                                listUbicadoMercaderia[i].fotoUbicadoMercaderia!,
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
            onPressed: () async {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("Datos Registrados con exito"),
                backgroundColor: Colors.green,
              ));
            },
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

  Future pickUbicadoMercaderia(ImageSource source) async {
    try {
      final imageInicioParalizacion =
          await ImagePicker().pickImage(source: source);

      if (imageInicioParalizacion == null) return;

      final imageTemporary = File(imageInicioParalizacion.path);

      setState(() => this.imagePosicionMercaderia = imageTemporary);
    } on PlatformException catch (e) {
      e.message;
    }
  }
}
