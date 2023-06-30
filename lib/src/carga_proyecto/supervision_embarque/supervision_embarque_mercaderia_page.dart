import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import '../../../utils/constants.dart';

class SupervisionEmbarqueMercaderia extends StatefulWidget {
  const SupervisionEmbarqueMercaderia({super.key});

  @override
  State<SupervisionEmbarqueMercaderia> createState() =>
      _SupervisionEmbarqueMercaderiaState();
}

class ListEmbarqueMercaderia {
  ListEmbarqueMercaderia({this.id, this.fotoEmbarqueMercaderia, this.urlFoto});

  int? id;
  File? fotoEmbarqueMercaderia;
  String? urlFoto;
}

class _SupervisionEmbarqueMercaderiaState
    extends State<SupervisionEmbarqueMercaderia> {
  File? imageEmbarqueMercaderia;

  List<ListEmbarqueMercaderia> listEmbarqueMercaderia = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("SUPERVISION EMBARQUE"),
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(children: [
          Container(
            height: 40,
            color: kColorAzul,
            child: const Center(
              child: Text("EMBARQUE DE MERCADERIA",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white)),
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
                  "Ingrese Fotos de Embarque",
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
                      child: imageEmbarqueMercaderia != null
                          ? Image.file(imageEmbarqueMercaderia!,
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
                                  "Inserte Embarque",
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
                                  pickEmbarqueMercaderia(ImageSource.gallery)),
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
                                  pickEmbarqueMercaderia(ImageSource.camera)),
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
                  itemCount: listEmbarqueMercaderia.length,
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
                            listEmbarqueMercaderia[i].fotoEmbarqueMercaderia !=
                                    null
                                ? Image.file(
                                    listEmbarqueMercaderia[i]
                                        .fotoEmbarqueMercaderia!,
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
              "REGISTRAR EMBARQUE",
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

  Future pickEmbarqueMercaderia(ImageSource source) async {
    try {
      final imageInicioParalizacion =
          await ImagePicker().pickImage(source: source);

      if (imageInicioParalizacion == null) return;

      final imageTemporary = File(imageInicioParalizacion.path);

      setState(() => this.imageEmbarqueMercaderia = imageTemporary);
    } on PlatformException catch (e) {
      e.message;
    }
  }
}
