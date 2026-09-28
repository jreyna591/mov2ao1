import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'pantallas/pantalla_agregar_contacto.dart';
import 'pantallas/pantalla_contactos.dart';
import 'pantallas/pantalla_login.dart';
import 'provider/contactos_provider.dart';

void main() {
  runApp(const MiAplicacion());
}

class MiAplicacion extends StatelessWidget {
  const MiAplicacion({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ContactosProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Mi Agenda',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        ),
        home: const PantallaLogin(),
        routes: {
          '/contactos': (context) => const PantallaContactos(),
          '/agregar': (context) => const PantallaAgregarContacto(),
        },
      ),
    );
  }
}
