import 'package:flutter/foundation.dart';

class Lote extends ChangeNotifier {
  int loteSeleccionado = 3;

  void addBotonPulsado(int lote) {
    loteSeleccionado = lote;
    print('llamado');
    notifyListeners();
  }

  int getBotonPulsado() {
    return loteSeleccionado;
  }
}
