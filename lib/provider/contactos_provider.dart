import 'package:flutter/material.dart';

import '../datos/contactos_ejemplo.dart';
import '../modelos/contacto.dart';

class ContactosProvider extends ChangeNotifier {
  List<Contacto> listaContactos = List.from(contactosEjemplo);

  void agregarContacto(Contacto contactoNuevo) {
    listaContactos.add(contactoNuevo);
    notifyListeners();
  }

  List<Contacto> buscarContactos(String textoBuscado) {
    if (textoBuscado.isEmpty) {
      return listaContactos;
    }

    return listaContactos.where((contacto) {
      String nombreCompleto = '${contacto.nombre} ${contacto.apellido}'
          .toLowerCase();

      return nombreCompleto.contains(textoBuscado.toLowerCase());
    }).toList();
  }
}
