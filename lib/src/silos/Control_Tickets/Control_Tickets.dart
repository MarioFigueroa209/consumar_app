import 'package:flutter/material.dart';
import '../../../utils/constants.dart';

class ControlTickets extends StatefulWidget {
  const ControlTickets({Key? key}) : super(key: key);

  @override
  State<ControlTickets> createState() => _ControlTicketsState();
}

class _ControlTicketsState extends State<ControlTickets> {
  final idUsuarioController = TextEditingController();

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
                  
                  suffixIcon: IconButton(
                      icon: const Icon(Icons.camera_alt_outlined),
                      onPressed: () {
                      }),
                  labelText: 'TicketAPM',
                  labelStyle: TextStyle(
                    color: kColorAzul,
                    fontSize: 20.0,
                  ),
                  hintText: 'Ingrese el TicketAPM'),
              onChanged: (value) {
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, ingrese el TicketAPM';
                }
                return null;
              },
            ),

            const SizedBox(height: 20),

            TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                    
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                  }
                ),
                labelText: 'Codigo Vehiculo',
                labelStyle: TextStyle(
                  color: kColorAzul,
                  fontSize: 20.0,
                ),
                hintText: 'Ingrese el numero de Codigo del Vehiculo'
              ),
              onChanged: (value) {
              },
              controller: idUsuarioController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, ingrese el Codigo del Vehiculo';
                }
                return null;
              },
            ),

            const SizedBox(height: 20),

            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      
                      labelText: 'Transporte',
                      labelStyle: TextStyle(
                        color: kColorAzul,
                        fontSize: 20.0,
                      ),
                      hintText: '',
                    ),
                    enabled: false,
                  ),
                ),
                const SizedBox(width: 10,),
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      
                      labelText: 'Placa',
                      labelStyle: TextStyle(
                        color: kColorAzul,
                        fontSize: 20.0,
                      ),
                    ),
                    enabled: false,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                
                labelText: 'Nave',
                labelStyle: TextStyle(
                  color: kColorAzul,
                  fontSize: 20.0,
                ),
                hintText: '',
              ),
              enabled: false,
            ),

            const SizedBox(height: 20),

            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      
                      labelText: 'BL',
                      labelStyle: TextStyle(
                        color: kColorAzul,
                        fontSize: 20.0,
                      ),
                      hintText: '',
                    ),
                    enabled: false,
                  ),
                ),
                const SizedBox(width: 10,),
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      
                      labelText: 'SUB BL',
                      labelStyle: TextStyle(
                        color: kColorAzul,
                        fontSize: 20.0,
                      ),
                    ),
                    enabled: false,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                
                labelText: 'DO',
                labelStyle: TextStyle(
                  color: kColorAzul,
                  fontSize: 20.0,
                ),
                hintText: '',
              ),
              enabled: false,
            ),

            const SizedBox(height: 20),

            TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                
                labelText: 'DAM',
                labelStyle: TextStyle(
                  color: kColorAzul,
                  fontSize: 20.0,
                ),
                hintText: '',
              ),
              enabled: false,
            ),

            const SizedBox(height: 20),

            TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                
                labelText: 'Importador',
                labelStyle: TextStyle(
                  color: kColorAzul,
                  fontSize: 20.0,
                ),
                hintText: '',
              ),
              enabled: false,
            ),

            const SizedBox(height: 20),

            TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                
                labelText: 'Producto',
                labelStyle: TextStyle(
                  color: kColorAzul,
                  fontSize: 20.0,
                ),
                hintText: '',
              ),
              enabled: false,
            ),

            const SizedBox(height: 20),

            TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                
                labelText: 'Transportista',
                labelStyle: TextStyle(
                  color: kColorAzul,
                  fontSize: 20.0,
                ),
                hintText: '',
              ),
              enabled: false,
            ),

            const SizedBox(height: 20),

            TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                
                labelText: 'Manifiesto',
                labelStyle: TextStyle(
                  color: kColorAzul,
                  fontSize: 20.0,
                ),
                hintText: '',
              ),
              enabled: false,
            ),

            const SizedBox(height: 20),

            TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
          
                labelText: 'Ubicación de la carga',
                labelStyle: TextStyle(
                  color: kColorAzul,
                  fontSize: 20.0,
                ),
                hintText: '',
              ),
              enabled: false,
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
                "REGISTRAR TICKET",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5
                ),
              ),
            ),





          ],)
        ),

      )
    );
  }


}
