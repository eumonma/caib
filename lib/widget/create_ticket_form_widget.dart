import 'dart:developer';

import 'package:caib/models/lote.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class createTicketFormWidget extends StatefulWidget {
  const createTicketFormWidget({ Key? key }) : super(key: key);

  @override
  _createTicketFormWidgetState createState() => _createTicketFormWidgetState();
}

class _createTicketFormWidgetState extends State<createTicketFormWidget> {

  final formKey = GlobalKey<FormState>();
  late int loteSeleccionado = 0;
  late String codTicketPrefix;

  late String codTicket;
  late String descTicket;
  late int horasEstimadas;
  late int horasConsumidas;
  late String finalizadaSN = 'N';

  bool isChecked = false;

  @override
  Widget build(BuildContext context) => Consumer<Lote>(
    builder: (context, lotes, child) {
      loteSeleccionado = lotes.getBotonPulsado();
      if (loteSeleccionado == 1) {
        codTicketPrefix = 'DCC-';
      } else {
        codTicketPrefix = 'DCP-';
      }
      return Container(
        child: CreateTicketEB(),
      );
    }
  );

  Widget CreateTicketEB() => ElevatedButton(
          child: Text('Insertar Nuevo...'),
          onPressed: () {
            openDialogCreateTicket();
          },
        );


Future openDialogCreateTicket() => showDialog(
    context: context,
    builder: (context) { 
      //controllerCodTicket.text = ticket.codTicket;
      return AlertDialog(
        title: Text('Insertar Ticket en Lote ${loteSeleccionado}'),
        content: Container(
          height: 500,
          width: 300,
          child: Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            key: formKey,
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                checkBox2(
                  tareaRealizada: finalizadaSN,
                  onChanged: (valor){
                    finalizadaSN = valor;
                    print("CheckBox: ${finalizadaSN}");
                  },
                  ),
//                checkBoxPrueba(
//                  ticketFinalizado: finalizadaSN,
//                  ),
                formFieldCodTicket(),
                const SizedBox(height: 32),
                TextFormField(
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.description),
                    labelText: 'Descripción',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value == ''){
                      return 'Ha de tener contenido';
                    } else {
                      return null;
                    }
                  },
                  onChanged: (value) => setState(() {
                    descTicket = value;
                  }
                  ),
                ),
                const SizedBox(height: 32),
                TextFormField(
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.av_timer),
                    labelText: 'Horas Estimadas',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value == ''){
                      return 'Ha de tener contenido';
                    } else {
                      return null;
                    }
                  },
                  onChanged: (value) => setState(() {
                    horasEstimadas = int.parse(value);
                  }
                  ),
                ),
                const SizedBox(height: 32),
                TextFormField(
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.timelapse),
                    labelText: 'Horas Consumidas',
                    border: OutlineInputBorder(),
                    prefix: Text('h.'),
                  ),
                  validator: (value) {
                    if (value == null || value == ''){
                      return 'Ha de tener contenido';
                    } else if (value == null){
                      return 'Ha de tener contenido';
                    } else {
                      return null;
                    }
                  },
                  onChanged: (value) => setState(() {
                    horasConsumidas = int.parse(value);
                  }
                  ),
                ),
                const SizedBox(height: 32,),
              ],
            )
          ),
        ),
        actions: [
          TextButton(
            child: Text('Cancelar'),
            onPressed: (){
              print('Valor cambiado');
              cancelar();
            },
          )
        ],
      );
    }
  );

TextFormField formFieldCodTicket() {
  if (loteSeleccionado == 1){
    return TextFormField(
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.code),
                    prefix: Text('DCC-'),
                    labelText: 'Código Ticket',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value == ''){
                      return 'Ha de tener contenido';
                    } else {
                      return null;
                    }
                  },
                  onChanged: (value) => setState(() {
                    codTicket = value;
                  }
                  ),
                );
  } else {
        return TextFormField(
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.code),
                    prefix: Text('DCP-'),
                    labelText: 'Código Ticket',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value == ''){
                      return 'Ha de tener contenido';
                    } else {
                      return null;
                    }
                  },
                  onChanged: (value) => setState(() {
                    codTicket = value;
                  }
                  ),
                );

  }
}


  void cancelar(){
    Navigator.of(context).pop();
  }


}



class checkBox2 extends StatefulWidget {
  final ValueChanged<String> onChanged;
  String tareaRealizada;

  checkBox2(
    { Key? key,
    required this.tareaRealizada,
    required this.onChanged }) : super(key: key);

  @override
  _checkBox2State createState() => _checkBox2State();
}

class _checkBox2State extends State<checkBox2> {
  late bool isChecked = widget.tareaRealizada == 'S' ? true : false;
  
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Checkbox(
        value: isChecked,
        onChanged: (valor){
          setState(() {
            isChecked = valor!;
          });
          widget.onChanged( isChecked ? 'S' : 'N');
        }
        ),
    );
  }
}

