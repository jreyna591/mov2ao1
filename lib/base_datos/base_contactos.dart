import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../datos/contactos_ejemplo.dart';
import '../modelos/contacto.dart';

class BaseContactos {
  static Database? base;

  Future<Database> abrirBase() async {
    if (base != null) {
      return base!;
    }

    String carpeta = await getDatabasesPath();
    String ruta = join(carpeta, 'agenda.db');

    base = await openDatabase(
      ruta,
      version: 1,
      onCreate: (baseNueva, version) async {
        await baseNueva.execute('''
          CREATE TABLE contactos (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            nombre TEXT NOT NULL,
            apellido TEXT NOT NULL,
            telefono TEXT NOT NULL,
            correo TEXT NOT NULL,
            domicilio TEXT NOT NULL,
            fechaNacimiento TEXT NOT NULL,
            genero TEXT NOT NULL
          )
        ''');

        for (Contacto contacto in contactosEjemplo) {
          Map<String, Object?> datos = contacto.convertirAMapa();
          datos.remove('id');

          await baseNueva.insert('contactos', datos);
        }
      },
    );

    return base!;
  }

  Future<int> agregarContacto(Contacto contacto) async {
    Database baseActual = await abrirBase();

    Map<String, Object?> datos = contacto.convertirAMapa();
    datos.remove('id');

    return await baseActual.insert('contactos', datos);
  }

  Future<List<Contacto>> obtenerContactos() async {
    Database baseActual = await abrirBase();

    List<Map<String, Object?>> datos = await baseActual.query(
      'contactos',
      orderBy: 'id ASC',
    );

    List<Contacto> lista = [];

    for (Map<String, Object?> fila in datos) {
      Contacto contacto = Contacto.crearDesdeMapa(fila);
      lista.add(contacto);
    }

    return lista;
  }

  Future<void> modificarContacto(Contacto contacto) async {
    Database baseActual = await abrirBase();

    Map<String, Object?> datos = contacto.convertirAMapa();
    datos.remove('id');

    await baseActual.update(
      'contactos',
      datos,
      where: 'id = ?',
      whereArgs: [contacto.id],
    );
  }

  Future<void> eliminarContacto(int id) async {
    Database baseActual = await abrirBase();

    await baseActual.delete('contactos', where: 'id = ?', whereArgs: [id]);
  }
}
