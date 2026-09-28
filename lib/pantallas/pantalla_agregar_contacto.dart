import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../modelos/contacto.dart';
import '../provider/contactos_provider.dart';

class PantallaAgregarContacto extends StatefulWidget {
  const PantallaAgregarContacto({super.key});

  @override
  State<PantallaAgregarContacto> createState() =>
      _PantallaAgregarContactoState();
}

class _PantallaAgregarContactoState extends State<PantallaAgregarContacto> {
  TextEditingController controladorNombre = TextEditingController();
  TextEditingController controladorApellido = TextEditingController();
  TextEditingController controladorTelefono = TextEditingController();
  TextEditingController controladorCorreo = TextEditingController();
  TextEditingController controladorDomicilio = TextEditingController();

  String fechaElegida = '';
  String generoElegido = 'Femenino';

  Future<void> elegirFecha() async {
    DateTime? fecha = await showDatePicker(
      context: context,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      initialDate: DateTime.now(),
    );

    if (fecha != null) {
      setState(() {
        fechaElegida = '${fecha.day}/${fecha.month}/${fecha.year}';
      });
    }
  }

  void guardarContacto() {
    if (controladorNombre.text.isEmpty ||
        controladorApellido.text.isEmpty ||
        controladorTelefono.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Completá nombre, apellido y teléfono')),
      );
      return;
    }

    Contacto contactoNuevo = Contacto(
      nombre: controladorNombre.text,
      apellido: controladorApellido.text,
      telefono: controladorTelefono.text,
      correo: controladorCorreo.text,
      domicilio: controladorDomicilio.text,
      fechaNacimiento: fechaElegida,
      genero: generoElegido,
    );

    context.read<ContactosProvider>().agregarContacto(contactoNuevo);

    Navigator.pop(context);
  }

  @override
  void dispose() {
    controladorNombre.dispose();
    controladorApellido.dispose();
    controladorTelefono.dispose();
    controladorCorreo.dispose();
    controladorDomicilio.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agregar contacto'),
        actions: [
          IconButton(icon: const Icon(Icons.check), onPressed: guardarContacto),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: controladorNombre,
              decoration: const InputDecoration(
                labelText: 'Nombre',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: controladorApellido,
              decoration: const InputDecoration(
                labelText: 'Apellido',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: controladorTelefono,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                labelText: 'Teléfono',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: controladorCorreo,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: 'Correo electrónico',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: controladorDomicilio,
              decoration: const InputDecoration(
                labelText: 'Domicilio',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ListTile(
              shape: RoundedRectangleBorder(
                side: const BorderSide(color: Colors.grey),
                borderRadius: BorderRadius.circular(4),
              ),
              title: const Text('Fecha de nacimiento'),
              subtitle: Text(
                fechaElegida.isEmpty ? 'Seleccionar fecha' : fechaElegida,
              ),
              trailing: const Icon(Icons.calendar_month),
              onTap: elegirFecha,
            ),
            const SizedBox(height: 16),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text('Género', style: TextStyle(fontSize: 16)),
            ),
            RadioGroup<String>(
              groupValue: generoElegido,
              onChanged: (valor) {
                setState(() {
                  generoElegido = valor!;
                });
              },
              child: Column(
                children: [
                  RadioListTile<String>(
                    title: const Text('Femenino'),
                    value: 'Femenino',
                  ),
                  RadioListTile<String>(
                    title: const Text('Masculino'),
                    value: 'Masculino',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
