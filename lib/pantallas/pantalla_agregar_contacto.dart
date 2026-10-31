import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../modelos/contacto.dart';
import '../provider/contactos_provider.dart';

class PantallaAgregarContacto extends StatefulWidget {
  final Contacto? contacto;

  const PantallaAgregarContacto({super.key, this.contacto});

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

  @override
  void initState() {
    super.initState();

    Contacto? contacto = widget.contacto;

    if (contacto != null) {
      controladorNombre.text = contacto.nombre;
      controladorApellido.text = contacto.apellido;
      controladorTelefono.text = contacto.telefono;
      controladorCorreo.text = contacto.correo;
      controladorDomicilio.text = contacto.domicilio;
      fechaElegida = contacto.fechaNacimiento;
      generoElegido = contacto.genero;
    }
  }

  Future<void> elegirFecha() async {
    DateTime fechaInicial = DateTime.now();

    if (fechaElegida.isNotEmpty) {
      List<String> partes = fechaElegida.split('/');

      fechaInicial = DateTime(
        int.parse(partes[2]),
        int.parse(partes[1]),
        int.parse(partes[0]),
      );
    }

    DateTime? fecha = await showDatePicker(
      context: context,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      initialDate: fechaInicial,
    );

    if (fecha == null || !mounted) {
      return;
    }

    setState(() {
      fechaElegida = '${fecha.day}/${fecha.month}/${fecha.year}';
    });
  }

  Future<void> guardarContacto() async {
    String nombre = controladorNombre.text.trim();
    String apellido = controladorApellido.text.trim();
    String telefono = controladorTelefono.text.trim();

    if (nombre.isEmpty || apellido.isEmpty || telefono.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Completá nombre, apellido y teléfono')),
      );
      return;
    }

    Contacto contacto = Contacto(
      id: widget.contacto?.id,
      nombre: nombre,
      apellido: apellido,
      telefono: telefono,
      correo: controladorCorreo.text.trim(),
      domicilio: controladorDomicilio.text.trim(),
      fechaNacimiento: fechaElegida,
      genero: generoElegido,
    );

    ContactosProvider contactosProvider = context.read<ContactosProvider>();

    if (widget.contacto == null) {
      await contactosProvider.agregarContacto(contacto);
    } else {
      await contactosProvider.modificarContacto(contacto);
    }

    if (!mounted) {
      return;
    }

    Navigator.pop(context);
  }

  Future<void> eliminarContacto() async {
    bool? confirmar = await showDialog<bool>(
      context: context,
      builder: (contextoDialogo) {
        return AlertDialog(
          title: const Text('Eliminar contacto'),
          content: Text(
            '¿Querés eliminar a ${widget.contacto!.nombre} '
            '${widget.contacto!.apellido}?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(contextoDialogo, false);
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(contextoDialogo, true);
              },
              child: const Text('Eliminar'),
            ),
          ],
        );
      },
    );

    if (confirmar != true || !mounted) {
      return;
    }

    await context.read<ContactosProvider>().eliminarContacto(
      widget.contacto!.id!,
    );

    if (!mounted) {
      return;
    }

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
        title: Text(
          widget.contacto == null ? 'Agregar contacto' : 'Editar contacto',
        ),
        actions: [
          if (widget.contacto != null)
            IconButton(
              tooltip: 'Eliminar contacto',
              icon: const Icon(Icons.close, color: Colors.red),
              onPressed: eliminarContacto,
            ),
          IconButton(
            tooltip: 'Guardar contacto',
            icon: const Icon(Icons.check),
            onPressed: guardarContacto,
          ),
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
                if (valor != null) {
                  setState(() {
                    generoElegido = valor;
                  });
                }
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
