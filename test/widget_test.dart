import 'package:flutter_test/flutter_test.dart';

import 'package:jreyna591m2/main.dart';

void main() {
  testWidgets('Muestra la pantalla de inicio', (WidgetTester tester) async {
    await tester.pumpWidget(const MiAplicacion());

    expect(find.text('Mi Agenda'), findsOneWidget);
    expect(find.text('Iniciar sesión'), findsOneWidget);
  });
}
