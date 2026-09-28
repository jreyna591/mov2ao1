import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../modelos/contacto.dart';
import '../provider/contactos_provider.dart';

class PantallaContactos extends StatefulWidget {
  const PantallaContactos({super.key});

  @override
  State<PantallaContactos> createState() => _PantallaContactosState();
}

class _PantallaContactosState extends State<PantallaContactos> {
  bool buscando = false;
  String textoBuscado = '';

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
        ],
      ),
      body: listaParaMostrar.isEmpty
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.contacts_outlined, size: 90, color: Colors.grey),
                  SizedBox(height: 16),
                  Text('Aún no hay contactos'),
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
