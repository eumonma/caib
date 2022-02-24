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
            children: tickets.map(buildUser).toList(),
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

  Stream<List<Ticket>> readTickets() => FirebaseFirestore.instance
      .collection('Lote1')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Ticket.fromJson(doc.data())).toList());
}
