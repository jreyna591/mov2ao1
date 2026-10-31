import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PantallaLogin extends StatefulWidget {
  const PantallaLogin({super.key});

  @override
  State<PantallaLogin> createState() => _PantallaLoginState();
}

class _PantallaLoginState extends State<PantallaLogin> {
  TextEditingController controladorUsuario = TextEditingController();
  TextEditingController controladorClave = TextEditingController();

  String usuarioCorrecto = 'admin';
  String claveCorrecta = '1234';

  Future<void> ingresar() async {
    String usuarioIngresado = controladorUsuario.text;
    String claveIngresada = controladorClave.text;

    if (usuarioIngresado == usuarioCorrecto &&
        claveIngresada == claveCorrecta) {
      SharedPreferences preferencias = await SharedPreferences.getInstance();

      await preferencias.setBool('sesionIniciada', true);

      if (!mounted) {
        return;
      }

      Navigator.pushReplacementNamed(context, '/contactos');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Usuario o contraseña incorrectos')),
      );
    }
  }

  @override
  void dispose() {
    controladorUsuario.dispose();
    controladorClave.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.account_circle, size: 100, color: Colors.blue),
                const SizedBox(height: 16),
                const Text(
                  'Mi Agenda',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 32),
                TextField(
                  controller: controladorUsuario,
                  decoration: const InputDecoration(
                    labelText: 'Usuario',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: controladorClave,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Contraseña',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: ingresar,
                    child: const Text('Iniciar sesión'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
