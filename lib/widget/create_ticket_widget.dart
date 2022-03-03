import 'package:caib/models/lote.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class createTicketWidget extends StatefulWidget {
  const createTicketWidget({ Key? key }) : super(key: key);

  @override
  _createTicketWidgetState createState() => _createTicketWidgetState();
}

class _createTicketWidgetState extends State<createTicketWidget> {
  
  final controllerCodTicket = TextEditingController();
  final controllerDescTicket = TextEditingController();
  final controllerHorasEstimadas = TextEditingController();
  final controllerHorasConsumidas = TextEditingController();
  final controllerFinalizadaSN = TextEditingController();
  final controllerEmpresaAsignada = TextEditingController();
  final controllerLote = TextEditingController();
  int loteSeleccionado = 0;
  
  @override
  Widget build(BuildContext context) => Consumer<Lote>(
      builder: (context, lotes, child) {
          loteSeleccionado = lotes.getBotonPulsado();
          return Container(
            child: CreateTicketEB(),
          );
      }
    );
  
  Widget CreateTicketEB() => ElevatedButton(
          child: Text('Insertar...'),
          onPressed: () {
            openDialogCreateTicket();

/*            final snackBar = SnackBar(
              backgroundColor: Colors.green,
              content: Text(
                'Added to Firebase!',
                style: TextStyle(fontSize: 24),
              ),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
*/            
          },
        );


Future openDialogCreateTicket() => showDialog(
    context: context,
    builder: (context) { 
      //controllerCodTicket.text = ticket.codTicket;
      return AlertDialog(
      title: Text('Insertar Ticket en Lote ${loteSeleccionado}'),
      content: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: controllerCodTicket,
              autofocus: true,
              decoration: InputDecoration(
                labelText: 'Cód. Ticket',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 6,),
            TextField(
              controller: controllerDescTicket,
              autofocus: true,
              decoration: InputDecoration(
                labelText: 'Descripción Ticket',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 6,),
            TextField(
              controller: controllerHorasEstimadas,
              autofocus: true,
              decoration: InputDecoration(
                labelText: 'Horas Estimadas',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 6,),
            TextField(
              controller: controllerHorasConsumidas,
              autofocus: true,
              decoration: InputDecoration(
                labelText: 'Horas Consumidas',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 6,),
            TextField(
              controller: controllerFinalizadaSN,
              autofocus: true,
              decoration: InputDecoration(
                labelText: 'Ticket Finalizado',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 6,),
            TextField(
              controller: controllerEmpresaAsignada,
              autofocus: true,
              decoration: InputDecoration(
                labelText: 'Empresa Asignada',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          child: Text('Cancelar'),
          onPressed: (){
            print('Valor cambiado: ${controllerCodTicket.text}');
            cancelar();
          },
        )
      ],
    );
    }
  );

  void cancelar(){
    Navigator.of(context).pop();
  }

  Future CreateTicket() async {
    /// Reference to document
    ///
    print('CreateTicket');

    final docTicket =
//        FirebaseFirestore.instance.collection('Lote${loteSeleccionado}').doc();
//        FirebaseFirestore.instance.collection('Tickets').doc('Lote${loteSeleccionado}').collection('Tickets').doc('DCC-11');
        FirebaseFirestore.instance.collection('Tickets').doc();

    final json = {
      'id': docTicket.id,
      'lote': loteSeleccionado,
      'descTicket': controllerDescTicket.text,
      'codTicket': controllerCodTicket.text,
      'horasEstimadas': controllerHorasEstimadas.text,
      'horasConsumidas': controllerHorasConsumidas.text,
      'finalizadaSN': controllerFinalizadaSN.text,
      'empresaAsignada': controllerCodTicket.text,
    };

    /// Create document and write data to Firebase
    await docTicket.set(json);
  }
}