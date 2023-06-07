import 'dart:io';

import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import '../../services/api_services.dart';

class UploadImageScreen extends StatefulWidget {
  const UploadImageScreen({Key? key}) : super(key: key);

  @override
  //_UploadImageScreenState createState() => _UploadImageScreenState();
State<UploadImageScreen> createState() => _UploadImageScreenState();
}

class _UploadImageScreenState extends State<UploadImageScreen> {
  File? image;
  final _picker = ImagePicker();
  bool showSpinner = false;
  TextEditingController qrController = TextEditingController();
  String textoQr = "Hola QR";

  Future getImage() async {
    final pickedFile =
        await _picker.pickImage(source: ImageSource.camera, imageQuality: 80);

    if (pickedFile != null) {
      image = File(pickedFile.path);
      setState(() {});
      // //print('Imagen seleccionable');
    } else {
      // //print('no image selected');
    }
  }

  Future<void> uploadImage() async {
    setState(() {
      showSpinner = true;
    });
    Map<String, String> headers = {
      'accept': 'application/json',
      'Content-Type': 'multipart/form-data'
    };
    var request = http.MultipartRequest('POST', urlPostArchives);

    request.headers.addAll(headers);
    request.fields['file'] = "file";
    request.files.add(await http.MultipartFile.fromPath('file', image!.path));

    // var streamedResponse = await request.send();
    // var response = await http.Response.fromStream(streamedResponse);
    //
    ////print('respuesta de imagen:${response.body}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload Image'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          BarcodeWidget(
            barcode: Barcode.qrCode(),
            data: textoQr,
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextField(
              controller: qrController,
              onChanged: (value) {
                textoQr = value;
                setState(() {});
              },
            ),
          ),
          GestureDetector(
            onTap: () {
              getImage();
            },
            child: Container(
              child: image == null
                  ? const Center(
                      child: Text('Pick Image'),
                    )
                  : Center(
                      child: Image.file(
                        File(image!.path).absolute,
                        height: 100,
                        width: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
            ),
          ),
          Text(image != null ? image!.path.toString() : "Nada papu"),
          const SizedBox(
            height: 50,
          ),
          GestureDetector(
            onTap: () {
              uploadImage();
            },
            child: Container(
              height: 50,
              width: 200,
              color: Colors.green,
              child: const Center(child: Text('Upload')),
            ),
          )
        ],
      ),
    );
  }
}
