import 'package:flutter/material.dart';

import '../base_datos/base_contactos.dart';
import '../modelos/contacto.dart';

class ContactosProvider extends ChangeNotifier {
  BaseContactos baseContactos = BaseContactos();

  List<Contacto> listaContactos = [];

  ContactosProvider() {
    cargarContactos();
  }

  Future<void> cargarContactos() async {
    listaContactos = await baseContactos.obtenerContactos();
    notifyListeners();
  }

  Future<void> agregarContacto(Contacto contactoNuevo) async {
    int idNuevo = await baseContactos.agregarContacto(contactoNuevo);

    contactoNuevo.id = idNuevo;

    await cargarContactos();
  }

  Future<void> modificarContacto(Contacto contacto) async {
    await baseContactos.modificarContacto(contacto);

    await cargarContactos();
  }

  Future<void> eliminarContacto(int id) async {
    await baseContactos.eliminarContacto(id);

    await cargarContactos();
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
