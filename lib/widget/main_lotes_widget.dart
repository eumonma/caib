import 'package:caib/models/lote.dart';
import 'package:caib/widget/ticket2_widget.dart';
import 'package:caib/widget/ticket_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class mainLotesWidget extends StatelessWidget {
  //const mainLotesWidget({Key? key}) : super(key: key);

  int loteSeleccionado = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Text(
            'Pantalla',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
        ),
        Consumer<Lote>(
          builder: (context, lotes, child) {
            print('enterado');
            loteSeleccionado = lotes.getBotonPulsado();
            return Text('Valor Lote: ${lotes.getBotonPulsado()}');
          },
        ),
        Text('Valor 1'),
        SizedBox(
          height: 32,
        ),
        DefaultTabController(
          length: 4,
          initialIndex: 0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                child: TabBar(
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.grey,
                  tabs: [
                    Tab(
                      icon: Icon(Icons.list),
                      text: 'Tickets',
                    ),
                    Tab(
                      icon: Icon(Icons.task),
                      text: 'Producción',
                    ),
                    Tab(
                      icon: Icon(Icons.euro_symbol),
                      text: 'Facturación',
                    ),
                    Tab(
                      icon: Icon(Icons.timeline),
                      text: 'Previsión',
                    ),
                  ],
                ),
              ),
              Container(
                height: 600,
                child: TabBarView(
                  children: [
                    ticket2Widget(),
                    Icon(Icons.directions_transit),
                    Icon(Icons.directions_bike),
                    Icon(Icons.timeline),
                  ],
                ),
              )
            ],
          ),
        ),
        ElevatedButton(
          child: Text('Insertar'),
          onPressed: () {
            CreateTicket();

            final snackBar = SnackBar(
              backgroundColor: Colors.green,
              content: Text(
                'Added to Firebase!',
                style: TextStyle(fontSize: 24),
              ),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          },
        )
      ],
    );
  }

  Future CreateTicket() async {
    /// Reference to document
    ///
    print('CreateTicket');

    final docUser =
        FirebaseFirestore.instance.collection('Lote${loteSeleccionado}').doc();

    final json = {
      'id': docUser.id,
      'descTicket': 'Ejemplo de Ticket',
      'codTicket': 'DCC-50',
      'horasEstimadas': 21,
      'horasConsumidas': 15,
      'finalizadaSN': 'S',
      'empresaAsignada': 'AT4',
    };

    /// Create document and write data to Firebase
    await docUser.set(json);
  }
}
