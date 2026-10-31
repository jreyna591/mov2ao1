import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../modelos/contacto.dart';
import '../provider/contactos_provider.dart';
import 'pantalla_login.dart';
import 'pantalla_agregar_contacto.dart';

class PantallaContactos extends StatefulWidget {
  const PantallaContactos({super.key});

  @override
  State<PantallaContactos> createState() => _PantallaContactosState();
}

class _PantallaContactosState extends State<PantallaContactos> {
  bool buscando = false;
  String textoBuscado = '';

  Future<void> cerrarSesion() async {
    SharedPreferences preferencias = await SharedPreferences.getInstance();

    await preferencias.setBool('sesionIniciada', false);

    if (!mounted) {
      return;
    }

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const PantallaLogin()),
      (ruta) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    ContactosProvider contactosProvider = context.watch<ContactosProvider>();

    List<Contacto> listaParaMostrar = contactosProvider.buscarContactos(
      textoBuscado,
    );

    return Scaffold(
      appBar: AppBar(
        title: buscando
            ? TextField(
                autofocus: true,
                decoration: const InputDecoration(
                  hintText: 'Buscar...',
                  border: InputBorder.none,
                ),
                onChanged: (texto) {
                  setState(() {
                    textoBuscado = texto;
                  });
                },
              )
            : const Text('Contactos'),
        actions: [
          IconButton(
            icon: Icon(buscando ? Icons.close : Icons.search),
            onPressed: () {
              setState(() {
                buscando = !buscando;
                textoBuscado = '';
              });
            },
          ),
          PopupMenuButton<String>(
            onSelected: (opcion) {
              if (opcion == 'cerrar') {
                cerrarSesion();
              }
            },
            itemBuilder: (context) {
              return [
                const PopupMenuItem<String>(
                  value: 'cerrar',
                  child: Text('Cerrar sesión'),
                ),
              ];
            },
          ),
        ],
      ),
      body: listaParaMostrar.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.contacts_outlined,
                    size: 90,
                    color: Colors.grey,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    textoBuscado.isEmpty
                        ? 'Aún no hay contactos'
                        : 'No se encontraron contactos',
                  ),
                ],
              ),
            )
          : ListView.builder(
              itemCount: listaParaMostrar.length,
              itemBuilder: (context, posicion) {
                Contacto contacto = listaParaMostrar[posicion];

                return ListTile(
                  leading: CircleAvatar(child: Text(contacto.nombre[0])),
                  title: Text('${contacto.nombre} ${contacto.apellido}'),
                  subtitle: Text(contacto.telefono),
                  trailing: const Icon(Icons.call, color: Colors.green),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            PantallaAgregarContacto(contacto: contacto),
                      ),
                    );
                  },
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/agregar');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
