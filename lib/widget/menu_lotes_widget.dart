import 'package:flutter/material.dart';

class menuLotesWidget extends StatelessWidget {
  const menuLotesWidget({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 50,),
        ElevatedButton(
           child: Text('Lote 1. Colegios Concertados'),
           style: ElevatedButton.styleFrom(
             textStyle: TextStyle(fontSize: 18),
           ),
           onPressed: () {},
          )
      ],
    );
  }
}