import 'package:caib/models/lote.dart';
import 'package:flutter/material.dart';

import 'package:caib/widget/main_lotes_widget.dart';
import 'package:provider/src/provider.dart';

class menuLotesWidget extends StatelessWidget {
  menuLotesWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 50,
        ),
        ElevatedButton(
          child: Text('Lote 1. Colegios Concertados'),
          style: ElevatedButton.styleFrom(
            textStyle: TextStyle(fontSize: 18),
          ),
          onPressed: () {
            print('Botón pulsado 1');
            var lote = context.read<Lote>();
            lote.addBotonPulsado(1);
          },
        ),
        SizedBox(
          height: 50,
        ),
        ElevatedButton(
          child: Text('Lote 2. Colegios Públicos'),
          style: ElevatedButton.styleFrom(
            textStyle: TextStyle(fontSize: 18),
          ),
          onPressed: () {
            print('Botón pulsado 2');
            var lote = context.read<Lote>();
            lote.addBotonPulsado(2);
          },
        )
      ],
    );
  }
}
