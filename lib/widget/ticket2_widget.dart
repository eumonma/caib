import 'package:caib/models/ticket.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ticket2Widget extends StatefulWidget {
  const ticket2Widget({Key? key}) : super(key: key);

  @override
  _ticket2WidgetState createState() => _ticket2WidgetState();
}

class _ticket2WidgetState extends State<ticket2Widget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: buildUsers(),
    );
  }

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

  Widget buildUser2(Ticket ticket) => Row(
    children: [
      CircleAvatar(child: Text(ticket.codTicket)),
      Text(ticket.descTicket),
      Text(ticket.horasEstimadas.toString()),
      Text(ticket.horasConsumidas.toString()),
      celda('Descripción', ticket.descTicket),
    ],
    );

  Widget celda(String etiqueta, String dato) => Container(
    width: 100,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          child: Text(etiqueta,
            style: TextStyle(
              fontSize: 10,
              color: Color.fromARGB(197, 144, 247, 153)),
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
      .collection('Lote1')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Ticket.fromJson(doc.data())).toList());
}
