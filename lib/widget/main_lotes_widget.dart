import 'package:flutter/material.dart';

class mainLotesWidget extends StatefulWidget {
  const mainLotesWidget({ Key? key }) : super(key: key);

  @override
  _mainLotesWidgetState createState() => _mainLotesWidgetState();
}

class _mainLotesWidgetState extends State<mainLotesWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Pantalla Princiapl',
        style: TextStyle(fontSize: 20,),
        )
    );
  }
}