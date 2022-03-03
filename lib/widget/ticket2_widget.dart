import 'package:caib/models/lote.dart';
import 'package:caib/models/ticket.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ticket2Widget extends StatefulWidget {
  const ticket2Widget({Key? key}) : super(key: key);

  @override
  _ticket2WidgetState createState() => _ticket2WidgetState();
}

class _ticket2WidgetState extends State<ticket2Widget> {

  final controllerCodTicket = TextEditingController();
  int loteSeleccionado = 0;

/*  @override
  Widget build(BuildContext context) {
    return Container(
      child: buildUsers(),
    );
  }
*/
  @override
  Widget build(BuildContext context) => Consumer<Lote>(
      builder: (context, lotes, child) {
          loteSeleccionado = lotes.getBotonPulsado();
          return Container(
            child: buildUsers(),
          );
      }
    );

  Widget buildUsers() => StreamBuilder<List<Ticket>>(
      stream: readTickets(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong! ${snapshot.error}');
        } else if (snapshot.hasData) {
          final tickets = snapshot.data!;

          return ListView(
            children: tickets.map(buildUser2).toList(),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      });

  Widget buildUser(Ticket ticket) => ListTile(
        leading: CircleAvatar(child: Text(ticket.codTicket)),
        title: Text(ticket.descTicket),
        subtitle: Text(ticket.descTicket),
      );

  Widget buildUser2(Ticket ticket) => Container(
    color: Colors.grey.shade800,
    margin: const EdgeInsets.all(4.0),
    //padding: const EdgeInsets.all(8.0),
    child: Row(
      children: [
        IconButton(
          icon: const Icon(Icons.edit,),
          onPressed: (){
            openDialog(ticket);
          },
        ),
        CircleAvatar(child: Text(ticket.codTicket)),
        Text(ticket.descTicket),
        Text(ticket.horasEstimadas.toString()),
        Text(ticket.horasConsumidas.toString()),
        celda('Descripción', ticket.descTicket),
      ],
      ),
  );

  Future openDialog(Ticket ticket) => showDialog(
    context: context,
    builder: (context) { 
      controllerCodTicket.text = ticket.codTicket;
      return AlertDialog(
      title: Text('Modificar Ticket ${ticket.id}'),
      content: TextField(
//        initialValue: ticket.codTicket,
        controller: controllerCodTicket,
        autofocus: true,
        decoration: InputDecoration(
          labelText: 'Cualquier cosa',
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

  Widget celda(String etiqueta, String dato) => Container(
    width: 100,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          child: Text(etiqueta,
            style: TextStyle(
              fontSize: 12,
              color: Color.fromARGB(255, 0, 150, 136)),
          ),
          alignment: Alignment.topLeft,
        ),
        Text(dato,
          textAlign: TextAlign.start,
          //style: TextStyle(color: Color.fromARGB(199, 245, 83, 83)),
        ),
      ],
    ),
  );

  Stream<List<Ticket>> readTickets() => FirebaseFirestore.instance
//      .collection('Lote1')
//      .collection('Lote${loteSeleccionado}')
      .collection('Tickets')
      .where('lote', isEqualTo: loteSeleccionado)
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Ticket.fromJson(doc.data())).toList());
}
