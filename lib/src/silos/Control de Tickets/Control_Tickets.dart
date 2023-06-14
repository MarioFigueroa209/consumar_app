import 'package:flutter/material.dart';

import '../../../utils/constants.dart';

class ControlTickets extends StatefulWidget {
  const ControlTickets({Key? key}) : super(key: key);

  @override
  State<ControlTickets> createState() => _ControlTicketsState();
}

class _ControlTicketsState extends State<ControlTickets> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CONTROL DE TICKETS'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(children: [
            TextFormField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  prefixIcon: IconButton(
                      icon: const Icon(Icons.closed_caption_off_rounded),
                      onPressed: () async {
                      }),
                  suffixIcon: IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: () {
                      }),
                  labelText: 'Codigo',
                  labelStyle: TextStyle(
                    color: kColorAzul,
                    fontSize: 20.0,
                  ),
                  hintText: 'Ingrese el Codigo'),
              onChanged: (value) {
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, ingrese el Codigo';
                }
                return null;
              },
            ),
          ],)
        ),

      )
    );
  }


}
