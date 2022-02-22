import 'package:caib/models/lote.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class mainLotesWidget extends StatelessWidget {
  const mainLotesWidget({Key? key}) : super(key: key);

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
            return Text('Valor Lote: ${lotes.getBotonPulsado()}');
          },
        ),
        Text('Valor 1'),
      ],
    );
  }
}
