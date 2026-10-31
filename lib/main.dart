import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'pantallas/pantalla_agregar_contacto.dart';
import 'pantallas/pantalla_contactos.dart';
import 'pantallas/pantalla_login.dart';
import 'provider/contactos_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences preferencias = await SharedPreferences.getInstance();

  bool sesionIniciada = preferencias.getBool('sesionIniciada') ?? false;

  runApp(MiAplicacion(sesionIniciada: sesionIniciada));
}

class MiAplicacion extends StatelessWidget {
  final bool sesionIniciada;

  const MiAplicacion({super.key, this.sesionIniciada = false});

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
        home: sesionIniciada
            ? const PantallaContactos()
            : const PantallaLogin(),
        routes: {
          '/contactos': (context) => const PantallaContactos(),
          '/agregar': (context) => const PantallaAgregarContacto(),
        },
      ),
    );
  }
}
