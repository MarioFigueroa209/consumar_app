import 'package:flutter/material.dart';

import '../../models/ship_model.dart';
import '../../services/ship_services.dart';

class Silos extends StatefulWidget {
  const Silos({Key? key}) : super(key: key);

  @override
  State<Silos> createState() => _SilosState();
}

class _SilosState extends State<Silos> {
  ShipServices shipServices = ShipServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("SILOS"),
      ),
      body: Center(
          child: FutureBuilder<List<ShipModel>>(
        future: shipServices.getShips(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ShipList(ships: snapshot.data!);
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          } // Por defecto, muestra un loading spinner
          return const CircularProgressIndicator();
        },
      )),
    );
  }
}

class ShipList extends StatelessWidget {
  final List<ShipModel> ships;

  const ShipList({Key? key, required this.ships}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: ships.length,
        prototypeItem: const ListTile(title: Text("Lista de Naves")),
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(ships[index].nombreNave!),
          );
        });
  }
}
