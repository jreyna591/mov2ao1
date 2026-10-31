class Contacto {
  int? id;
  String nombre;
  String apellido;
  String telefono;
  String correo;
  String domicilio;
  String fechaNacimiento;
  String genero;

  Contacto({
    this.id,
    required this.nombre,
    required this.apellido,
    required this.telefono,
    required this.correo,
    required this.domicilio,
    required this.fechaNacimiento,
    required this.genero,
  });

  Map<String, Object?> convertirAMapa() {
    return {
      'id': id,
      'nombre': nombre,
      'apellido': apellido,
      'telefono': telefono,
      'correo': correo,
      'domicilio': domicilio,
      'fechaNacimiento': fechaNacimiento,
      'genero': genero,
    };
  }

  factory Contacto.crearDesdeMapa(Map<String, Object?> datos) {
    return Contacto(
      id: datos['id'] as int,
      nombre: datos['nombre'] as String,
      apellido: datos['apellido'] as String,
      telefono: datos['telefono'] as String,
      correo: datos['correo'] as String,
      domicilio: datos['domicilio'] as String,
      fechaNacimiento: datos['fechaNacimiento'] as String,
      genero: datos['genero'] as String,
    );
  }
}
