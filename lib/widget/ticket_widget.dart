import 'package:caib/models/lote.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ticketWidget extends StatelessWidget {
  //const ticketWidget({Key? key}) : super(key: key);

  int loteSeleccionado = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          ElevatedButton(
            child: Consumer<Lote>(builder: (context, lotes, child) {
              print('enterado');
              loteSeleccionado = lotes.getBotonPulsado();
              return Text('Valor Lote: ${lotes.getBotonPulsado()}');
            }),
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
          ),
        ],
      ),
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
      'Lote': loteSeleccionado,
      'age': 21,
      'birthday': DateTime(2001, 7, 28),
    };

    /// Create document and write data to Firebase
    await docUser.set(json);
  }
}
