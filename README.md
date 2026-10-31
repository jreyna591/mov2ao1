# Mi Agenda

Aplicación Android desarrollada con Flutter para las Actividades Obligatorias Integradoras N.º 1 y N.º 2 de Programación de Aplicaciones Móviles II.

Este proyecto es una práctica universitaria de gestión de contactos.

## Funcionalidades

- Inicio de sesión con credenciales de prueba.
- Sesión recordada al cerrar y volver a abrir la aplicación.
- Opción para cerrar sesión.
- Seis contactos de ejemplo al crear la base de datos por primera vez.
- Listado de contactos con nombre, apellido y teléfono.
- Búsqueda por nombre o apellido mientras se escribe.
- Alta de nuevos contactos.
- Edición al tocar un contacto de la lista.
- Eliminación con confirmación desde la pantalla de edición.
- Almacenamiento local con SQLite: los contactos y sus cambios se conservan al cerrar la aplicación.

## Datos de los contactos

Cada contacto incluye:

- Nombre.
- Apellido.
- Teléfono.
- Correo electrónico.
- Domicilio.
- Fecha de nacimiento.
- Género: Femenino o Masculino.

## Credenciales de prueba

```text
Usuario: admin
Contraseña: 1234
```

Las credenciales están definidas en el código para fines educativos.

## Uso de la aplicación

1. Iniciar sesión con las credenciales de prueba.
2. Consultar los contactos o usar la lupa para buscar.
3. Tocar el botón `+` para crear un contacto.
4. Completar los datos y tocar `✓` para guardar.
5. Tocar un contacto de la lista para editar sus datos.
6. En la pantalla de edición, tocar `✓` para guardar o `✕` para eliminar.
7. Para cerrar sesión, abrir el menú de tres puntos y seleccionar “Cerrar sesión”.

La flecha Atrás permite salir del formulario sin guardar los cambios.

El ícono de teléfono del listado es ilustrativo; no realiza llamadas.

## Almacenamiento

SharedPreferences guarda si hay una sesión iniciada. Si existe, la aplicación abre directamente la lista de contactos.

SQLite guarda los contactos en el teléfono. Los seis contactos de ejemplo se insertan únicamente cuando se crea la base por primera vez.

Provider mantiene actualizada la lista que muestran las pantallas.

Cerrar sesión no elimina los contactos.

## Tecnologías utilizadas

- Flutter y Dart.
- Material Design.
- Provider.
- SharedPreferences.
- SQLite mediante sqflite.
- Path.

## Estructura principal

```text
lib/
  base_datos/
    base_contactos.dart
  datos/
    contactos_ejemplo.dart
  modelos/
    contacto.dart
  pantallas/
    pantalla_login.dart
    pantalla_contactos.dart
    pantalla_agregar_contacto.dart
  provider/
    contactos_provider.dart
  main.dart
```

## Autor

Julio Reyna
