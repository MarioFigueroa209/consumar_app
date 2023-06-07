import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../qr_overlay.dart';

class ScannerScreen extends StatefulWidget {
  const ScannerScreen({Key? key}) : super(key: key);

  @override
  State<ScannerScreen> createState() => _ScannerScreenState();
  //_ScannerScreenState createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  MobileScannerController cameraController = MobileScannerController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Escanear QR"),
        actions: [
          IconButton(
            onPressed: () {
              cameraController.switchCamera();
            },
            icon: const Icon(Icons.cameraswitch_rounded),
          ),
          IconButton(
            color: Colors.white,
            icon: ValueListenableBuilder(
              valueListenable: cameraController.torchState,
              builder: (context, state, child) {
                switch (state) {
                  case TorchState.off:
                    return const Icon(
                      Icons.flash_off,
                      color: Colors.white,
                    );
                  case TorchState.on:
                    return const Icon(
                      Icons.flash_on,
                      color: Colors.yellow,
                    );
                }
              },
            ),
            iconSize: 32.0,
            onPressed: () => cameraController.toggleTorch(),
          ),
        ],
      ),
      body: Stack(
        children: [
          MobileScanner(
            allowDuplicates: false,
            controller: cameraController,
            onDetect: (barcode, args) {
              Navigator.pop(context, barcode.rawValue!);
              //debug//print('Barcode found! ${barcode.rawValue!}');
            },
          ),
          QRScannerOverlay(overlayColour: Colors.black.withOpacity(0.5)),
        ],
      ),
    );
  }
}
