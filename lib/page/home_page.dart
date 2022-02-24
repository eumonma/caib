import 'package:caib/models/lote.dart';
import 'package:caib/widget/loged_widget.dart';
import 'package:caib/widget/main_lotes_widget.dart';
import 'package:caib/widget/menu_lotes_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;

    return Scaffold(
        appBar: AppBar(
          leading: Builder(builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              tooltip: 'Menú',
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          }),
          title: Consumer<Lote>(
            builder: (context, lotes, child) {
              print('enterado');
              return Text('Lote: ${lotes.getBotonPulsado()}');
            },
          ),
          //Text('Home'),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.logout),
              tooltip: 'Logout',
              onPressed: () => FirebaseAuth.instance.signOut(),
            )
          ],
        ),
        body: Row(
          children: [
            Container(
              color: Colors.grey[900],
              width: 240,
              child: menuLotesWidget(),
            ),
            Expanded(
              child: mainLotesWidget(
                  //color: Colors.black54
                  ),
            ),
          ],
        )

//        child: logedWidget())
        );
  }
}
